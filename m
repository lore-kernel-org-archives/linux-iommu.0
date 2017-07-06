From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH V4 2/6] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Thu,  6 Jul 2017 15:07:01 +0530
Message-ID: <1499333825-7658-3-git-send-email-vivek.gautam@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, m.szyprowski@samsung.com, sboyd@codeaurora.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org, stanimir.varbanov@linaro.org, architt@codeaurora.org, vivek.gautam@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Sricharan R <sricharan@codeaurora.org>

The smmu needs to be functional only when the respective
master's using it are active. The device_link feature
helps to track such functional dependencies, so that the
iommu gets powered when the master device enables itself
using pm_runtime. So by adapting the smmu driver for
runtime pm, above said dependency can be addressed.

This patch adds the pm runtime/sleep callbacks to the
driver and also the functions to parse the smmu clocks
from DT and enable them in resume/suspend.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Archit Taneja <architt@codeaurora.org>
[vivek: Clock rework to loop over clock names data]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 61b1f8729a7c..bfe613f8939c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -48,6 +48,7 @@
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -196,6 +197,9 @@ struct arm_smmu_device {
 	u32				num_global_irqs;
 	u32				num_context_irqs;
 	unsigned int			*irqs;
+	int                             num_clks;
+	struct clk                      **clocks;
+	const char * const		*clk_names;
 
 	u32				cavium_id_base; /* Specific to Cavium */
 
@@ -272,6 +276,32 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
 	} while (arm_smmu_options[++i].opt);
 }
 
+static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < smmu->num_clks; ++i) {
+		ret = clk_prepare_enable(smmu->clocks[i]);
+		if (ret) {
+			dev_err(smmu->dev, "Couldn't enable %s clock\n",
+				smmu->clk_names[i]);
+			while (i--)
+				clk_disable_unprepare(smmu->clocks[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void arm_smmu_disable_clocks(struct arm_smmu_device *smmu)
+{
+	int i = smmu->num_clks;
+
+	while (i--)
+		clk_disable_unprepare(smmu->clocks[i]);
+}
+
 static struct device_node *dev_get_dev_node(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
@@ -1626,6 +1656,36 @@ static int arm_smmu_id_size_to_bits(int size)
 	}
 }
 
+static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
+{
+	int i, err;
+	struct device *dev = smmu->dev;
+
+	if (smmu->num_clks < 1)
+		return 0;
+
+	smmu->clocks = devm_kcalloc(dev, smmu->num_clks,
+				    sizeof(*smmu->clocks), GFP_KERNEL);
+	if (!smmu->clocks)
+		return -ENOMEM;
+
+	for (i = 0; i < smmu->num_clks; i++) {
+		const char *cname = smmu->clk_names[i];
+		struct clk *c = devm_clk_get(dev, cname);
+
+		if (IS_ERR(c)) {
+			err = PTR_ERR(c);
+			if (err != -EPROBE_DEFER)
+				dev_err(dev, "Couldn't get clock: %s", cname);
+
+			return err;
+		}
+		smmu->clocks[i] = c;
+	}
+
+	return 0;
+}
+
 static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned long size;
@@ -1833,10 +1893,12 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
+	const char * const *clks;
+	int num_clks;
 };
 
 #define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
-static struct arm_smmu_match_data name = { .version = ver, .model = imp }
+static const struct arm_smmu_match_data name = { .version = ver, .model = imp }
 
 ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
@@ -1937,6 +1999,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	data = of_device_get_match_data(dev);
 	smmu->version = data->version;
 	smmu->model = data->model;
+	smmu->clk_names = data->clks;
+	smmu->num_clks = data->num_clks;
 
 	parse_driver_options(smmu);
 
@@ -2035,6 +2099,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = arm_smmu_init_clocks(smmu);
+	if (err)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2120,10 +2188,35 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int arm_smmu_resume(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	return arm_smmu_enable_clocks(smmu);
+}
+
+static int arm_smmu_suspend(struct device *dev)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
+
+	arm_smmu_disable_clocks(smmu);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(arm_smmu_suspend, arm_smmu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.pm = &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
