From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 20/32] powerpc/dma: fix an off-by-one in dma_capable
Date: Wed, 13 Feb 2019 08:01:21 +0100
Message-ID: <20190213070133.11259-21-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: iommu@lists.linux-foundation.org

We need to compare the last byte in the dma range and not the one after it
for the bus_dma_mask, just like we do for the regular dma_mask.  Fix this
cleanly by merging the two comparisms into one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-direct.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index e00ab5d0612d..92d8aed86422 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -4,15 +4,11 @@
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
-#ifdef CONFIG_SWIOTLB
-	if (dev->bus_dma_mask && addr + size > dev->bus_dma_mask)
-		return false;
-#endif
-
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <= *dev->dma_mask;
+	return addr + size - 1 <=
+		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
 
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
-- 
2.20.1
