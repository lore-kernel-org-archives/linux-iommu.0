From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Subject: [PATCH] iommu/arm-smmu: Properly initialize CBAR MemAttr
Date: Mon, 30 May 2016 14:15:42 +0000
Message-ID: <1464617742-5493-1-git-send-email-bogdan.purcareata@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: will.deacon@arm.com, robin.murphy@arm.com
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Currently, when initializing the CBAR memattr attributes to the weakest
values, it is expected that the final ones will be declared in the TTBCR
register (SMMU_CBn_TCR).

This is not required when CBAR type consists of a stage 1 translation
followed by a stage 2 bypass. This is the case when assigning a VFIO PCI
device to a KVM guest. Overriding the default transaction attributes to
writeback cacheable results in the device no longer working in the guest
(the adapter requires explicit flushes on the descriptor rings memory).

Update the context init routine to initialize the CBAR MemAttr field only
if there's a stage 1 followed by a stage 2 translation.

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
---
 drivers/iommu/arm-smmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ff7a392..1400ec9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -765,13 +765,14 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 {
 	u32 reg;
 	u64 reg64;
-	bool stage1;
+	bool stage1, stage1_stage2;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	void __iomem *cb_base, *gr1_base;
 
 	gr1_base = ARM_SMMU_GR1(smmu);
 	stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
+	stage1_stage2 = cfg->cbar == CBAR_TYPE_S1_TRANS_S2_TRANS;
 	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
 
 	if (smmu->version > ARM_SMMU_V1) {
@@ -793,15 +794,19 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
 	/*
 	 * Use the weakest shareability/memory types, so they are
-	 * overridden by the ttbcr/pte.
+	 * overridden by the ttbcr/pte. This happens only if the stage
+	 * 1 is followed by a stage 2 translation.
 	 */
-	if (stage1) {
+	if (stage1_stage2) {
 		reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
 			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
-	} else if (!(smmu->features & ARM_SMMU_FEAT_VMID16)) {
+	}
+
+	if (!stage1 && !(smmu->features & ARM_SMMU_FEAT_VMID16)) {
 		/* 8-bit VMIDs live in CBAR */
 		reg |= ARM_SMMU_CB_VMID(smmu, cfg) << CBAR_VMID_SHIFT;
 	}
+
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
 
 	/* TTBRs */
-- 
1.9.1
