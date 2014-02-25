From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] arm: dma-mapping: remove order parameter from
	arm_iommu_create_mapping()
Date: Tue, 25 Feb 2014 13:42:21 +0100
Message-ID: <1393332141-17781-3-git-send-email-m.szyprowski@samsung.com>
References: <1393332141-17781-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1393332141-17781-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The 'order' parameter for IOMMU-aware dma-mapping implementation was
introduced mainly as a hack to reduce size of the bitmap used for
tracking IO virtual address space. Since now it is possible to dynamically
resize the bitmap, this hack is not needed and can be removed without any
impact on the client devices. This way the parameters for
arm_iommu_create_mapping() becomes much easier to understand. 'size'
parameter now means the maximum supported IO address space size.

The code will allocate (resize) bitmap in chunks, ensuring that a single
chunk is not larger than a single memory page to avoid unreliable
allocations of size larger than PAGE_SIZE in atomic context.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/include/asm/dma-iommu.h          |    4 +--
 arch/arm/mm/dma-mapping.c                 |   43 ++++++++++++++---------------
 drivers/gpu/drm/exynos/exynos_drm_drv.h   |    2 --
 drivers/gpu/drm/exynos/exynos_drm_iommu.c |    6 ++--
 drivers/gpu/drm/exynos/exynos_drm_iommu.h |    1 -
 drivers/iommu/shmobile-iommu.c            |    2 +-
 6 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 686797c..eec0a12 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -19,7 +19,6 @@ struct dma_iommu_mapping {
 	size_t			bitmap_size;	/* size of a single bitmap */
 	size_t			bits;		/* per bitmap */
 	unsigned int		size;		/* per bitmap */
-	unsigned int		order;
 	dma_addr_t		base;
 
 	spinlock_t		lock;
@@ -27,8 +26,7 @@ struct dma_iommu_mapping {
 };
 
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
-			 int order);
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size);
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index cc42bc2..f62aa06 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1081,11 +1081,8 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	if (order > CONFIG_ARM_DMA_IOMMU_ALIGNMENT)
 		order = CONFIG_ARM_DMA_IOMMU_ALIGNMENT;
 
-	count = ((PAGE_ALIGN(size) >> PAGE_SHIFT) +
-		 (1 << mapping->order) - 1) >> mapping->order;
-
-	if (order > mapping->order)
-		align = (1 << (order - mapping->order)) - 1;
+	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+	align = (1 << order) - 1;
 
 	spin_lock_irqsave(&mapping->lock, flags);
 	for (i = 0; i < mapping->nr_bitmaps; i++) {
@@ -1123,7 +1120,7 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	spin_unlock_irqrestore(&mapping->lock, flags);
 
 	iova = mapping->base + (mapping->size * i);
-	iova += start << (mapping->order + PAGE_SHIFT);
+	iova += start << PAGE_SHIFT;
 
 	return iova;
 }
@@ -1144,7 +1141,7 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 
 	bitmap_base = mapping->base + mapping->size * bitmap_index;
 
-	start = (addr - bitmap_base) >>	(mapping->order + PAGE_SHIFT);
+	start = (addr - bitmap_base) >>	PAGE_SHIFT;
 
 	if (addr + size > bitmap_base + mapping->size) {
 		/*
@@ -1155,8 +1152,7 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 		 */
 		BUG();
 	} else
-		count = ((size >> PAGE_SHIFT) +
-			(1 << mapping->order) - 1) >> mapping->order;
+		count = size >> PAGE_SHIFT;
 
 	spin_lock_irqsave(&mapping->lock, flags);
 	bitmap_clear(mapping->bitmaps[bitmap_index], start, count);
@@ -1924,8 +1920,7 @@ struct dma_map_ops iommu_coherent_ops = {
  * arm_iommu_create_mapping
  * @bus: pointer to the bus holding the client device (for IOMMU calls)
  * @base: start address of the valid IO address space
- * @size: size of the valid IO address space
- * @order: accuracy of the IO addresses allocations
+ * @size: maximum size of the valid IO address space
  *
  * Creates a mapping structure which holds information about used/unused
  * IO address ranges, which is required to perform memory allocation and
@@ -1935,37 +1930,41 @@ struct dma_map_ops iommu_coherent_ops = {
  * arm_iommu_attach_device function.
  */
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
-			 int order)
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
 {
-	unsigned int count = size >> (PAGE_SHIFT + order);
+	unsigned int bits = size >> PAGE_SHIFT;
+	unsigned int bitmap_size = BITS_TO_LONGS(bits) * sizeof(long);
 	struct dma_iommu_mapping *mapping;
-	int extensions = 0;
+	int extensions = 1;
 	int err = -ENOMEM;
 
-	if (!count)
+	if (!bitmap_size)
 		return ERR_PTR(-EINVAL);
 
+	if (bitmap_size > PAGE_SIZE) {
+		extensions = bitmap_size / PAGE_SIZE;
+		bitmap_size = PAGE_SIZE;
+	}
+
 	mapping = kzalloc(sizeof(struct dma_iommu_mapping), GFP_KERNEL);
 	if (!mapping)
 		goto err;
 
-	mapping->bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
-	mapping->bitmaps = kzalloc((extensions + 1) * sizeof(unsigned long *),
+	mapping->bitmap_size = bitmap_size;
+	mapping->bitmaps = kzalloc(extensions * sizeof(unsigned long *),
 				GFP_KERNEL);
 	if (!mapping->bitmaps)
 		goto err2;
 
-	mapping->bitmaps[0] = kzalloc(mapping->bitmap_size, GFP_KERNEL);
+	mapping->bitmaps[0] = kzalloc(bitmap_size, GFP_KERNEL);
 	if (!mapping->bitmaps[0])
 		goto err3;
 
 	mapping->nr_bitmaps = 1;
 	mapping->extensions = extensions;
 	mapping->base = base;
-	mapping->size = size;
-	mapping->order = order;
-	mapping->bits = BITS_PER_BYTE * mapping->bitmap_size;
+	mapping->size = bitmap_size << PAGE_SHIFT;
+	mapping->bits = BITS_PER_BYTE * bitmap_size;
 
 	spin_lock_init(&mapping->lock);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.h b/drivers/gpu/drm/exynos/exynos_drm_drv.h
index 0eaf5a2..a8f9dba 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_drv.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_drv.h
@@ -237,7 +237,6 @@ struct drm_exynos_file_private {
  *	otherwise default one.
  * @da_space_size: size of device address space.
  *	if 0 then default value is used for it.
- * @da_space_order: order to device address space.
  */
 struct exynos_drm_private {
 	struct drm_fb_helper *fb_helper;
@@ -255,7 +254,6 @@ struct exynos_drm_private {
 
 	unsigned long da_start;
 	unsigned long da_space_size;
-	unsigned long da_space_order;
 };
 
 /*
diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.c b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
index fb8db03..b32b291 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
@@ -36,12 +36,10 @@ int drm_create_iommu_mapping(struct drm_device *drm_dev)
 		priv->da_start = EXYNOS_DEV_ADDR_START;
 	if (!priv->da_space_size)
 		priv->da_space_size = EXYNOS_DEV_ADDR_SIZE;
-	if (!priv->da_space_order)
-		priv->da_space_order = EXYNOS_DEV_ADDR_ORDER;
 
 	mapping = arm_iommu_create_mapping(&platform_bus_type, priv->da_start,
-						priv->da_space_size,
-						priv->da_space_order);
+						priv->da_space_size);
+
 	if (IS_ERR(mapping))
 		return PTR_ERR(mapping);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.h b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
index 598e60f..72376d4 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.h
@@ -14,7 +14,6 @@
 
 #define EXYNOS_DEV_ADDR_START	0x20000000
 #define EXYNOS_DEV_ADDR_SIZE	0x40000000
-#define EXYNOS_DEV_ADDR_ORDER	0x0
 
 #ifdef CONFIG_DRM_EXYNOS_IOMMU
 
diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index 7a3b928..464acda 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -343,7 +343,7 @@ static int shmobile_iommu_add_device(struct device *dev)
 	mapping = archdata->iommu_mapping;
 	if (!mapping) {
 		mapping = arm_iommu_create_mapping(&platform_bus_type, 0,
-						   L1_LEN << 20, 0);
+						   L1_LEN << 20);
 		if (IS_ERR(mapping))
 			return PTR_ERR(mapping);
 		archdata->iommu_mapping = mapping;
-- 
1.7.9.5
