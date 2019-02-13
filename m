From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 03/32] powerpc/dma: untangle vio_dma_mapping_ops from
	dma_iommu_ops
Date: Wed, 13 Feb 2019 08:01:04 +0100
Message-ID: <20190213070133.11259-4-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190213070133.11259-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

vio_dma_mapping_ops currently does a lot of indirect calls through
dma_iommu_ops, which not only make the code harder to follow but are
also expensive in the post-spectre world.  Unwind the indirect calls
by calling the ppc_iommu_* or iommu_* APIs directly applicable, or
just use the dma_iommu_* methods directly where we can.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/powerpc/include/asm/iommu.h     |  1 +
 arch/powerpc/kernel/dma-iommu.c      |  2 +-
 arch/powerpc/platforms/pseries/vio.c | 87 ++++++++++++----------------
 3 files changed, 38 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 17524d222a7b..bd069a6542ab 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -237,6 +237,7 @@ static inline void iommu_del_device(struct device *dev)
 }
 #endif /* !CONFIG_IOMMU_API */
 
+u64 dma_iommu_get_required_mask(struct device *dev);
 #else
 
 static inline void *get_iommu_table_base(struct device *dev)
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 9c9bcaae2f75..dd8601cd20df 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -92,7 +92,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		return 1;
 }
 
-static u64 dma_iommu_get_required_mask(struct device *dev)
+u64 dma_iommu_get_required_mask(struct device *dev)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 	u64 mask;
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 1fad4649735b..7870bf99168c 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -492,7 +492,9 @@ static void *vio_dma_iommu_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	}
 
-	ret = dma_iommu_ops.alloc(dev, size, dma_handle, flag, attrs);
+	ret = iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
+				    dma_handle, dev->coherent_dma_mask, flag,
+				    dev_to_node(dev));
 	if (unlikely(ret == NULL)) {
 		vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
 		atomic_inc(&viodev->cmo.allocs_failed);
@@ -507,8 +509,7 @@ static void vio_dma_iommu_free_coherent(struct device *dev, size_t size,
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
 
-	dma_iommu_ops.free(dev, size, vaddr, dma_handle, attrs);
-
+	iommu_free_coherent(get_iommu_table_base(dev), size, vaddr, dma_handle);
 	vio_cmo_dealloc(viodev, roundup(size, PAGE_SIZE));
 }
 
@@ -518,22 +519,22 @@ static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
                                          unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
-	struct iommu_table *tbl;
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 	dma_addr_t ret = DMA_MAPPING_ERROR;
 
-	tbl = get_iommu_table_base(dev);
-	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)))) {
-		atomic_inc(&viodev->cmo.allocs_failed);
-		return ret;
-	}
-
-	ret = dma_iommu_ops.map_page(dev, page, offset, size, direction, attrs);
-	if (unlikely(dma_mapping_error(dev, ret))) {
-		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)));
-		atomic_inc(&viodev->cmo.allocs_failed);
-	}
-
+	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl))))
+		goto out_fail;
+	ret = iommu_map_page(dev, tbl, page, offset, size, device_to_mask(dev),
+			direction, attrs);
+	if (unlikely(ret == DMA_MAPPING_ERROR))
+		goto out_deallocate;
 	return ret;
+
+out_deallocate:
+	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)));
+out_fail:
+	atomic_inc(&viodev->cmo.allocs_failed);
+	return DMA_MAPPING_ERROR;
 }
 
 static void vio_dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
@@ -542,11 +543,9 @@ static void vio_dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				     unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
-	struct iommu_table *tbl;
-
-	tbl = get_iommu_table_base(dev);
-	dma_iommu_ops.unmap_page(dev, dma_handle, size, direction, attrs);
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 
+	iommu_unmap_page(tbl, dma_handle, size, direction, attrs);
 	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE(tbl)));
 }
 
@@ -555,34 +554,32 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
                                 unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
-	struct iommu_table *tbl;
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 	struct scatterlist *sgl;
 	int ret, count;
 	size_t alloc_size = 0;
 
-	tbl = get_iommu_table_base(dev);
 	for_each_sg(sglist, sgl, nelems, count)
 		alloc_size += roundup(sgl->length, IOMMU_PAGE_SIZE(tbl));
 
-	if (vio_cmo_alloc(viodev, alloc_size)) {
-		atomic_inc(&viodev->cmo.allocs_failed);
-		return 0;
-	}
-
-	ret = dma_iommu_ops.map_sg(dev, sglist, nelems, direction, attrs);
-
-	if (unlikely(!ret)) {
-		vio_cmo_dealloc(viodev, alloc_size);
-		atomic_inc(&viodev->cmo.allocs_failed);
-		return ret;
-	}
+	if (vio_cmo_alloc(viodev, alloc_size))
+		goto out_fail;
+	ret = ppc_iommu_map_sg(dev, tbl, sglist, nelems, device_to_mask(dev),
+			direction, attrs);
+	if (unlikely(!ret))
+		goto out_deallocate;
 
 	for_each_sg(sglist, sgl, ret, count)
 		alloc_size -= roundup(sgl->dma_length, IOMMU_PAGE_SIZE(tbl));
 	if (alloc_size)
 		vio_cmo_dealloc(viodev, alloc_size);
-
 	return ret;
+
+out_deallocate:
+	vio_cmo_dealloc(viodev, alloc_size);
+out_fail:
+	atomic_inc(&viodev->cmo.allocs_failed);
+	return 0;
 }
 
 static void vio_dma_iommu_unmap_sg(struct device *dev,
@@ -591,30 +588,18 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
 		unsigned long attrs)
 {
 	struct vio_dev *viodev = to_vio_dev(dev);
-	struct iommu_table *tbl;
+	struct iommu_table *tbl = get_iommu_table_base(dev);
 	struct scatterlist *sgl;
 	size_t alloc_size = 0;
 	int count;
 
-	tbl = get_iommu_table_base(dev);
 	for_each_sg(sglist, sgl, nelems, count)
 		alloc_size += roundup(sgl->dma_length, IOMMU_PAGE_SIZE(tbl));
 
-	dma_iommu_ops.unmap_sg(dev, sglist, nelems, direction, attrs);
-
+	ppc_iommu_unmap_sg(tbl, sglist, nelems, direction, attrs);
 	vio_cmo_dealloc(viodev, alloc_size);
 }
 
-static int vio_dma_iommu_dma_supported(struct device *dev, u64 mask)
-{
-        return dma_iommu_ops.dma_supported(dev, mask);
-}
-
-static u64 vio_dma_get_required_mask(struct device *dev)
-{
-        return dma_iommu_ops.get_required_mask(dev);
-}
-
 static const struct dma_map_ops vio_dma_mapping_ops = {
 	.alloc             = vio_dma_iommu_alloc_coherent,
 	.free              = vio_dma_iommu_free_coherent,
@@ -623,8 +608,8 @@ static const struct dma_map_ops vio_dma_mapping_ops = {
 	.unmap_sg          = vio_dma_iommu_unmap_sg,
 	.map_page          = vio_dma_iommu_map_page,
 	.unmap_page        = vio_dma_iommu_unmap_page,
-	.dma_supported     = vio_dma_iommu_dma_supported,
-	.get_required_mask = vio_dma_get_required_mask,
+	.dma_supported     = dma_iommu_dma_supported,
+	.get_required_mask = dma_iommu_get_required_mask,
 };
 
 /**
-- 
2.20.1
