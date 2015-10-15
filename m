From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4/6] iommu/arm-smmu: fix error checking for ASID and VMID allocation
Date: Thu, 15 Oct 2015 16:04:22 +0100
Message-ID: <1444921464-14895-5-git-send-email-will.deacon@arm.com>
References: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, jroedel@suse.de, marc.zyngier@arm.com, robin.murphy@arm.com, tchalamarla@caviumnetworks.com, fabio.estevam@freescale.com, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The bitmap allocator returns an int, which is one of the standard
negative values on failure. Rather than assigning this straight to a
u16 (like we do for the ASID and VMID callers), which means that we
won't detect failure correctly, use an int for the purposes of error
checking.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 637014ab8965..970d78dcac53 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1419,7 +1419,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
-	u16 asid;
+	int asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
 
@@ -1431,10 +1431,11 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 					 &cfg->cdptr_dma, GFP_KERNEL);
 	if (!cfg->cdptr) {
 		dev_warn(smmu->dev, "failed to allocate context descriptor\n");
+		ret = -ENOMEM;
 		goto out_free_asid;
 	}
 
-	cfg->cd.asid	= asid;
+	cfg->cd.asid	= (u16)asid;
 	cfg->cd.ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
 	cfg->cd.tcr	= pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 	cfg->cd.mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair[0];
@@ -1448,7 +1449,7 @@ out_free_asid:
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
-	u16 vmid;
+	int vmid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 
@@ -1456,7 +1457,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	if (IS_ERR_VALUE(vmid))
 		return vmid;
 
-	cfg->vmid	= vmid;
+	cfg->vmid	= (u16)vmid;
 	cfg->vttbr	= pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
 	cfg->vtcr	= pgtbl_cfg->arm_lpae_s2_cfg.vtcr;
 	return 0;
-- 
2.1.4
