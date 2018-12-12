From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 13/24] iommu/tegra: gart: Integrate with Memory Controller driver
Date: Wed, 12 Dec 2018 23:38:56 +0300
Message-ID: <20181212203907.23461-14-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The device-tree binding has been changed. There is no separate GART device
anymore, it is squashed into the Memory Controller. Integrate GART module
with the MC in a way it is done for the SMMU on Tegra30+.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/Kconfig      |  1 +
 drivers/iommu/tegra-gart.c | 71 ++++++++++----------------------------
 drivers/memory/tegra/mc.c  | 43 +++++++++++++++++++++++
 include/soc/tegra/mc.h     | 25 ++++++++++++++
 4 files changed, 87 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9a25715650e..83c099bb7288 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -282,6 +282,7 @@ config ROCKCHIP_IOMMU
 config TEGRA_IOMMU_GART
 	bool "Tegra GART IOMMU Support"
 	depends on ARCH_TEGRA_2x_SOC
+	depends on TEGRA_MC
 	select IOMMU_API
 	help
 	  Enables support for remapping discontiguous physical memory
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 835fea461c59..b35ffa312a83 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,16 +19,17 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/moduleparam.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 
+#include <soc/tegra/mc.h>
+
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
 
@@ -397,9 +398,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iotlb_sync	= gart_iommu_sync,
 };
 
-static int tegra_gart_suspend(struct device *dev)
+int tegra_gart_suspend(struct gart_device *gart)
 {
-	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long iova;
 	u32 *data = gart->savedata;
 	unsigned long flags;
@@ -411,9 +411,8 @@ static int tegra_gart_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_gart_resume(struct device *dev)
+int tegra_gart_resume(struct gart_device *gart)
 {
-	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
@@ -422,41 +421,33 @@ static int tegra_gart_resume(struct device *dev)
 	return 0;
 }
 
-static int tegra_gart_probe(struct platform_device *pdev)
+struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 {
 	struct gart_device *gart;
-	struct resource *res, *res_remap;
+	struct resource *res_remap;
 	void __iomem *gart_regs;
-	struct device *dev = &pdev->dev;
 	int ret;
 
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
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
-	}
-
-	gart_regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (!gart_regs) {
-		dev_err(dev, "failed to remap GART registers\n");
-		return -ENXIO;
+		return ERR_PTR(-ENOMEM);
 	}
 
-	ret = iommu_device_sysfs_add(&gart->iommu, &pdev->dev, NULL,
-				     dev_name(&pdev->dev));
+	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -468,7 +459,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		goto remove_sysfs;
 	}
 
-	gart->dev = &pdev->dev;
+	gart->dev = dev;
+	gart_regs = mc->regs + GART_REG_BASE;
 	spin_lock_init(&gart->pte_lock);
 	spin_lock_init(&gart->client_lock);
 	INIT_LIST_HEAD(&gart->client);
@@ -483,46 +475,19 @@ static int tegra_gart_probe(struct platform_device *pdev)
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
-static const struct dev_pm_ops tegra_gart_pm_ops = {
-	.suspend	= tegra_gart_suspend,
-	.resume		= tegra_gart_resume,
-};
-
-static const struct of_device_id tegra_gart_of_match[] = {
-	{ .compatible = "nvidia,tegra20-gart", },
-	{ },
-};
-
-static struct platform_driver tegra_gart_driver = {
-	.probe		= tegra_gart_probe,
-	.driver = {
-		.name	= "tegra-gart",
-		.pm	= &tegra_gart_pm_ops,
-		.of_match_table = tegra_gart_of_match,
-		.suppress_bind_attrs = true,
-	},
-};
-
-static int __init tegra_gart_init(void)
-{
-	return platform_driver_register(&tegra_gart_driver);
+	return ERR_PTR(ret);
 }
-subsys_initcall(tegra_gart_init);
 
 module_param(gart_debug, bool, 0644);
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 55ecfb2d8cfd..e684e234361a 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -702,13 +702,56 @@ static int tegra_mc_probe(struct platform_device *pdev)
 				PTR_ERR(mc->smmu));
 	}
 
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) && !mc->soc->smmu) {
+		mc->gart = tegra_gart_probe(&pdev->dev, mc);
+		if (IS_ERR(mc->gart)) {
+			dev_err(&pdev->dev, "failed to probe GART: %ld\n",
+				PTR_ERR(mc->gart));
+			mc->gart = NULL;
+		}
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
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) && mc->gart) {
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
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) && mc->gart) {
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
index db5bfdf589b4..e489a028ec9f 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -9,6 +9,7 @@
 #ifndef __SOC_TEGRA_MC_H__
 #define __SOC_TEGRA_MC_H__
 
+#include <linux/err.h>
 #include <linux/reset-controller.h>
 #include <linux/types.h>
 
@@ -77,6 +78,7 @@ struct tegra_smmu_soc {
 
 struct tegra_mc;
 struct tegra_smmu;
+struct gart_device;
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
 struct tegra_smmu *tegra_smmu_probe(struct device *dev,
@@ -96,6 +98,28 @@ static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
 }
 #endif
 
+#ifdef CONFIG_TEGRA_IOMMU_GART
+struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc);
+int tegra_gart_suspend(struct gart_device *gart);
+int tegra_gart_resume(struct gart_device *gart);
+#else
+static inline struct gart_device *
+tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
+{
+	return ERR_PTR(-ENODEV);
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
@@ -144,6 +168,7 @@ struct tegra_mc_soc {
 struct tegra_mc {
 	struct device *dev;
 	struct tegra_smmu *smmu;
+	struct gart_device *gart;
 	void __iomem *regs;
 	struct clk *clk;
 	int irq;
-- 
2.20.0
