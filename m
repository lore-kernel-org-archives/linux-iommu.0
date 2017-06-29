From: David Dillow via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Don't free parent pagetable of the PTE we're
	adding
Date: Wed, 28 Jun 2017 19:42:23 -0700
Message-ID: <20170629024223.14866-1-dillow@google.com>
Reply-To: David Dillow <dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When adding a large scatterlist entry that covers more than the L3
superpage size (1GB) but has an alignment such that we must use L2
superpages (2MB) , we give dma_pte_free_level() a range that causes it
to free the L3 pagetable we're about to populate. We fix this by telling
dma_pte_free_pagetable() about the pagetable level we're about to populate
to prevent freeing it.

For example, mapping a scatterlist with entry lengths 854MB and 1194MB
at IOVA 0xffff80000000 would, when processing the 2MB-aligned second
entry, cause pfn_to_dma_pte() to create a L3 directory to hold L2
superpages for the mapping at IOVA 0xffffc0000000. We would previously
call dma_pte_free_pagetable(domain, 0xffffc0000, 0xfffffffff), which
would free the L3 directory pfn_to_dma_pte() just created for IO PFN
0xffffc0000. Telling dma_pte_free_pagetable() to retain the L3
directories while using L2 superpages avoids the erroneous free.

Signed-off-by: David Dillow <dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fc2765ccdb57..3a8036f60367 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1137,8 +1137,9 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 }
 
 static void dma_pte_free_level(struct dmar_domain *domain, int level,
-			       struct dma_pte *pte, unsigned long pfn,
-			       unsigned long start_pfn, unsigned long last_pfn)
+			       int retain_level, struct dma_pte *pte,
+			       unsigned long pfn, unsigned long start_pfn,
+			       unsigned long last_pfn)
 {
 	pfn = max(start_pfn, pfn);
 	pte = &pte[pfn_level_offset(pfn, level)];
@@ -1153,12 +1154,17 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 		level_pfn = pfn & level_mask(level);
 		level_pte = phys_to_virt(dma_pte_addr(pte));
 
-		if (level > 2)
-			dma_pte_free_level(domain, level - 1, level_pte,
-					   level_pfn, start_pfn, last_pfn);
+		if (level > 2) {
+			dma_pte_free_level(domain, level - 1, retain_level,
+					   level_pte, level_pfn, start_pfn,
+					   last_pfn);
+		}
 
-		/* If range covers entire pagetable, free it */
-		if (!(start_pfn > level_pfn ||
+		/*
+		 * Free the page table if we're below the level we want to
+		 * retain and the range covers the entire table.
+		 */
+		if (level < retain_level && !(start_pfn > level_pfn ||
 		      last_pfn < level_pfn + level_size(level) - 1)) {
 			dma_clear_pte(pte);
 			domain_flush_cache(domain, pte, sizeof(*pte));
@@ -1169,10 +1175,14 @@ static void dma_pte_free_level(struct dmar_domain *domain, int level,
 	} while (!first_pte_in_page(++pte) && pfn <= last_pfn);
 }
 
-/* clear last level (leaf) ptes and free page table pages. */
+/*
+ * clear last level (leaf) ptes and free page table pages below the
+ * level we wish to keep intact.
+ */
 static void dma_pte_free_pagetable(struct dmar_domain *domain,
 				   unsigned long start_pfn,
-				   unsigned long last_pfn)
+				   unsigned long last_pfn,
+				   int retain_level)
 {
 	BUG_ON(!domain_pfn_supported(domain, start_pfn));
 	BUG_ON(!domain_pfn_supported(domain, last_pfn));
@@ -1181,7 +1191,7 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 	dma_pte_clear_range(domain, start_pfn, last_pfn);
 
 	/* We don't need lock here; nobody else touches the iova range */
-	dma_pte_free_level(domain, agaw_to_level(domain->agaw),
+	dma_pte_free_level(domain, agaw_to_level(domain->agaw), retain_level,
 			   domain->pgd, 0, start_pfn, last_pfn);
 
 	/* free pgd */
@@ -2277,8 +2287,11 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 				/*
 				 * Ensure that old small page tables are
 				 * removed to make room for superpage(s).
+				 * We're adding new large pages, so make sure
+				 * we don't remove their parent tables.
 				 */
-				dma_pte_free_pagetable(domain, iov_pfn, end_pfn);
+				dma_pte_free_pagetable(domain, iov_pfn, end_pfn,
+						       largepage_lvl + 1);
 			} else {
 				pteval &= ~(uint64_t)DMA_PTE_LARGE_PAGE;
 			}
@@ -3954,7 +3967,8 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	ret = domain_sg_mapping(domain, start_vpfn, sglist, size, prot);
 	if (unlikely(ret)) {
 		dma_pte_free_pagetable(domain, start_vpfn,
-				       start_vpfn + size - 1);
+				       start_vpfn + size - 1,
+				       agaw_to_level(domain->agaw) + 1);
 		free_iova_fast(&domain->iovad, iova_pfn, dma_to_mm_pfn(size));
 		return 0;
 	}
-- 
2.13.2.725.g09c95d1e9-goog
