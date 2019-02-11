From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/8] macb_main: pass struct device to DMA API functions
Date: Mon, 11 Feb 2019 14:19:59 +0100
Message-ID: <20190211132004.29143-4-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index eaabe8c278ec..4d1509f431d7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3673,9 +3673,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		/* Store packet information (to free when Tx completed) */
 		lp->skb = skb;
 		lp->skb_length = skb->len;
-		lp->skb_physaddr = dma_map_single(NULL, skb->data, skb->len,
-							DMA_TO_DEVICE);
-		if (dma_mapping_error(NULL, lp->skb_physaddr)) {
+		lp->skb_physaddr = dma_map_single(&lp->pdev->dev, skb->data,
+						  skb->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(&lp->pdev->dev, lp->skb_physaddr)) {
 			dev_kfree_skb_any(skb);
 			dev->stats.tx_dropped++;
 			netdev_err(dev, "%s: DMA mapping error\n", __func__);
@@ -3765,7 +3765,7 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 		if (lp->skb) {
 			dev_kfree_skb_irq(lp->skb);
 			lp->skb = NULL;
-			dma_unmap_single(NULL, lp->skb_physaddr,
+			dma_unmap_single(&lp->pdev->dev, lp->skb_physaddr,
 					 lp->skb_length, DMA_TO_DEVICE);
 			dev->stats.tx_packets++;
 			dev->stats.tx_bytes += lp->skb_length;
-- 
2.20.1
