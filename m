From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] dma-mapping: don't BUG when calling dma_map_resource on RAM
Date: Fri, 11 Jan 2019 19:17:30 +0100
Message-ID: <20190111181731.11782-3-hch@lst.de>
References: <20190111181731.11782-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111181731.11782-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Russell King <linux@armlinux.org.uk>, Mauro Carvalho Chehab <mchehab@kernel.org>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Use WARN_ON_ONCE to print a stack trace and return a proper error
code instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index d3087829a6df..91add0751aa5 100644
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
