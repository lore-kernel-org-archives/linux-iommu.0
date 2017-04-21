From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] iommu: arm-smmu: correct sid to mask
Date: Fri, 21 Apr 2017 17:03:36 +0800
Message-ID: <1492765416-30835-1-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com
Cc: robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
List-Id: iommu@lists.linux-foundation.org

>From code "SMR mask 0x%x out of range for SMMU",
so, we need to use mask, not sid.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b493c99..5a06de2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1467,7 +1467,7 @@ static int arm_smmu_add_device(struct device *dev)
 		}
 		if (mask & ~smmu->smr_mask_mask) {
 			dev_err(dev, "SMR mask 0x%x out of range for SMMU (0x%x)\n",
-				sid, smmu->smr_mask_mask);
+				mask, smmu->smr_mask_mask);
 			goto out_free;
 		}
 	}
-- 
2.6.6
