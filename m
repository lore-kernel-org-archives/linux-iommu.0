From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/2] mmc: sdhi: internal_dmac: set dma_parms
Date: Tue, 11 Sep 2018 18:30:50 +0200
Message-ID: <20180911163050.28072-3-wsa+renesas@sang-engineering.com>
References: <20180911163050.28072-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911163050.28072-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
Cc: linux-renesas-soc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: iommu@lists.linux-foundation.org

We have our own DMA provider, so we should set the dma_parms properly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index ca0b43973769..00116e4ec6c4 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -315,6 +315,8 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 
 	global_flags |= (unsigned long)soc->data;
 
+	dmam_set_dma_parms(&pdev->dev, 0xffffffff, 0);
+
 	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
 }
 
-- 
2.18.0
