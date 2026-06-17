Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FDF3BBFA4
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681165; cv=none; b=fxbu+/1OixHYFBdO+nmRBsarFpnpiOFgmvlbnbUsPacNmD6vqd5wk35XTeBxeyaiZd0bNI1D/FWTAijTxvqf+LEQ+RVYzCRdXTqmK4nSecfAm1aBivoz9Qnxjk+u0cQ4CP6aGy8OGh2CurW2y6ENo6rcuIQ7OuKb78Lj+RxpIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681165; c=relaxed/simple;
	bh=1Tdp7ieZpJE8YUxn3oCZBrRzyVGXSHKWj3Y1QzfSCX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ANuvq4+Rq+QweipbxjnoPUbt1tRW7c2syUYnakHbBLZl4FXoRIWAxBnthwtB8JZM1fr0p7jEHWsmL6xa5FilX+OfV6mYlrwAD47NGuvStPXiDzV1yxIJxvWy6dudA1JDkaiaUNIRoCYSm79JoiNonGDkugPT6IicAbU5l7ZRWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EF588202483;
	Wed, 17 Jun 2026 09:26:02 +0200 (CEST)
Date: Wed, 17 Jun 2026 09:26:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v7.2
Message-ID: <ajJL1Jx3bTh1EaVV@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48:

  Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.2

for you to fetch changes up to dd8a3c6cd531dca5917111a94fa3074077f6ba5a:

  Merge branches 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 'rockchip', 'verisilicon', 'riscv', 'intel/vt-d', 'amd/amd-vi' and 'core' into next (2026-06-12 14:57:23 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v7.2

Including:

Core Code:

  - Fix dma-iommu scatterlist length handling in the P2PDMA path.

  - Extend the generic IOMMU page-table code with detailed gather
    support for more precise invalidations.

  - Add pending-gather tracking to generic page-table invalidation
    handling.

  - Add support for smaller virtual address sizes in the generic AMDv1
    page-table format, including KUnit coverage.

  - Fix page-size bitmap calculation for smaller VA configurations.

  - Rework Arm io-pgtable allocation/freeing to consistently use the
    iommu-pages API and address-conversion helpers.

  - Add PCI ATS infrastructure for devices that require ATS, including
    always-on ATS handling for pre-CXL devices.

AMD IOMMU:

  - Fix several IOTLB invalidation details, including PDE handling,
    flush-all behavior, and command address encoding.

  - Honor IVINFO[VASIZE] when deriving address limits.

  - Fix premature loop termination in init_iommu_one().

  - Add Hygon family 18h model 4h IOAPIC support.

  - Clean up legacy-mode handling, stale comments, dead IVMD
    exclusion-range code, and unused address-size macros.

Arm SMMU / Arm SMMU v3:

  - SMMUv2:
    - Device-tree binding updates for Qualcomm Hawi, Nord and Shikra
      SoCs.
    - Constain the clocks which can be specified for recent Qualcomm
      SoCs.
    - Fix broken compatible string for Qualcomm prefetcher
      configuration an add new entry for the Glymur MDSS.
    - Ensure SMMU is powered-up when writing context bank for Adreno
      client.

  - SMMUv3:
    - Fix off-by-one in queue allocation retry loop.
    - Enable hardware update of access/dirty bits from the SMMU.
    - Re-jig command construction to use separate inline helpers for
      each command type.

Intel VT-d:

  - Add the PCI segment number to DMA fault messages.

  - Improve support for non-PRI mode SVA.

  - Ensure atomicity during context entry teardown.

  - Fix RB-tree corruption in the probe error path.

RISC-V IOMMU:

  - Add NAPOT range invalidation support.

  - Use detailed gather information for invalidation decisions.

  - Compute the best stride for single invalidations.

  - Advertise Svpbmt support to the generic page-table code.

  - Add capability definitions and clean up command macro encoding.

VeriSilicon IOMMU:

  - Add a new VeriSilicon IOMMU driver.

  - Add devicetree binding documentation and MAINTAINERS coverage.

  - Add the RK3588 VeriSilicon IOMMU node.

  - Apply small cleanups and warning fixes in the new driver.

Rockchip IOMMU:

  - Disable the fetch DTE time limit.

Apple DART:

  - Correct a stale CONFIG_PCIE_APPLE macro name in a comment.

----------------------------------------------------------------
Akhil P Oommen (1):
      dt-bindings: arm-smmu: Update the description for Glymur GPU SMMU

Ankit Soni (4):
      iommu_pt: Fix pgsize_bitmap calculation in get_info for smaller vasz's
      iommu_pt: support small VA for AMDv1
      iommu_pt: add kunit config for 32-bit VA (amdv1_cfg_1)
      iommu/amd: Adhere to IVINFO[VASIZE] for address limits

Anna Maniscalco (1):
      iommu: arm-smmu-qcom: Ensure smmu is powered up in set_ttbr0_cfg

Arnd Bergmann (1):
      iommu: vsi: avoid -Wformat-security warning

Benjamin Gaignard (3):
      dt-bindings: iommu: verisilicon: Add binding for VSI IOMMU
      iommu: Add verisilicon IOMMU driver
      arm64: dts: rockchip: Add verisilicon IOMMU node on RK3588

Bibek Kumar Patro (1):
      iommu/arm-smmu-qcom: Fix fastrpc compatible string in ACTLR client match table

Dan Carpenter (1):
      iommu/vsi: Use list_for_each_entry()

Ethan Nelson-Moore (1):
      iommu/apple-dart: correct CONFIG_PCIE_APPLE macro name in comment

Fangyu Yu (3):
      iommu/riscv: Advertise Svpbmt support to generic page table
      iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits
      iommupt: Fixup build warning by using BIT_ULL() for RISCVPT_NC/IO

Fu Hao (1):
      iommu/amd: Add support for Hygon family 18h model 4h IOAPIC

Guanghui Feng (1):
      iommu/vt-d: Improve IOMMU fault information

Jason Gunthorpe (22):
      iommu: Split the kdoc comment for struct iommu_iotlb_gather
      iommupt: Add struct iommupt_pending_gather
      iommupt: Add PT_FEAT_DETAILED_GATHER
      iommu/riscv: Enable PT_FEAT_DETAILED_GATHER and pass gather to iotlb_inval
      iommu/riscv: Compute best stride for single invalidation
      iommu/riscv: Add RISCV_IOMMU_CAPABILITIES_NL
      iommu/riscv: Include the dword number in RISCV_IOMMU_CMD macros
      iommu/riscv: Add NAPOT range invalidation support
      iommu/arm-smmu-v3: Add struct arm_smmu_cmd to represent the HW format command
      iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq selection functions
      iommu/arm-smmu-v3: Use the HW arm_smmu_cmd in cmdq submission functions
      iommu/arm-smmu-v3: Convert arm_smmu_cmdq_batch cmds to struct arm_smmu_cmd
      iommu/arm-smmu-v3: Remove CMDQ_OP_CFGI_CD_ALL from arm_smmu_cmdq_build_cmd()
      iommu/arm-smmu-v3: Directly encode simple commands
      iommu/arm-smmu-v3: Directly encode CMDQ_OP_ATC_INV
      iommu/arm-smmu-v3: Directly encode CMDQ_OP_SYNC
      iommu/arm-smmu-v3: Directly encode TLBI commands
      iommu/amd: Simplify build_inv_address()
      iommu/amd: Pass last in through to build_inv_address()
      iommu/amd: Have amd_iommu_domain_flush_pages() use last
      iommu/amd: Make CMD_INV_IOMMU_ALL_PAGES_ADDRESS match the spec
      iommu/amd: Control INVALIDATE_IOMMU_PAGES PDE from the gather

Joerg Roedel (1):
      Merge branches 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 'rockchip', 'verisilicon', 'riscv', 'intel/vt-d', 'amd/amd-vi' and 'core' into next

Komal Bajaj (1):
      dt-bindings: arm-smmu: qcom: Add compatible for Qualcomm Shikra SoC

Krzysztof Kozlowski (2):
      dt-bindings: arm-smmu: Constrain clocks for newer Qualcomm variants
      dt-bindings: arm-smmu: Correct and add constraints for Hawi, Shikra and Kaanapali

Leo Jiang (1):
      iommu/arm-smmu-v3: Limit queue allocation retry boundary to PAGE_SIZE

Li RongQing (1):
      iommu/dma-iommu: Fix wrong scatterlist length assignment in P2PDMA path

Lokanadha M R (1):
      iommu/arm-smmu-qcom: Add glymur MDSS to ACTLR client table

Lu Baolu (1):
      iommu/vt-d: Avoid WARNING in sva unbind path

Michael Bommarito (1):
      iommu/vt-d: Clear Present bit before tearing down scalable-mode context entry

Michał Grzelak (1):
      iommu/vt-d: Remove typo from pasid_pte_config_nested()

Mostafa Saleh (3):
      iommu/io-pgtable-arm: Use consistent sizes for page allocation and freeing
      iommu/io-pgtable-arm: Rework to use the iommu-pages API
      iommu/io-pgtable-arm: Use address conversion consistently

Mukesh Ojha (1):
      dt-bindings: arm-smmu: qcom: Add Hawi compatible for Application processor

Nicolin Chen (4):
      iommu/arm-smmu-v3-sva: Enable Hardware Access and Hardware Dirty bits
      PCI: Add pci_ats_required() for CXL.cache capable devices
      PCI: Allow ATS to be always on for pre-CXL devices
      iommu/arm-smmu-v3: Allow ATS to be always on

Pranjal Shrivastava (1):
      iommu/vt-d: Fix RB-tree corruption in probe error path

Sean Christopherson (2):
      iommu/amd: Explicitly bail from enable_iommus_vapic() when in legacy mode
      iommu/amd: Fix a stale comment about which legacy mode is user visible

Shawn Guo (1):
      dt-bindings: arm-smmu: Add compatible for Qualcomm Nord SoC

Simon Xue (1):
      iommu/rockchip: disable fetch dte time limit

Vasant Hegde (1):
      iommu/amd: Fix premature break in init_iommu_one()

Wei Wang (1):
      iommu/amd: Remove unused IOMMU_IN/OUT_ADDR_BIT_SIZE macros

Weinan Liu (1):
      iommu/amd: Don't split flush for amd_iommu_domain_flush_all()

Yu Zhang (1):
      iommu/amd: Remove dead code for exclusion ranges in IVMD

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  44 +-
 .../bindings/iommu/verisilicon,iommu.yaml          |  71 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  11 +
 drivers/iommu/Kconfig                              |  11 +
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd/amd_iommu.h                      |   6 +-
 drivers/iommu/amd/amd_iommu_types.h                |  29 +-
 drivers/iommu/amd/init.c                           |  63 +-
 drivers/iommu/amd/iommu.c                          | 181 +++--
 drivers/iommu/amd/pasid.c                          |   2 +-
 drivers/iommu/apple-dart.c                         |   2 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |  24 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  10 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 558 +++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        | 249 ++++---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |  16 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  13 +-
 drivers/iommu/dma-iommu.c                          |   2 +-
 drivers/iommu/generic_pt/fmt/amdv1.h               |   1 +
 drivers/iommu/generic_pt/fmt/iommu_riscv64.c       |   4 +-
 drivers/iommu/generic_pt/fmt/riscv.h               |  11 +-
 drivers/iommu/generic_pt/iommu_pt.h                | 110 ++-
 drivers/iommu/generic_pt/kunit_generic_pt.h        |  10 +-
 drivers/iommu/generic_pt/kunit_iommu_pt.h          |   5 +-
 drivers/iommu/intel/dmar.c                         |   9 +-
 drivers/iommu/intel/iommu.c                        |   6 +-
 drivers/iommu/intel/iommu.h                        |  11 +
 drivers/iommu/intel/pasid.c                        |  16 +-
 drivers/iommu/intel/svm.c                          |  12 +-
 drivers/iommu/io-pgtable-arm.c                     |  88 ++-
 drivers/iommu/riscv/iommu-bits.h                   | 123 ++--
 drivers/iommu/riscv/iommu.c                        | 162 ++++-
 drivers/iommu/rockchip-iommu.c                     |   8 +
 drivers/iommu/vsi-iommu.c                          | 791 +++++++++++++++++++++
 drivers/pci/ats.c                                  |  47 ++
 drivers/pci/pci.h                                  |   9 +
 drivers/pci/quirks.c                               |  42 ++
 include/linux/generic_pt/common.h                  |   9 +
 include/linux/iommu.h                              |  42 +-
 include/linux/pci-ats.h                            |   3 +
 include/uapi/linux/pci_regs.h                      |   1 +
 42 files changed, 2055 insertions(+), 766 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/verisilicon,iommu.yaml
 create mode 100644 drivers/iommu/vsi-iommu.c

Please pull.

Thanks,

	Joerg
