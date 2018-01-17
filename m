From: Nate Watterson <nwatters@codeaurora.org>
Subject: [PATCH] iommu/arm-smmu-v3: suppress MSI allocation failure message
Date: Wed, 17 Jan 2018 13:39:59 -0500
Message-ID: <1516214399-24012-1-git-send-email-nwatters@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>, Nate Watterson <nwatters@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

From: Sinan Kaya <okaya@codeaurora.org>

Even though QDF2400 supports MSI interrupts with SMMUv3, it is not enabled
in ACPI FW to preserve compatibility with older kernel versions. Code is
emitting warning message during boot.

This is causing some test tools to record a false warning and is causing
support issues.

Better reduce the message level.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 744592d..2118fda 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2331,7 +2331,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
 	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
 	if (ret) {
-		dev_warn(dev, "failed to allocate MSIs\n");
+		dev_info(dev, "failed to allocate MSIs\n");
 		return;
 	}
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
Foundation Collaborative Project.
