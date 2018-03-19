From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 08/14] iommu/intel-iommu: cleanup intel_{alloc,free}_coherent
Date: Mon, 19 Mar 2018 11:38:20 +0100
Message-ID: <20180319103826.12853-9-hch@lst.de>
References: <20180319103826.12853-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180319103826.12853-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Use the dma_direct_* helpers and cleanup the code flow.

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/iommu/Kconfig       |  1 +
 drivers/iommu/intel-iommu.c | 62 ++++++++++++---------------------------------
 2 files changed, 17 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc7c1914645d..df171cb85822 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -143,6 +143,7 @@ config DMAR_TABLE
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
+	select DMA_DIRECT_OPS
 	select IOMMU_API
 	select IOMMU_IOVA
 	select DMAR_TABLE
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fd899b2a12bb..24d1b1b42013 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/mempool.h>
 #include <linux/memory.h>
 #include <linux/cpu.h>
@@ -3708,61 +3709,30 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  unsigned long attrs)
 {
-	struct page *page = NULL;
-	int order;
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	if (!iommu_no_mapping(dev))
-		flags &= ~(GFP_DMA | GFP_DMA32);
-	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
-		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
-			flags |= GFP_DMA;
-		else
-			flags |= GFP_DMA32;
-	}
+	void *vaddr;
 
-	if (gfpflags_allow_blocking(flags)) {
-		unsigned int count = size >> PAGE_SHIFT;
+	vaddr = dma_direct_alloc(dev, size, dma_handle, flags, attrs);
+	if (iommu_no_mapping(dev) || !vaddr)
+		return vaddr;
 
-		page = dma_alloc_from_contiguous(dev, count, order, flags);
-		if (page && iommu_no_mapping(dev) &&
-		    page_to_phys(page) + size > dev->coherent_dma_mask) {
-			dma_release_from_contiguous(dev, page, count);
-			page = NULL;
-		}
-	}
-
-	if (!page)
-		page = alloc_pages(flags, order);
-	if (!page)
-		return NULL;
-	memset(page_address(page), 0, size);
-
-	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
-					 DMA_BIDIRECTIONAL,
-					 dev->coherent_dma_mask);
-	if (*dma_handle)
-		return page_address(page);
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, order);
+	*dma_handle = __intel_map_single(dev, virt_to_phys(vaddr),
+			PAGE_ALIGN(size), DMA_BIDIRECTIONAL,
+			dev->coherent_dma_mask);
+	if (!*dma_handle)
+		goto out_free_pages;
+	return vaddr;
 
+out_free_pages:
+	dma_direct_free(dev, size, vaddr, *dma_handle, attrs);
 	return NULL;
 }
 
 static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 				dma_addr_t dma_handle, unsigned long attrs)
 {
-	int order;
-	struct page *page = virt_to_page(vaddr);
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	intel_unmap(dev, dma_handle, size);
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, order);
+	if (!iommu_no_mapping(dev))
+		intel_unmap(dev, dma_handle, PAGE_ALIGN(size));
+	dma_direct_free(dev, size, vaddr, dma_handle, attrs);
 }
 
 static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
-- 
2.14.2
