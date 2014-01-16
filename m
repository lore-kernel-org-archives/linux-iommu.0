From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: [PATCH 11/11] arm: dma-mapping: Add support to extend DMA IOMMU
 mappings
Date: Thu, 16 Jan 2014 13:44:23 +0100
Message-ID: <1389876263-25759-12-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King <linux@arm.linux.org.uk>, Andreas Herrmann <herrmann.der.user@googlemail.com>, iommu@lists.linux-foundation.org, Andreas Herrmann <andreas.herrmann@calxeda.com>, Hiroshi Doyu <hdoyu@nvidia.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Instead of using just one bitmap to keep track of IO virtual addresses
(handed out for IOMMU use) introduce a list of iova_ranges (each
having its own bitmap). This allows us to extend existing mappings
when running out of iova space for a mapping.

If there is not enough space in the mapping to service an IO virtual
address allocation request, __alloc_iova() tries to extend the mapping
-- by allocating another bitmap -- and makes another allocation
attempt using the freshly allocated bitmap.

This allows arm iommu drivers to start with a decent initial size when
an dma_iommu_mapping is created and still to avoid running out of IO
virtual addresses for the mapping.

Tests were done on Calxeda ECX-2000 with smmu for sata and xgmac.
I've used SZ_512K both for initial mapping size and grow_size.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 arch/arm/include/asm/dma-iommu.h |   17 ++++-
 arch/arm/mm/dma-mapping.c        |  147 ++++++++++++++++++++++++++++++++------
 2 files changed, 139 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index 50edacd..987d62c 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -8,15 +8,26 @@
 #include <linux/dma-debug.h>
 #include <linux/kmemcheck.h>
 #include <linux/kref.h>
+#include <linux/list.h>
+
+struct dma_iommu_iova_range {
+	struct list_head	list_head;
+	unsigned long		*bitmap;
+	size_t			bits;
+	dma_addr_t		base;
+	dma_addr_t		size;
+};
 
 struct dma_iommu_mapping {
 	/* iommu specific data */
 	struct iommu_domain	*domain;
 
-	void			*bitmap;
-	size_t			bits;
-	unsigned int		order;
+	struct list_head	iova_ranges;
 	dma_addr_t		base;
+	dma_addr_t		size;
+	dma_addr_t		grow_size;
+	dma_addr_t		max_size;
+	unsigned int		order;
 
 	spinlock_t		lock;
 	struct kref		kref;
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ccea46a..503e8d6 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/list.h>
 
 #include <asm/memory.h>
 #include <asm/highmem.h>
@@ -1069,6 +1070,8 @@ fs_initcall(dma_debug_do_init);
 
 /* IOMMU */
 
+static int extend_iommu_mapping(struct dma_iommu_mapping *mapping);
+
 static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 				      size_t size)
 {
@@ -1076,6 +1079,8 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	unsigned int align = 0;
 	unsigned int count, start;
 	unsigned long flags;
+	struct dma_iommu_iova_range *e;
+	bool area_found;
 
 	if (order > CONFIG_ARM_DMA_IOMMU_ALIGNMENT)
 		order = CONFIG_ARM_DMA_IOMMU_ALIGNMENT;
@@ -1086,32 +1091,80 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	if (order > mapping->order)
 		align = (1 << (order - mapping->order)) - 1;
 
+	area_found = false;
 	spin_lock_irqsave(&mapping->lock, flags);
-	start = bitmap_find_next_zero_area(mapping->bitmap, mapping->bits, 0,
-					   count, align);
-	if (start > mapping->bits) {
-		spin_unlock_irqrestore(&mapping->lock, flags);
-		return DMA_ERROR_CODE;
+	list_for_each_entry(e, &mapping->iova_ranges, list_head) {
+		start = bitmap_find_next_zero_area(e->bitmap, e->bits, 0,
+						count, align);
+		if (start > e->bits)
+			continue;
+
+		bitmap_set(e->bitmap, start, count);
+		area_found = true;
+		break;
 	}
 
-	bitmap_set(mapping->bitmap, start, count);
+	/*
+	 * Try to extend the existing mapping and perform a second
+	 * attempt to reserve an IO virtual address range of size
+	 * bytes.
+	 */
+	if (!area_found) {
+		if (extend_iommu_mapping(mapping)) {
+			spin_unlock_irqrestore(&mapping->lock, flags);
+			return DMA_ERROR_CODE;
+		}
+		e = list_entry(mapping->iova_ranges.prev,
+			struct dma_iommu_iova_range, list_head);
+		start = bitmap_find_next_zero_area(e->bitmap, e->bits, 0,
+						count, align);
+		if (start > e->bits) {
+			spin_unlock_irqrestore(&mapping->lock, flags);
+			return DMA_ERROR_CODE;
+		}
+		bitmap_set(e->bitmap, start, count);
+	}
 	spin_unlock_irqrestore(&mapping->lock, flags);
 
-	return mapping->base + (start << (mapping->order + PAGE_SHIFT));
+	return e->base + (start << (mapping->order + PAGE_SHIFT));
 }
 
 static inline void __free_iova(struct dma_iommu_mapping *mapping,
 			       dma_addr_t addr, size_t size)
 {
-	unsigned int start = (addr - mapping->base) >>
-			     (mapping->order + PAGE_SHIFT);
-	unsigned int count = ((size >> PAGE_SHIFT) +
-			      (1 << mapping->order) - 1) >> mapping->order;
+	struct dma_iommu_iova_range *e;
+	unsigned int start, count, tmp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&mapping->lock, flags);
-	bitmap_clear(mapping->bitmap, start, count);
-	spin_unlock_irqrestore(&mapping->lock, flags);
+	list_for_each_entry(e, &mapping->iova_ranges, list_head) {
+		if (!size)
+			break;
+		if ((addr < e->base) || (addr >= e->base + e->size))
+			continue;
+
+		start = (addr - e->base) >> (mapping->order + PAGE_SHIFT);
+		if (addr + size > e->base + e->size) {
+			/*
+			 * The address range to be freed crosses an
+			 * iova_range boundary.
+			 * Hence calc count parameter to fit within
+			 * current iova_range and prepare addr and
+			 * size for next iteration.
+			 */
+			tmp = (e->base + e->size) - addr;
+			count = ((tmp >> PAGE_SHIFT) +
+				(1 << mapping->order) - 1) >> mapping->order;
+			size -= tmp;
+			addr += tmp;
+		} else {
+			count = ((size >> PAGE_SHIFT) +
+				(1 << mapping->order) - 1) >> mapping->order;
+			size -= size;
+		}
+		spin_lock_irqsave(&mapping->lock, flags);
+		bitmap_clear(e->bitmap, start, count);
+		spin_unlock_irqrestore(&mapping->lock, flags);
+	}
 }
 
 static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
@@ -1892,6 +1945,7 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
 	unsigned int count = size >> (PAGE_SHIFT + order);
 	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
 	struct dma_iommu_mapping *mapping;
+	struct dma_iommu_iova_range *iovar;
 	int err = -ENOMEM;
 
 	if (!count)
@@ -1901,23 +1955,37 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size,
 	if (!mapping)
 		goto err;
 
-	mapping->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!mapping->bitmap)
+	INIT_LIST_HEAD(&mapping->iova_ranges);
+	spin_lock_init(&mapping->lock);
+
+	iovar = kzalloc(sizeof(struct dma_iommu_iova_range), GFP_KERNEL);
+	if (!iovar)
 		goto err2;
 
-	mapping->base = base;
-	mapping->bits = BITS_PER_BYTE * bitmap_size;
+	iovar->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
+	if (!iovar->bitmap)
+		goto err3;
+
+	iovar->bits = BITS_PER_BYTE * bitmap_size;
+	list_add_tail(&iovar->list_head, &mapping->iova_ranges);
+
+	mapping->base = iovar->base = base;
+	mapping->size = iovar->size = size;
+
 	mapping->order = order;
-	spin_lock_init(&mapping->lock);
+	mapping->grow_size = grow_size;
+	mapping->max_size = max_size;
 
 	mapping->domain = iommu_domain_alloc(bus);
 	if (!mapping->domain)
-		goto err3;
+		goto err4;
 
 	kref_init(&mapping->kref);
 	return mapping;
+err4:
+	kfree(iovar->bitmap);
 err3:
-	kfree(mapping->bitmap);
+	kfree(iovar);
 err2:
 	kfree(mapping);
 err:
@@ -1927,14 +1995,49 @@ EXPORT_SYMBOL_GPL(arm_iommu_create_mapping);
 
 static void release_iommu_mapping(struct kref *kref)
 {
+	struct dma_iommu_iova_range *e, *tmp;
 	struct dma_iommu_mapping *mapping =
 		container_of(kref, struct dma_iommu_mapping, kref);
 
 	iommu_domain_free(mapping->domain);
-	kfree(mapping->bitmap);
+	list_for_each_entry_safe(e, tmp, &mapping->iova_ranges, list_head) {
+		list_del(&e->list_head);
+		kfree(e->bitmap);
+		kfree(e);
+	}
 	kfree(mapping);
 }
 
+static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
+{
+	struct dma_iommu_iova_range *iovar;
+	unsigned int count = mapping->grow_size >> (PAGE_SHIFT + mapping->order);
+	unsigned int bitmap_size = BITS_TO_LONGS(count) * sizeof(long);
+
+	if (!mapping->grow_size ||
+		(mapping->size + mapping->grow_size) >= mapping->max_size)
+		return -EINVAL;
+
+	iovar = kzalloc(sizeof(struct dma_iommu_iova_range), GFP_ATOMIC);
+	if (!iovar)
+		return -ENOMEM;
+
+	iovar->bitmap = kzalloc(bitmap_size, GFP_ATOMIC);
+	if (!iovar->bitmap) {
+		kfree(iovar);
+		return -ENOMEM;
+	}
+
+	iovar->bits = BITS_PER_BYTE * bitmap_size;
+	iovar->base = mapping->base + mapping->size;
+	iovar->size = mapping->grow_size;
+
+	mapping->size += mapping->grow_size;
+	list_add_tail(&iovar->list_head, &mapping->iova_ranges);
+
+	return 0;
+}
+
 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
 {
 	if (mapping)
-- 
1.7.9.5
