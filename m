From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v3 09/19] memory: tegra: Adapt to Tegra20 device-tree binding changes
Date: Sat, 18 Aug 2018 18:54:20 +0300
Message-ID: <20180818155430.5586-10-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh+dt@kernel.org>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The tegra20-mc DT binding has been changed, GART has been squashed
into Memory Controller and now the clock property is mandatory for
Tegra20. Adapt driver the to DT changes.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 19 +++++++------------
 drivers/memory/tegra/mc.h |  6 ------
 include/soc/tegra/mc.h    |  2 +-
 3 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index e56862495f36..3bf3138769f4 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -638,24 +638,19 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
+	mc->clk = devm_clk_get(&pdev->dev, "mc");
+	if (IS_ERR(mc->clk)) {
+		dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
+			PTR_ERR(mc->clk));
+		return PTR_ERR(mc->clk);
+	}
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	if (mc->soc == &tegra20_mc_soc) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		mc->regs2 = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(mc->regs2))
-			return PTR_ERR(mc->regs2);
-
 		isr = tegra20_mc_irq;
 	} else
 #endif
 	{
-		mc->clk = devm_clk_get(&pdev->dev, "mc");
-		if (IS_ERR(mc->clk)) {
-			dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
-				PTR_ERR(mc->clk));
-			return PTR_ERR(mc->clk);
-		}
-
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev, "failed to setup latency allowance: %d\n",
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 01065f12ebeb..9856f085e487 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -26,18 +26,12 @@
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
-	if (mc->regs2 && offset >= 0x24)
-		return readl(mc->regs2 + offset - 0x3c);
-
 	return readl(mc->regs + offset);
 }
 
 static inline void mc_writel(struct tegra_mc *mc, u32 value,
 			     unsigned long offset)
 {
-	if (mc->regs2 && offset >= 0x24)
-		return writel(value, mc->regs2 + offset - 0x3c);
-
 	writel(value, mc->regs + offset);
 }
 
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index b43f37fea096..db5bfdf589b4 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -144,7 +144,7 @@ struct tegra_mc_soc {
 struct tegra_mc {
 	struct device *dev;
 	struct tegra_smmu *smmu;
-	void __iomem *regs, *regs2;
+	void __iomem *regs;
 	struct clk *clk;
 	int irq;
 
-- 
2.18.0
