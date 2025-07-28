Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CDD22F74B;
	Mon, 28 Jul 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753699870; cv=none; b=JQpj431VjjBwL1bYon/kEGPu/xWWUMHjZA/iXiMUkbaP8KOpaJz7V7/R2RhsBsnlmpSLpQVI5Fy4u5R7L3X+U4IAz99KmIdhyOxcrLwy7S6AvvWfdMjHWbwF4gCOneNQ8moYsoIpRGQQsIHvLnNDSLp/LwEZtv49aiDW3QAcr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753699870; c=relaxed/simple;
	bh=ktteVd1e8A95xuWWFpvbHUtpkzcc4cRBe8jJTClR/1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PQvx8gKxvsQ9ix9XUG48LpuX6NtXPuXi3NcaPge/vGtzwyOZSj1gOwnvBOWyaR1AJ78S4SuC7EyNCG+1Qkh8ncToJeyPItyOPEd6kfevxBgalCvqnTOVyUowUh3cVwzM+Uhen5tGBAWkXQU3gHnQZpuTGvq1UqzIgGd1upXYxj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNxRBFR3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNxRBFR3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFFBC4CEF6;
	Mon, 28 Jul 2025 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753699870;
	bh=ktteVd1e8A95xuWWFpvbHUtpkzcc4cRBe8jJTClR/1s=;
	h=Date:From:To:Cc:Subject:From;
	b=MNxRBFR3i7IZ12aAfsENg26BQINm2aLafRhp0cTBWueykcNG0OhQSy/D2JsCFo953
	 XQ30f2cf0kP6YgsTy8ePp8MNgNymNbWoO3iaTljCXyplzvHI7+strnXau5Cl4OVE1l
	 REyk6Ysqk5lwPgzqvXXjX07T3qm03ytBX1D6LN+zaFoa+vSCDBfhzGPv1GdQeYoqSk
	 Ysy0hPk1R+eybKRIdTVI0AVxKuGTnSClLlLJXpLFtZQV8YpHrg7o4XfQNseYSwZlkh
	 zCHEG6XAdhT+MODKgn3vyIYdvF9b3cDJIRztWoTZURUIvkaRZUMG5eYNtv2Gj9kum6
	 1LPOohcweI0jg==
Date: Mon, 28 Jul 2025 11:51:05 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] IOMMU Updates for Linux v6.17
Message-ID: <aIdWGaahna8cQqjK@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Joerg (CC'd) has been away for a couple of weeks [1] so I've been
handling the IOMMU tree recently and here is the pull request for IOMMU
changes targetting v6.17.

There is a summary in the tag but it's mainly driver updates for x86 and
Arm-based systems. The only real core change is removal of the
'pgsize_bitmap' field from 'struct iommu_ops', along with the necessary
driver updates to go with it.

Please pull.

Cheers,

Will

[1] https://lore.kernel.org/linux-iommu/ojjm5wbqi44t5v2qo752u7q36uvbrda7au5coskjbnxgaom6t5@ebbfcm7zmwfa

--->8

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.17

for you to fetch changes up to b9e6e8ae0a5f9edae7cc1b5972a1d3dea9223fe2:

  Merge branch 'arm/smmu/updates' into next (2025-07-24 11:18:28 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.17:

- Core
  * Remove the 'pgsize_bitmap' member from 'struct iommu_ops'
  * Convert the x86 drivers over to msi_create_parent_irq_domain()

- AMD-Vi
  * Add support for examining driver/device internals via debugfs
  * Add support for "HATDis" to disable host translation when it is not
    supported
  * Add support for limiting the maximum host translation level based on
    EFR[HATS]

- Apple DART
  * Don't enable as built-in by default when ARCH_APPLE is selected

- Arm SMMU
  * Devicetree bindings update for the Qualcomm SMMU in the "Milos" SoC
  * Support for Qualcomm SM6115 MDSS parts
  * Disable PRR on Qualcomm SM8250 as using these bits causes the
    hypervisor to explode

- Intel VT-d
  * Reorganize Intel VT-d to be ready for iommupt
  * Optimize iotlb_sync_map for non-caching/non-RWBF modes
  * Fix missed PASID in dev TLB invalidation in cache_tag_flush_all()

- Mediatek
  * Fix build warnings when W=1

- Samsung Exynos
  * Add support for reserved memory regions specified by the bootloader

- TI OMAP
  * Use syscon_regmap_lookup_by_phandle_args() instead of parsing the
    node manually

- Misc
  * Cleanups and minor fixes across the board

----------------------------------------------------------------
Alexey Klimov (1):
      iommu/arm-smmu-qcom: Add SM6115 MDSS compatible

Ankit Soni (2):
      iommu/amd: Add HATDis feature support
      iommu/amd: Add efr[HATS] max v1 page table level

Bagas Sanjaya (1):
      iommu/amd: Wrap debugfs ABI testing symbols snippets in literal code blocks

Daniel Mentz (1):
      iommu/io-pgtable-arm: Remove unused macro iopte_prot

Dheeraj Kumar Srivastava (8):
      iommu/amd: Refactor AMD IOMMU debugfs initial setup
      iommu/amd: Add debugfs support to dump IOMMU MMIO registers
      iommu/amd: Add debugfs support to dump IOMMU Capability registers
      iommu/amd: Add debugfs support to dump IOMMU command buffer
      iommu/amd: Add support for device id user input
      iommu/amd: Add debugfs support to dump device table
      iommu/amd: Add debugfs support to dump IRT Table
      iommu/amd: Add documentation for AMD IOMMU debugfs support

Dmitry Baryshkov (1):
      iommu/arm-smmu: disable PRR on SM8250

Easwar Hariharan (1):
      iommu/amd: Enable PASID and ATS capabilities in the correct order

Ethan Milon (2):
      iommu/vt-d: Fix missing PASID in dev TLB flush with cache_tag_flush_all
      iommu/vt-d: Deduplicate cache_tag_flush_all by reusing flush_range

Jason Gunthorpe (17):
      qiommu/arm-smmu-v3: Remove iommu_ops pgsize_bitmap
      iommu/arm-smmu: Remove iommu_ops pgsize_bitmap
      iommu: Remove ops.pgsize_bitmap from drivers that don't use it
      iommu: Remove iommu_ops pgsize_bitmap from simple drivers
      iommu/mtk: Remove iommu_ops pgsize_bitmap
      iommu/qcom: Remove iommu_ops pgsize_bitmap
      iommu/msm: Remove ops->pgsize_bitmap
      iommu: Remove ops->pgsize_bitmap
      iommu/vt-d: Lift the __pa to domain_setup_first_level/intel_svm_set_dev_pasid()
      iommu/vt-d: Fold domain_exit() into intel_iommu_domain_free()
      iommu/vt-d: Do not wipe out the page table NID when devices detach
      iommu/vt-d: Split intel_iommu_domain_alloc_paging_flags()
      iommu/vt-d: Create unique domain ops for each stage
      iommu/vt-d: Split intel_iommu_enforce_cache_coherency()
      iommu/vt-d: Split paging_domain_compatible()
      iommu/qcom: Fix pgsize_bitmap
      iommu/amd: Fix geometry.aperture_end for V2 tables

Kaustabh Chakraborty (1):
      iommu/exynos: add support for reserved regions

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Remove sdm845-cheza specific entry

Krzysztof Kozlowski (2):
      iommu/omap: Drop redundant check if ti,syscon-mmuconfig exists
      iommu/omap: Use syscon_regmap_lookup_by_phandle_args

Lu Baolu (3):
      iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes
      iommu/vt-d: Make iotlb_sync_map a static property of dmar_domain
      iommu/vt-d: Fix UAF on sva unbind with pending IOPFs

Luca Weiss (1):
      dt-bindings: arm-smmu: document the support on Milos

Marc Zyngier (2):
      iommu/amd: Convert to msi_create_parent_irq_domain() helper
      iommu/intel: Convert to msi_create_parent_irq_domain() helper

Nicolin Chen (1):
      iommu/arm-smmu-v3: Revert vmaster in the error path

Robin Murphy (1):
      iommu/mediatek-v1: Tidy up probe_finalize

Sven Peter (1):
      iommu/apple-dart: Drop default ARCH_APPLE in Kconfig

Vineeth Pillai (Google) (1):
      iommu/vt-d: Remove the CONFIG_X86 wrapping from iommu init hook

Will Deacon (9):
      Merge branch 'core' into next
      Merge branch 'samsung/exynos' into next
      Merge branch 'intel/vt-d' into next
      Merge branch 'amd/amd-vi' into next
      Merge branch 'mediatek' into next
      Merge branch 'ti/omap' into next
      Merge branch 'apple/dart' into next
      Merge branch 'arm/smmu/bindings' into next
      Merge branch 'arm/smmu/updates' into next

 Documentation/ABI/testing/debugfs-amd-iommu        | 131 +++++++
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   7 +-
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/amd/Kconfig                          |   1 +
 drivers/iommu/amd/amd_iommu.h                      |   6 +-
 drivers/iommu/amd/amd_iommu_types.h                |  16 +-
 drivers/iommu/amd/debugfs.c                        | 378 ++++++++++++++++++++-
 drivers/iommu/amd/init.c                           |  52 ++-
 drivers/iommu/amd/io_pgtable.c                     |   4 +-
 drivers/iommu/amd/iommu.c                          |  67 ++--
 drivers/iommu/apple-dart.c                         |   1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |  17 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   4 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  12 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   6 +-
 drivers/iommu/exynos-iommu.c                       |   5 +-
 drivers/iommu/intel/cache.c                        |  55 +--
 drivers/iommu/intel/dmar.c                         |   3 -
 drivers/iommu/intel/iommu.c                        | 364 +++++++++++++-------
 drivers/iommu/intel/iommu.h                        |  22 +-
 drivers/iommu/intel/irq_remapping.c                |  28 +-
 drivers/iommu/intel/nested.c                       |   4 +-
 drivers/iommu/intel/pasid.c                        |  17 +-
 drivers/iommu/intel/pasid.h                        |  11 +-
 drivers/iommu/intel/svm.c                          |   3 +-
 drivers/iommu/intel/trace.h                        |   5 -
 drivers/iommu/io-pgtable-arm.c                     |   7 -
 drivers/iommu/iommu.c                              |   7 -
 drivers/iommu/iommufd/selftest.c                   |   1 -
 drivers/iommu/ipmmu-vmsa.c                         |   4 +-
 drivers/iommu/msm_iommu.c                          |   7 +-
 drivers/iommu/mtk_iommu.c                          |   9 +-
 drivers/iommu/mtk_iommu_v1.c                       |  11 +-
 drivers/iommu/omap-iommu.c                         |  27 +-
 drivers/iommu/riscv/iommu.c                        |   1 -
 drivers/iommu/rockchip-iommu.c                     |   3 +-
 drivers/iommu/s390-iommu.c                         |   2 +-
 drivers/iommu/sprd-iommu.c                         |   3 +-
 drivers/iommu/sun50i-iommu.c                       |   3 +-
 drivers/iommu/tegra-smmu.c                         |   3 +-
 drivers/iommu/virtio-iommu.c                       |   6 +-
 include/linux/iommu.h                              |   2 -
 42 files changed, 961 insertions(+), 356 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu
