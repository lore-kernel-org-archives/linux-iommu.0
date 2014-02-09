From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 04/28] Remove EXYNOS_DEV_SYSMMU
Date: Sun,  9 Feb 2014 19:47:42 +0100
Message-ID: <1391971686-9517-5-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391971686-9517-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>
List-Id: iommu@lists.linux-foundation.org

The symbol is an orphan, get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 79bbc21..20d062d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -178,7 +178,7 @@ config TEGRA_IOMMU_SMMU
 
 config EXYNOS_IOMMU
 	bool "Exynos IOMMU Support"
-	depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
+	depends on ARCH_EXYNOS
 	select IOMMU_API
 	help
 	  Support for the IOMMU(System MMU) of Samsung Exynos application
-- 
1.8.4.2
