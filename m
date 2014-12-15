From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
Date: Mon, 15 Dec 2014 13:00:13 +0000
Message-ID: <1418648413-32013-1-git-send-email-broonie@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>
List-Id: iommu@lists.linux-foundation.org

The Exynos IOMMU driver uses the ARM specific dmac_flush_range() and
outer_flush_range() functions. This breaks the build on arm64 allmodconfig
in -next since support has been merged for some Exynos ARMv8 SoCs. Add a
dependency on ARM to keep things building until either the driver has the
ARM dependencies removed or the ARMv8 architecture code implements these
ARM specific APIs.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 01e8bfae569b..325188eef1c1 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -187,7 +187,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS
+	depends on ARCH_EXYNOS && ARM
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	help
-- 
2.1.3
