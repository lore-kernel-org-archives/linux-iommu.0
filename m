From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/32] dma-direct: we might need GFP_DMA for 32-bit dma masks
Date: Wed, 13 Feb 2019 08:01:03 +0100
Message-ID: <20190213070133.11259-3-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: iommu@lists.linux-foundation.org

If there is no ZONE_DMA32 we might need GFP_DMA to be able to
allocate memory that satisfies a 32-bit DMA mask.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 kernel/dma/direct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..d5bb51cf27c6 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -132,8 +132,7 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 			goto again;
 		}
 
-		if (IS_ENABLED(CONFIG_ZONE_DMA) &&
-		    phys_mask < DMA_BIT_MASK(32) && !(gfp & GFP_DMA)) {
+		if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 			goto again;
 		}
-- 
2.20.1
