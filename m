From: thor.thayer@linux.intel.com
Subject: [PATCH 2/2] iommu/arm-smmu: Add support for Stratix10 smmu-v2 variant
Date: Wed, 25 Jul 2018 13:24:37 -0500
Message-ID: <1532543077-8933-3-git-send-email-thor.thayer@linux.intel.com>
References: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532543077-8933-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, will.deacon@arm.com, robin.murphy@arm.com
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thor Thayer <thor.thayer@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the clocks required for the Stratix10 SMMU. Define the
clock names in the SMMU name array and add DT compatible
matching element.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
This patch is dependent on the patch series
"iommu/arm-smmu: Add runtime pm/sleep support"
(https://patchwork.ozlabs.org/cover/946160/)
---
 drivers/iommu/arm-smmu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c69736a30f8..d46216b34a77 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1983,6 +1983,17 @@ static const struct arm_smmu_match_data qcom_smmuv2 = {
 	.num_clks = ARRAY_SIZE(qcom_smmuv2_clks),
 };
 
+static const char * const altr_smmuv2_clks[] = {
+	"masters"
+};
+
+static const struct arm_smmu_match_data altr_smmuv2 = {
+	.version = ARM_SMMU_V2,
+	.model = ARM_MMU500,
+	.clks = altr_smmuv2_clks,
+	.num_clks = ARRAY_SIZE(altr_smmuv2_clks),
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
@@ -1991,6 +2002,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
+	{ .compatible = "altr,smmu-v2", .data = &altr_smmuv2 },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
-- 
2.7.4
