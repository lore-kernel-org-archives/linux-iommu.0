From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH] iommu/arm-smmu: Fix bug in ARM_SMMU_FEAT_TRANS_OPS condition check
Date: Tue, 23 Jun 2015 17:37:26 +0530
Message-ID: <1435061246-14690-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, will.deacon@arm.com, b.reynal@virtualopensystems.com, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Patch 'fix ARM_SMMU_FEAT_TRANS_OPS condition' changed the check
for ARM_SMMU_FEAT_TRANS_OPS to be based on presence of stage1 check,
but used (id & ID0_ATOSNS) instead of !(id & ID0_ATOSNS).
Fix it here.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 09091e9..fbf4af6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1866,7 +1866,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		return -ENODEV;
 	}
 
-	if ((id & ID0_S1TS) && ((smmu->version == 1) || (id & ID0_ATOSNS))) {
+	if ((id & ID0_S1TS) && ((smmu->version == 1) || !(id & ID0_ATOSNS))) {
 		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
 		dev_notice(smmu->dev, "\taddress translation ops\n");
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
