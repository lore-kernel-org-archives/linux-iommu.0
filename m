Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64264224228
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480498; cv=none; b=RE3jmhAHztQxDf8sopKGQnPOgnCnAAMN0D1W8/jfz+7E5XVVpT2RTHgrB8aIAlqsohPsaY2BKW8i7oArZ4Zy51Ea8o32HHiQMF5bIR2SdOkUoA9BohQeabSON50qIa7y+VS/F/iAF12rXMBhmERtcrZornNctUpGVDV772SWSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480498; c=relaxed/simple;
	bh=YkrTUUBQHfeQyRejqEtXWqe04tMGYSC+0VnLil7RwcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfdTx8PBU+t+PoI3tEycUI8As2jn51f7NAs2Ni++ZLIuJIyk0Bat1+N60Q3LwZJnT7ZjHXAwQLdsog83XaAeAX1WEsQFvZGfDcYKbHH0MORHpRjdab00oCcQLb214mCedeQiDZEpv+A+a7qMNNr7Z2eZaxKpZL+m/SluqWma2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8108A1063;
	Thu, 20 Mar 2025 07:21:43 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 054353F63F;
	Thu, 20 Mar 2025 07:21:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu: Split out and tidy up Arm Kconfig
Date: Thu, 20 Mar 2025 14:21:28 +0000
Message-Id: <a614ec86ba78c09cd16e348f633f6bb38793391f.1742480488.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are quite a lot of options for the Arm drivers, still all buried
in the top-level Kconfig. For ease of use and consistency with all the
other subdirectories, break these out into drivers/arm. For similar
clarity and self-consistency, also tweak the ARM_SMMU sub-options to use
"if" instead of "depends", to match ARM_SMMU_V3. Lastly also clean up
the slightly messy description of ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT as
highlighted by Geert - by now we really shouldn't need commentary on
v4.x kernel behaviour anyway - and downgrade it to EXPERT as the first
step in the 6-year-old threat to remove it entirely.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig     | 157 +-------------------------------------
 drivers/iommu/arm/Kconfig | 144 ++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 156 deletions(-)
 create mode 100644 drivers/iommu/arm/Kconfig

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d935b59abb35..5ad3b7b8bfeb 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -193,6 +193,7 @@ config MSM_IOMMU
 	  If unsure, say N here.
 
 source "drivers/iommu/amd/Kconfig"
+source "drivers/iommu/arm/Kconfig"
 source "drivers/iommu/intel/Kconfig"
 source "drivers/iommu/iommufd/Kconfig"
 source "drivers/iommu/riscv/Kconfig"
@@ -315,150 +316,6 @@ config APPLE_DART
 
 	  Say Y here if you are using an Apple SoC.
 
-# ARM IOMMU support
-config ARM_SMMU
-	tristate "ARM Ltd. System MMU (SMMU) Support"
-	depends on ARM64 || ARM || COMPILE_TEST
-	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
-	select IOMMU_API
-	select IOMMU_IO_PGTABLE_LPAE
-	select ARM_DMA_USE_IOMMU if ARM
-	help
-	  Support for implementations of the ARM System MMU architecture
-	  versions 1 and 2.
-
-	  Say Y here if your SoC includes an IOMMU device implementing
-	  the ARM SMMU architecture.
-
-config ARM_SMMU_LEGACY_DT_BINDINGS
-	bool "Support the legacy \"mmu-masters\" devicetree bindings"
-	depends on ARM_SMMU=y && OF
-	help
-	  Support for the badly designed and deprecated "mmu-masters"
-	  devicetree bindings. This allows some DMA masters to attach
-	  to the SMMU but does not provide any support via the DMA API.
-	  If you're lucky, you might be able to get VFIO up and running.
-
-	  If you say Y here then you'll make me very sad. Instead, say N
-	  and move your firmware to the utopian future that was 2016.
-
-config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
-	bool "Default to disabling bypass on ARM SMMU v1 and v2"
-	depends on ARM_SMMU
-	default y
-	help
-	  Say Y here to (by default) disable bypass streams such that
-	  incoming transactions from devices that are not attached to
-	  an iommu domain will report an abort back to the device and
-	  will not be allowed to pass through the SMMU.
-
-	  Any old kernels that existed before this KConfig was
-	  introduced would default to _allowing_ bypass (AKA the
-	  equivalent of NO for this config).  However the default for
-	  this option is YES because the old behavior is insecure.
-
-	  There are few reasons to allow unmatched stream bypass, and
-	  even fewer good ones.  If saying YES here breaks your board
-	  you should work on fixing your board.  This KConfig option
-	  is expected to be removed in the future and we'll simply
-	  hardcode the bypass disable in the code.
-
-	  NOTE: the kernel command line parameter
-	  'arm-smmu.disable_bypass' will continue to override this
-	  config.
-
-config ARM_SMMU_MMU_500_CPRE_ERRATA
-	bool "Enable errata workaround for CPRE in SMMU reset path"
-	depends on ARM_SMMU
-	default y
-	help
-	  Say Y here (by default) to apply workaround to disable
-	  MMU-500's next-page prefetcher for sake of 4 known errata.
-
-	  Say N here only when it is sure that any errata related to
-	  prefetch enablement are not applicable on the platform.
-	  Refer silicon-errata.rst for info on errata IDs.
-
-config ARM_SMMU_QCOM
-	def_tristate y
-	depends on ARM_SMMU && ARCH_QCOM
-	select QCOM_SCM
-	help
-	  When running on a Qualcomm platform that has the custom variant
-	  of the ARM SMMU, this needs to be built into the SMMU driver.
-
-config ARM_SMMU_QCOM_DEBUG
-	bool "ARM SMMU QCOM implementation defined debug support"
-	depends on ARM_SMMU_QCOM=y
-	help
-	  Support for implementation specific debug features in ARM SMMU
-	  hardware found in QTI platforms. This include support for
-	  the Translation Buffer Units (TBU) that can be used to obtain
-	  additional information when debugging memory management issues
-	  like context faults.
-
-	  Say Y here to enable debug for issues such as context faults
-	  or TLB sync timeouts which requires implementation defined
-	  register dumps.
-
-config ARM_SMMU_V3
-	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
-	depends on ARM64
-	select IOMMU_API
-	select IOMMU_IO_PGTABLE_LPAE
-	select GENERIC_MSI_IRQ
-	select IOMMUFD_DRIVER if IOMMUFD
-	help
-	  Support for implementations of the ARM System MMU architecture
-	  version 3 providing translation support to a PCIe root complex.
-
-	  Say Y here if your system includes an IOMMU device implementing
-	  the ARM SMMUv3 architecture.
-
-if ARM_SMMU_V3
-config ARM_SMMU_V3_SVA
-	bool "Shared Virtual Addressing support for the ARM SMMUv3"
-	select IOMMU_SVA
-	select IOMMU_IOPF
-	select MMU_NOTIFIER
-	help
-	  Support for sharing process address spaces with devices using the
-	  SMMUv3.
-
-	  Say Y here if your system supports SVA extensions such as PCIe PASID
-	  and PRI.
-
-config ARM_SMMU_V3_IOMMUFD
-	bool "Enable IOMMUFD features for ARM SMMUv3 (EXPERIMENTAL)"
-	depends on IOMMUFD
-	help
-	  Support for IOMMUFD features intended to support virtual machines
-	  with accelerated virtual IOMMUs.
-
-	  Say Y here if you are doing development and testing on this feature.
-
-config ARM_SMMU_V3_KUNIT_TEST
-	tristate "KUnit tests for arm-smmu-v3 driver"  if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	depends on ARM_SMMU_V3_SVA
-	default KUNIT_ALL_TESTS
-	help
-	  Enable this option to unit-test arm-smmu-v3 driver functions.
-
-	  If unsure, say N.
-
-config TEGRA241_CMDQV
-	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
-	depends on ACPI
-	help
-	  Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
-	  CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
-	  support, except with virtualization capabilities.
-
-	  Say Y here if your system is NVIDIA Tegra241 (Grace) or it has the same
-	  CMDQ-V extension.
-endif
-
 config S390_IOMMU
 	def_bool y if S390 && PCI
 	depends on S390 && PCI
@@ -495,18 +352,6 @@ config MTK_IOMMU_V1
 
 	  if unsure, say N here.
 
-config QCOM_IOMMU
-	# Note: iommu drivers cannot (yet?) be built as modules
-	bool "Qualcomm IOMMU Support"
-	depends on ARCH_QCOM || COMPILE_TEST
-	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
-	select QCOM_SCM
-	select IOMMU_API
-	select IOMMU_IO_PGTABLE_LPAE
-	select ARM_DMA_USE_IOMMU
-	help
-	  Support for IOMMU on certain Qualcomm SoCs.
-
 config HYPERV_IOMMU
 	bool "Hyper-V IRQ Handling"
 	depends on HYPERV && X86
diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
new file mode 100644
index 000000000000..ef42bbe07dbe
--- /dev/null
+++ b/drivers/iommu/arm/Kconfig
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# ARM IOMMU support
+config ARM_SMMU
+	tristate "ARM Ltd. System MMU (SMMU) Support"
+	depends on ARM64 || ARM || COMPILE_TEST
+	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
+	select IOMMU_API
+	select IOMMU_IO_PGTABLE_LPAE
+	select ARM_DMA_USE_IOMMU if ARM
+	help
+	  Support for implementations of the ARM System MMU architecture
+	  versions 1 and 2.
+
+	  Say Y here if your SoC includes an IOMMU device implementing
+	  the ARM SMMU architecture.
+
+if ARM_SMMU
+config ARM_SMMU_LEGACY_DT_BINDINGS
+	bool "Support the legacy \"mmu-masters\" devicetree bindings"
+	depends on ARM_SMMU=y && OF
+	help
+	  Support for the badly designed and deprecated "mmu-masters"
+	  devicetree bindings. This allows some DMA masters to attach
+	  to the SMMU but does not provide any support via the DMA API.
+	  If you're lucky, you might be able to get VFIO up and running.
+
+	  If you say Y here then you'll make me very sad. Instead, say N
+	  and move your firmware to the utopian future that was 2016.
+
+config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
+	bool "Disable unmatched stream bypass by default" if EXPERT
+	default y
+	help
+	  If your firmware is broken and fails to describe StreamIDs which
+	  Linux should know about in order to manage the SMMU correctly and
+	  securely, and you don't want to boot with the 'arm-smmu.disable_bypass=0'
+	  command line parameter, then as a last resort you can turn it off
+	  by default here. But don't. This option may be removed at any time.
+
+	  Note that 'arm-smmu.disable_bypass=1' will still take precedence.
+
+config ARM_SMMU_MMU_500_CPRE_ERRATA
+	bool "Enable errata workaround for CPRE in SMMU reset path"
+	default y
+	help
+	  Say Y here (by default) to apply workaround to disable
+	  MMU-500's next-page prefetcher for sake of 4 known errata.
+
+	  Say N here only when it is sure that any errata related to
+	  prefetch enablement are not applicable on the platform.
+	  Refer silicon-errata.rst for info on errata IDs.
+
+config ARM_SMMU_QCOM
+	def_tristate y
+	depends on ARCH_QCOM
+	select QCOM_SCM
+	help
+	  When running on a Qualcomm platform that has the custom variant
+	  of the ARM SMMU, this needs to be built into the SMMU driver.
+
+config ARM_SMMU_QCOM_DEBUG
+	bool "ARM SMMU QCOM implementation defined debug support"
+	depends on ARM_SMMU_QCOM=y
+	help
+	  Support for implementation specific debug features in ARM SMMU
+	  hardware found in QTI platforms. This include support for
+	  the Translation Buffer Units (TBU) that can be used to obtain
+	  additional information when debugging memory management issues
+	  like context faults.
+
+	  Say Y here to enable debug for issues such as context faults
+	  or TLB sync timeouts which requires implementation defined
+	  register dumps.
+endif
+
+config ARM_SMMU_V3
+	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
+	depends on ARM64
+	select IOMMU_API
+	select IOMMU_IO_PGTABLE_LPAE
+	select GENERIC_MSI_IRQ
+	select IOMMUFD_DRIVER if IOMMUFD
+	help
+	  Support for implementations of the ARM System MMU architecture
+	  version 3 providing translation support to a PCIe root complex.
+
+	  Say Y here if your system includes an IOMMU device implementing
+	  the ARM SMMUv3 architecture.
+
+if ARM_SMMU_V3
+config ARM_SMMU_V3_SVA
+	bool "Shared Virtual Addressing support for the ARM SMMUv3"
+	select IOMMU_SVA
+	select IOMMU_IOPF
+	select MMU_NOTIFIER
+	help
+	  Support for sharing process address spaces with devices using the
+	  SMMUv3.
+
+	  Say Y here if your system supports SVA extensions such as PCIe PASID
+	  and PRI.
+
+config ARM_SMMU_V3_IOMMUFD
+	bool "Enable IOMMUFD features for ARM SMMUv3 (EXPERIMENTAL)"
+	depends on IOMMUFD
+	help
+	  Support for IOMMUFD features intended to support virtual machines
+	  with accelerated virtual IOMMUs.
+
+	  Say Y here if you are doing development and testing on this feature.
+
+config ARM_SMMU_V3_KUNIT_TEST
+	tristate "KUnit tests for arm-smmu-v3 driver"  if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on ARM_SMMU_V3_SVA
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to unit-test arm-smmu-v3 driver functions.
+
+	  If unsure, say N.
+
+config TEGRA241_CMDQV
+	bool "NVIDIA Tegra241 CMDQ-V extension support for ARM SMMUv3"
+	depends on ACPI
+	help
+	  Support for NVIDIA CMDQ-Virtualization extension for ARM SMMUv3. The
+	  CMDQ-V extension is similar to v3.3 ECMDQ for multi command queues
+	  support, except with virtualization capabilities.
+
+	  Say Y here if your system is NVIDIA Tegra241 (Grace) or it has the same
+	  CMDQ-V extension.
+endif
+
+config QCOM_IOMMU
+	# Note: iommu drivers cannot (yet?) be built as modules
+	bool "Qualcomm IOMMU Support"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
+	select QCOM_SCM
+	select IOMMU_API
+	select IOMMU_IO_PGTABLE_LPAE
+	select ARM_DMA_USE_IOMMU
+	help
+	  Support for IOMMU on certain Qualcomm SoCs.
-- 
2.39.2.101.g768bb238c484.dirty

