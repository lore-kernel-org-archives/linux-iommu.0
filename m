From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [RFC/PATCH 6/7] defconfig: msm: Enable Qualcomm SMMUv1 driver
Date: Mon, 30 Jun 2014 09:51:55 -0700
Message-ID: <1404147116-4598-7-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com, thierry.reding@gmail.com, joro@8bytes.org, vgandhi@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Enable the Qualcomm SMMUv1 driver allowing bus masters to operate
on physically discontigous memory.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 0414889..12838bb 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -137,6 +137,7 @@ CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_MSM_IOMMU_V0=y
+CONFIG_MSM_IOMMU_V1=y
 CONFIG_GENERIC_PHY=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
