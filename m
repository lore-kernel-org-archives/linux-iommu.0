From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 22/26] iommu/vt-d: Get rid of domain->iommu_lock
Date: Wed,  5 Aug 2015 17:18:53 +0200
Message-ID: <1438787937-7340-23-git-send-email-joro@8bytes.org>
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

When this lock is held the device_domain_lock is also
required to make sure the device_domain_info does not vanish
while in use. So this lock can be removed as it gives no
additional protection.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 87 +++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index eb2a99a..1a9ecfe 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -404,7 +404,6 @@ struct dmar_domain {
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
 					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
-	spinlock_t	iommu_lock;	/* protect iommu set in domain */
 	u64		max_addr;	/* maximum mapped address */
 
 	struct iommu_domain domain;	/* generic domain data structure for
@@ -474,6 +473,8 @@ static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 				     struct device *dev);
 static void domain_context_clear(struct intel_iommu *iommu,
 				 struct device *dev);
+static void __dmar_remove_one_dev_info(struct dmar_domain *domain,
+				       struct device *dev);
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu);
 
@@ -1402,24 +1403,23 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
 			 u8 bus, u8 devfn)
 {
 	bool found = false;
-	unsigned long flags;
 	struct device_domain_info *info;
 	struct pci_dev *pdev;
 
+	assert_spin_locked(&device_domain_lock);
+
 	if (!ecap_dev_iotlb_support(iommu->ecap))
 		return NULL;
 
 	if (!iommu->qi)
 		return NULL;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link)
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
 			found = true;
 			break;
 		}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	if (!found || !info->dev || !dev_is_pci(info->dev))
 		return NULL;
@@ -1614,10 +1614,12 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 static void disable_dmar_iommu(struct intel_iommu *iommu)
 {
 	struct device_domain_info *info, *tmp;
+	unsigned long flags;
 
 	if (!iommu->domains || !iommu->domain_ids)
 		return;
 
+	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
 		struct dmar_domain *domain;
 
@@ -1634,6 +1636,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 		if (!domain_type_is_vm_or_si(domain))
 			domain_exit(domain);
 	}
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
@@ -1670,7 +1673,6 @@ static struct dmar_domain *alloc_domain(int flags)
 	memset(domain, 0, sizeof(*domain));
 	domain->nid = -1;
 	domain->flags = flags;
-	spin_lock_init(&domain->iommu_lock);
 	INIT_LIST_HEAD(&domain->devices);
 
 	return domain;
@@ -1681,13 +1683,11 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu)
 {
 	unsigned long ndomains;
-	unsigned long flags;
-	int ret, num;
+	int num;
 
+	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
 
-	spin_lock_irqsave(&domain->iommu_lock, flags);
-
 	domain->iommu_refcnt[iommu->seq_id] += 1;
 	domain->iommu_count += 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 1) {
@@ -1698,8 +1698,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 			pr_err("%s: No free domain ids\n", iommu->name);
 			domain->iommu_refcnt[iommu->seq_id] -= 1;
 			domain->iommu_count -= 1;
-			ret = -ENOSPC;
-			goto out_unlock;
+			return -ENOSPC;
 		}
 
 		set_bit(num, iommu->domain_ids);
@@ -1711,22 +1710,17 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 	}
 
-	ret = 0;
-out_unlock:
-	spin_unlock_irqrestore(&domain->iommu_lock, flags);
-
-	return ret;
+	return 0;
 }
 
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu)
 {
 	int num, count = INT_MAX;
-	unsigned long flags;
 
+	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
 
-	spin_lock_irqsave(&domain->iommu_lock, flags);
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
 	count = --domain->iommu_count;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
@@ -1737,7 +1731,6 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
-	spin_unlock_irqrestore(&domain->iommu_lock, flags);
 
 	return count;
 }
@@ -1892,7 +1885,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	unsigned long flags;
 	struct dma_pte *pgd;
-	int agaw;
+	int ret, agaw;
 
 	WARN_ON(did == 0);
 
@@ -1905,16 +1898,17 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	BUG_ON(!domain->pgd);
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&iommu->lock);
+
+	ret = -ENOMEM;
 	context = iommu_context_addr(iommu, bus, devfn, 1);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 	if (!context)
-		return -ENOMEM;
-	spin_lock_irqsave(&iommu->lock, flags);
-	if (context_present(context)) {
-		spin_unlock_irqrestore(&iommu->lock, flags);
-		return 0;
-	}
+		goto out_unlock;
+
+	ret = 0;
+	if (context_present(context))
+		goto out_unlock;
 
 	pgd = domain->pgd;
 
@@ -1927,11 +1921,10 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	 */
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
 		for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+			ret = -ENOMEM;
 			pgd = phys_to_virt(dma_pte_addr(pgd));
-			if (!dma_pte_present(pgd)) {
-				spin_unlock_irqrestore(&iommu->lock, flags);
-				return -ENOMEM;
-			}
+			if (!dma_pte_present(pgd))
+				goto out_unlock;
 		}
 
 		info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
@@ -1970,7 +1963,12 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		iommu_flush_write_buffer(iommu);
 	}
 	iommu_enable_dev_iotlb(info);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+
+	ret = 0;
+
+out_unlock:
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return 0;
 }
@@ -2213,9 +2211,12 @@ static inline void unlink_domain_info(struct device_domain_info *info)
 static void domain_remove_dev_info(struct dmar_domain *domain)
 {
 	struct device_domain_info *info, *tmp;
+	unsigned long flags;
 
+	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		dmar_remove_one_dev_info(domain, info->dev);
+		__dmar_remove_one_dev_info(domain, info->dev);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
 /*
@@ -4517,14 +4518,16 @@ static void domain_context_clear(struct intel_iommu *iommu, struct device *dev)
 	pci_for_each_dma_alias(to_pci_dev(dev), &domain_context_clear_one_cb, iommu);
 }
 
-static void dmar_remove_one_dev_info(struct dmar_domain *domain,
-				     struct device *dev)
+static void __dmar_remove_one_dev_info(struct dmar_domain *domain,
+				       struct device *dev)
 {
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	unsigned long flags;
 	u8 bus, devfn;
 
+	assert_spin_locked(&device_domain_lock);
+
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return;
@@ -4534,9 +4537,7 @@ static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 	if (WARN_ON(!info))
 		return;
 
-	spin_lock_irqsave(&device_domain_lock, flags);
 	unlink_domain_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	iommu_disable_dev_iotlb(info);
 	domain_context_clear(iommu, dev);
@@ -4547,6 +4548,16 @@ static void dmar_remove_one_dev_info(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+static void dmar_remove_one_dev_info(struct dmar_domain *domain,
+				     struct device *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	__dmar_remove_one_dev_info(domain, dev);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+}
+
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
-- 
1.9.1
