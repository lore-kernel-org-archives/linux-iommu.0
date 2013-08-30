From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 2/2] iommu/arm-smmu: don't enable SMMU device until probing has completed
Date: Fri, 30 Aug 2013 18:59:22 +0100
Message-ID: <1377885562-12536-2-git-send-email-will.deacon@arm.com>
References: <1377885562-12536-1-git-send-email-will.deacon@arm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1377885562-12536-1-git-send-email-will.deacon@arm.com>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

We currently reset and enable the SMMU before the device has finished
being probed, so if we fail later on (for example, because we couldn't
request a global irq successfully) then we will leave the device in an
active state.

This patch delays the reset and enabling of the SMMU hardware until
probing has completed.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c3642cc..2931921 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1853,8 +1853,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		goto out_put_parent;
 	}
 
-	arm_smmu_device_reset(smmu);
-
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
 		err = request_irq(smmu->irqs[i],
 				  arm_smmu_global_fault,
@@ -1872,6 +1870,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	spin_lock(&arm_smmu_devices_lock);
 	list_add(&smmu->list, &arm_smmu_devices);
 	spin_unlock(&arm_smmu_devices_lock);
+
+	arm_smmu_device_reset(smmu);
 	return 0;
 
 out_free_irqs:
-- 
1.8.2.2
