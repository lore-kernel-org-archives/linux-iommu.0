From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V4 7/7] iommu/msm: Remove driver BROKEN
Date: Mon, 16 May 2016 12:19:01 +0530
Message-ID: <1463381341-30498-8-git-send-email-sricharan@codeaurora.org>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org, architt@codeaurora.org, robh@kernel.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

Now that the driver is DT adapted, bus_set_iommu gets called only
when on compatible matching. So the driver should not break multiplatform
builds now. So remove the BROKEN config.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1f5d496..b81a0bb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -90,7 +90,6 @@ config MSM_IOMMU
 	bool "MSM IOMMU Support"
 	depends on ARM
 	depends on ARCH_MSM8X60 || ARCH_MSM8960 || COMPILE_TEST
-	depends on BROKEN
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_ARMV7S
 	help
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
