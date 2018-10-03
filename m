From: thor.thayer@linux.intel.com
Subject: [PATCHv3 2/2] iommu/arm-smmu: Add SMMU clock
Date: Wed,  3 Oct 2018 17:28:13 -0500
Message-ID: <1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
References: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, aisheng.dong@nxp.com, sboyd@kernel.org
Cc: vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Thor Thayer <thor.thayer@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add a clock to the SMMU structure. In the device tree case,
check for a clock node and enable the clock if found.

This patch is dependent upon the following patches that add
a device tree bulk clock function.
"[V6, 1/4] clk: bulk: add of_clk_bulk_get()"
https://patchwork.kernel.org/patch/10583133/
"[V6, 2/4] clk: add new APIs to operation on all available
clocks"
https://patchwork.kernel.org/patch/10583131/
"[V6, 3/4] clk: add managerged version of clk_bulk_get_all"
https://patchwork.kernel.org/patch/10583139/

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5a28ae892504..0f4596b42ca7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -213,6 +213,8 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+	int				num_clks;
+	struct clk_bulk_data		*clks;
 };
 
 enum arm_smmu_context_fmt {
@@ -2038,6 +2040,17 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	const struct arm_smmu_match_data *data;
 	struct device *dev = &pdev->dev;
 	bool legacy_binding;
+	int ret;
+
+	/* If a clock is declared, enable it */
+	ret = devm_clk_bulk_get_all(smmu->dev, &smmu->clks);
+	if (IS_ERR(ret)) {
+		smmu->clks = NULL;
+		dev_dbg(dev, "cannot get smmu clock\n");
+	} else {
+		smmu->num_clks = ret;
+		clk_bulk_prepare_enable(smmu->num_clks, smmu->clks);
+	}
 
 	if (of_property_read_u32(dev->of_node, "#global-interrupts",
 				 &smmu->num_global_irqs)) {
@@ -2236,6 +2249,10 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	if (smmu->clks)
+		clk_bulk_disable_unprepare(smmu->num_clks, smmu->clks);
+
 	return 0;
 }
 
@@ -2248,6 +2265,9 @@ static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
 {
 	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
 
+	if (smmu->clks)
+		clk_bulk_prepare_enable(smmu->num_clks, smmu->clks);
+
 	arm_smmu_device_reset(smmu);
 	return 0;
 }
-- 
2.7.4
