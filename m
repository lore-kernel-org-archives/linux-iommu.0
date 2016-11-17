From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH] arm: dma-mapping: Reset the device's dma_ops
Date: Thu, 17 Nov 2016 16:50:45 +0530
Message-ID: <1479381645-3230-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: rmk+kernel@armlinux.org.uk, robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
,dma_ops should be cleared in the teardown path. Otherwise
this causes problem when the probe of device is retried after
being deferred. The device's iommu structures are cleared
after EPROBEDEFER error, but on the next try dma_ops will still
be set to old value, which is not right.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/mm/dma-mapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ab4f745..a40f03e 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2358,6 +2358,7 @@ static void arm_teardown_iommu_dma_ops(struct device *dev)
 
 	__arm_iommu_detach_device(dev);
 	arm_iommu_release_mapping(mapping);
+	set_dma_ops(dev, NULL);
 }
 
 #else
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
