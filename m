From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] iommu/dma: Add support for DMA_ATTR_FORCE_CONTIGUOUS
Date: Fri, 27 Jan 2017 16:34:18 +0100
Message-ID: <1485531259-17513-2-git-send-email-geert+renesas@glider.be>
References: <1485531259-17513-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485531259-17513-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: iommu@lists.linux-foundation.org

Add helpers for allocating physically contiguous DMA buffers to the
generic IOMMU DMA code.  This can be useful when two or more devices
with different memory requirements are involved in buffer sharing.

The iommu_dma_{alloc,free}_contiguous() functions complement the existing
iommu_dma_{alloc,free}() functions, and allow architecture-specific code
to implement support for the DMA_ATTR_FORCE_CONTIGUOUS attribute on
systems with an IOMMU.  As this uses the CMA allocator, setting this
attribute has a runtime-dependency on CONFIG_DMA_CMA.

Note that unlike the existing iommu_dma_alloc() helper,
iommu_dma_alloc_contiguous() has no callback to flush pages.
Ensuring the returned region is made visible to a non-coherent device is
the responsibility of the caller.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Provide standalone iommu_dma_{alloc,free}_contiguous() functions, as
    requested by Robin Murphy,
  - Simplify operations by getting rid of the page array/scatterlist
    dance, as the buffer is contiguous,
  - Move CPU cache magement into the caller, which is much simpler with
    a single contiguous buffer.
---
 drivers/iommu/dma-iommu.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h |  4 +++
 2 files changed, 76 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2db0d641cf4505b5..8f8ed4426f9a3a12 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -30,6 +30,7 @@
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
+#include <linux/dma-contiguous.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -408,6 +409,77 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 }
 
 /**
+ * iommu_dma_free_contiguous - Free a buffer allocated by
+ *			       iommu_dma_alloc_contiguous()
+ * @dev: Device which owns this buffer
+ * @page: Buffer page pointer as returned by iommu_dma_alloc_contiguous()
+ * @size: Size of buffer in bytes
+ * @handle: DMA address of buffer
+ *
+ * Frees the pages associated with the buffer.
+ */
+void iommu_dma_free_contiguous(struct device *dev, struct page *page,
+		size_t size, dma_addr_t *handle)
+{
+	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), *handle);
+	dma_release_from_contiguous(dev, page, PAGE_ALIGN(size) >> PAGE_SHIFT);
+	*handle = DMA_ERROR_CODE;
+}
+
+/**
+ * iommu_dma_alloc_contiguous - Allocate and map a buffer contiguous in IOVA
+ *				and physical space
+ * @dev: Device to allocate memory for. Must be a real device attached to an
+ *	 iommu_dma_domain
+ * @size: Size of buffer in bytes
+ * @prot: IOMMU mapping flags
+ * @handle: Out argument for allocated DMA handle
+ *
+ * Return: Buffer page pointer, or NULL on failure.
+ *
+ * Note that unlike iommu_dma_alloc(), it's the caller's responsibility to
+ * ensure the returned region is made visible to the given non-coherent device.
+ */
+struct page *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
+		int prot, dma_addr_t *handle)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iova_domain *iovad = cookie_iovad(domain);
+	dma_addr_t dma_addr;
+	unsigned int count;
+	struct page *page;
+	struct iova *iova;
+	int ret;
+
+	*handle = DMA_ERROR_CODE;
+
+	size = PAGE_ALIGN(size);
+	count = size >> PAGE_SHIFT;
+	page = dma_alloc_from_contiguous(dev, count, get_order(size));
+	if (!page)
+		return NULL;
+
+	iova = __alloc_iova(domain, size, dev->coherent_dma_mask);
+	if (!iova)
+		goto out_free_pages;
+
+	size = iova_align(iovad, size);
+	dma_addr = iova_dma_addr(iovad, iova);
+	ret = iommu_map(domain, dma_addr, page_to_phys(page), size, prot);
+	if (ret < 0)
+		goto out_free_iova;
+
+	*handle = dma_addr;
+	return page;
+
+out_free_iova:
+	__free_iova(iovad, iova);
+out_free_pages:
+	dma_release_from_contiguous(dev, page, count);
+	return NULL;
+}
+
+/**
  * iommu_dma_mmap - Map a buffer into provided user VMA
  * @pages: Array representing buffer from iommu_dma_alloc()
  * @size: Size of buffer in bytes
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 7f7e9a7e3839966c..7eee62c2b0e752f7 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -45,6 +45,10 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 		void (*flush_page)(struct device *, const void *, phys_addr_t));
 void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 		dma_addr_t *handle);
+struct page *iommu_dma_alloc_contiguous(struct device *dev, size_t size,
+		int prot, dma_addr_t *handle);
+void iommu_dma_free_contiguous(struct device *dev, struct page *page,
+		size_t size, dma_addr_t *handle);
 
 int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma);
 
-- 
1.9.1
