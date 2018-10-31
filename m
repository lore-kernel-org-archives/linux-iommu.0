From: Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v2 4/5] arm64: defconfig: Enable ARM_SMMU_TEGRA
Date: Wed, 31 Oct 2018 16:48:35 -0700
Message-ID: <1541029716-14353-5-git-send-email-vdumpa@nvidia.com>
References: <1541029716-14353-2-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541029716-14353-2-git-send-email-vdumpa@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com, snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com, avanbrunt@nvidia.com, nicolinc@nvidia.com, Krishna Reddy <vdumpa@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

Enabling CONFIG_ARM_SMMU_TEGRA that is used
by Tegra194 SOC.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4b38444..d875f64 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -611,6 +611,7 @@ CONFIG_QCOM_APCS_IPC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
 CONFIG_ARM_SMMU=y
+CONFIG_ARM_SMMU_TEGRA=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
-- 
2.1.4
