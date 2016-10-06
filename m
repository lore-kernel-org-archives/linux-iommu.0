From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v13 09/15] vfio/type1: vfio_find_dma accepting a type argument
Date: Thu,  6 Oct 2016 08:45:25 +0000
Message-ID: <1475743531-4780-10-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In our RB-tree we get prepared to insert slots of different types
(USER and RESERVED). It becomes useful to be able to search for dma
slots of a specific type or any type.

This patch introduces vfio_find_dma_from_node which starts the
search from a given node and stops on the first node that matches
the @start and @size parameters. If this node also matches the
@type parameter, the node is returned else NULL is returned.

At the moment we only have USER SLOTS so the type will always match.

In a separate patch, this function will be enhanced to pursue the
search recursively in case a node with a different type is
encountered.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/vfio/vfio_iommu_type1.c | 53 +++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index a9f8b93..cb7267a 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -94,25 +94,56 @@ struct vfio_group {
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
-			return dma;
+			break;
 	}
+	if (!node)
+		return NULL;
+
+	/* a dma slot intersects our window, check the type also matches */
+	if (type == VFIO_IOVA_ANY || dma->type == type)
+		return dma;
 
 	return NULL;
 }
 
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
+
+	return vfio_find_dma_from_node(top_node, start, size, type);
+}
+
 static void vfio_link_dma(struct vfio_iommu *iommu, struct vfio_dma *new)
 {
 	struct rb_node **link = &iommu->dma_list.rb_node, *parent = NULL;
@@ -484,19 +515,21 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
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
@@ -600,7 +633,7 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 
 	mutex_lock(&iommu->lock);
 
-	if (vfio_find_dma(iommu, iova, size)) {
+	if (vfio_find_dma(iommu, iova, size, VFIO_IOVA_ANY)) {
 		mutex_unlock(&iommu->lock);
 		return -EEXIST;
 	}
-- 
1.9.1
