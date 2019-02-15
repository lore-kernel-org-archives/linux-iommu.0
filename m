From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/5] ccio: allow large DMA masks
Date: Fri, 15 Feb 2019 15:45:55 +0100
Message-ID: <20190215144559.8777-2-hch@lst.de>
References: <20190215144559.8777-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215144559.8777-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

There is no harm in setting a 64-bit mask even if we don't need it,
and the current ccio code is one of the few place in the kernel
still rejecting larger than required DMA masks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/parisc/ccio-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parisc/ccio-dma.c b/drivers/parisc/ccio-dma.c
index 8d2fc84119c6..24a68fb7b2f9 100644
--- a/drivers/parisc/ccio-dma.c
+++ b/drivers/parisc/ccio-dma.c
@@ -710,8 +710,8 @@ ccio_dma_supported(struct device *dev, u64 mask)
 		return 0;
 	}
 
-	/* only support 32-bit devices (ie PCI/GSC) */
-	return (int)(mask == 0xffffffffUL);
+	/* only support 32-bit or better devices (ie PCI/GSC) */
+	return (int)(mask >= 0xffffffffUL);
 }
 
 /**
-- 
2.20.1
