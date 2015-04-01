From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/9] iommu/amd: Optimize alloc_new_range for new fetch_pte
	interface
Date: Wed,  1 Apr 2015 14:58:50 +0200
Message-ID: <1427893132-18310-8-git-send-email-joro@8bytes.org>
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

Now that fetch_pte returns the page-size of the pte, the
call in this function can also be optimized a little bit.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c9ee444..f97441b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1591,7 +1591,7 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 {
 	int index = dma_dom->aperture_size >> APERTURE_RANGE_SHIFT;
 	struct amd_iommu *iommu;
-	unsigned long i, old_size;
+	unsigned long i, old_size, pte_pgsize;
 
 #ifdef CONFIG_IOMMU_STRESS
 	populate = false;
@@ -1664,13 +1664,13 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 	 */
 	for (i = dma_dom->aperture[index]->offset;
 	     i < dma_dom->aperture_size;
-	     i += PAGE_SIZE) {
-		unsigned long pte_pgsize;
+	     i += pte_pgsize) {
 		u64 *pte = fetch_pte(&dma_dom->domain, i, &pte_pgsize);
 		if (!pte || !IOMMU_PTE_PRESENT(*pte))
 			continue;
 
-		dma_ops_reserve_addresses(dma_dom, i >> PAGE_SHIFT, 1);
+		dma_ops_reserve_addresses(dma_dom, i >> PAGE_SHIFT,
+					  pte_pgsize >> 12);
 	}
 
 	update_domain(&dma_dom->domain);
-- 
1.9.1
