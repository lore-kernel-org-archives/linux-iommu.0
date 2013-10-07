From: Cho KyongHo <pullip.cho@samsung.com>
Subject: [PATCH v10 09/20] iommu/exynos: use managed device helper functions
Date: Mon, 07 Oct 2013 10:56:36 +0900
Message-ID: <20131007105636.d3eabb5be87899116cca4a99@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Cc: Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Subash Patel <supash.ramaswamy@linaro.org>, Varun Sethi <Varun.Sethi@freescale.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch uses managed device helper functions in the probe().

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   64 ++++++++++++++++-------------------------
 1 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 735d75e..6fdb3836 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -510,53 +510,48 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 
 static int exynos_sysmmu_probe(struct platform_device *pdev)
 {
-	int ret;
+	int irq, ret;
 	struct device *dev = &pdev->dev;
 	struct sysmmu_drvdata *data;
 	struct resource *res;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_dbg(dev, "Not enough memory\n");
-		ret = -ENOMEM;
-		goto err_alloc;
-	}
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
-		dev_dbg(dev, "Unable to find IOMEM region\n");
-		ret = -ENOENT;
-		goto err_res;
+		dev_err(dev, "Unable to find IOMEM region\n");
+		return -ENOENT;
 	}
 
-	data->sfrbase = ioremap(res->start, resource_size(res));
-	if (!data->sfrbase) {
-		dev_dbg(dev, "Unable to map IOMEM @ PA:%#x\n", res->start);
-		ret = -ENOENT;
-		goto err_res;
-	}
+	data->sfrbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->sfrbase))
+		return PTR_ERR(data->sfrbase);
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
 		dev_dbg(dev, "Unable to find IRQ resource\n");
-		goto err_irq;
+		return irq;
 	}
 
-	ret = request_irq(ret, exynos_sysmmu_irq, 0,
+	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
 				dev_name(dev), data);
 	if (ret) {
-		dev_dbg(dev, "Unabled to register interrupt handler\n");
-		goto err_irq;
+		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
+		return ret;
 	}
 
-	if (dev_get_platdata(dev)) {
-		struct sysmmu_platform_data *platdata = dev_get_platdata(dev);
+	data->clk = devm_clk_get(dev, "sysmmu");
+	if (IS_ERR(data->clk)) {
+		dev_info(dev, "No gate clock found!\n");
+		data->clk = NULL;
+	}
 
-		data->clk = clk_get(dev, "sysmmu");
-		if (IS_ERR(data->clk)) {
-			data->clk = NULL;
-			dev_dbg(dev, "No clock descriptor registered\n");
-		}
+	ret = clk_prepare(data->clk);
+	if (ret) {
+		dev_err(dev, "Failed to prepare clk\n");
+		return ret;
 	}
 
 	data->sysmmu = dev;
@@ -569,17 +564,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	dev_dbg(dev, "Initialized\n");
+	dev_dbg(dev, "Probed and initialized\n");
 	return 0;
-err_irq:
-	free_irq(platform_get_irq(pdev, 0), data);
-err_res:
-	iounmap(data->sfrbase);
-err_init:
-	kfree(data);
-err_alloc:
-	dev_err(dev, "Failed to initialize\n");
-	return ret;
 }
 
 static struct platform_driver exynos_sysmmu_driver = {
-- 
1.7.2.5
