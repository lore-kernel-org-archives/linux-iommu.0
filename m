From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH V4 5/6] iommu/arm-smmu: Add support for MMU40x/500 clocks
Date: Thu,  6 Jul 2017 15:07:04 +0530
Message-ID: <1499333825-7658-6-git-send-email-vivek.gautam@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, m.szyprowski@samsung.com, sboyd@codeaurora.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org, stanimir.varbanov@linaro.org, architt@codeaurora.org, vivek.gautam@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Sricharan R <sricharan@codeaurora.org>

The MMU400x/500 is the implementation of the SMMUv2
arch specification. It is split in to two blocks
TBU, TCU. TBU caches the page table, instantiated
for each master locally, clocked by the TBUn_clk.
TCU manages the address translation with PTW and has
the programming interface as well, clocked using the
TCU_CLK. The TBU can also be sharing the same clock
domain as TCU, in which case both are clocked using
the TCU_CLK.

This defines the clock bindings for the same and adds
the clock names to compatible data.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[vivek: clock rework and cleanup]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         | 24 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                           | 12 ++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index 8a6ffce12af5..00331752d355 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -71,6 +71,26 @@ conditions.
                   or using stream matching with #iommu-cells = <2>, and
                   may be ignored if present in such cases.
 
+- clock-names:    Should be "tcu" and "iface" for "arm,mmu-400",
+                  "arm,mmu-401" and "arm,mmu-500"
+
+                  "tcu" clock is required for smmu's register access using the
+                  programming interface and ptw for downstream bus access. This
+                  clock is also used for access to the TBU connected to the
+                  master locally. Sometimes however, TBU is clocked along with
+                  the master.
+
+                  "iface" clock is required to access the TCU's programming
+                  interface, apart from the "tcu" clock.
+
+- clocks:         Phandles for respective clocks described by clock-names.
+
+- power-domains:  Phandles to SMMU's power domain specifier. This is
+                  required even if SMMU belongs to the master's power
+                  domain, as the SMMU will have to be enabled and
+                  accessed before master gets enabled and linked to its
+                  SMMU.
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
@@ -95,6 +115,10 @@ conditions.
                              <0 36 4>,
                              <0 37 4>;
                 #iommu-cells = <1>;
+                clocks = <&gcc GCC_SMMU_CFG_CLK>,
+                         <&gcc GCC_APSS_TCU_CLK>;
+
+		clock-names = "iface", "tcu";
         };
 
         /* device with two stream IDs, 0 and 7 */
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 75567d9698ab..7bb09280fa11 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1947,9 +1947,19 @@ struct arm_smmu_match_data {
 ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
-ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 
+static const char * const arm_mmu500_clks[] = {
+	"tcu", "iface",
+};
+
+static const struct arm_smmu_match_data arm_mmu500 = {
+	.version = ARM_SMMU_V2,
+	.model = ARM_MMU500,
+	.clks = arm_mmu500_clks,
+	.num_clks = ARRAY_SIZE(arm_mmu500_clks),
+};
+
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

