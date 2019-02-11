From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 8/8] smc911x: pass struct device to DMA API functions
Date: Mon, 11 Feb 2019 14:20:04 +0100
Message-ID: <20190211132004.29143-9-hch@lst.de>
References: <20190211132004.29143-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211132004.29143-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Note that smc911x apparently is a PIO chip with an external DMA
handshake, and we probably use the wrong device here.  But at least
it matches the mapping side, which apparently works or at least
worked in the not too distant past.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/smsc/smc911x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc911x.c b/drivers/net/ethernet/smsc/smc911x.c
index 8355dfbb8ec3..b550e624500d 100644
--- a/drivers/net/ethernet/smsc/smc911x.c
+++ b/drivers/net/ethernet/smsc/smc911x.c
@@ -1188,7 +1188,7 @@ smc911x_tx_dma_irq(void *data)
 
 	DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, dev, "TX DMA irq handler\n");
 	BUG_ON(skb == NULL);
-	dma_unmap_single(NULL, tx_dmabuf, tx_dmalen, DMA_TO_DEVICE);
+	dma_unmap_single(lp->dev, tx_dmabuf, tx_dmalen, DMA_TO_DEVICE);
 	netif_trans_update(dev);
 	dev_kfree_skb_irq(skb);
 	lp->current_tx_skb = NULL;
@@ -1219,7 +1219,7 @@ smc911x_rx_dma_irq(void *data)
 
 	DBG(SMC_DEBUG_FUNC, dev, "--> %s\n", __func__);
 	DBG(SMC_DEBUG_RX | SMC_DEBUG_DMA, dev, "RX DMA irq handler\n");
-	dma_unmap_single(NULL, rx_dmabuf, rx_dmalen, DMA_FROM_DEVICE);
+	dma_unmap_single(lp->dev, rx_dmabuf, rx_dmalen, DMA_FROM_DEVICE);
 	BUG_ON(skb == NULL);
 	lp->current_rx_skb = NULL;
 	PRINT_PKT(skb->data, skb->len);
-- 
2.20.1
