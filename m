From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/9] iommu/amd: Return the pte page-size in fetch_pte
Date: Wed,  1 Apr 2015 14:58:48 +0200
Message-ID: <1427893132-18310-6-git-send-email-joro@8bytes.org>
References: <1427893132-18310-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1427893132-18310-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Extend the fetch_pte function to also return the page-size
that is mapped by the returned pte.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       | 52 ++++++++++++++++++++++++-----------------
 drivers/iommu/amd_iommu_types.h |  6 +++++
 2 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 49ecf00..24ef9e6 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1322,7 +1322,9 @@ static u64 *alloc_pte(struct protection_domain *domain,
  * This function checks if there is a PTE for a given dma address. If
  * there is one, it returns the pointer to it.
  */
-static u64 *fetch_pte(struct protection_domain *domain, unsigned long address)
+static u64 *fetch_pte(struct protection_domain *domain,
+		      unsigned long address,
+		      unsigned long *page_size)
 {
 	int level;
 	u64 *pte;
@@ -1330,8 +1332,9 @@ static u64 *fetch_pte(struct protection_domain *domain, unsigned long address)
 	if (address > PM_LEVEL_SIZE(domain->mode))
 		return NULL;
 
-	level   =  domain->mode - 1;
-	pte     = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
+	level	   =  domain->mode - 1;
+	pte	   = &domain->pt_root[PM_LEVEL_INDEX(level, address)];
+	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
 
@@ -1340,19 +1343,9 @@ static u64 *fetch_pte(struct protection_domain *domain, unsigned long address)
 			return NULL;
 
 		/* Large PTE */
-		if (PM_PTE_LEVEL(*pte) == 0x07) {
-			unsigned long pte_mask, __pte;
-
-			/*
-			 * If we have a series of large PTEs, make
-			 * sure to return a pointer to the first one.
-			 */
-			pte_mask = PTE_PAGE_SIZE(*pte);
-			pte_mask = ~((PAGE_SIZE_PTE_COUNT(pte_mask) << 3) - 1);
-			__pte    = ((unsigned long)pte) & pte_mask;
-
-			return (u64 *)__pte;
-		}
+		if (PM_PTE_LEVEL(*pte) == 7 ||
+		    PM_PTE_LEVEL(*pte) == 0)
+			break;
 
 		/* No level skipping support yet */
 		if (PM_PTE_LEVEL(*pte) != level)
@@ -1361,8 +1354,21 @@ static u64 *fetch_pte(struct protection_domain *domain, unsigned long address)
 		level -= 1;
 
 		/* Walk to the next level */
-		pte = IOMMU_PTE_PAGE(*pte);
-		pte = &pte[PM_LEVEL_INDEX(level, address)];
+		pte	   = IOMMU_PTE_PAGE(*pte);
+		pte	   = &pte[PM_LEVEL_INDEX(level, address)];
+		*page_size = PTE_LEVEL_PAGE_SIZE(level);
+	}
+
+	if (PM_PTE_LEVEL(*pte) == 0x07) {
+		unsigned long pte_mask;
+
+		/*
+		 * If we have a series of large PTEs, make
+		 * sure to return a pointer to the first one.
+		 */
+		*page_size = pte_mask = PTE_PAGE_SIZE(*pte);
+		pte_mask   = ~((PAGE_SIZE_PTE_COUNT(pte_mask) << 3) - 1);
+		pte        = (u64 *)(((unsigned long)pte) & pte_mask);
 	}
 
 	return pte;
@@ -1423,6 +1429,7 @@ static unsigned long iommu_unmap_page(struct protection_domain *dom,
 				      unsigned long page_size)
 {
 	unsigned long long unmap_size, unmapped;
+	unsigned long pte_pgsize;
 	u64 *pte;
 
 	BUG_ON(!is_power_of_2(page_size));
@@ -1431,7 +1438,7 @@ static unsigned long iommu_unmap_page(struct protection_domain *dom,
 
 	while (unmapped < page_size) {
 
-		pte = fetch_pte(dom, bus_addr);
+		pte = fetch_pte(dom, bus_addr, &pte_pgsize);
 
 		if (!pte) {
 			/*
@@ -1674,7 +1681,8 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 	for (i = dma_dom->aperture[index]->offset;
 	     i < dma_dom->aperture_size;
 	     i += PAGE_SIZE) {
-		u64 *pte = fetch_pte(&dma_dom->domain, i);
+		unsigned long pte_pgsize;
+		u64 *pte = fetch_pte(&dma_dom->domain, i, &pte_pgsize);
 		if (!pte || !IOMMU_PTE_PRESENT(*pte))
 			continue;
 
@@ -3382,14 +3390,14 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 					  dma_addr_t iova)
 {
 	struct protection_domain *domain = dom->priv;
-	unsigned long offset_mask;
+	unsigned long offset_mask, pte_pgsize;
 	phys_addr_t paddr;
 	u64 *pte, __pte;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return iova;
 
-	pte = fetch_pte(domain, iova);
+	pte = fetch_pte(domain, iova, &pte_pgsize);
 
 	if (!pte || !IOMMU_PTE_PRESENT(*pte))
 		return 0;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index c4fffb7..60e87d2 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -282,6 +282,12 @@
 #define PTE_PAGE_SIZE(pte) \
 	(1ULL << (1 + ffz(((pte) | 0xfffULL))))
 
+/*
+ * Takes a page-table level and returns the default page-size for this level
+ */
+#define PTE_LEVEL_PAGE_SIZE(level)			\
+	(1ULL << (12 + (9 * (level))))
+
 #define IOMMU_PTE_P  (1ULL << 0)
 #define IOMMU_PTE_TV (1ULL << 1)
 #define IOMMU_PTE_U  (1ULL << 59)
-- 
1.9.1
