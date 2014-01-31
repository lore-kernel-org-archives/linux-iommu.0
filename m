From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] arm: dma-mapping: Add support to extend DMA IOMMU mappings
Date: Fri, 31 Jan 2014 18:23:40 +0100
Message-ID: <20140131172340.GQ13543@alberich>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
	<1389876263-25759-12-git-send-email-andreas.herrmann@calxeda.com>
	<52E8DE7D.5020801@samsung.com>
	<20140129110537.GG26622@mudshark.cambridge.arm.com>
	<20140129144017.GA13543@alberich> <52EA0D43.1010802@samsung.com>
	<20140130084413.GC13543@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140130084413.GC13543@alberich>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Instead of using just one bitmap to keep track of IO virtual addresses
(handed out for IOMMU use) introduce an array of bitmaps. This allows
us to extend existing mappings when running out of iova space in the
initial mapping etc.

If there is not enough space in the mapping to service an IO virtual
address allocation request, __alloc_iova() tries to extend the mapping
-- by allocating another bitmap -- and makes another allocation
attempt using the freshly allocated bitmap.

This allows arm iommu drivers to start with a decent initial size when
an dma_iommu_mapping is created and still to avoid running out of IO
virtual addresses for the mapping.

A new parameter is introduced for arm_iommu_create_mapping:

  int extensions

	Specifies how often the initial mapping of size bytes can be
	 extended by another address range of size bytes.  Thus if
	 extensions = 0 is passed the mapping won't be extended at
	 all.

Adapt existing calls to arm_iommu_create_mapping in exynos_drm_iommu.c
and shmobile-iommu.c such that they do not make use of the extension
feature.

Adapt existing call to arm_iommu_create_mapping in arm-smmu.c such
that the extension feature will be used. (The resulting maximum
mapping size is 4GB.)

Tests were done on Calxeda ECX-2000 with smmu for sata and xgmac.
I've used SZ_512K for the size of the mapping and 31 for the
extensions parameter.

Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/include/asm/dma-iommu.h          |   12 ++-
 arch/arm/mm/dma-mapping.c                 |  135 ++++++++++++++++++++++++-----
 drivers/gpu/drm/exynos/exynos_drm_iommu.c |    4 +-
 drivers/iommu/arm-smmu.c                  |    2 +-
 drivers/iommu/shmobile-iommu.c            |    2 +-
 5 files changed, 126 insertions(+), 29 deletions(-)

Hi Marek, Will,

Here is a 2nd attempt to implement this feature. This time using
an array of bitmaps. The initial size for the mapping will be used
to extend the mapping if running out of unused IO addresses.

Comments welcome.


Regards,
Andreas


diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index a8c56ac..e12c6c2 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -13,8 +13,12 @@ struct dma_iommu_mapping {
 	/* iommu specific data */
 	struct iommu_domain	*domain;
 
-	void			*bitmap;
-	size_t			bits;
+	unsigned long		**bitmaps;	/* array of bitmaps */
+	unsigned int		nr_bitmaps;	/* nr of elements in array */
+	unsigned int		extensions;
+	size_t			bitmap_size;	/* size of a sinble bitmap */
+	size_t			bits;		/* per bitmap */
+	unsigned int		size;		/* per bitmap */
 	unsigned int		order;
 	dma_addr_t		base;
 
@@ -23,8 +27,8 @@ struct dma_iommu_mapping {
 };
 
 struct dma_iommu_mapping *
-arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
-			 int order);
+arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base,  size_t size,
+			int order, int extensions);
 
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f61a570..bd9cd22 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1069,6 +1069,8 @@ fs_initcall(dma_debug_do_init);
 
 /* IOMMU */
 
+static int extend_iommu_mapping(struct dma_iommu_mapping *mapping);
+
 static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 				      size_t size)
 {
@@ -1076,6 +1078,8 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	unsigned int align = 0;
 	unsigned int count, start;
 	unsigned long flags;
+	dma_addr_t iova;
+	int i;
 
 	if (order > CONFIG_ARM_DMA_IOMMU_ALIGNMENT)
 		order = CONFIG_ARM_DMA_IOMMU_ALIGNMENT;
@@ -1087,30 +1091,78 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 		align = (1 << (order - mapping->order)) - 1;
 
 	spin_lock_irqsave(&mapping->lock, flags);
-	start = bitmap_find_next_zero_area(mapping->bitmap, mapping->bits, 0,
-					   count, align);
-	if (start > mapping->bits) {
-		spin_unlock_irqrestore(&mapping->lock, flags);
-		return DMA_ERROR_CODE;
+	for (i = 0; i < mapping->nr_bitmaps; i++) {
+		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
+				mapping->bits, 0, count, align);
+
+		if (start > mapping->bits)
+			continue;
+
+		bitmap_set(mapping->bitmaps[i], start, count);
+		break;
 	}
 
-	bitmap_set(mapping->bitmap, start, count);
+	/*
+	 * No unused range found. Try to extend the existing mapping
+	 * and perform a second attempt to reserve an IO virtual
+	 * address range of size bytes.
+	 */
+	if (i == mapping->nr_bitmaps) {
+		if (extend_iommu_mapping(mapping)) {
+			spin_unlock_irqrestore(&mapping->lock, flags);
+			return DMA_ERROR_CODE;
+		}
+		pr_err("extended iommu mapping\n");
+		start = bitmap_find_next_zero_area(mapping->bitmaps[i],
+				mapping->bits, 0, count, align);
+
+		if (start > mapping->bits) {
+			spin_unlock_irqrestore(&mapping->lock, flags);
+			return DMA_ERROR_CODE;
+		}
+
+		bitmap_set(mapping->bitmaps[i], start, count);
+	}
 	spin_unlock_irqrestore(&mapping->lock, flags);
 
-	return mapping->base + (start << (mapping->order + PAGE_SHIFT));
+	iova = mapping->base + (mapping->size * i);
+	iova += start << (mapping->order + PAGE_SHIFT);
+
+	return iova;
 }
 
 static inline void __free_iova(struct dma_iommu_mapping *mapping,
 			       dma_addr_t addr, size_t size)
 {
-	unsigned int start = (addr - mapping->base) >>
-			     (mapping->order + PAGE_SHIFT);
-	unsigned int count = ((size >> PAGE_SHIFT) +
-			      (1 << mapping->order) - 1) >> mapping->order;
+	unsigned int start, count;
 	unsigned long flags;
+	dma_addr_t bitmap_base;
+	u32 bitmap_index;
+
+	if (!size)
+		return;
+
+	bitmap_index = (u32) (addr - mapping->base) / (u32) mapping->size;
+	BUG_ON(addr < mapping->base || bitmap_index > mapping->extensions);
+
+	bitmap_base = mapping->base + mapping->size * bitmap_index;
+
+	start = (addr - bitmap_base) >>	(mapping->order + PAGE_SHIFT);
+
+	if (addr + size > bitmap_base + mapping->size) {
+		/*
+		 * The address range to be freed reaches into the iova
+		 * range of the next bitmap. This should not happen as
+		 * we don't allow this in __alloc_iova (at the
+		 * moment).
+		 */
+		BUG();
+	} else
+		count = ((size >> PAGE_SHIFT) +
+			(1 << mapping->order) - 1) >> mapping->order;
 
 	spin_lock_irqsave(&mapping->lock, flags);
-	bitmap_clear(mapping->bitmap, start, count);
+	bitmap_clear(mapping->bitmaps[bitmap_index], start, count);
 	spin_unlock_irqrestore(&mapping->lock, flags);
 }
 
@@ -1875,22 +1927,30 @@ struct dma_map_ops iommu_coherent_ops = {
  * arm_iommu_create_mapping
  * @bus: pointer to the bus holding the client device (for IOMMU calls)
  * @base: start address of the valid IO address space
- * @size: size of the valid IO address space
+ * @size: (initial) size of the valid IO address space
  * @order: accuracy of the IO addresses allocations
+ * @extensions: specifies how many times it's allowed to extend the initial
+ *              mapping (0 - no extension at all, 1 - mapping can be extended
+ *              once, 2 - mapping can be extended twice, etc.)
  *
  * Creates a mapping structure which holds information about used/unused
  * IO address ranges, which is required to perform memory allocation and
  * mapping with IOMMU aware functions.
  *
+ * If a positive extensions parameter is passed the mapping will be
+ * extended (by size bytes) when the mapping runs out of unused IO
+ * addresses.  Thus the maximum size of the mapping is
+ *
+ *      size * (1 + extensions)
+ *
  * The client device need to be attached to the mapping with
  * arm_iommu_attach_device function.
  */
 struct dma_iommu_mapping *
 arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
-			 int order)
+			int order, int extensions)
 {
 	unsigned int count = size >> (PAGE_SHIFT + order);
-	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
 	struct dma_iommu_mapping *mapping;
 	int err = -ENOMEM;
 
@@ -1901,23 +1961,35 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
 	if (!mapping)
 		goto err;
 
-	mapping->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!mapping->bitmap)
+	mapping->bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
+	mapping->bitmaps = kzalloc((extensions + 1) * sizeof(unsigned long *),
+				GFP_KERNEL);
+	if (!mapping->bitmaps)
 		goto err2;
 
+	mapping->bitmaps[0] = kzalloc(mapping->bitmap_size, GFP_KERNEL);
+	if (!mapping->bitmaps[0])
+		goto err3;
+
+	mapping->nr_bitmaps = 1;
+	mapping->extensions = extensions;
 	mapping->base = base;
-	mapping->bits = BITS_PER_BYTE * bitmap_size;
+	mapping->size = size;
 	mapping->order = order;
+	mapping->bits = BITS_PER_BYTE * mapping->bitmap_size;
+
 	spin_lock_init(&mapping->lock);
 
 	mapping->domain = iommu_domain_alloc(bus);
 	if (!mapping->domain)
-		goto err3;
+		goto err4;
 
 	kref_init(&mapping->kref);
 	return mapping;
+err4:
+	kfree(mapping->bitmaps[0]);
 err3:
-	kfree(mapping->bitmap);
+	kfree(mapping->bitmaps);
 err2:
 	kfree(mapping);
 err:
@@ -1927,14 +1999,35 @@ EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
 static void release_iommu_mapping(struct kref *kref)
 {
+	int i;
 	struct dma_iommu_mapping *mapping =
 		container_of(kref, struct dma_iommu_mapping, kref);
 
 	iommu_domain_free(mapping->domain);
-	kfree(mapping->bitmap);
+	for (i = 0; i < mapping->nr_bitmaps; i++)
+		kfree(mapping->bitmaps[i]);
+	kfree(mapping->bitmaps);
 	kfree(mapping);
 }
 
+static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
+{
+	int next_bitmap;
+
+	if (mapping->nr_bitmaps > mapping->extensions)
+		return -EINVAL;
+
+	next_bitmap = mapping->nr_bitmaps;
+	mapping->bitmaps[next_bitmap] = kzalloc(mapping->bitmap_size,
+						GFP_ATOMIC);
+	if (!mapping->bitmaps[next_bitmap])
+		return -ENOMEM;
+
+	mapping->nr_bitmaps++;
+
+	return 0;
+}
+
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 {
 	if (mapping)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_iommu.c b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
index fb8db03..cc8389e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_iommu.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_iommu.c
@@ -40,8 +40,8 @@ int drm_create_iommu_mapping(struct drm_device *drm_dev)
 		priv->da_space_order = EXYNOS_DEV_ADDR_ORDER;
 
 	mapping = arm_iommu_create_mapping(&platform_bus_type, priv->da_start,
-						priv->da_space_size,
-						priv->da_space_order);
+					priv->da_space_size,
+					priv->da_space_order, 0);
 	if (IS_ERR(mapping))
 		return PTR_ERR(mapping);
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index bee88c8..67b3364 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1694,7 +1694,7 @@ static int arm_smmu_group_notifier(struct notifier_block *nb,
 			break;
 
 		mapping = arm_iommu_create_mapping(&platform_bus_type,
-						0, SZ_128M, 0);
+						0, SZ_128M, 0, 31);
 		if (IS_ERR(mapping)) {
 			ret = PTR_ERR(mapping);
 			dev_info(dev, "arm_iommu_create_mapping failed\n");
diff --git a/drivers/iommu/shmobile-iommu.c b/drivers/iommu/shmobile-iommu.c
index d572863..2540b7e 100644
--- a/drivers/iommu/shmobile-iommu.c
+++ b/drivers/iommu/shmobile-iommu.c
@@ -343,7 +343,7 @@ static int shmobile_iommu_add_device(struct device *dev)
 	mapping = archdata->iommu_mapping;
 	if (!mapping) {
 		mapping = arm_iommu_create_mapping(&platform_bus_type, 0,
-						   L1_LEN << 20, 0);
+						L1_LEN << 20, 0, 0);
 		if (IS_ERR(mapping))
 			return PTR_ERR(mapping);
 		archdata->iommu_mapping = mapping;
-- 
1.7.9.5
