From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V3 5/5] iommu/arm-smmu: Add the device_link between masters and smmu
Date: Thu,  9 Mar 2017 21:05:48 +0530
Message-ID: <1489073748-3659-6-git-send-email-sricharan@codeaurora.org>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mathieu.poirier@linaro.org, mark.rutland@arm.com
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Finally add the device link between the master device and
smmu, so that the smmu gets runtime enabled/disabled only when the
master needs it. This is done from add_device callback which gets
called once when the master is added to the smmu.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6370421..b06f86c7 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1671,6 +1671,7 @@ static int arm_smmu_add_device(struct device *dev)
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master_cfg *cfg;
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct device_link *link = NULL;
 	int i, ret;
 	unsigned long err;
 
@@ -1727,6 +1728,16 @@ static int arm_smmu_add_device(struct device *dev)
 	if (IS_ERR_VALUE(err))
 		goto out_free;
 
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
 
 out_free:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

