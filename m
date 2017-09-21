From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v2] iommu/arm-smmu-v3: Avoid ILLEGAL setting of STE.S1STALLD and CD.S
Date: Thu, 21 Sep 2017 20:36:07 +0800
Message-ID: <1505997367-51569-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, jean-philippe.brucker@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, liubo95@huawei.com, chenjiankang1@huawei.com, xieyisheng1@huawei.com
List-Id: iommu@lists.linux-foundation.org

According to Spec, it is ILLEGAL to set STE.S1STALLD if STALL_MODEL
is not 0b00, which means we should not disable stall mode if stall
or terminate mode is not configuable.

Meanwhile, it is also ILLEGAL when STALL_MODEL==0b10 && CD.S==0 which
means if stall mode is force we should always set CD.S.

As Jean-Philippe's suggestion, this patch introduce a feature bit
ARM_SMMU_FEAT_STALL_FORCE, which means smmu only supports stall force.
Therefore, we can avoid the ILLEGAL setting of STE.S1STALLD.by checking
ARM_SMMU_FEAT_STALL_FORCE.

This patch keeps the ARM_SMMU_FEAT_STALLS as the meaning of stall supported
(force or configuable) to easy to expand the future function, i.e. we can
only use ARM_SMMU_FEAT_STALLS to check whether we should register fault
handle or enable master can_stall, etc to supporte platform SVM.

The feature bit, STE.S1STALLD and CD.S setting will be like:

STALL_MODEL  FEATURE                                         S1STALLD CD.S
0b00         ARM_SMMU_FEAT_STALLS                                 0b1 0b0
0b01         !ARM_SMMU_FEAT_STALLS && !ARM_SMMU_FEAT_STALL_FORCE  0b0 0b0
0b10         ARM_SMMU_FEAT_STALLS && ARM_SMMU_FEAT_STALL_FORCE    0b0 0b1

after apply this patch.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 * Keep the feature bits backward compatible and add new one at the end
 * Avoid ILLEGAL of CD.S - both as Jean's suggestion.

 drivers/iommu/arm-smmu-v3.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index e67ba6c..22a6b08 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -316,6 +316,7 @@
 #define ARM64_TCR_TBI0_MASK		0x1UL
 
 #define CTXDESC_CD_0_AA64		(1UL << 41)
+#define CTXDESC_CD_0_S			(1UL << 44)
 #define CTXDESC_CD_0_R			(1UL << 45)
 #define CTXDESC_CD_0_A			(1UL << 46)
 #define CTXDESC_CD_0_ASET_SHIFT		47
@@ -604,6 +605,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_TRANS_S2		(1 << 10)
 #define ARM_SMMU_FEAT_STALLS		(1 << 11)
 #define ARM_SMMU_FEAT_HYP		(1 << 12)
+#define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -996,6 +998,11 @@ static void arm_smmu_write_ctx_desc(struct arm_smmu_device *smmu,
 	      CTXDESC_CD_0_R | CTXDESC_CD_0_A | CTXDESC_CD_0_ASET_PRIVATE |
 	      CTXDESC_CD_0_AA64 | (u64)cfg->cd.asid << CTXDESC_CD_0_ASID_SHIFT |
 	      CTXDESC_CD_0_V;
+
+	/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
+	if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		val |= CTXDESC_CD_0_S;
+
 	cfg->cdptr[0] = cpu_to_le64(val);
 
 	val = cfg->cd.ttbr & CTXDESC_CD_1_TTB0_MASK << CTXDESC_CD_1_TTB0_SHIFT;
@@ -1112,7 +1119,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 #endif
 			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
 
-		if (smmu->features & ARM_SMMU_FEAT_STALLS)
+		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
+		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
@@ -2536,9 +2544,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 			 coherent ? "true" : "false");
 
 	switch (reg & IDR0_STALL_MODEL_MASK << IDR0_STALL_MODEL_SHIFT) {
-	case IDR0_STALL_MODEL_STALL:
-		/* Fallthrough */
 	case IDR0_STALL_MODEL_FORCE:
+		smmu->features |= ARM_SMMU_FEAT_STALL_FORCE;
+		/* Fallthrough */
+	case IDR0_STALL_MODEL_STALL:
 		smmu->features |= ARM_SMMU_FEAT_STALLS;
 	}
 
-- 
1.7.12.4
