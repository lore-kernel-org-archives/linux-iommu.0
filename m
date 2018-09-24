From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 12/20] iommu/tegra: gart: Integrate with Memory Controller
	driver
Date: Mon, 24 Sep 2018 03:41:45 +0300
Message-ID: <20180924004153.8232-13-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-1-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The device-tree binding has been changed. There is no separate GART device
anymore, it is squashed into the Memory Controller. Integrate GART module
with the MC in a way it is done for the SMMU of Tegra30+.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/Kconfig      |  1 +
 drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
 drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
 include/soc/tegra/mc.h     | 27 +++++++++++
 4 files changed, 93 insertions(+), 74 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c60395b7470f..33f97e5f07ca 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -269,6 +269,7 @@ config ROCKCHIP_IOMMU
 config TEGRA_IOMMU_GART
 	bool "Tegra GART IOMMU Support"
 	depends on ARCH_TEGRA_2x_SOC
+	depends on TEGRA_MC
 	select IOMMU_API
 	help
 	  Enables support for remapping discontiguous physical memory
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 86a855c0d031..1c89b20ba4bb 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -21,11 +21,13 @@
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 
+#include <soc/tegra/mc.h>
+
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
 
@@ -394,9 +396,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iotlb_sync	= gart_iommu_sync,
 };
 
-static int tegra_gart_suspend(struct device *dev)
+int tegra_gart_suspend(struct gart_device *gart)
 {
-	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long iova;
 	u32 *data = gart->savedata;
 	unsigned long flags;
@@ -408,9 +409,8 @@ static int tegra_gart_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_gart_resume(struct device *dev)
+int tegra_gart_resume(struct gart_device *gart)
 {
-	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
@@ -419,41 +419,39 @@ static int tegra_gart_resume(struct device *dev)
 	return 0;
 }
 
-static int tegra_gart_probe(struct platform_device *pdev)
+struct gart_device *tegra_gart_probe(struct device *dev,
+				     const struct tegra_smmu_soc *soc,
+				     struct tegra_mc *mc)
 {
 	struct gart_device *gart;
-	struct resource *res, *res_remap;
+	struct resource *res_remap;
 	void __iomem *gart_regs;
-	struct device *dev = &pdev->dev;
 	int ret;
 
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
+	/* Tegra30+ has an SMMU and no GART */
+	if (soc)
+		return NULL;
+
 	/* the GART memory aperture is required */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	res_remap = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res || !res_remap) {
+	res_remap = platform_get_resource(to_platform_device(dev),
+					  IORESOURCE_MEM, 1);
+	if (!res_remap) {
 		dev_err(dev, "GART memory aperture expected\n");
-		return -ENXIO;
+		return ERR_PTR(-ENXIO);
 	}
 
 	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 
-	gart_regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (!gart_regs) {
-		dev_err(dev, "failed to remap GART registers\n");
-		return -ENXIO;
-	}
-
-	ret = iommu_device_sysfs_add(&gart->iommu, &pdev->dev, NULL,
-				     dev_name(&pdev->dev));
+	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -465,7 +463,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		goto remove_sysfs;
 	}
 
-	gart->dev = &pdev->dev;
+	gart->dev = dev;
+	gart_regs = mc->regs + GART_REG_BASE;
 	spin_lock_init(&gart->pte_lock);
 	spin_lock_init(&gart->client_lock);
 	INIT_LIST_HEAD(&gart->client);
@@ -480,72 +479,23 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		goto unregister_iommu;
 	}
 
-	platform_set_drvdata(pdev, gart);
 	do_gart_setup(gart, NULL);
 
 	gart_handle = gart;
 
-	return 0;
+	return gart;
 
 unregister_iommu:
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
 
-	return ret;
-}
-
-static int tegra_gart_remove(struct platform_device *pdev)
-{
-	struct gart_device *gart = platform_get_drvdata(pdev);
-
-	iommu_device_unregister(&gart->iommu);
-	iommu_device_sysfs_remove(&gart->iommu);
-
-	writel(0, gart->regs + GART_CONFIG);
-	if (gart->savedata)
-		vfree(gart->savedata);
-	gart_handle = NULL;
-	return 0;
-}
-
-static const struct dev_pm_ops tegra_gart_pm_ops = {
-	.suspend	= tegra_gart_suspend,
-	.resume		= tegra_gart_resume,
-};
-
-static const struct of_device_id tegra_gart_of_match[] = {
-	{ .compatible = "nvidia,tegra20-gart", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
-
-static struct platform_driver tegra_gart_driver = {
-	.probe		= tegra_gart_probe,
-	.remove		= tegra_gart_remove,
-	.driver = {
-		.name	= "tegra-gart",
-		.pm	= &tegra_gart_pm_ops,
-		.of_match_table = tegra_gart_of_match,
-	},
-};
-
-static int tegra_gart_init(void)
-{
-	return platform_driver_register(&tegra_gart_driver);
-}
-
-static void __exit tegra_gart_exit(void)
-{
-	platform_driver_unregister(&tegra_gart_driver);
+	return ERR_PTR(ret);
 }
 
-subsys_initcall(tegra_gart_init);
-module_exit(tegra_gart_exit);
 module_param(gart_debug, bool, 0644);
 
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
 MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>");
-MODULE_ALIAS("platform:tegra-gart");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index cdc33f93cf7c..cdb6f1069930 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -700,13 +700,54 @@ static int tegra_mc_probe(struct platform_device *pdev)
 				PTR_ERR(mc->smmu));
 	}
 
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART)) {
+		mc->gart = tegra_gart_probe(&pdev->dev, mc->soc->smmu, mc);
+		if (IS_ERR(mc->gart))
+			dev_err(&pdev->dev, "failed to probe GART: %ld\n",
+				PTR_ERR(mc->gart));
+	}
+
+	return 0;
+}
+
+static int tegra_mc_suspend(struct device *dev)
+{
+	struct tegra_mc *mc = dev_get_drvdata(dev);
+	int err;
+
+	if (mc->gart) {
+		err = tegra_gart_suspend(mc->gart);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
+static int tegra_mc_resume(struct device *dev)
+{
+	struct tegra_mc *mc = dev_get_drvdata(dev);
+	int err;
+
+	if (mc->gart) {
+		err = tegra_gart_resume(mc->gart);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_mc_pm_ops = {
+	.suspend = tegra_mc_suspend,
+	.resume = tegra_mc_resume,
+};
+
 static struct platform_driver tegra_mc_driver = {
 	.driver = {
 		.name = "tegra-mc",
 		.of_match_table = tegra_mc_of_match,
+		.pm = &tegra_mc_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 	.prevent_deferred_probe = true,
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index db5bfdf589b4..5da42e3fb801 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -77,6 +77,7 @@ struct tegra_smmu_soc {
 
 struct tegra_mc;
 struct tegra_smmu;
+struct gart_device;
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
 struct tegra_smmu *tegra_smmu_probe(struct device *dev,
@@ -96,6 +97,31 @@ static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
 }
 #endif
 
+#ifdef CONFIG_TEGRA_IOMMU_GART
+struct gart_device *tegra_gart_probe(struct device *dev,
+				     const struct tegra_smmu_soc *soc,
+				     struct tegra_mc *mc);
+int tegra_gart_suspend(struct gart_device *gart);
+int tegra_gart_resume(struct gart_device *gart);
+#else
+static inline struct gart_device *
+tegra_gart_probe(struct device *dev, const struct tegra_smmu_soc *soc,
+		 struct tegra_mc *mc)
+{
+	return NULL;
+}
+
+static inline int tegra_gart_suspend(struct gart_device *gart)
+{
+	return -ENODEV;
+}
+
+static inline int tegra_gart_resume(struct gart_device *gart)
+{
+	return -ENODEV;
+}
+#endif
+
 struct tegra_mc_reset {
 	const char *name;
 	unsigned long id;
@@ -144,6 +170,7 @@ struct tegra_mc_soc {
 struct tegra_mc {
 	struct device *dev;
 	struct tegra_smmu *smmu;
+	struct gart_device *gart;
 	void __iomem *regs;
 	struct clk *clk;
 	int irq;
-- 
2.19.0
