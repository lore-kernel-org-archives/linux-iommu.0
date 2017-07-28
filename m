From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] iommu/exynos: prevent building on big-endian kernels
Date: Fri, 28 Jul 2017 15:19:19 +0200
Message-ID: <20170728131954.213595-1-arnd@arndb.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Since we print the correct warning, an allmodconfig build is no longer
clean but always prints it, which defeats compile-testing:

drivers/iommu/exynos-iommu.c:58:2: error: #warning "revisit driver if we can enable big-endian ptes" [-Werror=cpp]

This replaces the #warning with a dependency, moving warning text into
a comment.

Fixes: 1f59adb1766d ("iommu/exynos: Replace non-existing big-endian Kconfig option")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/Kconfig        | 1 +
 drivers/iommu/exynos-iommu.c | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f73ff28f77e2..c5d80fe3dab9 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -253,6 +253,7 @@ config TEGRA_IOMMU_SMMU
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
 	depends on ARCH_EXYNOS && MMU
+	depends on !CPU_BIG_ENDIAN # revisit driver if we can enable big-endian ptes
 	select IOMMU_API
 	select ARM_DMA_USE_IOMMU
 	help
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b7aebaf28b82..c6b69e91132b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -54,10 +54,6 @@ typedef u32 sysmmu_pte_t;
 #define lv2ent_small(pent) ((*(pent) & 2) == 2)
 #define lv2ent_large(pent) ((*(pent) & 3) == 1)
 
-#ifdef CONFIG_CPU_BIG_ENDIAN
-#warning "revisit driver if we can enable big-endian ptes"
-#endif
-
 /*
  * v1.x - v3.x SYSMMU supports 32bit physical and 32bit virtual address spaces
  * v5.0 introduced support for 36bit physical address space by shifting
-- 
2.9.0
