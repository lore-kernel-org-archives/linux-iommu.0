From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 20/26] iommu/vt-d: Unify domain->iommu attach/detachment
Date: Wed,  5 Aug 2015 17:18:51 +0200
Message-ID: <1438787937-7340-21-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Move the code to attach/detach domains to iommus and vice
verce into a single function to make sure there are no
dangling references.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 124 +++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 75 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 27762d7..50b5e6c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1676,89 +1676,64 @@ static struct dmar_domain *alloc_domain(int flags)
 	return domain;
 }
 
-static int __iommu_attach_domain(struct dmar_domain *domain,
-				 struct intel_iommu *iommu)
-{
-	int num;
-	unsigned long ndomains;
-
-	num = domain->iommu_did[iommu->seq_id];
-	if (num)
-		return num;
-
-	ndomains = cap_ndoms(iommu->cap);
-	num	 = find_first_zero_bit(iommu->domain_ids, ndomains);
-
-	if (num < ndomains) {
-		set_bit(num, iommu->domain_ids);
-		set_iommu_domain(iommu, num, domain);
-		domain->iommu_did[iommu->seq_id] = num;
-	} else {
-		num = -ENOSPC;
-	}
-
-	if (num < 0)
-		pr_err("%s: No free domain ids\n", iommu->name);
-
-	return num;
-}
-
-static int iommu_attach_domain(struct dmar_domain *domain,
+/* Must be called with iommu->lock */
+static int domain_attach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu)
 {
-	int num;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	num = __iommu_attach_domain(domain, iommu);
-	spin_unlock_irqrestore(&iommu->lock, flags);
-
-	return num;
-}
-
-static void iommu_detach_domain(struct dmar_domain *domain,
-				struct intel_iommu *iommu)
-{
+	unsigned long ndomains;
 	unsigned long flags;
-	int num;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-
-	num = domain->iommu_did[iommu->seq_id];
-
-	WARN_ON(num == 0);
-
-	clear_bit(num, iommu->domain_ids);
-	set_iommu_domain(iommu, num, NULL);
+	int ret, num;
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
-}
-
-static void domain_attach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu)
-{
-	unsigned long flags;
+	assert_spin_locked(&iommu->lock);
 
 	spin_lock_irqsave(&domain->iommu_lock, flags);
+
 	domain->iommu_refcnt[iommu->seq_id] += 1;
 	domain->iommu_count += 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 1) {
-		domain->nid = iommu->node;
+		ndomains = cap_ndoms(iommu->cap);
+		num      = find_first_zero_bit(iommu->domain_ids, ndomains);
+
+		if (num >= ndomains) {
+			pr_err("%s: No free domain ids\n", iommu->name);
+			domain->iommu_refcnt[iommu->seq_id] -= 1;
+			domain->iommu_count -= 1;
+			ret = -ENOSPC;
+			goto out_unlock;
+		}
+
+		set_bit(num, iommu->domain_ids);
+		set_iommu_domain(iommu, num, domain);
+
+		domain->iommu_did[iommu->seq_id] = num;
+		domain->nid			 = iommu->node;
+
 		domain_update_iommu_cap(domain);
 	}
+
+	ret = 0;
+out_unlock:
 	spin_unlock_irqrestore(&domain->iommu_lock, flags);
+
+	return ret;
 }
 
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu)
 {
+	int num, count = INT_MAX;
 	unsigned long flags;
-	int count = INT_MAX;
+
+	assert_spin_locked(&iommu->lock);
 
 	spin_lock_irqsave(&domain->iommu_lock, flags);
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
 	count = --domain->iommu_count;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
+		num = domain->iommu_did[iommu->seq_id];
+		clear_bit(num, iommu->domain_ids);
+		set_iommu_domain(iommu, num, NULL);
+
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
@@ -1883,7 +1858,6 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 static void domain_exit(struct dmar_domain *domain)
 {
 	struct page *freelist = NULL;
-	int i;
 
 	/* Domain 0 is reserved, so dont process it */
 	if (!domain)
@@ -1893,20 +1867,16 @@ static void domain_exit(struct dmar_domain *domain)
 	if (!intel_iommu_strict)
 		flush_unmaps_timeout(0);
 
-	/* remove associated devices */
+	/* Remove associated devices and clear attached or cached domains */
+	rcu_read_lock();
 	domain_remove_dev_info(domain);
+	rcu_read_unlock();
 
 	/* destroy iovas */
 	put_iova_domain(&domain->iovad);
 
 	freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
 
-	/* clear attached or cached domains */
-	rcu_read_lock();
-	for_each_domain_iommu(i, domain)
-		iommu_detach_domain(domain, g_iommus[i]);
-	rcu_read_unlock();
-
 	dma_free_pagelist(freelist);
 
 	free_domain_mem(domain);
@@ -2284,6 +2254,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	struct dmar_domain *found = NULL;
 	struct device_domain_info *info;
 	unsigned long flags;
+	int ret;
 
 	info = alloc_devinfo_mem();
 	if (!info)
@@ -2311,11 +2282,14 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		return found;
 	}
 
-	if (iommu_attach_domain(domain, iommu) < 0) {
+	spin_lock(&iommu->lock);
+	ret = domain_attach_iommu(domain, iommu);
+	spin_unlock(&iommu->lock);
+
+	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		return NULL;
 	}
-	domain_attach_iommu(domain, iommu);
 
 	list_add(&info->link, &domain->devices);
 	list_add(&info->global, &device_domain_list);
@@ -4567,12 +4541,10 @@ static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 	iommu_disable_dev_iotlb(info);
 	domain_context_clear(iommu, dev);
 	free_devinfo_mem(info);
-	domain_detach_iommu(domain, iommu);
 
-	spin_lock_irqsave(&domain->iommu_lock, flags);
-	if (!domain->iommu_refcnt[iommu->seq_id])
-		iommu_detach_domain(domain, iommu);
-	spin_unlock_irqrestore(&domain->iommu_lock, flags);
+	spin_lock_irqsave(&iommu->lock, flags);
+	domain_detach_iommu(domain, iommu);
+	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
@@ -4653,10 +4625,12 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 
 		old_domain = find_domain(dev);
 		if (old_domain) {
+			rcu_read_lock();
 			if (domain_type_is_vm_or_si(dmar_domain))
 				dmar_remove_one_dev_info(old_domain, dev);
 			else
 				domain_remove_dev_info(old_domain);
+			rcu_read_unlock();
 
 			if (!domain_type_is_vm_or_si(old_domain) &&
 			     list_empty(&old_domain->devices))
-- 
1.9.1
