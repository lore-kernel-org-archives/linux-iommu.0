From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 19/23] iommu/amd: Initialize new aperture range before making
	it visible
Date: Tue, 22 Dec 2015 23:21:24 +0100
Message-ID: <1450822888-22590-20-git-send-email-joro@8bytes.org>
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

Make sure the aperture range is fully initialized before it
is visible to the address allocator.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index ecdd3f7..11ee885 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1425,8 +1425,10 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 			   bool populate, gfp_t gfp)
 {
 	int index = dma_dom->aperture_size >> APERTURE_RANGE_SHIFT;
-	struct amd_iommu *iommu;
 	unsigned long i, old_size, pte_pgsize;
+	struct aperture_range *range;
+	struct amd_iommu *iommu;
+	unsigned long flags;
 
 #ifdef CONFIG_IOMMU_STRESS
 	populate = false;
@@ -1435,17 +1437,17 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 	if (index >= APERTURE_MAX_RANGES)
 		return -ENOMEM;
 
-	dma_dom->aperture[index] = kzalloc(sizeof(struct aperture_range), gfp);
-	if (!dma_dom->aperture[index])
+	range = kzalloc(sizeof(struct aperture_range), gfp);
+	if (!range)
 		return -ENOMEM;
 
-	dma_dom->aperture[index]->bitmap = (void *)get_zeroed_page(gfp);
-	if (!dma_dom->aperture[index]->bitmap)
+	range->bitmap = (void *)get_zeroed_page(gfp);
+	if (!range->bitmap)
 		goto out_free;
 
-	dma_dom->aperture[index]->offset = dma_dom->aperture_size;
+	range->offset = dma_dom->aperture_size;
 
-	spin_lock_init(&dma_dom->aperture[index]->bitmap_lock);
+	spin_lock_init(&range->bitmap_lock);
 
 	if (populate) {
 		unsigned long address = dma_dom->aperture_size;
@@ -1458,14 +1460,18 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 			if (!pte)
 				goto out_free;
 
-			dma_dom->aperture[index]->pte_pages[i] = pte_page;
+			range->pte_pages[i] = pte_page;
 
 			address += APERTURE_RANGE_SIZE / 64;
 		}
 	}
 
-	old_size                = dma_dom->aperture_size;
-	dma_dom->aperture_size += APERTURE_RANGE_SIZE;
+	/* First take the bitmap_lock and then publish the range */
+	spin_lock_irqsave(&range->bitmap_lock, flags);
+
+	old_size                 = dma_dom->aperture_size;
+	dma_dom->aperture[index] = range;
+	dma_dom->aperture_size  += APERTURE_RANGE_SIZE;
 
 	/* Reserve address range used for MSI messages */
 	if (old_size < MSI_ADDR_BASE_LO &&
@@ -1512,15 +1518,16 @@ static int alloc_new_range(struct dma_ops_domain *dma_dom,
 
 	update_domain(&dma_dom->domain);
 
+	spin_unlock_irqrestore(&range->bitmap_lock, flags);
+
 	return 0;
 
 out_free:
 	update_domain(&dma_dom->domain);
 
-	free_page((unsigned long)dma_dom->aperture[index]->bitmap);
+	free_page((unsigned long)range->bitmap);
 
-	kfree(dma_dom->aperture[index]);
-	dma_dom->aperture[index] = NULL;
+	kfree(range);
 
 	return -ENOMEM;
 }
-- 
1.9.1
