From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] ARM: dma-mapping: Pass DMA attrs as IOMMU prot
Date: Thu, 20 Jun 2013 13:58:43 +0300
Message-ID: <1371725924-13957-3-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Pass DMA attribute as IOMMU property, which can be proccessed in the
backend implementation of IOMMU. For example, DMA_ATTR_READ_ONLY can
be translated into each IOMMU H/W implementaion.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 4152ed6..cbc6768 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1254,7 +1254,8 @@ err:
  */
 static dma_addr_t
 ____iommu_create_mapping(struct device *dev, dma_addr_t *req,
-			 struct page **pages, size_t size)
+			 struct page **pages, size_t size,
+			 struct dma_attrs *attrs)
 {
 	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -1280,7 +1281,7 @@ ____iommu_create_mapping(struct device *dev, dma_addr_t *req,
 				break;
 
 		len = (j - i) << PAGE_SHIFT;
-		ret = iommu_map(mapping->domain, iova, phys, len, 0);
+		ret = iommu_map(mapping->domain, iova, phys, len, (int)attrs);
 		if (ret < 0)
 			goto fail;
 		iova += len;
@@ -1294,9 +1295,10 @@ fail:
 }
 
 static dma_addr_t
-__iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
+__iommu_create_mapping(struct device *dev, struct page **pages, size_t size,
+		       struct dma_attrs *attrs)
 {
-	return ____iommu_create_mapping(dev, NULL, pages, size);
+	return ____iommu_create_mapping(dev, NULL, pages, size, attrs);
 }
 
 static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t size)
@@ -1332,7 +1334,7 @@ static struct page **__iommu_get_pages(void *cpu_addr, struct dma_attrs *attrs)
 }
 
 static void *__iommu_alloc_atomic(struct device *dev, size_t size,
-				  dma_addr_t *handle)
+				  dma_addr_t *handle, struct dma_attrs *attrs)
 {
 	struct page *page;
 	void *addr;
@@ -1341,7 +1343,7 @@ static void *__iommu_alloc_atomic(struct device *dev, size_t size,
 	if (!addr)
 		return NULL;
 
-	*handle = __iommu_create_mapping(dev, &page, size);
+	*handle = __iommu_create_mapping(dev, &page, size, attrs);
 	if (*handle == DMA_ERROR_CODE)
 		goto err_mapping;
 
@@ -1378,17 +1380,20 @@ static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 
 	if (gfp & GFP_ATOMIC)
-		return __iommu_alloc_atomic(dev, size, handle);
+
+		return __iommu_alloc_atomic(dev, size, handle, attrs);
 
 	pages = __iommu_alloc_buffer(dev, size, gfp);
 	if (!pages)
 		return NULL;
 
 	if (*handle == DMA_ERROR_CODE)
-		*handle = __iommu_create_mapping(dev, pages, size);
+		*handle = __iommu_create_mapping(dev, pages, size, attrs);
 	else
-		*handle = ____iommu_create_mapping(dev, handle, pages, size);
+		*handle = ____iommu_create_mapping(dev, handle, pages, size,
+						   attrs);
 
+	*handle = __iommu_create_mapping(dev, pages, size, attrs);
 	if (*handle == DMA_ERROR_CODE)
 		goto err_buffer;
 
@@ -1513,7 +1518,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 
 skip_cmaint:
 	count = size >> PAGE_SHIFT;
-	ret = iommu_map_sg(mapping->domain, iova_base, sg, count, 0);
+	ret = iommu_map_sg(mapping->domain, iova_base, sg, count, (int)attrs);
 	if (WARN_ON(ret < 0))
 		goto fail;
 
@@ -1716,7 +1721,8 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	if (dma_addr == DMA_ERROR_CODE)
 		return dma_addr;
 
-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, 0);
+	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len,
+			(int)attrs);
 	if (ret < 0)
 		goto fail;
 
@@ -1756,7 +1762,8 @@ static dma_addr_t arm_iommu_map_page_at(struct device *dev, struct page *page,
 	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 		__dma_page_cpu_to_dev(page, offset, size, dir);
 
-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, 0);
+	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len,
+			(int)attrs);
 	if (ret < 0)
 		return DMA_ERROR_CODE;
 
@@ -1778,7 +1785,8 @@ static dma_addr_t arm_iommu_map_pages(struct device *dev, struct page **pages,
 			__dma_page_cpu_to_dev(pages[i], 0, PAGE_SIZE, dir);
 	}
 
-	ret = iommu_map_pages(mapping->domain, dma_handle, pages, count, 0);
+	ret = iommu_map_pages(mapping->domain, dma_handle, pages, count,
+			      (int)attrs);
 	if (ret < 0)
 		return DMA_ERROR_CODE;
 
-- 
1.8.1.5
