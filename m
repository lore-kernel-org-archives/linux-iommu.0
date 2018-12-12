From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 16/24] memory: tegra: Clean up error messages
Date: Wed, 12 Dec 2018 23:38:59 +0300
Message-ID: <20181212203907.23461-17-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Make all messages to start with a lower case and don't unnecessarily go
over 80 chars in the code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 570da2129fa6..0a53598d982f 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -163,7 +163,7 @@ static int tegra_mc_hotreset_assert(struct reset_controller_dev *rcdev,
 		/* block clients DMA requests */
 		err = rst_ops->block_dma(mc, rst);
 		if (err) {
-			dev_err(mc->dev, "Failed to block %s DMA: %d\n",
+			dev_err(mc->dev, "failed to block %s DMA: %d\n",
 				rst->name, err);
 			return err;
 		}
@@ -173,7 +173,7 @@ static int tegra_mc_hotreset_assert(struct reset_controller_dev *rcdev,
 		/* wait for completion of the outstanding DMA requests */
 		while (!rst_ops->dma_idling(mc, rst)) {
 			if (!retries--) {
-				dev_err(mc->dev, "Failed to flush %s DMA\n",
+				dev_err(mc->dev, "failed to flush %s DMA\n",
 					rst->name);
 				return -EBUSY;
 			}
@@ -186,7 +186,7 @@ static int tegra_mc_hotreset_assert(struct reset_controller_dev *rcdev,
 		/* clear clients DMA requests sitting before arbitration */
 		err = rst_ops->hotreset_assert(mc, rst);
 		if (err) {
-			dev_err(mc->dev, "Failed to hot reset %s: %d\n",
+			dev_err(mc->dev, "failed to hot reset %s: %d\n",
 				rst->name, err);
 			return err;
 		}
@@ -215,7 +215,7 @@ static int tegra_mc_hotreset_deassert(struct reset_controller_dev *rcdev,
 		/* take out client from hot reset */
 		err = rst_ops->hotreset_deassert(mc, rst);
 		if (err) {
-			dev_err(mc->dev, "Failed to deassert hot reset %s: %d\n",
+			dev_err(mc->dev, "failed to deassert hot reset %s: %d\n",
 				rst->name, err);
 			return err;
 		}
@@ -225,7 +225,7 @@ static int tegra_mc_hotreset_deassert(struct reset_controller_dev *rcdev,
 		/* allow new DMA requests to proceed to arbitration */
 		err = rst_ops->unblock_dma(mc, rst);
 		if (err) {
-			dev_err(mc->dev, "Failed to unblock %s DMA : %d\n",
+			dev_err(mc->dev, "failed to unblock %s DMA : %d\n",
 				rst->name, err);
 			return err;
 		}
@@ -657,7 +657,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	{
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
-			dev_err(&pdev->dev, "failed to setup latency allowance: %d\n",
+			dev_err(&pdev->dev,
+				"failed to setup latency allowance: %d\n",
 				err);
 			return err;
 		}
@@ -678,7 +679,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return mc->irq;
 	}
 
-	WARN(!mc->soc->client_id_mask, "Missing client ID mask for this SoC\n");
+	WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
 	mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
-- 
2.20.0
