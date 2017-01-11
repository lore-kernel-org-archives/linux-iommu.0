From: Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH 1/1] iommu/arm-smmu: Fix for ThunderX erratum #27704
Date: Wed, 11 Jan 2017 12:51:47 +0100
Message-ID: <1484135507-24872-1-git-send-email-tn@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, mark.rutland@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, Tirumalesh.Chalamarla@cavium.com, Prasun.Kapoor@cavium.com, Tomasz Nowicki <tn@semihalf.com>
List-Id: iommu@lists.linux-foundation.org

The goal of erratum #27704 workaround was to make sure that ASIDs and VMIDs
are unique across all SMMU instances on affected Cavium systems.

Currently, the workaround code partitions ASIDs and VMIDs by increasing
global cavium_smmu_context_count which in turn becomes the base ASID and VMID
value for the given SMMU instance upon the context bank initialization.

For systems with multiple SMMU instances this approach implies the risk
of crossing 8-bit ASID, like for CN88xx capable of 4 SMMUv2, 128 context bank each:
SMMU_0 (0-127 ASID RANGE)
SMMU_1 (127-255 ASID RANGE)
SMMU_2 (256-383 ASID RANGE) <--- crossing 8-bit ASID
SMMU_3 (384-511 ASID RANGE) <--- crossing 8-bit ASID

Since we use 8-bit ASID now we effectively misconfigure ASID[15:8] bits for
SMMU_CBn_TTBRm register. Also, we still use non-zero ASID[15:8] bits
upon context invalidation. This patch adds 16-bit ASID support for stage-1
AArch64 contexts for Cavium SMMUv2 model so that we use ASIDs consistently.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/iommu/arm-smmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a60cded..ae8f059 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -260,6 +260,7 @@ enum arm_smmu_s2cr_privcfg {
 
 #define TTBCR2_SEP_SHIFT		15
 #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
+#define TTBCR2_AS			(1 << 4)
 
 #define TTBRn_ASID_SHIFT		48
 
@@ -778,6 +779,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
 			reg2 |= TTBCR2_SEP_UPSTREAM;
+			if (smmu->model == CAVIUM_SMMUV2 &&
+			    cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
+				reg2 |= TTBCR2_AS;
 		}
 		if (smmu->version > ARM_SMMU_V1)
 			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
-- 
2.7.4
