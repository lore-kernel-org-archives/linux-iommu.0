From: Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: intel-iommu: iova_to_phys: fill in bits from iova when large pte
Date: Fri, 1 Nov 2013 23:45:12 -0200
Message-ID: <20131102014511.GA29838@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


intel_iommu_iova_to_phys returns incorrect physical address 
when iova is translated by large pte.

Fill in bits from iova when creating the physical address.

Signed-off-by: Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 15e9b57..f8f2988 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -774,7 +774,8 @@ out:
 }
 
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
-				      unsigned long pfn, int target_level)
+				      unsigned long pfn, int target_level,
+				      int *large_page)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
 	struct dma_pte *parent, *pte = NULL;
@@ -790,8 +791,15 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 
 		offset = pfn_level_offset(pfn, level);
 		pte = &parent[offset];
-		if (!target_level && (dma_pte_superpage(pte) || !dma_pte_present(pte)))
-			break;
+		if (!target_level) {
+			if (!dma_pte_present(pte))
+				break;
+			if (dma_pte_superpage(pte)) {
+				if (large_page)
+					*large_page = level;
+				break;
+			}
+		}
 		if (level == target_level)
 			break;
 
@@ -1824,7 +1832,8 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		if (!pte) {
 			largepage_lvl = hardware_largepage_caps(domain, iov_pfn, phys_pfn, sg_res);
 
-			first_pte = pte = pfn_to_dma_pte(domain, iov_pfn, largepage_lvl);
+			first_pte = pte = pfn_to_dma_pte(domain, iov_pfn,
+							 largepage_lvl, NULL);
 			if (!pte)
 				return -ENOMEM;
 			/* It is large page*/
@@ -4129,11 +4138,17 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 {
 	struct dmar_domain *dmar_domain = domain->priv;
 	struct dma_pte *pte;
-	u64 phys = 0;
+	u64 phys = 0, iova_mask;
+	int large_page = 1;
 
-	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, 0);
-	if (pte)
+	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, 0,
+			     &large_page);
+	if (pte) {
 		phys = dma_pte_addr(pte);
+		large_page--;
+		iova_mask = (1ULL << (VTD_PAGE_SHIFT+(large_page*9)))-1;
+		phys |= iova & iova_mask;
+	}
 
 	return phys;
 }
