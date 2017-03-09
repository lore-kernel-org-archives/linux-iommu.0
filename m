From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V3 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Thu,  9 Mar 2017 21:05:44 +0530
Message-ID: <1489073748-3659-2-git-send-email-sricharan@codeaurora.org>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mathieu.poirier@linaro.org, mark.rutland@arm.com
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

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
---
 drivers/iommu/arm-smmu.c | 74 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index abf6496..f7e11d3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -48,6 +48,7 @@
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -340,6 +341,13 @@ struct arm_smmu_master_cfg {
 #define for_each_cfg_sme(fw, i, idx) \
 	for (i = 0; idx = fwspec_smendx(fw, i), i < fw->num_ids; ++i)
 
+struct arm_smmu_clks {
+	void *clks;
+	int (*init_clocks)(struct arm_smmu_device *smmu);
+	int (*enable_clocks)(struct arm_smmu_device *smmu);
+	void (*disable_clocks)(struct arm_smmu_device *smmu);
+};
+
 struct arm_smmu_device {
 	struct device			*dev;
 
@@ -387,7 +395,7 @@ struct arm_smmu_device {
 	u32				num_global_irqs;
 	u32				num_context_irqs;
 	unsigned int			*irqs;
-
+	struct arm_smmu_clks		smmu_clks;
 	u32				cavium_id_base; /* Specific to Cavium */
 
 	/* IOMMU core code handle */
@@ -1958,16 +1966,24 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
+	struct arm_smmu_clks smmu_clks;
 };
 
-#define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
-static struct arm_smmu_match_data name = { .version = ver, .model = imp }
-
-ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
-ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
-ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
-ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
-ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
+#define ARM_SMMU_MATCH_DATA(name, ver, imp, init, enable, disable)	\
+static struct arm_smmu_match_data name = { .version = ver, .model = imp, \
+					   .smmu_clks.init_clocks = init, \
+					   .smmu_clks.enable_clocks = enable, \
+					   .smmu_clks.disable_clocks = disable }
+
+ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU,
+		    NULL, NULL, NULL);
+ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU,
+		    NULL, NULL, NULL);
+ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU,
+		    NULL, NULL, NULL);
+ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500, NULL, NULL, NULL);
+ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2,
+		    NULL, NULL, NULL);
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
@@ -2054,6 +2070,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	data = of_device_get_match_data(dev);
 	smmu->version = data->version;
 	smmu->model = data->model;
+	smmu->smmu_clks = data->smmu_clks;
 
 	parse_driver_options(smmu);
 
@@ -2135,6 +2152,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	if (smmu->smmu_clks.init_clocks) {
+		err = smmu->smmu_clks.init_clocks(smmu);
+		if (err)
+			return err;
+	}
+
+	pm_runtime_enable(dev);
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2211,10 +2235,42 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int arm_smmu_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	if (smmu->smmu_clks.enable_clocks)
+		ret = smmu->smmu_clks.enable_clocks(smmu);
+
+	return ret;
+}
+
+static int arm_smmu_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+
+	if (smmu->smmu_clks.disable_clocks)
+		smmu->smmu_clks.disable_clocks(smmu);
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

