From: Nate Watterson <nwatters@codeaurora.org>
Subject: [PATCH] iommu/arm-smmu-v3: limit use of 2-level stream tables
Date: Mon, 11 Jul 2016 14:00:59 -0400
Message-ID: <1468260059-10759-1-git-send-email-nwatters@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Nate Watterson <nwatters@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

In the current arm-smmu-v3 driver, all smmus that support 2-level
stream tables are being forced to use them. This is suboptimal for
smmus that support fewer stream id bits than would fill in a single
second level table. This patch limits the use of 2-level tables to
smmus that both support the feature and whose first level table can
possibly contain more than a single entry.

Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
---
 drivers/iommu/arm-smmu-v3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 5f6b3bc..742254c 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2531,6 +2531,17 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
 	smmu->ssid_bits = reg >> IDR1_SSID_SHIFT & IDR1_SSID_MASK;
 	smmu->sid_bits = reg >> IDR1_SID_SHIFT & IDR1_SID_MASK;
 
+	/*
+	 * If the SMMU supports fewer bits than would fill a single L2 stream
+	 * table, use a linear table instead.
+	 */
+	if (smmu->sid_bits <= STRTAB_SPLIT &&
+	    smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
+		dev_info(smmu->dev, "SIDSIZE (%d) <= STRTAB_SPLIT (%d) : disabling 2-level stream tables\n",
+			 smmu->sid_bits, STRTAB_SPLIT);
+	}
+
 	/* IDR5 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
 
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
