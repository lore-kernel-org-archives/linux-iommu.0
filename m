From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [RFC PATCH 4/5] iommu/dma: Export non-static functions to use in
	modules
Date: Wed,  5 Jul 2017 16:12:14 +0900
Message-ID: <20170705071215.17603-5-tfiga@chromium.org>
References: <20170705071215.17603-1-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170705071215.17603-1-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There is nothing wrong in having a loadable module implementing DMA API,
for example to be used for sub-devices registered by the module. However,
most of the functions from dma-iommu do not have their symbols exported,
making it impossible to use them from loadable modules.

Export all the non-static functions in the file, so that loadable modules
can benefit from them. Use EXPORT_SYMBOL() for consistency with other
exports in the file.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9d1cebe7f6cb..7cdeaf930106 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -80,6 +80,7 @@ int iommu_dma_init(void)
 {
 	return iova_cache_get();
 }
+EXPORT_SYMBOL(iommu_dma_init);
 
 /**
  * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
@@ -357,6 +358,7 @@ int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 		return 0;
 	}
 }
+EXPORT_SYMBOL(dma_info_to_prot);
 
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, dma_addr_t dma_limit, struct device *dev)
@@ -504,6 +506,7 @@ void iommu_dma_free(struct device *dev, struct page **pages, size_t size,
 	__iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
 	*handle = IOMMU_MAPPING_ERROR;
 }
+EXPORT_SYMBOL(iommu_dma_free);
 
 /**
  * iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
@@ -588,6 +591,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
 }
+EXPORT_SYMBOL(iommu_dma_alloc);
 
 /**
  * iommu_dma_mmap - Map a buffer into provided user VMA
@@ -613,6 +617,7 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
 	}
 	return ret;
 }
+EXPORT_SYMBOL(iommu_dma_mmap);
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot)
@@ -643,12 +648,14 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	return __iommu_dma_map(dev, page_to_phys(page) + offset, size, prot);
 }
+EXPORT_SYMBOL(iommu_dma_map_page);
 
 void iommu_dma_unmap_page(struct device *dev, dma_addr_t handle, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
 }
+EXPORT_SYMBOL(iommu_dma_unmap_page);
 
 /*
  * Prepare a successfully-mapped scatterlist to give back to the caller.
@@ -802,6 +809,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	__invalidate_sg(sg, nents);
 	return 0;
 }
+EXPORT_SYMBOL(iommu_dma_map_sg);
 
 void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -822,6 +830,7 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 	end = sg_dma_address(sg) + sg_dma_len(sg);
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), start, end - start);
 }
+EXPORT_SYMBOL(iommu_dma_unmap_sg);
 
 dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
@@ -829,17 +838,20 @@ dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
 	return __iommu_dma_map(dev, phys, size,
 			dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO);
 }
+EXPORT_SYMBOL(iommu_dma_map_resource);
 
 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), handle, size);
 }
+EXPORT_SYMBOL(iommu_dma_unmap_resource);
 
 int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	return dma_addr == IOMMU_MAPPING_ERROR;
 }
+EXPORT_SYMBOL(iommu_dma_mapping_error);
 
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
@@ -913,3 +925,4 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 		msg->address_lo += lower_32_bits(msi_page->iova);
 	}
 }
+EXPORT_SYMBOL(iommu_dma_map_msi_msg);
-- 
2.13.2.725.g09c95d1e9-goog
