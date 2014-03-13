From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] [RFC] arm: iommu: Refactoring dma-mapping iommu code
Date: Fri, 14 Mar 2014 01:54:17 +0530
Message-ID: <CAD15aga6=Au6qtuiZuxgZxtNuE8U++4vOW8caySxbZfTmoFAsQ@mail.gmail.com>
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
To: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: Vinayak Menon <menon.vinayak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Taking out complete function defination to lib/iommu-helper.c
from arch/arm/mm/dma-mapping.c

Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c    | 38 ++++----------------------------------
 include/linux/iommu-helper.h |  2 ++
 lib/iommu-helper.c           | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ae301c8e..331465e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1143,39 +1143,6 @@ static int __iommu_free_buffer(struct device
*dev, struct page **pages,
 }

 /*
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
-}
-
-/*
  * Create a mapping in device IO address space for specified pages
  */
 static dma_addr_t
@@ -1263,6 +1230,7 @@ static void *arm_iommu_alloc_attrs(struct device
*dev, size_t size,
        pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
        struct page **pages;
        void *addr = NULL;
+       unsigned long flags = 0;

        *handle = DMA_ERROR_CODE;
        size = PAGE_ALIGN(size);
@@ -1290,7 +1258,9 @@ static void *arm_iommu_alloc_attrs(struct device
*dev, size_t size,
        if (dma_get_attr(DMA_ATTR_NO_KERNEL_MAPPING, attrs))
                return pages;

-       addr = __iommu_alloc_remap(pages, size, gfp, prot,
+       flags = VM_ARM_DMA_CONSISTENT | VM_USERMAP;
+
+       addr = iommu_alloc_remap(pages, size, flags, prot,
                                   __builtin_return_address(0));
        if (!addr)
                goto err_mapping;
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index d580508..52dde70 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -43,5 +43,7 @@ extern dma_addr_t iommu_mapper(struct iommu_domain *domain,

 extern void iommu_unmapper(struct iommu_domain *domain, dma_addr_t iova,
                        size_t size);
+extern void *iommu_alloc_remap(struct page **pages, size_t size, unsigned long
+                       flags, pgprot_t prot, const void *caller);

 #endif
diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index b6ea51b..ae4f0d6 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -176,3 +176,36 @@ void iommu_unmapper(struct iommu_domain *domain,
dma_addr_t iova, size_t size)

        iommu_unmap(domain, iova, size);
 }
+
+/*
+ * Create a CPU mapping for a specified pages
+ */
+void *
+iommu_alloc_remap(struct page **pages, size_t size, unsigned long flags,
+                       pgprot_t prot, const void *caller)
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
