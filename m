From: Sricharan R <sricharan@codeaurora.org>
Subject: [RFC PATCH 4/4] iommu/arm-smmu: Add support for specifying regulators
Date: Fri, 17 Jul 2015 22:23:25 +0530
Message-ID: <1437152005-25092-5-git-send-email-sricharan@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, will.deacon@arm.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

From: Mitchel Humpherys <mitchelh@codeaurora.org>

This adds the support to turn on the regulators required
for SMMUs. It is turned on during the SMMU probe and remains
'on' till the device exists.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |  3 ++
 drivers/iommu/arm-smmu.c                           | 48 +++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index c2cf4fe..433d778 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -60,6 +60,9 @@ conditions.
 		  Documentation/devicetree/bindings/clock/clock-bindings.txt
 		  for more info.
 
+- vdd-supply    : Phandle of the regulator that should be powered on during
+                  SMMU register access.
+
 Example:
 
         smmu {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 80d56f0a..c92de50 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -326,6 +326,8 @@ struct arm_smmu_device {
 
 	int				num_clocks;
 	struct clk			**clocks;
+
+	struct regulator		*regulator;
 };
 
 struct arm_smmu_cfg {
@@ -559,6 +561,22 @@ static void __arm_smmu_free_bitmap(unsigned long *map, int idx)
 	clear_bit(idx, map);
 }
 
+static int arm_smmu_enable_regulators(struct arm_smmu_device *smmu)
+{
+	if (!smmu->regulator)
+		return 0;
+
+	return regulator_enable(smmu->regulator);
+}
+
+static int arm_smmu_disable_regulators(struct arm_smmu_device *smmu)
+{
+	if (!smmu->regulator)
+		return 0;
+
+	return regulator_disable(smmu->regulator);
+}
+
 /* Wait for any pending TLB invalidations to complete */
 static void __arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
@@ -1583,6 +1601,20 @@ static int arm_smmu_id_size_to_bits(int size)
 	}
 }
 
+static int arm_smmu_init_regulators(struct arm_smmu_device *smmu)
+{
+	struct device *dev = smmu->dev;
+
+	if (!of_get_property(dev->of_node, "vdd-supply", NULL))
+		return 0;
+
+	smmu->regulator = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(smmu->regulator))
+		return PTR_ERR(smmu->regulator);
+
+	return 0;
+}
+
 static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
 {
 	const char *cname;
@@ -1841,11 +1873,21 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = arm_smmu_init_regulators(smmu);
+	if (err)
+		goto out_put_masters;
+
 	err = arm_smmu_init_clocks(smmu);
 	if (err)
 		goto out_put_masters;
 
-	arm_smmu_enable_clocks(smmu);
+	err = arm_smmu_enable_regulators(smmu);
+	if (err)
+		goto out_put_masters;
+
+	err = arm_smmu_enable_clocks(smmu);
+	if (err)
+		goto out_disable_regulators;
 
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
@@ -1908,6 +1950,9 @@ out_free_irqs:
 out_disable_clocks:
 	arm_smmu_disable_clocks(smmu);
 
+out_disable_regulators:
+	arm_smmu_disable_regulators(smmu);
+
 out_put_masters:
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master
@@ -1953,6 +1998,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
 	arm_smmu_disable_clocks(smmu);
+	arm_smmu_disable_regulators(smmu);
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
