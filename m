From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V3 3/5] drivers: arm-smmu: Add clock support for QCOM_SMMUV2
Date: Thu,  9 Mar 2017 21:05:46 +0530
Message-ID: <1489073748-3659-4-git-send-email-sricharan@codeaurora.org>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489073748-3659-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The QCOM_SMMUV2 is an implementation of the arm,smmu-v2 architecture.
The qcom,smmu is instantiated for each of the multimedia cores (for eg)
Venus (video encoder/decoder), mdp (display) etc, and they are connected
to the Multimedia Aggregator Interconnect (MMAGIC). So the access to
any of the MMU's registers, as well as MMU's downstream bus access,
requires the specified MMAGIC clocks to be enabled. So adding a new
binding for the qcom,smmu-v2 and the required mmagic clock bindings for
the same. Also adding the support for enabling the qcom,smmu-v2 clocks in
the driver.

               -------------  ---------
               |   VENUS   |  | MDP   |
	       |	   |  |       |
	       -------------  --------
		     |           |
		     |           |
                  ------      ---------
                  |SMMU |     | SMMU  |
                  |	|     |       |
                  ------      --------
		    |            |
		    |            |
       -----------------------------------------
       |	MMAGIC INTERCONNECT (MMSS NOC) |
       |                                       |
       -----------------------------------------
                   |                 |
		   |           ----------------------------------
                 -----         | 	SYSTEM NOC		|
                 |DDR|	       |				|
                 -----         ---------------------------------
		   |		    |
                   |               ------
		   |<-------------| CPU|
				  ------

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |   8 ++
 drivers/iommu/arm-smmu.c                           | 124 +++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index b369c13..88e02d6 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -17,6 +17,7 @@ conditions.
                         "arm,mmu-401"
                         "arm,mmu-500"
                         "cavium,smmu-v2"
+			"qcom,smmu-v2"
 
                   depending on the particular implementation and/or the
                   version of the architecture implemented.
@@ -74,6 +75,13 @@ conditions.
                   "cfg_clk" is optional if required to access the TCU's programming
                   interface, apart from the "tcu_clk".
 
+		  Should have "mmagic_ahb_clk", "mmagic_cfg_ahb_clk",
+                              "smmu_core_ahb_clk", "smmu_core_axi_clk",
+                              "mmagic_core_axi_clk" for "qcom,smmu-v2"
+
+		  "mmagic_core_axi_clk" is required for smmu's access to the
+                   downstream bus and rest for the smmu's register group access.
+
 - clocks:         Phandles for respective clocks described by clock-names.
 
 - power-domains:  Phandles to SMMU's power domain specifier. This is
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 720a1ef..f29e28bf 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -309,6 +309,7 @@ enum arm_smmu_implementation {
 	GENERIC_SMMU,
 	ARM_MMU500,
 	CAVIUM_SMMUV2,
+	QCOM_SMMUV2,
 };
 
 struct arm_smmu_s2cr {
@@ -341,6 +342,14 @@ struct arm_smmu_master_cfg {
 #define for_each_cfg_sme(fw, i, idx) \
 	for (i = 0; idx = fwspec_smendx(fw, i), i < fw->num_ids; ++i)
 
+struct qcom_smmu_clk {
+	struct clk *mmagic_ahb_clk;
+	struct clk *mmagic_cfg_ahb_clk;
+	struct clk *smmu_core_ahb_clk;
+	struct clk *smmu_core_axi_clk;
+	struct clk *mmagic_core_axi_clk;
+};
+
 struct mmu500_clk {
 	struct clk *cfg_clk;
 	struct clk *tcu_clk;
@@ -547,6 +556,117 @@ static int mmu500_init_clocks(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int qcom_smmu_init_clocks(struct arm_smmu_device *smmu)
+{
+	struct device *dev = smmu->dev;
+	struct qcom_smmu_clk *sclks;
+
+	if (!of_find_property(dev->of_node, "clocks", NULL))
+		return 0;
+
+	sclks = devm_kzalloc(dev, sizeof(*sclks), GFP_KERNEL);
+	if (!sclks)
+		return -ENOMEM;
+
+	sclks->mmagic_ahb_clk = devm_clk_get(dev, "mmagic_ahb_clk");
+	if (IS_ERR(sclks->mmagic_ahb_clk)) {
+		dev_err(dev, "Couldn't get mmagic_ahb_clk");
+		return PTR_ERR(sclks->mmagic_ahb_clk);
+	}
+
+	sclks->mmagic_cfg_ahb_clk = devm_clk_get(dev, "mmagic_cfg_ahb_clk");
+	if (IS_ERR(sclks->mmagic_cfg_ahb_clk)) {
+		dev_err(dev, "Couldn't get mmagic_cfg_ahb_clk");
+		return PTR_ERR(sclks->mmagic_cfg_ahb_clk);
+	}
+
+	sclks->smmu_core_ahb_clk = devm_clk_get(dev, "smmu_core_ahb_clk");
+	if (IS_ERR(sclks->smmu_core_ahb_clk)) {
+		dev_err(dev, "Couldn't get smmu_core_ahb_clk");
+		return PTR_ERR(sclks->smmu_core_ahb_clk);
+	}
+
+	sclks->smmu_core_axi_clk = devm_clk_get(dev, "smmu_core_axi_clk");
+	if (IS_ERR(sclks->smmu_core_axi_clk)) {
+		dev_err(dev, "Couldn't get smmu_core_axi_clk");
+		return PTR_ERR(sclks->smmu_core_axi_clk);
+	}
+
+	sclks->mmagic_core_axi_clk = devm_clk_get(dev, "mmagic_core_axi_clk");
+	if (IS_ERR(sclks->mmagic_core_axi_clk)) {
+		dev_err(dev, "Couldn't get mmagic_core_axi_clk");
+		return PTR_ERR(sclks->mmagic_core_axi_clk);
+	}
+
+	smmu->smmu_clks.clks = sclks;
+	return 0;
+}
+
+static int qcom_smmu_enable_clocks(struct arm_smmu_device *smmu)
+{
+	int ret = 0;
+	struct qcom_smmu_clk *sclks = smmu->smmu_clks.clks;
+
+	if (!sclks)
+		return 0;
+
+	ret = clk_prepare_enable(sclks->mmagic_ahb_clk);
+	if (ret) {
+		dev_err(smmu->dev, "Couldn't enable mmagic_ahb_clk");
+		goto ahb_clk_fail;
+	}
+
+	ret = clk_prepare_enable(sclks->mmagic_cfg_ahb_clk);
+	if (ret) {
+		dev_err(smmu->dev, "Couln't enable mmagic_cfg_ahb_clk");
+		goto cfg_ahb_clk_fail;
+	}
+
+	ret = clk_prepare_enable(sclks->smmu_core_ahb_clk);
+	if (ret) {
+		dev_err(smmu->dev, "Couln't enable smmu_core_ahb_clk");
+		goto core_ahb_clk_fail;
+	}
+
+	ret = clk_prepare_enable(sclks->smmu_core_axi_clk);
+	if (ret) {
+		dev_err(smmu->dev, "Couln't enable smmu_core_axi_clk");
+		goto smmu_core_axi_clk_fail;
+	}
+
+	ret = clk_prepare_enable(sclks->mmagic_core_axi_clk);
+	if (ret) {
+		dev_err(smmu->dev, "Couln't enable mmagic_core_axi_clk");
+		goto core_axi_clk_fail;
+	}
+
+	return 0;
+
+core_axi_clk_fail:
+	clk_disable_unprepare(sclks->smmu_core_axi_clk);
+smmu_core_axi_clk_fail:
+	clk_disable_unprepare(sclks->smmu_core_ahb_clk);
+core_ahb_clk_fail:
+	clk_disable_unprepare(sclks->mmagic_cfg_ahb_clk);
+cfg_ahb_clk_fail:
+	clk_disable_unprepare(sclks->mmagic_ahb_clk);
+ahb_clk_fail:
+	return ret;
+}
+
+static void qcom_smmu_disable_clocks(struct arm_smmu_device *smmu)
+{
+	struct qcom_smmu_clk *sclks = smmu->smmu_clks.clks;
+
+	if (!sclks) {
+		clk_disable_unprepare(sclks->mmagic_core_axi_clk);
+		clk_disable_unprepare(sclks->smmu_core_axi_clk);
+		clk_disable_unprepare(sclks->smmu_core_ahb_clk);
+		clk_disable_unprepare(sclks->mmagic_cfg_ahb_clk);
+		clk_disable_unprepare(sclks->mmagic_ahb_clk);
+	}
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -2077,6 +2197,9 @@ struct arm_smmu_match_data {
 		    mmu500_enable_clocks, mmu500_disable_clocks);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2,
 		    NULL, NULL, NULL);
+ARM_SMMU_MATCH_DATA(qcom_smmuv2, ARM_SMMU_V2, QCOM_SMMUV2,
+		    qcom_smmu_init_clocks, qcom_smmu_enable_clocks,
+		    qcom_smmu_disable_clocks);
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
@@ -2085,6 +2208,7 @@ struct arm_smmu_match_data {
 	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
+	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
