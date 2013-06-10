From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
	protection attributes
Date: Mon, 10 Jun 2013 19:34:39 +0100
Message-ID: <1370889285-22799-4-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1370889285-22799-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

IOMMU mappings take a prot parameter, identifying the protection bits
to enforce on the newly created mapping (READ or WRITE). The ARM
dma-mapping framework currently just passes 0 as the prot argument,
resulting in faulting mappings.

This patch infers the protection attributes based on the direction of
the DMA transfer.

Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/mm/dma-mapping.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6fb80cf..d119de7 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1636,13 +1636,27 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 {
 	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
 	dma_addr_t dma_addr;
-	int ret, len = PAGE_ALIGN(size + offset);
+	int ret, prot, len = PAGE_ALIGN(size + offset);
 
 	dma_addr = __alloc_iova(mapping, len);
 	if (dma_addr == DMA_ERROR_CODE)
 		return dma_addr;
 
-	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, 0);
+	switch (dir) {
+	case DMA_BIDIRECTIONAL:
+		prot = IOMMU_READ | IOMMU_WRITE;
+		break;
+	case DMA_TO_DEVICE:
+		prot = IOMMU_READ;
+		break;
+	case DMA_FROM_DEVICE:
+		prot = IOMMU_WRITE;
+		break;
+	default:
+		prot = 0;
+	}
+
+	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
 	if (ret < 0)
 		goto fail;
 
-- 
1.8.2.2
