From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] dma-direct: Export dma_direct_alloc() and dma_direct_free()
Date: Tue,  5 Feb 2019 12:06:02 +0100
Message-ID: <20190205110602.27717-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding@nvidia.com>

Drivers that are built as modules may want to use these functions, so
make them available like the rest of the functions.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 kernel/dma/direct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25bd19974223..f14b7ced4592 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -200,6 +200,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 	return dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 }
+EXPORT_SYMBOL(dma_direct_alloc);
 
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
@@ -209,6 +210,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	else
 		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 }
+EXPORT_SYMBOL(dma_direct_free);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
-- 
2.19.1
