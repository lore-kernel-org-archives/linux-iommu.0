From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH V4 1/6] iommu/arm-smmu: Fix the error path in arm_smmu_add_device
Date: Thu,  6 Jul 2017 15:07:00 +0530
Message-ID: <1499333825-7658-2-git-send-email-vivek.gautam@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, m.szyprowski@samsung.com, sboyd@codeaurora.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org, stanimir.varbanov@linaro.org, architt@codeaurora.org, vivek.gautam@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

fwspec->iommu_priv is available only after arm_smmu_master_cfg
instance has been allocated. We shouldn't free it before that.
Also it's logical to free the master cfg itself without
checking for fwspec.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9a45117d90de..61b1f8729a7c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1349,15 +1349,15 @@ static int arm_smmu_add_device(struct device *dev)
 
 	ret = arm_smmu_master_alloc_smes(dev);
 	if (ret)
-		goto out_free;
+		goto out_cfg_free;
 
 	iommu_device_link(&smmu->iommu, dev);
 
 	return 0;
 
+out_cfg_free:
+	kfree(cfg);
 out_free:
-	if (fwspec)
-		kfree(fwspec->iommu_priv);
 	iommu_fwspec_free(dev);
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

