From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/9] iommu/amd: Optimize iommu_unmap_page for new fetch_pte
	interface
Date: Wed,  1 Apr 2015 14:58:49 +0200
Message-ID: <1427893132-18310-7-git-send-email-joro@8bytes.org>
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

Now that fetch_pte returns the page-size of the pte, this
function can be optimized a lot.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 24ef9e6..c9ee444 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1428,8 +1428,8 @@ static unsigned long iommu_unmap_page(struct protection_domain *dom,
 				      unsigned long bus_addr,
 				      unsigned long page_size)
 {
-	unsigned long long unmap_size, unmapped;
-	unsigned long pte_pgsize;
+	unsigned long long unmapped;
+	unsigned long unmap_size;
 	u64 *pte;
 
 	BUG_ON(!is_power_of_2(page_size));
@@ -1438,28 +1438,12 @@ static unsigned long iommu_unmap_page(struct protection_domain *dom,
 
 	while (unmapped < page_size) {
 
-		pte = fetch_pte(dom, bus_addr, &pte_pgsize);
-
-		if (!pte) {
-			/*
-			 * No PTE for this address
-			 * move forward in 4kb steps
-			 */
-			unmap_size = PAGE_SIZE;
-		} else if (PM_PTE_LEVEL(*pte) == 0) {
-			/* 4kb PTE found for this address */
-			unmap_size = PAGE_SIZE;
-			*pte       = 0ULL;
-		} else {
-			int count, i;
-
-			/* Large PTE found which maps this address */
-			unmap_size = PTE_PAGE_SIZE(*pte);
-
-			/* Only unmap from the first pte in the page */
-			if ((unmap_size - 1) & bus_addr)
-				break;
-			count      = PAGE_SIZE_PTE_COUNT(unmap_size);
+		pte = fetch_pte(dom, bus_addr, &unmap_size);
+
+		if (pte) {
+			int i, count;
+
+			count = PAGE_SIZE_PTE_COUNT(unmap_size);
 			for (i = 0; i < count; i++)
 				pte[i] = 0ULL;
 		}
-- 
1.9.1
