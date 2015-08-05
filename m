From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/26] iommu/vt-d: Replace iommu_bmp with a refcount
Date: Wed,  5 Aug 2015 17:18:41 +0200
Message-ID: <1438787937-7340-11-git-send-email-joro@8bytes.org>
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

This replaces the dmar_domain->iommu_bmp with a similar
reference count array. This allows us to keep track of how
many devices behind each iommu are attached to the domain.

This is necessary for further simplifications and
optimizations to the iommu<->domain attachment code.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 82 +++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 25b2ba7..c46afb6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -373,10 +373,16 @@ static int hw_pass_through = 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY	(1 << 1)
 
+#define for_each_domain_iommu(idx, domain)			\
+	for (idx = 0; idx < g_num_of_iommus; idx++)		\
+		if (domain->iommu_refcnt[idx])
+
 struct dmar_domain {
 	int	nid;			/* node id */
-	DECLARE_BITMAP(iommu_bmp, DMAR_UNITS_SUPPORTED);
-					/* bitmap of iommus this domain uses*/
+
+	int		iommu_refcnt[DMAR_UNITS_SUPPORTED];
+					/* Refcount of devices per iommu */
+
 
 	u16	iommu_did[DMAR_UNITS_SUPPORTED];
 					/* Domain ids per IOMMU */
@@ -697,7 +703,9 @@ static struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 
 	/* si_domain and vm domain should not get here. */
 	BUG_ON(domain_type_is_vm_or_si(domain));
-	iommu_id = find_first_bit(domain->iommu_bmp, g_num_of_iommus);
+	for_each_domain_iommu(iommu_id, domain)
+		break;
+
 	if (iommu_id < 0 || iommu_id >= g_num_of_iommus)
 		return NULL;
 
@@ -713,7 +721,7 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 
 	domain->iommu_coherency = 1;
 
-	for_each_set_bit(i, domain->iommu_bmp, g_num_of_iommus) {
+	for_each_domain_iommu(i, domain) {
 		found = true;
 		if (!ecap_coherent(g_iommus[i]->ecap)) {
 			domain->iommu_coherency = 0;
@@ -1605,25 +1613,26 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 
 static void disable_dmar_iommu(struct intel_iommu *iommu)
 {
-	struct dmar_domain *domain;
-	int i;
+	struct device_domain_info *info, *tmp;
 
-	if ((iommu->domains) && (iommu->domain_ids)) {
-		for_each_set_bit(i, iommu->domain_ids, cap_ndoms(iommu->cap)) {
-			/*
-			 * Domain id 0 is reserved for invalid translation
-			 * if hardware supports caching mode and used as
-			 * a non-allocated marker.
-			 */
-			if (i == 0)
-				continue;
+	if (!iommu->domains || !iommu->domain_ids)
+		return;
 
-			domain = get_iommu_domain(iommu, i);
-			clear_bit(i, iommu->domain_ids);
-			if (domain_detach_iommu(domain, iommu) == 0 &&
-			    !domain_type_is_vm(domain))
-				domain_exit(domain);
-		}
+	list_for_each_entry_safe(info, tmp, &device_domain_list, global) {
+		struct dmar_domain *domain;
+
+		if (info->iommu != iommu)
+			continue;
+
+		if (!info->dev || !info->domain)
+			continue;
+
+		domain = info->domain;
+
+		domain_remove_one_dev_info(domain, info->dev);
+
+		if (!domain_type_is_vm_or_si(domain))
+			domain_exit(domain);
 	}
 
 	if (iommu->gcmd & DMA_GCMD_TE)
@@ -1731,10 +1740,10 @@ static void domain_attach_iommu(struct dmar_domain *domain,
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->iommu_lock, flags);
-	if (!test_and_set_bit(iommu->seq_id, domain->iommu_bmp)) {
-		domain->iommu_count++;
-		if (domain->iommu_count == 1)
-			domain->nid = iommu->node;
+	domain->iommu_refcnt[iommu->seq_id] += 1;
+	domain->iommu_count += 1;
+	if (domain->iommu_refcnt[iommu->seq_id] == 1) {
+		domain->nid = iommu->node;
 		domain_update_iommu_cap(domain);
 	}
 	spin_unlock_irqrestore(&domain->iommu_lock, flags);
@@ -1747,8 +1756,9 @@ static int domain_detach_iommu(struct dmar_domain *domain,
 	int count = INT_MAX;
 
 	spin_lock_irqsave(&domain->iommu_lock, flags);
-	if (test_and_clear_bit(iommu->seq_id, domain->iommu_bmp)) {
-		count = --domain->iommu_count;
+	domain->iommu_refcnt[iommu->seq_id] -= 1;
+	count = --domain->iommu_count;
+	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
@@ -1873,9 +1883,8 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 
 static void domain_exit(struct dmar_domain *domain)
 {
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
 	struct page *freelist = NULL;
+	int i;
 
 	/* Domain 0 is reserved, so dont process it */
 	if (!domain)
@@ -1895,10 +1904,8 @@ static void domain_exit(struct dmar_domain *domain)
 
 	/* clear attached or cached domains */
 	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd)
-		if (domain_type_is_vm(domain) ||
-		    test_bit(iommu->seq_id, domain->iommu_bmp))
-			iommu_detach_domain(domain, iommu);
+	for_each_domain_iommu(i, domain)
+		iommu_detach_domain(domain, g_iommus[i]);
 	rcu_read_unlock();
 
 	dma_free_pagelist(freelist);
@@ -4610,9 +4617,10 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
 				continue;
 		}
 
-		/* if there is no other devices under the same iommu
-		 * owned by this domain, clear this iommu in iommu_bmp
-		 * update iommu count and coherency
+		/*
+		 * If there is no other devices under the same iommu owned by
+		 * this domain, clear this iommu in iommu_refcnt update iommu
+		 * count and coherency.
 		 */
 		if (info->iommu == iommu)
 			found = true;
@@ -4820,7 +4828,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 
 	npages = last_pfn - start_pfn + 1;
 
-	for_each_set_bit(iommu_id, dmar_domain->iommu_bmp, g_num_of_iommus) {
+	for_each_domain_iommu(iommu_id, dmar_domain) {
 		iommu = g_iommus[iommu_id];
 
 		/*
-- 
1.9.1
