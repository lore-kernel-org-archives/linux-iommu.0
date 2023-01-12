Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B78D8814
	for <iommu@lists.linux.dev>; Thu, 12 Jan 2023 20:00:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C41FEC;
	Thu, 12 Jan 2023 12:00:41 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 483503F67D;
	Thu, 12 Jan 2023 11:59:58 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] iommu: Tidy up io-pgtable dependencies
Date: Thu, 12 Jan 2023 19:59:47 +0000
Message-Id: <51d8c78e2ecc6696ac5907526580209ea6da167f.1673553587.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some io-pgtable implementations, and thus their users too, carry a
slightly odd dependency to get around the GENERIC_ATOMIC64 version of
cmpxchg64() often failing to compile. Since this is a functional
dependency, it's a bit misleading and untidy to tie it explicitly to
COMPILE_TEST while assuming that it's also implied by the other
platform/architecture options. Make things clearer by separating these
functional dependencies into distinct statements from those controlling
visibility, and since they do look a bit non-obvious to the uninitiated,
also commenting them for good measure.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 79707685d54a..889c7efd050b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -32,7 +32,8 @@ config IOMMU_IO_PGTABLE
 config IOMMU_IO_PGTABLE_LPAE
 	bool "ARMv7/v8 Long Descriptor Format"
 	select IOMMU_IO_PGTABLE
-	depends on ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARM || ARM64 || COMPILE_TEST
+	depends on !GENERIC_ATOMIC64	# for cpmxchg64()
 	help
 	  Enable support for the ARM long descriptor pagetable format.
 	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
@@ -70,7 +71,8 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 config IOMMU_IO_PGTABLE_DART
 	bool "Apple DART Formats"
 	select IOMMU_IO_PGTABLE
-	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARM64 || COMPILE_TEST
+	depends on !GENERIC_ATOMIC64	# for cpmxchg64()
 	help
 	  Enable support for the Apple DART pagetable formats. These include
 	  the t8020 and t6000/t8110 DART formats used in Apple M1/M2 family
@@ -284,7 +286,8 @@ config EXYNOS_IOMMU_DEBUG
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
-	depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU
@@ -304,7 +307,8 @@ config SPAPR_TCE_IOMMU
 
 config APPLE_DART
 	tristate "Apple DART IOMMU Support"
-	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARCH_APPLE || COMPILE_TEST
+	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_DART
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_DART
 	default ARCH_APPLE
@@ -319,7 +323,8 @@ config APPLE_DART
 # ARM IOMMU support
 config ARM_SMMU
 	tristate "ARM Ltd. System MMU (SMMU) Support"
-	depends on ARM64 || ARM || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARM64 || ARM || COMPILE_TEST
+	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU if ARM
@@ -466,7 +471,8 @@ config MTK_IOMMU_V1
 config QCOM_IOMMU
 	# Note: iommu drivers cannot (yet?) be built as modules
 	bool "Qualcomm IOMMU Support"
-	depends on ARCH_QCOM || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
 	select QCOM_SCM
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
-- 
2.36.1.dirty

