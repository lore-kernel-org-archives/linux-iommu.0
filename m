From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH V4 4/6] iommu/arm-smmu: Add the device_link between masters and smmu
Date: Thu,  6 Jul 2017 15:07:03 +0530
Message-ID: <1499333825-7658-5-git-send-email-vivek.gautam@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, m.szyprowski@samsung.com, sboyd@codeaurora.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org, stanimir.varbanov@linaro.org, architt@codeaurora.org, vivek.gautam@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Sricharan R <sricharan@codeaurora.org>

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ddbfa8ab69e6..75567d9698ab 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1348,6 +1348,7 @@ static int arm_smmu_add_device(struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct device_link *link = NULL;
 	int i, ret;
 
 	if (using_legacy_binding) {
@@ -1403,6 +1404,16 @@ static int arm_smmu_add_device(struct device *dev)
 
 	pm_runtime_put_sync(smmu->dev);
 
+	/*
+	 * Establish the link between smmu and master, so that the
+	 * smmu gets runtime enabled/disabled as per the master's
+	 * needs.
+	 */
+	link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+	if (!link)
+		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
+			 dev_name(smmu->dev), dev_name(dev));
+
 	return 0;
 
 out_cfg_free:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
