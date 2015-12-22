From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 18/23] iommu/amd: Build io page-tables with cmpxchg64
Date: Tue, 22 Dec 2015 23:21:23 +0100
Message-ID: <1450822888-22590-19-git-send-email-joro@8bytes.org>
References: <1450822888-22590-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1450822888-22590-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This allows to build up the page-tables without holding any
locks. As a consequence it removes the need to pre-populate
dma_ops page-tables.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 4c926da..ecdd3f7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1206,11 +1206,21 @@ static u64 *alloc_pte(struct protection_domain *domain,
 	end_lvl = PAGE_SIZE_LEVEL(page_size);
 
 	while (level > end_lvl) {
-		if (!IOMMU_PTE_PRESENT(*pte)) {
+		u64 __pte, __npte;
+
+		__pte = *pte;
+
+		if (!IOMMU_PTE_PRESENT(__pte)) {
 			page = (u64 *)get_zeroed_page(gfp);
 			if (!page)
 				return NULL;
-			*pte = PM_LEVEL_PDE(level, virt_to_phys(page));
+
+			__npte = PM_LEVEL_PDE(level, virt_to_phys(page));
+
+			if (cmpxchg64(pte, __pte, __npte)) {
+				free_page((unsigned long)page);
+				continue;
+			}
 		}
 
 		/* No level skipping support yet */
@@ -1607,7 +1617,7 @@ static unsigned long dma_ops_alloc_addresses(struct device *dev,
 		address = dma_ops_area_alloc(dev, dom, pages,
 					     align_mask, dma_mask);
 
-		if (address == -1 && alloc_new_range(dom, true, GFP_ATOMIC))
+		if (address == -1 && alloc_new_range(dom, false, GFP_ATOMIC))
 			break;
 	}
 
-- 
1.9.1
