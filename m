From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/2] iommu/dma: Implement scatterlist segment merging
Date: Thu, 10 Mar 2016 19:28:13 +0000
Message-ID: <70acc522bff080b806dd88ff06abf0b6ee5f10a8.1457637385.git.robin.murphy@arm.com>
References: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Stop wasting IOVA space by over-aligning scatterlist segments for a
theoretical worst-case segment boundary mask, and instead take the real
limits into account to merge consecutive segments where appropriate, so
our callers can benefit from geting back nicely simplified lists.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 84 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58f2fe6..886cb3a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -389,26 +389,58 @@ void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
 
 /*
  * Prepare a successfully-mapped scatterlist to give back to the caller.
- * Handling IOVA concatenation can come later, if needed
+ *
+ * At this point the segments are already laid out by iommu_dma_map_sg() to
+ * avoid individually crossing any boundaries, so we merely need to check a
+ * segment's start address to avoid concatenating across one.
  */
 static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		dma_addr_t dma_addr)
 {
-	struct scatterlist *s;
-	int i;
+	struct scatterlist *s, *cur = sg;
+	unsigned long seg_mask = dma_get_seg_boundary(dev);
+	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
+	int i, count = 0;
 
 	for_each_sg(sg, s, nents, i) {
-		/* Un-swizzling the fields here, hence the naming mismatch */
-		unsigned int s_offset = sg_dma_address(s);
+		/* Restore this segment's original unaligned fields first */
+		unsigned int s_iova_off = sg_dma_address(s);
 		unsigned int s_length = sg_dma_len(s);
-		unsigned int s_dma_len = s->length;
+		unsigned int s_iova_len = s->length;
 
-		s->offset += s_offset;
+		s->offset += s_iova_off;
 		s->length = s_length;
-		sg_dma_address(s) = dma_addr + s_offset;
-		dma_addr += s_dma_len;
+		sg_dma_address(s) = DMA_ERROR_CODE;
+		sg_dma_len(s) = 0;
+
+		/*
+		 * Now fill in the real DMA data. If...
+		 * - there is a valid output segment to append to
+		 * - and this segment starts on an IOVA page boundary
+		 * - but doesn't fall at a segment boundary
+		 * - and wouldn't make the resulting output segment too long
+		 */
+		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
+		    (cur_len + s_length <= max_len)) {
+			/* ...then concatenate it with the previous one */
+			cur_len += s_length;
+		} else {
+			/* Otherwise start the next output segment */
+			if (i > 0)
+				cur = sg_next(cur);
+			cur_len = s_length;
+			count++;
+
+			sg_dma_address(cur) = dma_addr + s_iova_off;
+		}
+
+		sg_dma_len(cur) = cur_len;
+		dma_addr += s_iova_len;
+
+		if (s_length + s_iova_off < s_iova_len)
+			cur_len = 0;
 	}
-	return i;
+	return count;
 }
 
 /*
@@ -446,34 +478,40 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *s, *prev = NULL;
 	dma_addr_t dma_addr;
 	size_t iova_len = 0;
+	unsigned long mask = dma_get_seg_boundary(dev);
 	int i;
 
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
 	 * trickery we can modify the list in-place, but reversibly, by
-	 * hiding the original data in the as-yet-unused DMA fields.
+	 * stashing the unaligned parts in the as-yet-unused DMA fields.
 	 */
 	for_each_sg(sg, s, nents, i) {
-		size_t s_offset = iova_offset(iovad, s->offset);
+		size_t s_iova_off = iova_offset(iovad, s->offset);
 		size_t s_length = s->length;
+		size_t pad_len = (mask - iova_len + 1) & mask;
 
-		sg_dma_address(s) = s_offset;
+		sg_dma_address(s) = s_iova_off;
 		sg_dma_len(s) = s_length;
-		s->offset -= s_offset;
-		s_length = iova_align(iovad, s_length + s_offset);
+		s->offset -= s_iova_off;
+		s_length = iova_align(iovad, s_length + s_iova_off);
 		s->length = s_length;
 
 		/*
-		 * The simple way to avoid the rare case of a segment
-		 * crossing the boundary mask is to pad the previous one
-		 * to end at a naturally-aligned IOVA for this one's size,
-		 * at the cost of potentially over-allocating a little.
+		 * Due to the alignment of our single IOVA allocation, we can
+		 * depend on these assumptions about the segment boundary mask:
+		 * - If mask size >= IOVA size, then the IOVA range cannot
+		 *   possibly fall across a boundary, so we don't care.
+		 * - If mask size < IOVA size, then the IOVA range must start
+		 *   exactly on a boundary, therefore we can lay things out
+		 *   based purely on segment lengths without needing to know
+		 *   the actual addresses beforehand.
+		 * - The mask must be a power of 2, so pad_len == 0 if
+		 *   iova_len == 0, thus we cannot dereference prev the first
+		 *   time through here (i.e. before it has a meaningful value).
 		 */
-		if (prev) {
-			size_t pad_len = roundup_pow_of_two(s_length);
-
-			pad_len = (pad_len - iova_len) & (pad_len - 1);
+		if (pad_len && pad_len < s_length - 1) {
 			prev->length += pad_len;
 			iova_len += pad_len;
 		}
-- 
2.7.2.333.g70bd996.dirty
