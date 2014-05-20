From: <ritesh.harjani@gmail.com>
Subject: [PATCH v2] arm: dma-iommu: Clean up redundant variable
Date: Tue, 20 May 2014 10:02:59 +0530
Message-ID: <1400560379-1502-1-git-send-email-ritesh.harjani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: m.szyprowski@samsung.com, catalin.marinas@arm.com
Cc: mp.vikram@gmail.com, Will.Deacon@arm.com, iommu@lists.linux-foundation.org, laurent.pinchart@ideasonboard.com, ritesh.harjani@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

mapping->size can be derived from mapping->bits << PAGE_SHIFT
which makes mapping->size as redundant.

Clean this up.

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
Reported-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/dma-iommu.h |  1 -
 arch/arm/mm/dma-mapping.c        | 11 ++++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
index eec0a12..8e3fcb9 100644
--- a/arch/arm/include/asm/dma-iommu.h
+++ b/arch/arm/include/asm/dma-iommu.h
@@ -18,7 +18,6 @@ struct dma_iommu_mapping {
 	unsigned int		extensions;
 	size_t			bitmap_size;	/* size of a single bitmap */
 	size_t			bits;		/* per bitmap */
-	unsigned int		size;		/* per bitmap */
 	dma_addr_t		base;
 
 	spinlock_t		lock;
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b00be1..3d43c41 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1074,6 +1074,7 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	unsigned int order = get_order(size);
 	unsigned int align = 0;
 	unsigned int count, start;
+	size_t mapping_size = mapping->bits << PAGE_SHIFT;
 	unsigned long flags;
 	dma_addr_t iova;
 	int i;
@@ -1119,7 +1120,7 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
 	}
 	spin_unlock_irqrestore(&mapping->lock, flags);
 
-	iova = mapping->base + (mapping->size * i);
+	iova = mapping->base + (mapping_size * i);
 	iova += start << PAGE_SHIFT;
 
 	return iova;
@@ -1129,6 +1130,7 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 			       dma_addr_t addr, size_t size)
 {
 	unsigned int start, count;
+	size_t mapping_size = mapping->bits << PAGE_SHIFT;
 	unsigned long flags;
 	dma_addr_t bitmap_base;
 	u32 bitmap_index;
@@ -1136,14 +1138,14 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 	if (!size)
 		return;
 
-	bitmap_index = (u32) (addr - mapping->base) / (u32) mapping->size;
+	bitmap_index = (u32) (addr - mapping->base) / (u32) mapping_size;
 	BUG_ON(addr < mapping->base || bitmap_index > mapping->extensions);
 
-	bitmap_base = mapping->base + mapping->size * bitmap_index;
+	bitmap_base = mapping->base + mapping_size * bitmap_index;
 
 	start = (addr - bitmap_base) >>	PAGE_SHIFT;
 
-	if (addr + size > bitmap_base + mapping->size) {
+	if (addr + size > bitmap_base + mapping_size) {
 		/*
 		 * The address range to be freed reaches into the iova
 		 * range of the next bitmap. This should not happen as
@@ -1964,7 +1966,6 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
 	mapping->extensions = extensions;
 	mapping->base = base;
 	mapping->bits = BITS_PER_BYTE * bitmap_size;
-	mapping->size = mapping->bits << PAGE_SHIFT;
 
 	spin_lock_init(&mapping->lock);
 
-- 
1.8.1.3
