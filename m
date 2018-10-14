From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH] dma-mapping: move the remap helpers to a separate file
Date: Sun, 14 Oct 2018 20:16:51 +0200
Message-ID: <20181014181651.22971-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The dma remap code only really makes sense for not cache coherent
architectures, and currently is only used by arm, arm64 and xtensa.
Split it out into a separate file with a separate Kconfig symbol.

[Laura: you wrote this code back then, do you have a sensible
 copyright statement to add, given that the mapping.c statement
 obviously does not match your code that was written much later]

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 arch/arm/Kconfig     |  1 +
 arch/arm64/Kconfig   |  1 +
 arch/xtensa/Kconfig  |  1 +
 kernel/dma/Kconfig   |  4 +++
 kernel/dma/Makefile  |  2 +-
 kernel/dma/mapping.c | 84 -------------------------------------------
 kernel/dma/remap.c   | 85 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 93 insertions(+), 85 deletions(-)
 create mode 100644 kernel/dma/remap.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..cf54e572dafd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,6 +30,7 @@ config ARM
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select DMA_DIRECT_OPS if !MMU
+	select DMA_REMAP if MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
 	select GENERIC_ALLOCATOR
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1b1a0e95c751..179994b67d11 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -77,6 +77,7 @@ config ARM64
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS
 	select DMA_DIRECT_OPS
+	select DMA_REMAP
 	select EDAC_SUPPORT
 	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 9a7c654a7654..d57abe4cad0f 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -10,6 +10,7 @@ config XTENSA
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_DIRECT_OPS
+	select DMA_REMAP if MMU
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_SHOW
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 645c7a2ecde8..c92e08173ed8 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -51,3 +51,7 @@ config SWIOTLB
 	bool
 	select DMA_DIRECT_OPS
 	select NEED_DMA_MAP_STATE
+
+config DMA_REMAP
+	depends on MMU
+	bool
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 7d581e4eea4a..f4feeceb8020 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_DMA_DIRECT_OPS)		+= direct.o
 obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
-
+obj-$(CONFIG_DMA_REMAP)			+= remap.o
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 58dec7a92b7b..dfbc3deb95cd 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -262,87 +262,3 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 #endif /* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
 }
 EXPORT_SYMBOL(dma_common_mmap);
-
-#ifdef CONFIG_MMU
-static struct vm_struct *__dma_common_pages_remap(struct page **pages,
-			size_t size, unsigned long vm_flags, pgprot_t prot,
-			const void *caller)
-{
-	struct vm_struct *area;
-
-	area = get_vm_area_caller(size, vm_flags, caller);
-	if (!area)
-		return NULL;
-
-	if (map_vm_area(area, prot, pages)) {
-		vunmap(area->addr);
-		return NULL;
-	}
-
-	return area;
-}
-
-/*
- * remaps an array of PAGE_SIZE pages into another vm_area
- * Cannot be used in non-sleeping contexts
- */
-void *dma_common_pages_remap(struct page **pages, size_t size,
-			unsigned long vm_flags, pgprot_t prot,
-			const void *caller)
-{
-	struct vm_struct *area;
-
-	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
-	if (!area)
-		return NULL;
-
-	area->pages = pages;
-
-	return area->addr;
-}
-
-/*
- * remaps an allocated contiguous region into another vm_area.
- * Cannot be used in non-sleeping contexts
- */
-
-void *dma_common_contiguous_remap(struct page *page, size_t size,
-			unsigned long vm_flags,
-			pgprot_t prot, const void *caller)
-{
-	int i;
-	struct page **pages;
-	struct vm_struct *area;
-
-	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
-	if (!pages)
-		return NULL;
-
-	for (i = 0; i < (size >> PAGE_SHIFT); i++)
-		pages[i] = nth_page(page, i);
-
-	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
-
-	kfree(pages);
-
-	if (!area)
-		return NULL;
-	return area->addr;
-}
-
-/*
- * unmaps a range previously mapped by dma_common_*_remap
- */
-void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
-{
-	struct vm_struct *area = find_vm_area(cpu_addr);
-
-	if (!area || (area->flags & vm_flags) != vm_flags) {
-		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
-		return;
-	}
-
-	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
-	vunmap(cpu_addr);
-}
-#endif
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
new file mode 100644
index 000000000000..33dff4096d46
--- /dev/null
+++ b/kernel/dma/remap.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+static struct vm_struct *__dma_common_pages_remap(struct page **pages,
+			size_t size, unsigned long vm_flags, pgprot_t prot,
+			const void *caller)
+{
+	struct vm_struct *area;
+
+	area = get_vm_area_caller(size, vm_flags, caller);
+	if (!area)
+		return NULL;
+
+	if (map_vm_area(area, prot, pages)) {
+		vunmap(area->addr);
+		return NULL;
+	}
+
+	return area;
+}
+
+/*
+ * remaps an array of PAGE_SIZE pages into another vm_area
+ * Cannot be used in non-sleeping contexts
+ */
+void *dma_common_pages_remap(struct page **pages, size_t size,
+			unsigned long vm_flags, pgprot_t prot,
+			const void *caller)
+{
+	struct vm_struct *area;
+
+	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+	if (!area)
+		return NULL;
+
+	area->pages = pages;
+
+	return area->addr;
+}
+
+/*
+ * Remaps an allocated contiguous region into another vm_area.
+ * Cannot be used in non-sleeping contexts
+ */
+void *dma_common_contiguous_remap(struct page *page, size_t size,
+			unsigned long vm_flags,
+			pgprot_t prot, const void *caller)
+{
+	int i;
+	struct page **pages;
+	struct vm_struct *area;
+
+	pages = kmalloc(sizeof(struct page *) << get_order(size), GFP_KERNEL);
+	if (!pages)
+		return NULL;
+
+	for (i = 0; i < (size >> PAGE_SHIFT); i++)
+		pages[i] = nth_page(page, i);
+
+	area = __dma_common_pages_remap(pages, size, vm_flags, prot, caller);
+
+	kfree(pages);
+
+	if (!area)
+		return NULL;
+	return area->addr;
+}
+
+/*
+ * Unmaps a range previously mapped by dma_common_*_remap
+ */
+void dma_common_free_remap(void *cpu_addr, size_t size, unsigned long vm_flags)
+{
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (!area || (area->flags & vm_flags) != vm_flags) {
+		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
+		return;
+	}
+
+	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
+	vunmap(cpu_addr);
+}
-- 
2.19.1
