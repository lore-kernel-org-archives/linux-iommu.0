From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] arm: dma-mapping: Add support to extend DMA IOMMU mappings
Date: Tue, 25 Feb 2014 13:42:20 +0100
Message-ID: <1393332141-17781-2-git-send-email-m.szyprowski@samsung.com>
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
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

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

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
[mszyprow: removed extensions parameter to arm_iommu_create_mapping()
 function, which will be modified in the next patch anyway, also some
 debug messages about extending bitmap]
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/include/asm/dma-iommu.h |    8 ++-
 arch/arm/mm/dma-mapping.c        |  123 ++++++++++++++++++++++++++++++++------
 2 files changed, 110 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index a8c56ac..686797c 100644
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
+	size_t			bitmap_size;	/* size of a single bitmap */
+	size_t			bits;		/* per bitmap */
+	unsigned int		size;		/* per bitmap */
 	unsigned int		order;
 	dma_addr_t		base;
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c9c6acdf..cc42bc2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1066,6 +1066,8 @@ fs_initcall(dma_debug_do_init);
 
 /* IOMMU */
 
+static int extend_iommu_mapping(struct dma_iommu_mapping *mapping);
+
 static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 				      size_t size)
 {
@@ -1073,6 +1075,8 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	unsigned int align = 0;
 	unsigned int count, start;
 	unsigned long flags;
+	dma_addr_t iova;
+	int i;
 
 	if (order > CONFIG_ARM_DMA_IOMMU_ALIGNMENT)
 		order = CONFIG_ARM_DMA_IOMMU_ALIGNMENT;
@@ -1084,30 +1088,78 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
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
+
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
 
@@ -1887,8 +1939,8 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
 			 int order)
 {
 	unsigned int count = size >> (PAGE_SHIFT + order);
-	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
 	struct dma_iommu_mapping *mapping;
+	int extensions = 0;
 	int err = -ENOMEM;
 
 	if (!count)
@@ -1898,23 +1950,35 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
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
@@ -1924,14 +1988,35 @@ EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
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
-- 
1.7.9.5
