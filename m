Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655890;
	b=DVVWF24hRjUJmAnFBpuXA6qqLKNcQCvXH25qVZMmLx49+b8FvtW+BGjtduDs6Erx6wAs
	 dEebXb7QiYOjrAhi300HWGvALXBN6rqG68S0/y5DfGPR7l7VRbKTLjaFnO3dFx0g5IQMw
	 8IQWUAtQ/p7LQKKzPVuoc/TLR+4t3H22mNCTAlDFJX/Q7fw/DD6xB82l5ttVoKVeDd7ye
	 /UIqkDgYelE2FmLBLJ6OmB2uXs3N8Hc23hTZYzRoUXyRjrTVkIb1LgfRJ69usz/gDOBho
	 eoCuLo+ztNNnFxKPGLttICLnuEHP81srMirZL2VFQp9ifk4J2VVROsEsnhW8Yokf5CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655890;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=yiyHDy8Y250tnW9FZf9O9LEqU4J4sES5GaiRIAh9GNE=;
	b=OWXcHUge/hWxhiehGvFHJrnxhv58j9uxLqAdFfVcEv+cyfrytD1NMzCAqrt2ANOJB1e1
	 xXQWZ7ZncJ3bV0Cql9DRgSb+aIXOhfgTIkszd9AXQYsaRPpwzfeCdh7C2zNRLWeRYayq3
	 twmmD6J2+3Kyxf30uhvyHJfrj3TwxmJ3ePvgbhFxWNQjgzDuBeMT7ZKo8XpYmvbIRUs2a
	 QP6BsiJ4gjy7Kcoubu7H2YrdS7RsOzZKLXN9Cq18avdfds2JQFV6r4DIC6bAZjAIinbbF
	 yIlbyrZ/4bKeHM4AEVEzQwlxFFH/GCxfZV+JRre6UASyoTU2jxqkbF8D9KL+58mparA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE65606A31D
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 07:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DE65606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a004d3fc2495c623980.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:4d3f:c249:5c62:3980])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B498D1C1958;
	Thu, 22 Oct 2026 09:58:01 +0200 (CEST)
Date: Thu, 22 Oct 2026 09:58:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v7.4
Message-ID: <atnAm_7wyGt6wsK7@8bytes.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This PR slightly violates the everything-must-be-ready-before-the-merge-window
rule, as I rebuilt the next branch on-top of the final v7.3 tag in order to not
include the fixes merged in v7.3-rc7. There is also a MAINTAINERS update patch
which I applied this week.

Everything else in this PR was ready before the merge window and the final
merge went through my usual testing as well. With that in mind, please
consider:

The following changes since commit c03c1a14507dfaf8b856c2608f9ac216021fc222:

  Linux 7.3 (2026-10-18 13:14:58 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.4

for you to fetch changes up to 20bfd25757659ff8229eeed6f048c76f9a11a4a3:

  Merge branches 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 'hyper-v', 'samsung/exynos', 'riscv', 'broadcom', 'intel/vt-d', 'amd/amd-vi' and 'core' into next (2026-10-20 09:43:47 +0200)

----------------------------------------------------------------
IOMMU updates for v7.4:

  - Core:
    - Detect scatterlist length overflows and finalize deferred domain
      attachments before mapping MSI pages.
    - Consolidate x86 MSI reserved-region handling and clean up internal DMA
      and SVA helpers.

  - AMD IOMMU:
    - Add IOMMU PerfOpt support, enabled by amdgpu for supported integrated
      GPUs in identity domains.
    - Restrict forced identity mapping to GPUs that require it.
    - Fix kdump device-table allocation and reuse, ATS configuration error
      handling, and an interrupt-remapping allocation leak.
    - Clean up device probing and initialization.
    - Add Vasant Hegde as an AMD IOMMU maintainer.

  - ARM SMMUv2:
    - Device-tree binding updates for Qualcomm Maili and Nord SoCs.

  - ARM SMMUv3:
    - Work around hardware integration issue on Google Tensor G5 SoCs where all
      DMA transactions appear as instruction fetches.
    - Allow command queue size to be configured on the kernel command-line.
    - Reduce queue sizes when running as a kdump kernel.
    - Fix some pre-existing issues in the driver and kunit tests reported by
      Sashiko.
    - Fix handling of Arm hardware errata relating to the contiguous hint
      when using SVA.
    - Rework the TLB invalidation logic in preparation for enabling iommu-pt in
      future.
    - Minor cleanups in preparation for improving support for kdump.

  - Apple DART:
    - Support device-tree DMA aperture specifications.

  - Broadcom:
    - Add BCM2712 IOMMU support for Raspberry Pi 5 display and multimedia
      devices, including the generic page-table format and shared TLB cache
      management.

  - Hyper-V:
    - Add a para-virtualized guest IOMMU driver with guest-managed stage-1 page
      tables and page-selective IOTLB invalidation.

  - Intel VT-d:
    - Enhanced IQE fault handling for batched multiple descriptors,
    - Optimization of page-table level calculation in compute_vasz_lg2_ss(),
    - Fixes for several pre-existing issues reported by Sashiko,
    - General cleanup and refinement.

  - RISC-V:
    - Report cache-coherency capability for coherent devices, enabling
      VFIO/iommufd use.

  - Samsung Exynos:
    - Support SysMMUs without BLOCK mode, fixing their enable sequence and TLB
      invalidation.
    - Improve v7 fault diagnostics with transaction information.

----------------------------------------------------------------
Andrew Jones (1):
      iommu/riscv: Report cache coherency capability

Daniel Drake (5):
      iommu_pt: Fix test_pgsize_boundary() failure on narrow-OA formats
      dt-bindings: iommu: Add Broadcom BCM2712 IOMMU
      dt-bindings: display: brcm,bcm2835-hvs: Document iommus property
      iommu/generic_pt: Add Broadcom BCM2712 page table format
      iommu: Add Broadcom BCM2712 IOMMU driver

Federico Parola (1):
      iommu: Finalize deferred attachments when mapping MSI pages

Guanghui Feng (1):
      iommu/vt-d: Fix IQE handling to cover all descriptors in submission range

Janne Grunau (2):
      dt-bindings: iommu: dart: Support specifying the DMA aperture
      iommu: apple-dart: Support specifying the DMA aperture in the DT

Jason Gunthorpe (7):
      iommu/arm-smmu-v3: Handle ARM erratum for CONT under invalidation with SVA
      iommu/arm-smmu-v3: Pass the parameters for the invalidation in a struct
      iommu/arm-smmu-v3: Move pgsize out of arm_smmu_inv
      iommu/arm-smmu-v3: Optimize range invalidation for latency
      iommu/arm-smmu-v3: Keep track in arm_smmu_invs if range invalidation is used
      iommu/arm-smmu-v3: Precompute the invalidation commands
      iommu/arm-smmu-v3: Populate the tlbi at the top of the call chain

Jingyi Wang (1):
      dt-bindings: arm-smmu: Document GPU SMMU on Qualcomm Maili SoC

Joerg Roedel (2):
      MAINTAINERS: Make Vasant Hegde AMD IOMMU maintainer
      Merge branches 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 'hyper-v', 'samsung/exynos', 'riscv', 'broadcom', 'intel/vt-d', 'amd/amd-vi' and 'core' into next

Kiryl Shutsemau (Meta) (2):
      iommu/arm-smmu-v3: Add a cmdq_max_n_shift module parameter
      iommu/arm-smmu-v3: Default queue depths to one page in a kdump kernel

Krzysztof Karas (1):
      iommu/dma: Catch scatterlist length overflows

Li RongQing (1):
      iommu/amd: Fix leak of data->entry in irq_remapping_alloc() error path

Lu Baolu (7):
      iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()
      iommu/vt-d: Do not ignore context table copy failures
      iommu/vt-d: Handle DID reservation errors when copying context tables
      iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
      iommu/vt-d: Use old domain parameter when attaching the blocking domain
      iommu/vt-d: Fix iopf refcount leak in nested attach
      iommu/vt-d: Drop old iopf ref only after attach succeeds

Mario Limonciello (2):
      iommu/amd: Add PerfOpt IOMMU performance optimization support
      drm/amdgpu: Enable PerfOpt IOMMU perf optimization when GPU in identity domain

Markuss Broks (4):
      iommu/exynos: detect SysMMUs without BLOCK mode
      iommu/exynos: fix the enable sequence for no-block SysMMUs
      iommu/exynos: fix TLB invalidation for no-block SysMMUs
      iommu/exynos: decode the v7 fault transaction info

Matt Fleming (2):
      iommu/amd: Program device table when kdump reuse fails
      iommu/amd: Don't allocate kdump device table from DMA32

Mostafa Saleh (5):
      iommu/arm-smmu-v3: Ensure L2 tables are visible before L1 ptrs
      iommu/arm-smmu-v3-test: Fix arm_smmu_v3_test_debug_print_used_bits()
      iommu/arm-smmu-v3-test: Add missing error checks for inv array
      iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
      iommu/arm-smmu-v3-test: Fix UBSAN error

Nicolin Chen (4):
      iommu/arm-smmu-v3: Disable the impl before disabling the SMMU on shutdown
      iommu/arm-smmu-v3: Add arm_smmu_attach_release()
      iommu/arm-smmu-v3: Add Q_POS() macro
      iommu/arm-smmu-v3: Don't rb_erase() a never-inserted stream node

Peter Griffin (2):
      dt-bindings: iommu: arm,smmu-v3: Add arm,instdata-override property
      iommu/arm-smmu-v3: Add support for arm,instdata-override DT property

Pranjal Shrivastava (3):
      iommu/amd: Refactor device probe and capability initialization
      iommu/amd: Remove iommu_ignore_device()
      iommu/amd: Fail probe on ATS configuration failure

Robin Murphy (2):
      iommu: Make iommu-dma helpers private
      iommu/dma: Clean up redundant MSI cookie check

Rong Zhang (3):
      iommu/amd: Do not request ACS when IOMMU is not going to be initialized
      iommu/amd: Disallow implicit START_STATE => IVRS_DETECTED transition
      iommu/amd: Remove ad-hoc checks that are never true

Shawn Guo (1):
      dt-bindings: arm-smmu: Document Adreno SMMU for Nord SoC

Vasant Hegde (2):
      iommu/amd: Force identity mode for selected GPUs only
      iommu/amd: Move GA log allocation to init

Wei Liu (1):
      hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU

Yu Zhang (6):
      Drivers: hv: Add logical device ID registry for vPCI devices
      iommu/x86: Add architectural MSI reserved region helper
      iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest
      iommu/hyperv: Add page-selective IOTLB flush support
      iommu/hyperv: Add missing PCI dependency for the guest IOMMU driver
      iommu/hyperv: Make hv_iommu_device static

Zhaoyu Liu (1):
      iommu/sva: remove iommu_sva_present flag

Zhenzhong Duan (1):
      iommu/vt-d: Fix page table level calculation in compute_vasz_lg2_ss()

 Documentation/arch/arm64/silicon-errata.rst        |   3 +-
 .../bindings/display/brcm,bcm2835-hvs.yaml         |   3 +
 .../devicetree/bindings/iommu/apple,dart.yaml      |  12 +-
 .../devicetree/bindings/iommu/arm,smmu-v3.yaml     |  10 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   4 +
 .../bindings/iommu/brcm,bcm2712-iommu.yaml         |  54 ++
 .../bindings/iommu/brcm,bcm2712-iommuc.yaml        |  40 ++
 MAINTAINERS                                        |  14 +-
 arch/x86/hyperv/hv_init.c                          |   4 +
 arch/x86/include/asm/iommu.h                       |  20 +
 arch/x86/include/asm/mshyperv.h                    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  50 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  12 +
 drivers/hv/hv_common.c                             | 115 ++++
 drivers/iommu/Kconfig                              |  18 +-
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd/amd_iommu.h                      |   3 +
 drivers/iommu/amd/amd_iommu_types.h                |   7 +
 drivers/iommu/amd/init.c                           | 192 ++++--
 drivers/iommu/amd/iommu.c                          | 438 ++++++++++---
 drivers/iommu/apple-dart.c                         |  74 ++-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  29 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   |  57 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 604 +++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  77 ++-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |   2 +-
 drivers/iommu/bcm2712-iommu-cache.c                |  84 +++
 drivers/iommu/bcm2712-iommu-cache.h                |   9 +
 drivers/iommu/bcm2712-iommu.c                      | 550 +++++++++++++++++
 drivers/iommu/dma-iommu.c                          |  32 +-
 drivers/iommu/exynos-iommu.c                       |  37 +-
 drivers/iommu/generic_pt/.kunitconfig              |   1 +
 drivers/iommu/generic_pt/Kconfig                   |  10 +
 drivers/iommu/generic_pt/fmt/Makefile              |   2 +
 drivers/iommu/generic_pt/fmt/bcm2712.h             | 288 +++++++++
 drivers/iommu/generic_pt/fmt/defs_bcm2712.h        |  18 +
 drivers/iommu/generic_pt/fmt/iommu_bcm2712.c       |   6 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h          |   2 +-
 drivers/iommu/hyperv/Kconfig                       |  15 +
 drivers/iommu/hyperv/Makefile                      |   1 +
 drivers/iommu/hyperv/hv-iommu-guest.c              | 682 +++++++++++++++++++++
 drivers/iommu/hyperv/iommu.h                       |  44 ++
 drivers/iommu/intel/dmar.c                         |  72 ++-
 drivers/iommu/intel/iommu.c                        | 167 ++++-
 drivers/iommu/intel/iommu.h                        |  17 +-
 drivers/iommu/intel/nested.c                       |   2 +
 drivers/iommu/iommu-priv.h                         |   4 +
 drivers/iommu/iommu-sva.c                          |  14 +-
 drivers/iommu/iommu.c                              |   4 +
 drivers/iommu/riscv/iommu.c                        |  12 +
 drivers/pci/controller/pci-hyperv.c                |  21 +-
 include/asm-generic/mshyperv.h                     |   4 +
 include/hyperv/hvgdk_mini.h                        |  10 +
 include/hyperv/hvhdk_mini.h                        | 155 +++++
 include/linux/amd-iommu.h                          |  13 +-
 include/linux/generic_pt/common.h                  |   6 +
 include/linux/generic_pt/iommu.h                   |  12 +
 include/linux/hyperv.h                             |   8 +
 include/linux/iommu.h                              |   2 -
 61 files changed, 3690 insertions(+), 463 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommu.yaml
 create mode 100644 Documentation/devicetree/bindings/iommu/brcm,bcm2712-iommuc.yaml
 create mode 100644 drivers/iommu/bcm2712-iommu-cache.c
 create mode 100644 drivers/iommu/bcm2712-iommu-cache.h
 create mode 100644 drivers/iommu/bcm2712-iommu.c
 create mode 100644 drivers/iommu/generic_pt/fmt/bcm2712.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_bcm2712.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_bcm2712.c
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/hv-iommu-guest.c
 create mode 100644 drivers/iommu/hyperv/iommu.h

Please pull.

Thanks,

	Joerg
