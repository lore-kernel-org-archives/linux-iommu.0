From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH] iommu/arm-smmu: Fix broken ATOS check
Date: Wed, 10 Jun 2015 16:58:55 +0100
Message-ID: <1433951935-6774-1-git-send-email-will.deacon@arm.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, b.reynal@virtualopensystems.com, varun.sethi@freescale.com, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Commit 83a60ed8f0b5 ("iommu/arm-smmu: fix ARM_SMMU_FEAT_TRANS_OPS
condition") accidentally negated the ID0_ATOSNS predicate in the ATOS
feature check, causing the driver to attempt ATOS requests on SMMUv2
hardware without the ATOS feature implemented.

This patch restores the predicate to the correct value.

Cc: <stable@vger.kernel.org> # 4.0+
Reported-by: Varun Sethi <varun.sethi@freescale.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index dce041b1c139..9f1af00d0f68 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1566,7 +1566,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		return -ENODEV;
 	}
 
-	if ((id & ID0_S1TS) && ((smmu->version == 1) || (id & ID0_ATOSNS))) {
+	if ((id & ID0_S1TS) && ((smmu->version == 1) || (!(id & ID0_ATOSNS)))) {
 		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
 		dev_notice(smmu->dev, "\taddress translation ops\n");
 	}
-- 
2.1.4
