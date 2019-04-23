From: Tom Murphy via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH] Remove old no iommu direct mapping code
Date: Tue, 23 Apr 2019 21:03:34 +0100
Message-ID: <20190423200335.3888-1-tmurphy@arista.com>
Reply-To: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, murphyt7-/Zw1syy4LHg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

These checks were intended to handle devices not mapped by the IOMMU.
Since the AMD IOMMU driver uses per-device dma_ops these functions can
no longer be called by direct mapped devices. So these checks aren't
needed anymore.

Signed-off-by: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b319e51c379b..67cdc9e5304b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2503,9 +2503,7 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 	u64 dma_mask;
 
 	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL)
-		return (dma_addr_t)paddr;
-	else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return DMA_MAPPING_ERROR;
 
 	dma_mask = *dev->dma_mask;
@@ -2676,11 +2674,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	struct page *page;
 
 	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL) {
-		page = alloc_pages(flag, get_order(size));
-		*dma_addr = page_to_phys(page);
-		return page_address(page);
-	} else if (IS_ERR(domain))
+	if (IS_ERR(domain))
 		return NULL;
 
 	dma_dom   = to_dma_ops_domain(domain);
-- 
2.17.1
