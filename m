From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/8] lantiq_etop: pass struct device to DMA API functions
Date: Mon, 11 Feb 2019 14:20:00 +0100
Message-ID: <20190211132004.29143-5-hch@lst.de>
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

Note this driver seems to lack dma_unmap_* calls entirely, but fixing
that is left for another time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/lantiq_etop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 32ac9045cdae..f9bb890733b5 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -112,10 +112,12 @@ struct ltq_etop_priv {
 static int
 ltq_etop_alloc_skb(struct ltq_etop_chan *ch)
 {
+	struct ltq_etop_priv *priv = netdev_priv(ch->netdev);
+
 	ch->skb[ch->dma.desc] = netdev_alloc_skb(ch->netdev, MAX_DMA_DATA_LEN);
 	if (!ch->skb[ch->dma.desc])
 		return -ENOMEM;
-	ch->dma.desc_base[ch->dma.desc].addr = dma_map_single(NULL,
+	ch->dma.desc_base[ch->dma.desc].addr = dma_map_single(&priv->pdev->dev,
 		ch->skb[ch->dma.desc]->data, MAX_DMA_DATA_LEN,
 		DMA_FROM_DEVICE);
 	ch->dma.desc_base[ch->dma.desc].addr =
@@ -487,7 +489,7 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	netif_trans_update(dev);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	desc->addr = ((unsigned int) dma_map_single(NULL, skb->data, len,
+	desc->addr = ((unsigned int) dma_map_single(&priv->pdev->dev, skb->data, len,
 						DMA_TO_DEVICE)) - byte_offset;
 	wmb();
 	desc->ctl = LTQ_DMA_OWN | LTQ_DMA_SOP | LTQ_DMA_EOP |
-- 
2.20.1
