From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/13] arm: dma-mapping: Use sychronized interface of the
	IOMMU-API
Date: Thu, 17 Aug 2017 14:56:28 +0200
Message-ID: <1502974596-23835-6-git-send-email-joro@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502974596-23835-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The map and unmap functions of the IOMMU-API changed their
semantics: They do no longer guarantee that the hardware
TLBs are synchronized with the page-table updates they made.

To make conversion easier, new synchronized functions have
been introduced which give these guarantees again until the
code is converted to use the new TLB-flush interface of the
IOMMU-API, which allows certain optimizations.

But for now, just convert this code to use the synchronized
functions so that it will behave as before.

Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index fcf1473..fae2398 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1444,7 +1444,7 @@ __iommu_create_mapping(struct device *dev, struct page **pages, size_t size,
 				break;
 
 		len = (j - i) << PAGE_SHIFT;
-		ret = iommu_map(mapping->domain, iova, phys, len,
+		ret = iommu_map_sync(mapping->domain, iova, phys, len,
 				__dma_info_to_prot(DMA_BIDIRECTIONAL, attrs));
 		if (ret < 0)
 			goto fail;
@@ -1453,7 +1453,7 @@ __iommu_create_mapping(struct device *dev, struct page **pages, size_t size,
 	}
 	return dma_addr;
 fail:
-	iommu_unmap(mapping->domain, dma_addr, iova-dma_addr);
+	iommu_unmap_sync(mapping->domain, dma_addr, iova-dma_addr);
 	__free_iova(mapping, dma_addr, size);
 	return ARM_MAPPING_ERROR;
 }
@@ -1469,7 +1469,7 @@ static int __iommu_remove_mapping(struct device *dev, dma_addr_t iova, size_t si
 	size = PAGE_ALIGN((iova & ~PAGE_MASK) + size);
 	iova &= PAGE_MASK;
 
-	iommu_unmap(mapping->domain, iova, size);
+	iommu_unmap_sync(mapping->domain, iova, size);
 	__free_iova(mapping, iova, size);
 	return 0;
 }
@@ -1730,7 +1730,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 
 		prot = __dma_info_to_prot(dir, attrs);
 
-		ret = iommu_map(mapping->domain, iova, phys, len, prot);
+		ret = iommu_map_sync(mapping->domain, iova, phys, len, prot);
 		if (ret < 0)
 			goto fail;
 		count += len >> PAGE_SHIFT;
@@ -1740,7 +1740,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 
 	return 0;
 fail:
-	iommu_unmap(mapping->domain, iova_base, count * PAGE_SIZE);
+	iommu_unmap_sync(mapping->domain, iova_base, count * PAGE_SIZE);
 	__free_iova(mapping, iova_base, size);
 	return ret;
 }
@@ -1938,7 +1938,8 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 
 	prot = __dma_info_to_prot(dir, attrs);
 
-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
+	ret = iommu_map_sync(mapping->domain, dma_addr, page_to_phys(page),
+			     len, prot);
 	if (ret < 0)
 		goto fail;
 
@@ -1988,7 +1989,7 @@ static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	if (!iova)
 		return;
 
-	iommu_unmap(mapping->domain, iova, len);
+	iommu_unmap_sync(mapping->domain, iova, len);
 	__free_iova(mapping, iova, len);
 }
 
@@ -2016,7 +2017,7 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
 		__dma_page_dev_to_cpu(page, offset, size, dir);
 
-	iommu_unmap(mapping->domain, iova, len);
+	iommu_unmap_sync(mapping->domain, iova, len);
 	__free_iova(mapping, iova, len);
 }
 
@@ -2044,7 +2045,7 @@ static dma_addr_t arm_iommu_map_resource(struct device *dev,
 
 	prot = __dma_info_to_prot(dir, attrs) | IOMMU_MMIO;
 
-	ret = iommu_map(mapping->domain, dma_addr, addr, len, prot);
+	ret = iommu_map_sync(mapping->domain, dma_addr, addr, len, prot);
 	if (ret < 0)
 		goto fail;
 
@@ -2073,7 +2074,7 @@ static void arm_iommu_unmap_resource(struct device *dev, dma_addr_t dma_handle,
 	if (!iova)
 		return;
 
-	iommu_unmap(mapping->domain, iova, len);
+	iommu_unmap_sync(mapping->domain, iova, len);
 	__free_iova(mapping, iova, len);
 }
 
-- 
2.7.4
