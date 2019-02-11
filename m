From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/8] au1000_eth: pass struct device to DMA API functions
Date: Mon, 11 Feb 2019 14:19:58 +0100
Message-ID: <20190211132004.29143-3-hch@lst.de>
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
 drivers/net/ethernet/amd/au1000_eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index e833d1b3fe18..e5073aeea06a 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1167,7 +1167,7 @@ static int au1000_probe(struct platform_device *pdev)
 	/* Allocate the data buffers
 	 * Snooping works fine with eth on all au1xxx
 	 */
-	aup->vaddr = (u32)dma_alloc_attrs(NULL, MAX_BUF_SIZE *
+	aup->vaddr = (u32)dma_alloc_attrs(&pdev->dev, MAX_BUF_SIZE *
 					  (NUM_TX_BUFFS + NUM_RX_BUFFS),
 					  &aup->dma_addr, 0,
 					  DMA_ATTR_NON_CONSISTENT);
@@ -1349,7 +1349,7 @@ static int au1000_probe(struct platform_device *pdev)
 err_remap2:
 	iounmap(aup->mac);
 err_remap1:
-	dma_free_attrs(NULL, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
+	dma_free_attrs(&pdev->dev, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
 			(void *)aup->vaddr, aup->dma_addr,
 			DMA_ATTR_NON_CONSISTENT);
 err_vaddr:
@@ -1383,7 +1383,7 @@ static int au1000_remove(struct platform_device *pdev)
 		if (aup->tx_db_inuse[i])
 			au1000_ReleaseDB(aup, aup->tx_db_inuse[i]);
 
-	dma_free_attrs(NULL, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
+	dma_free_attrs(&pdev->dev, MAX_BUF_SIZE * (NUM_TX_BUFFS + NUM_RX_BUFFS),
 			(void *)aup->vaddr, aup->dma_addr,
 			DMA_ATTR_NON_CONSISTENT);
 
-- 
2.20.1
