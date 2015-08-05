From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 07/26] iommu/vt-d: Pass dmar_domain directly into iommu_flush_iotlb_psi
Date: Wed,  5 Aug 2015 17:18:38 +0200
Message-ID: <1438787937-7340-8-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This function can figure out the domain-id to use itself
from the iommu_did array. This is more reliable over
different domain types and brings us one step further to
remove the domain->id field.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fdb51ec..31e8100 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1469,11 +1469,14 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static void iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
-				  unsigned long pfn, unsigned int pages, int ih, int map)
+static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
+				  struct dmar_domain *domain,
+				  unsigned long pfn, unsigned int pages,
+				  int ih, int map)
 {
 	unsigned int mask = ilog2(__roundup_pow_of_two(pages));
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
+	u16 did = domain->iommu_did[iommu->seq_id];
 
 	BUG_ON(pages == 0);
 
@@ -3420,7 +3423,9 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	/* it's a non-present to present mapping. Only flush if caching mode */
 	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain->id, mm_to_dma_pfn(iova->pfn_lo), size, 0, 1);
+		iommu_flush_iotlb_psi(iommu, domain,
+				      mm_to_dma_pfn(iova->pfn_lo),
+				      size, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
 
@@ -3471,7 +3476,7 @@ static void flush_unmaps(void)
 
 			/* On real hardware multiple invalidations are expensive */
 			if (cap_caching_mode(iommu->cap))
-				iommu_flush_iotlb_psi(iommu, domain->id,
+				iommu_flush_iotlb_psi(iommu, domain,
 					iova->pfn_lo, iova_size(iova),
 					!deferred_flush[i].freelist[j], 0);
 			else {
@@ -3555,7 +3560,7 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr)
 	freelist = domain_unmap(domain, start_pfn, last_pfn);
 
 	if (intel_iommu_strict) {
-		iommu_flush_iotlb_psi(iommu, domain->id, start_pfn,
+		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
 				      last_pfn - start_pfn + 1, !freelist, 0);
 		/* free iova */
 		__free_iova(&domain->iovad, iova);
@@ -3713,7 +3718,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 	/* it's a non-present to present mapping. Only flush if caching mode */
 	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain->id, start_vpfn, size, 0, 1);
+		iommu_flush_iotlb_psi(iommu, domain, start_vpfn, size, 0, 1);
 	else
 		iommu_flush_write_buffer(iommu);
 
@@ -4419,7 +4424,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
-				iommu_flush_iotlb_psi(iommu, si_domain->id,
+				iommu_flush_iotlb_psi(iommu, si_domain,
 					iova->pfn_lo, iova_size(iova),
 					!freelist, 0);
 			rcu_read_unlock();
@@ -4849,17 +4854,18 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	npages = last_pfn - start_pfn + 1;
 
 	for_each_set_bit(iommu_id, dmar_domain->iommu_bmp, g_num_of_iommus) {
-               iommu = g_iommus[iommu_id];
-
-               /*
-                * find bit position of dmar_domain
-                */
-               ndomains = cap_ndoms(iommu->cap);
-               for_each_set_bit(num, iommu->domain_ids, ndomains) {
-                       if (get_iommu_domain(iommu, num) == dmar_domain)
-                               iommu_flush_iotlb_psi(iommu, num, start_pfn,
-						     npages, !freelist, 0);
-	       }
+		iommu = g_iommus[iommu_id];
+
+		/*
+		 * find bit position of dmar_domain
+		 */
+		ndomains = cap_ndoms(iommu->cap);
+		for_each_set_bit(num, iommu->domain_ids, ndomains) {
+			if (get_iommu_domain(iommu, num) == dmar_domain)
+				iommu_flush_iotlb_psi(iommu, dmar_domain,
+						      start_pfn, npages,
+						      !freelist, 0);
+		}
 
 	}
 
-- 
1.9.1
