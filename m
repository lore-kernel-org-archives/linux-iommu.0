From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/8] moxart_ether: pass struct device to DMA API functions
Date: Mon, 11 Feb 2019 14:20:02 +0100
Message-ID: <20190211132004.29143-7-hch@lst.de>
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
---
 drivers/net/ethernet/moxa/moxart_ether.c | 11 +++++++----
 drivers/net/ethernet/moxa/moxart_ether.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index b34055ac476f..00dec0ffb11b 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -81,11 +81,13 @@ static void moxart_mac_free_memory(struct net_device *ndev)
 				 priv->rx_buf_size, DMA_FROM_DEVICE);
 
 	if (priv->tx_desc_base)
-		dma_free_coherent(NULL, TX_REG_DESC_SIZE * TX_DESC_NUM,
+		dma_free_coherent(&priv->pdev->dev,
+				  TX_REG_DESC_SIZE * TX_DESC_NUM,
 				  priv->tx_desc_base, priv->tx_base);
 
 	if (priv->rx_desc_base)
-		dma_free_coherent(NULL, RX_REG_DESC_SIZE * RX_DESC_NUM,
+		dma_free_coherent(&priv->pdev->dev,
+				  RX_REG_DESC_SIZE * RX_DESC_NUM,
 				  priv->rx_desc_base, priv->rx_base);
 
 	kfree(priv->tx_buf_base);
@@ -476,6 +478,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 
 	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
+	priv->pdev = pdev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ndev->base_addr = res->start;
@@ -491,7 +494,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 	priv->tx_buf_size = TX_BUF_SIZE;
 	priv->rx_buf_size = RX_BUF_SIZE;
 
-	priv->tx_desc_base = dma_alloc_coherent(NULL, TX_REG_DESC_SIZE *
+	priv->tx_desc_base = dma_alloc_coherent(&pdev->dev, TX_REG_DESC_SIZE *
 						TX_DESC_NUM, &priv->tx_base,
 						GFP_DMA | GFP_KERNEL);
 	if (!priv->tx_desc_base) {
@@ -499,7 +502,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 		goto init_fail;
 	}
 
-	priv->rx_desc_base = dma_alloc_coherent(NULL, RX_REG_DESC_SIZE *
+	priv->rx_desc_base = dma_alloc_coherent(&pdev->dev, RX_REG_DESC_SIZE *
 						RX_DESC_NUM, &priv->rx_base,
 						GFP_DMA | GFP_KERNEL);
 	if (!priv->rx_desc_base) {
diff --git a/drivers/net/ethernet/moxa/moxart_ether.h b/drivers/net/ethernet/moxa/moxart_ether.h
index bee608b547d1..bf4c3029cd0c 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.h
+++ b/drivers/net/ethernet/moxa/moxart_ether.h
@@ -292,6 +292,7 @@
 #define LINK_STATUS		0x4
 
 struct moxart_mac_priv_t {
+	struct platform_device *pdev;
 	void __iomem *base;
 	unsigned int reg_maccr;
 	unsigned int reg_imr;
-- 
2.20.1
