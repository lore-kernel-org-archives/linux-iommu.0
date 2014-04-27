From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH v12 10/31] iommu/exynos: use managed device helper functions
Date: Sun, 27 Apr 2014 13:07:42 +0530
Message-ID: <1398584283-22846-11-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: kgene.kim@samsung.com, prathyush.k@samsung.com, grundler@chromium.org, joro@8bytes.org, supash.ramaswamy@linaro.org, tomasz.figa@gmail.com, joshi@samsung.com, sachin.kamat@linaro.org, s.nawrocki@samsung.com, Varun.Sethi@freescale.com, a.motakis@virtualopensystems.com, pullip.cho@samsung.com, t.figa@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho@samsung.com>

This patch uses managed device helper functions in the probe().

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   68 ++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 1af2d23..0f1d3f0 100755
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -342,8 +342,7 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
 
 	__raw_writel(CTRL_DISABLE, data->sfrbase + REG_MMU_CTRL);
 
-	if (!IS_ERR(data->clk))
-		clk_disable(data->clk);
+	clk_disable(data->clk);
 
 	disabled = true;
 	data->pgtable = 0;
@@ -386,8 +385,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
 		goto finish;
 	}
 
-	if (!IS_ERR(data->clk))
-		clk_enable(data->clk);
+	clk_enable(data->clk);
 
 	data->pgtable = pgtable;
 
@@ -498,49 +496,43 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
 
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
-	if (!res) {
-		dev_dbg(dev, "Unable to find IOMEM region\n");
-		ret = -ENOENT;
-		goto err_init;
-	}
+	data->sfrbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->sfrbase))
+		return PTR_ERR(data->sfrbase);
 
-	data->sfrbase = ioremap(res->start, resource_size(res));
-	if (!data->sfrbase) {
-		dev_dbg(dev, "Unable to map IOMEM @ PA:%#x\n", res->start);
-		ret = -ENOENT;
-		goto err_res;
-	}
-
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
-		data->clk = clk_get(dev, "sysmmu");
-		if (IS_ERR(data->clk))
-			dev_dbg(dev, "No clock descriptor registered\n");
+	data->clk = devm_clk_get(dev, "sysmmu");
+	if (IS_ERR(data->clk)) {
+		dev_err(dev, "Failed to get clock!\n");
+		return PTR_ERR(data->clk);
+	} else  {
+		ret = clk_prepare(data->clk);
+		if (ret) {
+			dev_err(dev, "Failed to prepare clk\n");
+			return ret;
+		}
 	}
 
 	data->sysmmu = dev;
@@ -553,17 +545,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	dev_dbg(dev, "Initialized\n");
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
1.7.9.5
