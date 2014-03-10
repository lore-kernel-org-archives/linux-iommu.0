From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] arm64: iommu: Refactoring common code.
Date: Mon, 10 Mar 2014 22:02:50 +0530
Message-ID: <CAD15agbWL0A_vO4Osgi=uC1JxkMQgL3gshU3Z7euZf5eVaU0VA@mail.gmail.com>
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
To: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Everyone,

Please find the following patch as refactoring of the common code out
from arch/arm/mm/dma-mapping.c to lib/iommu-helper.c

This is just an initial version of patch to get more details and to
know if this is how we want to plan refactoring iommu code to
lib/iommu-helper.

Please let me know the changes/suggestion which you think in this ?




Taking out the common code of buffer allocation and mapping
for iommu from arch/arm to lib/iommu-helper file.

Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c    | 159 +++++-----------------------------------
 include/linux/iommu-helper.h |  22 ++++++
 lib/iommu-helper.c           | 169 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+), 140 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 11b3914..71e0dbd 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -26,6 +26,7 @@
 #include <linux/io.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/iommu-helper.h>

 #include <asm/memory.h>
 #include <asm/highmem.h>
@@ -1119,124 +1120,26 @@ static struct page
**__iommu_alloc_buffer(struct device *dev, size_t size,
 {
        struct page **pages;
        int count = size >> PAGE_SHIFT;
-       int array_size = count * sizeof(struct page *);
        int i = 0;

-       if (array_size <= PAGE_SIZE)
-               pages = kzalloc(array_size, gfp);
-       else
-               pages = vzalloc(array_size);
-       if (!pages)
-               return NULL;
-
-       if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs))
-       {
-               unsigned long order = get_order(size);
-               struct page *page;
-
-               page = dma_alloc_from_contiguous(dev, count, order);
-               if (!page)
-                       goto error;
-
-               __dma_clear_buffer(page, size);
-
-               for (i = 0; i < count; i++)
-                       pages[i] = page + i;
+       pages = iommu_lib_alloc_buffer(dev, size, gfp, attrs);

-               return pages;
-       }
-
-       /*
-        * IOMMU can map any pages, so himem can also be used here
-        */
-       gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
-
-       while (count) {
-               int j, order = __fls(count);
-
-               pages[i] = alloc_pages(gfp, order);
-               while (!pages[i] && order)
-                       pages[i] = alloc_pages(gfp, --order);
-               if (!pages[i])
-                       goto error;
-
-               if (order) {
-                       split_page(pages[i], order);
-                       j = 1 << order;
-                       while (--j)
-                               pages[i + j] = pages[i] + j;
+       if (!pages) {
+               return NULL;
+       } else {
+               while (count--) {
+                       __dma_clear_buffer(pages[i], PAGE_SIZE);
+                       i++;
                }
-
-               __dma_clear_buffer(pages[i], PAGE_SIZE << order);
-               i += 1 << order;
-               count -= 1 << order;
        }
-
        return pages;
-error:
-       while (i--)
-               if (pages[i])
-                       __free_pages(pages[i], 0);
-       if (array_size <= PAGE_SIZE)
-               kfree(pages);
-       else
-               vfree(pages);
-       return NULL;
+
 }

 static int __iommu_free_buffer(struct device *dev, struct page **pages,
                               size_t size, struct dma_attrs *attrs)
 {
-       int count = size >> PAGE_SHIFT;
-       int array_size = count * sizeof(struct page *);
-       int i;
-
-       if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
-               dma_release_from_contiguous(dev, pages[0], count);
-       } else {
-               for (i = 0; i < count; i++)
-                       if (pages[i])
-                               __free_pages(pages[i], 0);
-       }
-
-       if (array_size <= PAGE_SIZE)
-               kfree(pages);
-       else
-               vfree(pages);
-       return 0;
-}
-
-/*
- * Create a CPU mapping for a specified pages
- */
-static void *
-__iommu_alloc_remap(struct page **pages, size_t size, gfp_t gfp, pgprot_t prot,
-                   const void *caller)
-{
-       unsigned int i, nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
-       struct vm_struct *area;
-       unsigned long p;
-
-       area = get_vm_area_caller(size, VM_ARM_DMA_CONSISTENT | VM_USERMAP,
-                                 caller);
-       if (!area)
-               return NULL;
-
-       area->pages = pages;
-       area->nr_pages = nr_pages;
-       p = (unsigned long)area->addr;
-
-       for (i = 0; i < nr_pages; i++) {
-               phys_addr_t phys = __pfn_to_phys(page_to_pfn(pages[i]));
-               if (ioremap_page_range(p, p + PAGE_SIZE, phys, prot))
-                       goto err;
-               p += PAGE_SIZE;
-       }
-       return area->addr;
-err:
-       unmap_kernel_range((unsigned long)area->addr, size);
-       vunmap(area->addr);
-       return NULL;
+       return iommu_lib_free_buffer(dev, pages, size, attrs);
 }

 /*
@@ -1246,51 +1149,24 @@ static dma_addr_t
 __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
 {
        struct dma_iommu_mapping *mapping = dev->archdata.mapping;
-       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
        dma_addr_t dma_addr, iova;
-       int i, ret = DMA_ERROR_CODE;

        dma_addr = __alloc_iova(mapping, size);
        if (dma_addr == DMA_ERROR_CODE)
                return dma_addr;

-       iova = dma_addr;
-       for (i = 0; i < count; ) {
-               unsigned int next_pfn = page_to_pfn(pages[i]) + 1;
-               phys_addr_t phys = page_to_phys(pages[i]);
-               unsigned int len, j;
-
-               for (j = i + 1; j < count; j++, next_pfn++)
-                       if (page_to_pfn(pages[j]) != next_pfn)
-                               break;
+       iova = iommu_lib_map(mapping->domain, pages, dma_addr, size);
+       if (iova == DMA_ERROR_CODE)
+               __free_iova(mapping, dma_addr, size);

-               len = (j - i) << PAGE_SHIFT;
-               ret = iommu_map(mapping->domain, iova, phys, len,
-                               IOMMU_READ|IOMMU_WRITE);
-               if (ret < 0)
-                       goto fail;
-               iova += len;
-               i = j;
-       }
-       return dma_addr;
-fail:
-       iommu_unmap(mapping->domain, dma_addr, iova-dma_addr);
-       __free_iova(mapping, dma_addr, size);
-       return DMA_ERROR_CODE;
+       return iova;
 }

 static int __iommu_remove_mapping(struct device *dev, dma_addr_t
iova, size_t size)
 {
        struct dma_iommu_mapping *mapping = dev->archdata.mapping;

-       /*
-        * add optional in-page offset from iova to size and align
-        * result to page size
-        */
-       size = PAGE_ALIGN((iova & ~PAGE_MASK) + size);
-       iova &= PAGE_MASK;
-
-       iommu_unmap(mapping->domain, iova, size);
+       iommu_lib_unmap(mapping->domain, iova, size);
        __free_iova(mapping, iova, size);
        return 0;
 }
@@ -1354,6 +1230,7 @@ static void *arm_iommu_alloc_attrs(struct device
*dev, size_t size,
        pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
        struct page **pages;
        void *addr = NULL;
+       unsigned long flags = 0;

        *handle = DMA_ERROR_CODE;
        size = PAGE_ALIGN(size);
@@ -1381,7 +1258,9 @@ static void *arm_iommu_alloc_attrs(struct device
*dev, size_t size,
        if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
                return pages;

-       addr = __iommu_alloc_remap(pages, size, gfp, prot,
+       flags = VM_ARM_DMA_CONSISTENT | VM_USERMAP;
+
+       addr = iommu_lib_alloc_remap(pages, size, flags, prot,
                                   __builtin_return_address(0));
        if (!addr)
                goto err_mapping;
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 86bdeff..55d4797 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -2,6 +2,7 @@
 #define _LINUX_IOMMU_HELPER_H

 #include <linux/kernel.h>
+#include <linux/iommu.h>

 static inline unsigned long iommu_device_max_index(unsigned long size,
                                                   unsigned long offset,
@@ -31,4 +32,25 @@ static inline unsigned long
iommu_num_pages(unsigned long addr,
        return DIV_ROUND_UP(size, io_page_size);
 }

+extern struct page **iommu_lib_alloc_buffer(struct device *dev, size_t size,
+                                         gfp_t gfp, struct dma_attrs *attrs);
+
+extern int iommu_lib_free_buffer(struct device *dev, struct page **pages,
+                              size_t size, struct dma_attrs *attrs);
+
+extern dma_addr_t iommu_lib_map(struct iommu_domain *domain,
+                       struct page **pages, dma_addr_t iova, size_t size);
+
+extern void iommu_lib_unmap(struct iommu_domain *domain, dma_addr_t iova,
+                       size_t size);
+
+extern void *iommu_lib_alloc_remap(struct page **pages, size_t size,
+                               unsigned long flags, pgprot_t prot,
+                               const void *caller);
+
+
+
+
+
+
 #endif
diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index c27e269..4f80f9e 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -5,6 +5,13 @@
 #include <linux/export.h>
 #include <linux/bitmap.h>
 #include <linux/bug.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-contiguous.h>
+#include <linux/slab.h>
+#include <linux/iommu.h>
+#include <linux/io.h>
+#include <linux/vmalloc.h>
+#include <linux/sizes.h>

 int iommu_is_span_boundary(unsigned int index, unsigned int nr,
                           unsigned long shift,
@@ -39,3 +46,165 @@ again:
        return -1;
 }
 EXPORT_SYMBOL(iommu_area_alloc);
+
+struct page **iommu_lib_alloc_buffer(struct device *dev, size_t size,
+                                         gfp_t gfp, struct dma_attrs *attrs)
+{
+       struct page **pages;
+       int count = size >> PAGE_SHIFT;
+       int array_size = count * sizeof(struct page *);
+       int i = 0;
+
+       if (array_size <= PAGE_SIZE)
+               pages = kzalloc(array_size, gfp);
+       else
+               pages = vzalloc(array_size);
+       if (!pages)
+               return NULL;
+
+       if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
+               unsigned long order = get_order(size);
+               struct page *page;
+
+               page = dma_alloc_from_contiguous(dev, count, order);
+               if (!page)
+                       goto error;
+
+               for (i = 0; i < count; i++)
+                       pages[i] = page + i;
+
+               return pages;
+       }
+
+       /*
+        * IOMMU can map any pages, so himem can also be used here
+        */
+       gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+
+       while (count) {
+               int j, order = __fls(count);
+
+               pages[i] = alloc_pages(gfp, order);
+               while (!pages[i] && order)
+                       pages[i] = alloc_pages(gfp, --order);
+               if (!pages[i])
+                       goto error;
+
+               if (order) {
+                       split_page(pages[i], order);
+                       j = 1 << order;
+                       while (--j)
+                               pages[i + j] = pages[i] + j;
+               }
+
+               i += 1 << order;
+               count -= 1 << order;
+       }
+
+       return pages;
+error:
+       while (i--)
+               if (pages[i])
+                       __free_pages(pages[i], 0);
+       if (array_size <= PAGE_SIZE)
+               kfree(pages);
+       else
+               vfree(pages);
+       return NULL;
+}
+
+int iommu_lib_free_buffer(struct device *dev, struct page **pages,
+                              size_t size, struct dma_attrs *attrs)
+{
+       int count = size >> PAGE_SHIFT;
+       int array_size = count * sizeof(struct page *);
+       int i;
+
+       if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
+               dma_release_from_contiguous(dev, pages[0], count);
+       } else {
+               for (i = 0; i < count; i++)
+                       if (pages[i])
+                               __free_pages(pages[i], 0);
+       }
+
+       if (array_size <= PAGE_SIZE)
+               kfree(pages);
+       else
+               vfree(pages);
+       return 0;
+}
+
+dma_addr_t iommu_lib_map(struct iommu_domain *domain, struct page **pages,
+                       dma_addr_t iova, size_t size)
+{
+       dma_addr_t dma_addr = iova;
+       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+       int i, ret = DMA_ERROR_CODE;
+
+       for (i = 0; i < count; ) {
+               unsigned int next_pfn = page_to_pfn(pages[i]) + 1;
+               phys_addr_t phys = page_to_phys(pages[i]);
+               unsigned int len, j;
+
+               for (j = i + 1; j < count; j++, next_pfn++)
+                       if (page_to_pfn(pages[j]) != next_pfn)
+                               break;
+
+               len = (j - i) << PAGE_SHIFT;
+               ret = iommu_map(domain, iova, phys, len,
+                               IOMMU_READ|IOMMU_WRITE);
+               if (ret < 0)
+                       goto fail;
+               iova += len;
+               i = j;
+       }
+       return dma_addr;
+fail:
+       iommu_unmap(domain, dma_addr, iova-dma_addr);
+       return DMA_ERROR_CODE;
+}
+
+void iommu_lib_unmap(struct iommu_domain *domain, dma_addr_t iova, size_t size)
+{
+       /*
+        * add optional in-page offset from iova to size and align
+        * result to page size
+        */
+       size = PAGE_ALIGN((iova & ~PAGE_MASK) + size);
+       iova &= PAGE_MASK;
+
+       iommu_unmap(domain, iova, size);
+}
+
+/*
+ * Create a CPU mapping for a specified pages
+ */
+void *iommu_lib_alloc_remap(struct page **pages, size_t size, unsigned long
+                               flags, pgprot_t prot, const void *caller)
+{
+       unsigned int i, nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
+       struct vm_struct *area;
+       unsigned long p;
+
+       area = get_vm_area_caller(size, flags, caller);
+
+       if (!area)
+               return NULL;
+
+       area->pages = pages;
+       area->nr_pages = nr_pages;
+       p = (unsigned long)area->addr;
+
+       for (i = 0; i < nr_pages; i++) {
+               phys_addr_t phys = __pfn_to_phys(page_to_pfn(pages[i]));
+               if (ioremap_page_range(p, p + PAGE_SIZE, phys, prot))
+                       goto err;
+               p += PAGE_SIZE;
+       }
+       return area->addr;
+err:
+       unmap_kernel_range((unsigned long)area->addr, size);
+       vunmap(area->addr);
+       return NULL;
+}
--
1.8.1.3
