From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/9] csky: don't use GFP_DMA in atomic_pool_init
Date: Mon,  5 Nov 2018 13:19:30 +0100
Message-ID: <20181105121931.13481-9-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

csky does not implement ZONE_DMA, which means passing GFP_DMA is a no-op.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index 85437b21e045..ad4046939713 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -35,7 +35,7 @@ static int __init atomic_pool_init(void)
 	if (!atomic_pool)
 		BUG();
 
-	page = alloc_pages(GFP_KERNEL | GFP_DMA, get_order(size));
+	page = alloc_pages(GFP_KERNEL, get_order(size));
 	if (!page)
 		BUG();
 
-- 
2.19.1
