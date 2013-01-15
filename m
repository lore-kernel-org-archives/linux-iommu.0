From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/6] iommu/tegra: smmu: Add dependency on ARCH_TEGRA_114_SOC
Date: Tue, 15 Jan 2013 15:22:29 +0200
Message-ID: <1358256149-28700-1-git-send-email-hdoyu@nvidia.com>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358237848-968-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

TEGRA_IOMMU_SMMU depends on ARCH_TEGRA_114_SOC too.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e39f9db..90cc484 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -158,7 +158,7 @@ config TEGRA_IOMMU_GART
 
 config TEGRA_IOMMU_SMMU
 	bool "Tegra SMMU IOMMU Support"
-	depends on ARCH_TEGRA_3x_SOC && TEGRA_AHB
+	depends on (ARCH_TEGRA_114_SOC || ARCH_TEGRA_3x_SOC) && TEGRA_AHB
 	select IOMMU_API
 	help
 	  Enables support for remapping discontiguous physical memory
-- 
1.7.9.5
