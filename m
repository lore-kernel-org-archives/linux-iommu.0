From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/16] sparc: use generic dma_set_mask
Date: Mon,  9 Nov 2015 19:17:18 +0100
Message-ID: <1447093041-21832-14-git-send-email-hch@lst.de>
References: <1447093041-21832-1-git-send-email-hch@lst.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1447093041-21832-1-git-send-email-hch@lst.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Steven Miao <realmz6@gmail.com>, Ley Foon Tan <lftan@altera.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Chris Metcalf <cmetcalf@ezchip.com>, linux-snps-arc@lists.infraded.org, linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org, sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Sparc already uses the same code as the generic code for the PCI
implementation but just fails the call sbus.  This moves to the
generic implemenation which eventually return -EIO due to the NULL
dma_mask pointer in the device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/include/asm/dma-mapping.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index a21da59..2777092 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -37,21 +37,6 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 	return dma_ops;
 }
 
-#define HAVE_ARCH_DMA_SET_MASK 1
-
-static inline int dma_set_mask(struct device *dev, u64 mask)
-{
-#ifdef CONFIG_PCI
-	if (dev->bus == &pci_bus_type) {
-		if (!dev->dma_mask || !dma_supported(dev, mask))
-			return -EINVAL;
-		*dev->dma_mask = mask;
-		return 0;
-	}
-#endif
-	return -EINVAL;
-}
