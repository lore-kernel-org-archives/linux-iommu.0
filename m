From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/5] x86: enable DMA CMA with swiotlb
Date: Tue, 14 Jan 2014 23:13:47 +0900
Message-ID: <1389708830-5841-3-git-send-email-akinobu.mita@gmail.com>
References: <1389708830-5841-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389708830-5841-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The DMA Contiguous Memory Allocator support on x86 is disabled when
swiotlb config option is enabled.  So DMA CMA is always disabled on
x86_64 because swiotlb is always enabled.  This attempts to support
for DMA CMA with enabling swiotlb config option.

The contiguous memory allocator on x86 is integrated in the function
dma_generic_alloc_coherent() which is .alloc callback in nommu_dma_ops
for dma_alloc_coherent().

x86_swiotlb_alloc_coherent() which is .alloc callback in swiotlb_dma_ops
tries to allocate with dma_generic_alloc_coherent() firstly and then
swiotlb_alloc_coherent() is called as a fallback.

The main part of supporting DMA CMA with swiotlb is that changing
x86_swiotlb_free_coherent() which is .free callback in swiotlb_dma_ops
for dma_free_coherent() so that it can distinguish memory allocated by
dma_generic_alloc_coherent() from one allocated by swiotlb_alloc_coherent()
and release it with dma_generic_free_coherent() which can handle contiguous
memory.  This change requires making is_swiotlb_buffer() global function.

This also needs to change .free callback in the dma_map_ops for amd_gart
and sta2x11, because these dma_ops are also using
dma_generic_alloc_coherent().

Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
No change from the previous version

 arch/x86/Kconfig               | 2 +-
 arch/x86/include/asm/swiotlb.h | 7 +++++++
 arch/x86/kernel/amd_gart_64.c  | 2 +-
 arch/x86/kernel/pci-swiotlb.c  | 9 ++++++---
 arch/x86/pci/sta2x11-fixup.c   | 6 ++----
 include/linux/swiotlb.h        | 2 ++
 lib/swiotlb.c                  | 2 +-
 7 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0952ecd..1b6275d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -40,7 +40,7 @@ config X86
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_FRAME_POINTERS
 	select HAVE_DMA_ATTRS
-	select HAVE_DMA_CONTIGUOUS if !SWIOTLB
+	select HAVE_DMA_CONTIGUOUS
 	select HAVE_KRETPROBES
 	select HAVE_OPTPROBES
 	select HAVE_KPROBES_ON_FTRACE
diff --git a/arch/x86/include/asm/swiotlb.h b/arch/x86/include/asm/swiotlb.h
index 977f176..ab05d73 100644
--- a/arch/x86/include/asm/swiotlb.h
+++ b/arch/x86/include/asm/swiotlb.h
@@ -29,4 +29,11 @@ static inline void pci_swiotlb_late_init(void)
 
 static inline void dma_mark_clean(void *addr, size_t size) {}
 
+extern void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
+					dma_addr_t *dma_handle, gfp_t flags,
+					struct dma_attrs *attrs);
+extern void x86_swiotlb_free_coherent(struct device *dev, size_t size,
+					void *vaddr, dma_addr_t dma_addr,
+					struct dma_attrs *attrs);
+
 #endif /* _ASM_X86_SWIOTLB_H */
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index b574b29..8e3842f 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -512,7 +512,7 @@ gart_free_coherent(struct device *dev, size_t size, void *vaddr,
 		   dma_addr_t dma_addr, struct dma_attrs *attrs)
 {
 	gart_unmap_page(dev, dma_addr, size, DMA_BIDIRECTIONAL, NULL);
-	free_pages((unsigned long)vaddr, get_order(size));
+	dma_generic_free_coherent(dev, size, vaddr, dma_addr, attrs);
 }
 
 static int gart_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 6c483ba..77dd0ad 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -14,7 +14,7 @@
 #include <asm/iommu_table.h>
 int swiotlb __read_mostly;
 
-static void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
+void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 					dma_addr_t *dma_handle, gfp_t flags,
 					struct dma_attrs *attrs)
 {
@@ -28,11 +28,14 @@ static void *x86_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	return swiotlb_alloc_coherent(hwdev, size, dma_handle, flags);
 }
 
-static void x86_swiotlb_free_coherent(struct device *dev, size_t size,
+void x86_swiotlb_free_coherent(struct device *dev, size_t size,
 				      void *vaddr, dma_addr_t dma_addr,
 				      struct dma_attrs *attrs)
 {
-	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
+	if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
+		swiotlb_free_coherent(dev, size, vaddr, dma_addr);
+	else
+		dma_generic_free_coherent(dev, size, vaddr, dma_addr, attrs);
 }
 
 static struct dma_map_ops swiotlb_dma_ops = {
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 9d8a509..5ceda85 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -173,9 +173,7 @@ static void *sta2x11_swiotlb_alloc_coherent(struct device *dev,
 {
 	void *vaddr;
 
-	vaddr = dma_generic_alloc_coherent(dev, size, dma_handle, flags, attrs);
-	if (!vaddr)
-		vaddr = swiotlb_alloc_coherent(dev, size, dma_handle, flags);
+	vaddr = x86_swiotlb_alloc_coherent(dev, size, dma_handle, flags, attrs);
 	*dma_handle = p2a(*dma_handle, to_pci_dev(dev));
 	return vaddr;
 }
@@ -183,7 +181,7 @@ static void *sta2x11_swiotlb_alloc_coherent(struct device *dev,
 /* We have our own dma_ops: the same as swiotlb but from alloc (above) */
 static struct dma_map_ops sta2x11_dma_ops = {
 	.alloc = sta2x11_swiotlb_alloc_coherent,
-	.free = swiotlb_free_coherent,
+	.free = x86_swiotlb_free_coherent,
 	.map_page = swiotlb_map_page,
 	.unmap_page = swiotlb_unmap_page,
 	.map_sg = swiotlb_map_sg_attrs,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index a5ffd32..e7a018e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -116,4 +116,6 @@ static inline void swiotlb_free(void) { }
 #endif
 
 extern void swiotlb_print_info(void);
+extern int is_swiotlb_buffer(phys_addr_t paddr);
+
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index fe978e0..6e4a798 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -369,7 +369,7 @@ void __init swiotlb_free(void)
 	io_tlb_nslabs = 0;
 }
 
-static int is_swiotlb_buffer(phys_addr_t paddr)
+int is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
-- 
1.8.3.2
