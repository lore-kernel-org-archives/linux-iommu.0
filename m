From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v2 1/1] iommu/tegra: smmu: Change SMMU's dependency on ARCH_TEGRA
Date: Thu, 31 Jan 2013 12:43:08 +0200
Message-ID: <1359628988-3678-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Theoretically TEGRA_IOMMU_SMMU depends on ARCH_TEGRA_3x_SOC and
ARCH_TEGRA_114_SOC only. This patch allows a Tegra20 only kernel to
enable SMMU(Tegra20 doesn't have a SMMU), which could avoid editing
this Kconfig entry every time we add a new chip later.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v1:
http://lists.linuxfoundation.org/pipermail/iommu/2013-January/005051.html
---
 drivers/iommu/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e39f9db..3f0b15a1 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -158,7 +158,7 @@ config TEGRA_IOMMU_GART
 
 config TEGRA_IOMMU_SMMU
 	bool "Tegra SMMU IOMMU Support"
-	depends on ARCH_TEGRA_3x_SOC && TEGRA_AHB
+	depends on ARCH_TEGRA && TEGRA_AHB
 	select IOMMU_API
 	help
 	  Enables support for remapping discontiguous physical memory
-- 
1.7.9.5
