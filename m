From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] dma-direct: respect DMA_ATTR_NO_WARN
Date: Mon,  1 Oct 2018 13:12:57 -0700
Message-ID: <20181001201257.366-3-hch@lst.de>
References: <20181001201257.366-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001201257.366-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Respect the DMA_ATTR_NO_WARN flags for allocations in dma-direct.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 170bd322a94a..ba6f5956a291 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -107,6 +107,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	u64 phys_mask;
 	void *ret;
 
+	if (attrs & DMA_ATTR_NO_WARN)
+		gfp |= __GFP_NOWARN;
+
 	/* we always manually zero the memory once we are done: */
 	gfp &= ~__GFP_ZERO;
 	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-- 
2.19.0
