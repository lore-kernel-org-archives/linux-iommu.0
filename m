From: Andreas Herrmann <andreas.herrmann@calxeda.com>
Subject: [PATCH 3/7] ARM: dma-mapping: Always pass proper prot flags to
 iommu_map()
Date: Tue, 24 Sep 2013 17:06:57 +0200
Message-ID: <1380035221-11576-4-git-send-email-andreas.herrmann@calxeda.com>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

... otherwise it is impossible for the low level iommu driver to
figure out which pte flags should be used.

In __map_sg_chunk we can derive the flags from dma_data_direction.

In __iommu_create_mapping we should treat the memory like
DMA_BIDIRECTIONAL and pass both IOMMU_READ and IOMMU_WRITE to
iommu_map.
__iommu_create_mapping is used during dma_alloc_coherent (via
arm_iommu_alloc_attrs).  AFAIK dma_alloc_coherent is responsible for
allocation _and_ mapping.  I think this implies that access to the
mapped pages should be allowed.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
---
 arch/arm/mm/dma-mapping.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f5e1a84..95abed8 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1232,7 +1232,8 @@ __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
 				break;
 
 		len = (j - i) << PAGE_SHIFT;
-		ret = iommu_map(mapping->domain, iova, phys, len, 0);
+		ret = iommu_map(mapping->domain, iova, phys, len,
+				IOMMU_READ|IOMMU_WRITE);
 		if (ret < 0)
 			goto fail;
 		iova += len;
@@ -1444,6 +1445,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 	int ret = 0;
 	unsigned int count;
 	struct scatterlist *s;
+	int prot;
 
 	size = PAGE_ALIGN(size);
 	*handle = DMA_ERROR_CODE;
@@ -1460,7 +1462,21 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
 			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 
-		ret = iommu_map(mapping->domain, iova, phys, len, 0);
+		switch (dir) {
+		case DMA_BIDIRECTIONAL:
+			prot = IOMMU_READ | IOMMU_WRITE;
+			break;
+		case DMA_TO_DEVICE:
+			prot = IOMMU_READ;
+			break;
+		case DMA_FROM_DEVICE:
+			prot = IOMMU_WRITE;
+			break;
+		default:
+			prot = 0;
+		}
+
+		ret = iommu_map(mapping->domain, iova, phys, len, prot);
 		if (ret < 0)
 			goto fail;
 		count += len >> PAGE_SHIFT;
-- 
1.7.9.5
