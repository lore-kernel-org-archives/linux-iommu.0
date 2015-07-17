From: Sricharan R <sricharan@codeaurora.org>
Subject: [RFC PATCH 3/4] iommu/arm-smmu: Add support for specifying clocks
Date: Fri, 17 Jul 2015 22:23:24 +0530
Message-ID: <1437152005-25092-4-git-send-email-sricharan@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, will.deacon@arm.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

From: Mitchel Humpherys <mitchelh@codeaurora.org>

On some platforms with tight power constraints it is polite to only
leave your clocks on for as long as you absolutely need them. Currently
we assume that all clocks necessary for SMMU register access are always
on.

Add some optional device tree properties to specify any clocks that are
necessary for SMMU register access and turn them on and off as needed.

If no clocks are specified in the device tree things continue to work
the way they always have: we assume all necessary clocks are always
turned on. The clocks are turned 'on' during the SMMU device probe
and remains 'on' till the device exists.

Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         | 11 +++
 drivers/iommu/arm-smmu.c                           | 86 +++++++++++++++++++++-
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 0676050..c2cf4fe 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -49,6 +49,17 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
+- clocks	: List of clocks to be used during SMMU register access. See
+		  Documentation/devicetree/bindings/clock/clock-bindings.txt
+		  for information about the format. For each clock specified
+		  here, there must be a corresponding entery in clock-names
+		  (see below).
+
+- clock-names	: List of clock names corresponding to the clocks specified in
+		  the "clocks" property (above). See
+		  Documentation/devicetree/bindings/clock/clock-bindings.txt
+		  for more info.
+
 Example:
 
         smmu {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2cf65ab..80d56f0a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -323,6 +323,9 @@ struct arm_smmu_device {
 	struct list_head		list;
 	struct device_node		*node;
 	struct rb_root			masters;
+
+	int				num_clocks;
+	struct clk			**clocks;
 };
 
 struct arm_smmu_cfg {
@@ -365,6 +368,31 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < smmu->num_clocks; ++i) {
+		ret = clk_prepare_enable(smmu->clocks[i]);
+		if (ret) {
+			dev_err(smmu->dev, "Couldn't enable clock #%d\n", i);
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
+	int i;
+
+	for (i = 0; i < smmu->num_clocks; ++i)
+		clk_disable_unprepare(smmu->clocks[i]);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -1555,6 +1583,47 @@ static int arm_smmu_id_size_to_bits(int size)
 	}
 }
 
+static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
+{
+	const char *cname;
+	struct property *prop;
+	int i;
+	struct device *dev = smmu->dev;
+
+	smmu->num_clocks =
+		of_property_count_strings(dev->of_node, "clock-names");
+
+	if (smmu->num_clocks < 1)
+		return 0;
+
+	smmu->clocks = devm_kzalloc(
+		dev, sizeof(*smmu->clocks) * smmu->num_clocks,
+		GFP_KERNEL);
+
+	if (!smmu->clocks) {
+		dev_err(dev,
+			"Failed to allocate memory for clocks\n");
+		return -ENODEV;
+	}
+
+	i = 0;
+	of_property_for_each_string(dev->of_node, "clock-names",
+				    prop, cname) {
+		struct clk *c = devm_clk_get(dev, cname);
+
+		if (IS_ERR(c)) {
+			dev_err(dev, "Couldn't get clock: %s",
+				cname);
+			return -ENODEV;
+		}
+
+		smmu->clocks[i] = c;
+
+		++i;
+	}
+	return 0;
+}
+
 static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned long size;
@@ -1772,9 +1841,15 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = arm_smmu_init_clocks(smmu);
+	if (err)
+		goto out_put_masters;
+
+	arm_smmu_enable_clocks(smmu);
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
-		return err;
+		goto out_disable_clocks;
 
 	i = 0;
 	smmu->masters = RB_ROOT;
@@ -1785,7 +1860,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(dev, "failed to add master %s\n",
 				masterspec.np->name);
-			goto out_put_masters;
+			goto out_disable_clocks;
 		}
 
 		i++;
@@ -1800,7 +1875,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 			"found only %d context interrupt(s) but %d required\n",
 			smmu->num_context_irqs, smmu->num_context_banks);
 		err = -ENODEV;
-		goto out_put_masters;
+		goto out_disable_clocks;
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
@@ -1830,6 +1905,9 @@ out_free_irqs:
 	while (i--)
 		free_irq(smmu->irqs[i], smmu);
 
+out_disable_clocks:
+	arm_smmu_disable_clocks(smmu);
+
 out_put_masters:
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
 		struct arm_smmu_master *master
@@ -1874,6 +1952,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	arm_smmu_disable_clocks(smmu);
+
 	return 0;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
