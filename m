From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/29] dma-mapping: don't BUG when calling dma_map_resource on RAM
Date: Wed, 13 Feb 2019 19:28:33 +0100
Message-ID: <20190213182900.16707-3-hch@lst.de>
References: <20190213182900.16707-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213182900.16707-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Use WARN_ON_ONCE to print a stack trace and return a proper error
code instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/dma-mapping.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 9842085e6774..b904d55247ab 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -353,7 +353,8 @@ static inline dma_addr_t dma_map_resource(struct device *dev,
 	BUG_ON(!valid_dma_direction(dir));
 
 	/* Don't allow RAM to be mapped */
-	BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
+	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
+		return DMA_MAPPING_ERROR;
 
 	if (dma_is_direct(ops))
 		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
-- 
2.20.1
