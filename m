From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 2/7] vfio/type1: vfio_find_dma accepting a type argument
Date: Tue, 19 Apr 2016 17:24:42 +0000
Message-ID: <1461086687-2658-3-git-send-email-eric.auger@linaro.org>
References: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461086687-2658-1-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-qxv4g6HH51o@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In our RB-tree we now have slots of different types (USER and RESERVED).
It becomes useful to be able to search for dma slots of a specific type or
any type. This patch proposes an implementation for that modality and also
changes the existing callers using the USER type.

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 63 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index aaf5a6c..2d769d4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -98,23 +98,64 @@ struct vfio_group {
  * into DMA'ble space using the IOMMU
  */
 
-static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
-				      dma_addr_t start, size_t size)
+/**
+ * vfio_find_dma_from_node: looks for a dma slot intersecting a window
+ * from a given rb tree node
+ * @top: top rb tree node where the search starts (including this node)
+ * @start: window start
+ * @size: window size
+ * @type: window type
+ */
+static struct vfio_dma *vfio_find_dma_from_node(struct rb_node *top,
+						dma_addr_t start, size_t size,
+						enum vfio_iova_type type)
 {
-	struct rb_node *node = iommu->dma_list.rb_node;
+	struct rb_node *node = top;
+	struct vfio_dma *dma;
 
 	while (node) {
-		struct vfio_dma *dma = rb_entry(node, struct vfio_dma, node);
-
+		dma = rb_entry(node, struct vfio_dma, node);
 		if (start + size <= dma->iova)
 			node = node->rb_left;
 		else if (start >= dma->iova + dma->size)
 			node = node->rb_right;
 		else
+			break;
+	}
+	if (!node)
+		return NULL;
+
+	/* a dma slot intersects our window, check the type also matches */
+	if (type == VFIO_IOVA_ANY || dma->type == type)
+		return dma;
+
+	/* restart 2 searches skipping the current node */
+	if (start < dma->iova) {
+		dma = vfio_find_dma_from_node(node->rb_left, start,
+					      size, type);
+		if (dma)
 			return dma;
 	}
+	if (start + size > dma->iova + dma->size)
+		dma = vfio_find_dma_from_node(node->rb_right, start,
+					      size, type);
+	return dma;
+}
+
+/**
+ * vfio_find_dma: find a dma slot intersecting a given window
+ * @iommu: vfio iommu handle
+ * @start: window base iova
+ * @size: window size
+ * @type: window type
+ */
+static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
+				      dma_addr_t start, size_t size,
+				      enum vfio_iova_type type)
+{
+	struct rb_node *top_node = iommu->dma_list.rb_node;
 
-	return NULL;
+	return vfio_find_dma_from_node(top_node, start, size, type);
 }
 
 static void vfio_link_dma(struct vfio_iommu *iommu, struct vfio_dma *new)
@@ -488,19 +529,21 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 	 * mappings within the range.
 	 */
 	if (iommu->v2) {
-		dma = vfio_find_dma(iommu, unmap->iova, 0);
+		dma = vfio_find_dma(iommu, unmap->iova, 0, VFIO_IOVA_USER);
 		if (dma && dma->iova != unmap->iova) {
 			ret = -EINVAL;
 			goto unlock;
 		}
-		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0);
+		dma = vfio_find_dma(iommu, unmap->iova + unmap->size - 1, 0,
+				    VFIO_IOVA_USER);
 		if (dma && dma->iova + dma->size != unmap->iova + unmap->size) {
 			ret = -EINVAL;
 			goto unlock;
 		}
 	}
 
-	while ((dma = vfio_find_dma(iommu, unmap->iova, unmap->size))) {
+	while ((dma = vfio_find_dma(iommu, unmap->iova, unmap->size,
+				    VFIO_IOVA_USER))) {
 		if (!iommu->v2 && unmap->iova > dma->iova)
 			break;
 		unmapped += dma->size;
@@ -604,7 +647,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 
 	mutex_lock(&iommu->lock);
 
-	if (vfio_find_dma(iommu, iova, size)) {
+	if (vfio_find_dma(iommu, iova, size, VFIO_IOVA_ANY)) {
 		mutex_unlock(&iommu->lock);
 		return -EEXIST;
 	}
-- 
1.9.1
