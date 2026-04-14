Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6D83DDDB8
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166734; cv=none; b=konTmEkJx8z/zPOA8ZJzR2xEskgNJ1dkFUGe5vY7pBhA9NBKkz57QVnfDSItSOxr7Sf7knTJAXAAgO5rC/RvCSTBSeHA8NkEQcfDXmGvifarT5+HpByoRllXlPZ44JY0IzD3xAUrLO+kmNDH3rycad2nl2Uyib5zovCNGl1VoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166734; c=relaxed/simple;
	bh=9eHyk0cvUhTkrAspjWtt5sHAyf6ixgoGCCqPtt415NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LYiw0onpsaBK3uYsciF+vxyWgrk9xaS8DJW4RlosUcvaNGT2Jfs1lFjXi1jDou52TV05sNk9w0tDau9983AyhfhZUX2eOF3oZdptJBJVXMjgexQ8bNALBLwh+WBB3plxvnvgpoaYg08wIc6aWZubI8j4ausFeZYiZ9U3akw5LZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=eHdDp6xZ; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="eHdDp6xZ"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A911D1C26C4;
	Tue, 14 Apr 2026 13:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1776166723;
	bh=9eHyk0cvUhTkrAspjWtt5sHAyf6ixgoGCCqPtt415NQ=;
	h=Date:From:To:Cc:Subject:From;
	b=eHdDp6xZCH81qXy+TZfsp3/i96Vj9h7wuw4D/H4Tn3P82pnMjRlpYycxv9BANYG5r
	 dhd3DhG4jirPI9syFe4xoS+Sp2WkBHpzfYEmLRVPDDovp6jR0DW5zFMrNscXsMclAx
	 oCagpwUQH5PAAazo5txO/3qWGzC0mCdW3dOuVPmW+6BlvDEeQIzxvGq7rEyFvFNNmE
	 12DlNzhQR+7v8YfwVuV9FKvrJTGOwUlJF5TwZkwSdbtAOXWCvUvAuK4Hr4Vgmr5TsA
	 HESkNsLGTi59hhpkOMoY9JiIxlNDD4Ri7BRKCbecq/4/mgaVMf2z+pgaWH8Y7EtNoI
	 8xbsVYR/ebltg==
Date: Tue, 14 Apr 2026 13:38:42 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v7.1
Message-ID: <256dnfavvrodzkhib4d2vy3irictbb62umjdw2uh2hwm3u7zua@7wwea7jpebxi>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

A quick note: The next branch which this pull-request uses is based on
v7.0-rc6, so some of the patches below are already in your tree. With that in
mind, please consider:

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.1

for you to fetch changes up to f8d5e7066d846c92ecac245134baf8a207becb65:

  Merge branches 'fixes', 'arm/smmu/updates', 'arm/smmu/bindings', 'riscv', 'intel/vt-d', 'amd/amd-vi' and 'core' into next (2026-04-09 13:18:27 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v7.1:

Including:

	- Core:
	  - Support for RISC-V IO-page-table format in generic iommupt
	    code

	- ARM-SMMU Updates:

	  - Introduction of an "invalidation array" for SMMUv3, which enables
	    future scalability work and optimisations for devices with a large
	    number of SMMUv3 instances.

	  - Update the conditions under which the SMMUv3 driver works around
	    hardware errata for invalidation on MMU-700 implementations.

	  - Fix broken command filtering for the host view of NVIDIA's "cmdqv"
	    SMMUv3 extension.

	  - MMU-500 device-tree binding additions for Qualcomm Eliza & Hawi SoCs.

	- Intel VT-d:

	  - Support for dirty tracking on domains attached to PASID
	  - Removal of unnecessary read*()/write*() wrappers
	  - Improvements to the invalidation paths

	- AMD Vi:

	  - Race-condition fixed in debugfs code
	  - Make log buffer allocation NUMA aware

	- RISC-V:

	  - IO-TLB flushing improvements
	  - Minor fixes

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: arm-smmu: Add compatible for Eliza SoC

Alex Williamson (1):
      iommu/vt-d: Restore IOMMU_CAP_CACHE_COHERENCY

Bjorn Helgaas (2):
      iommu/vt-d: Remove dmar_readl() and dmar_readq()
      iommu/vt-d: Remove dmar_writel() and dmar_writeq()

Ethan Tidmore (1):
      iommu/riscv: Fix signedness bug

Fangyu Yu (2):
      iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
      iommu/riscv: Stop polling when CQCSR reports an error

Guanghui Feng (2):
      iommu/amd: Fix illegal device-id access in IOMMU debugfs
      iommu/amd: Fix illegal cap/mmio access in IOMMU debugfs

Jason Gunthorpe (17):
      iommupt: Add the RISC-V page table format
      iommu/riscv: Disable SADE
      iommu/riscv: Use the generic iommu page table
      iommu/riscv: Enable SVNAPOT support for contiguous ptes
      iommu/riscv: Add missing GENERIC_MSI_IRQ
      iommu/riscv: Allow RISC_VIOMMU to COMPILE_TEST
      iommupt: Optimize the gather processing for DMA-FQ mode
      iommupt: Directly call iommupt's unmap_range()
      iommupt: Avoid rewalking during map
      iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array
      iommu: Do not call drivers for empty gathers
      iommupt: Fix short gather if the unmap goes into a large mapping
      iommu/dma: Always allow DMA-FQ when iommupt provides the iommu_domain
      iommu/vt-d: Split piotlb invalidation into range and all
      iommu/vt-d: Pass size_order to qi_desc_piotlb() not npages
      iommu/vt-d: Remove the remaining pages along the invalidation path
      iommu/riscv: Remove overflows on the invalidation path

Li RongQing (1):
      iommu/amd: Add NUMA node affinity for IOMMU log buffers

Magnus Kalland (1):
      iommu/amd: Invalidate IRT cache for DMA aliases

Mukesh Ojha (1):
      dt-bindings: arm-smmu: qcom: Add compatible for Hawi SoC

Nicolin Chen (11):
      iommu/arm-smmu-v3: Add a missing dma_wmb() for hitless STE update
      iommu/arm-smmu-v3: Explicitly set smmu_domain->stage for SVA
      iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
      iommu/arm-smmu-v3: Pre-allocate a per-master invalidation array
      iommu/arm-smmu-v3: Populate smmu_domain->invs when attaching masters
      iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()
      iommu/arm-smmu-v3: Perform per-domain invalidations using arm_smmu_invs
      iommu/arm-smmu-v3: Do not continue in __arm_smmu_domain_inv_range()
      iommu/arm-smmu-v3: Fix typos introduced by arm_smmu_invs
      iommu/tegra241-cmdqv: Set supports_cmd op in tegra241_vcmdq_hw_init()
      iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN requirement

Robin Murphy (2):
      iommu/arm-smmu-v3: Update Arm errata
      iommu: Ensure .iotlb_sync is called correctly

Shameer Kolothum (2):
      iommu: Add device ATS supported capability
      iommufd: Report ATS not supported status via IOMMU_GET_HW_INFO

Sherry Yang (1):
      iommupt/amdv1: mark amdv1pt_install_leaf_entry as __always_inline

Vasant Hegde (1):
      iommu/amd: Fix clone_alias() to use the original device's devid

Will Deacon (1):
      Merge branches 'fixes', 'arm/smmu/updates', 'arm/smmu/bindings', 'riscv', 'intel/vt-d', 'amd/amd-vi' and 'core' into next

Yaxing Guo (1):
      iommu/riscv: Skip IRQ count check when using MSI interrupts

Zhenzhong Duan (4):
      iommu/vt-d: Block PASID attachment to nested domain with dirty tracking
      iommu/vt-d: Rename device_set_dirty_tracking() and pass dmar_domain pointer
      iommu/vt-d: Support dirty tracking on PASID
      iommufd/selftest: Test dirty tracking on PASID

lynn (1):
      iommu/iova: Add NULL check in iova_magazine_free()

 Documentation/arch/arm64/silicon-errata.rst        |   8 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 drivers/iommu/amd/debugfs.c                        |  63 +-
 drivers/iommu/amd/init.c                           |   9 +-
 drivers/iommu/amd/iommu.c                          |  43 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  35 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   | 135 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 954 +++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        | 142 ++-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   7 +-
 drivers/iommu/dma-iommu.c                          |  13 +-
 drivers/iommu/generic_pt/.kunitconfig              |   1 +
 drivers/iommu/generic_pt/Kconfig                   |  11 +
 drivers/iommu/generic_pt/fmt/Makefile              |   2 +
 drivers/iommu/generic_pt/fmt/amdv1.h               |   2 +-
 drivers/iommu/generic_pt/fmt/defs_riscv.h          |  29 +
 drivers/iommu/generic_pt/fmt/iommu_riscv64.c       |  11 +
 drivers/iommu/generic_pt/fmt/riscv.h               | 313 +++++++
 drivers/iommu/generic_pt/iommu_pt.h                | 191 +++--
 drivers/iommu/generic_pt/kunit_generic_pt.h        |  12 +
 drivers/iommu/generic_pt/pt_iter.h                 |  22 +
 drivers/iommu/intel/cache.c                        |  53 +-
 drivers/iommu/intel/debugfs.c                      |  18 +-
 drivers/iommu/intel/dmar.c                         |  43 +-
 drivers/iommu/intel/iommu.c                        |  58 +-
 drivers/iommu/intel/iommu.h                        |  47 +-
 drivers/iommu/intel/irq_remapping.c                |   6 +-
 drivers/iommu/intel/pasid.c                        |   6 +-
 drivers/iommu/intel/perfmon.c                      |  50 +-
 drivers/iommu/intel/prq.c                          |  28 +-
 drivers/iommu/intel/trace.h                        |  18 +-
 drivers/iommu/iommu.c                              |  72 +-
 drivers/iommu/iommufd/device.c                     |   4 +
 drivers/iommu/iova.c                               |   3 +-
 drivers/iommu/riscv/Kconfig                        |   8 +-
 drivers/iommu/riscv/iommu-bits.h                   |   4 +-
 drivers/iommu/riscv/iommu-platform.c               |  17 +-
 drivers/iommu/riscv/iommu.c                        | 386 +++------
 include/linux/generic_pt/common.h                  |  16 +
 include/linux/generic_pt/iommu.h                   |  80 +-
 include/linux/iommu.h                              |   6 +-
 include/uapi/linux/iommufd.h                       |   9 +
 tools/testing/selftests/iommu/iommufd.c            |  27 +
 43 files changed, 2166 insertions(+), 798 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_riscv.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_riscv64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/riscv.h

Please pull.

Thanks,

	Joerg
