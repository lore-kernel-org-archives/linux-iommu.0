From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] iommu: Add missing dependencies
Date: Sun, 10 Sep 2017 13:43:37 -0700
Message-ID: <1505076217-18276-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: iommu@lists.linux-foundation.org

parisc:allmodconfig, xtensa:allmodconfig, and possibly others generate
the following Kconfig warning.

warning: (IPMMU_VMSA && ARM_SMMU && ARM_SMMU_V3 && QCOM_IOMMU) selects
IOMMU_IO_PGTABLE_LPAE which has unmet direct dependencies (IOMMU_SUPPORT &&
HAS_DMA && (ARM || ARM64 || COMPILE_TEST && !GENERIC_ATOMIC64))

IOMMU_IO_PGTABLE_LPAE depends on (COMPILE_TEST && !GENERIC_ATOMIC64),
so any configuration option selecting it needs to have the same dependencies.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iommu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 49bd2ab8c507..8530ef78925d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -278,7 +278,7 @@ config EXYNOS_IOMMU_DEBUG
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
 	depends on ARM || IOMMU_DMA
-	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU
@@ -373,7 +373,7 @@ config MTK_IOMMU_V1
 config QCOM_IOMMU
 	# Note: iommu drivers cannot (yet?) be built as modules
 	bool "Qualcomm IOMMU Support"
-	depends on ARCH_QCOM || COMPILE_TEST
+	depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU
-- 
2.7.4
