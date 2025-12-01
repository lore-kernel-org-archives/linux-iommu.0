Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F00312817
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764594953; cv=none; b=Z5zD84A+3em6+cT4fa6SLDYwCdesGJVzHRoGaGHMUfQCOvyWl7g4q3KPd5ORh1JKfNl2HWmPMl/FbXEqmO4AvB53JHDhJIzLgHQei9bZ3xMPly337YWGqiNX8rYtQwGv2S0hdBp+sRgAg5I6eefohHLZ9o/pdU9KstbSqhH03ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764594953; c=relaxed/simple;
	bh=tPUGglOiu0jIOW09wH8MbKpIcJ+nzVKNTe7WHePRnBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PXqZIhKqwrzhrj7qbE05jWT6Z7SLzIiR3CmtEAvo9+thZ+wRMsXjSzk22GOZJLgjkPmqGQnmGThMnNtjljW3Jxas5rSmPCS9uO3zpeDYV1XqegjXOUlqodIzBH55CkgDNKzLSN7ppR8ls4AIii5k37bhEpblZRhVp+HtsEVLslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=KqF6dMF6; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="KqF6dMF6"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9024C5C8E3;
	Mon,  1 Dec 2025 14:15:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1764594944;
	bh=tPUGglOiu0jIOW09wH8MbKpIcJ+nzVKNTe7WHePRnBY=;
	h=Date:From:To:Cc:Subject:From;
	b=KqF6dMF6Z0mpTxCFQVXto+tRd4ByymyJaOx0bs5UyBt0eYMScR4oGdcTxOeRoBr3g
	 AZU8c+Bv8GWCltlrV2UkoYkVsnLlx2s2LE7mXHCh0xfYZIZQF5/j3jpgIj9uoUqfxL
	 2laE5iLCwljnKJcgR5RSQkEQjFnzl/e+tytFAGFAzQCrHOA09m2hLSafTONa10o5Yu
	 COCGCSnUDiHuN12riIPW8dPgkRvT39o0MWg+GliSekXUcAo2cIDaeqjLq5GPgIS8N0
	 hTrlm+6j+6QcaiZeDvHj+AaqH+HLoTkADBb2PZvY6b8B09+0N08h2lMs4FbrVWMDeO
	 lBfHo4xPWBQmQ==
Date: Mon, 1 Dec 2025 14:15:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.19
Message-ID: <2siidejxg252y5jsrevsx3pcfijzvtw5a76ct4ysajzllxxofl@surpwwn4naps>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d:

  Linux 6.18-rc7 (2025-11-23 14:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.19

for you to fetch changes up to 0d081b16946ef449fcb35b6edc1ef6f9fea6f0a0:

  Merge branches 'arm/smmu/updates', 'arm/smmu/bindings', 'mediatek', 'nvidia/tegra', 'intel/vt-d', 'amd/amd-vi' and 'core' into next (2025-11-28 08:44:21 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.19

Including:

	- Introduction of the generic IO page-table framework with support for
	  Intel and AMD IOMMU formats from Jason. This has good potential for
	  unifying more IO page-table implementations and making future
	  enhancements more easy. But this also needed quite some fixes during
	  development. All known issues have been fixed, but my feeling is that
	  there is a higher potential than usual that more might be needed.

	- Intel VT-d updates:
	  - Use right invalidation hint in qi_desc_iotlb().

	  - Reduce the scope of INTEL_IOMMU_FLOPPY_WA.

	- ARM-SMMU updates:
	  - Qualcomm device-tree binding updates for Kaanapali and Glymur SoCs
	    and a new clock for the TBU.

	  - Fix error handling if level 1 CD table allocation fails.

	  - Permit more than the architectural maximum number of SMRs for funky
	    Qualcomm mis-implementations of SMMUv2.

	- Mediatek driver:
	  - MT8189 iommu support.

	- Move ARM IO-pgtable selftests to kunit.

	- Device leak fixes for a couple of drivers.

	- Random smaller fixes and improvements.

----------------------------------------------------------------
Aashish Sharma (1):
      iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb

Abel Vesa (1):
      iommu/arm-smmu-qcom: Add Glymur MDSS compatible

Alejandro Jimenez (1):
      iommu/amd: Use the generic iommu page table

Bagas Sanjaya (3):
      Documentation: genpt: Don't use code block marker before iommu_amdv1.c include listing
      iommupt: Describe @bitnr parameter
      iommupt: Actually correct pt_test_sw_bit_{acquire_release}() parameter description

Dheeraj Kumar Srivastava (1):
      iommu/amd: Enhance "Completion-wait Time-out" error message

Geert Uytterhoeven (1):
      genpt: Make GENERIC_PT invisible

Jason Gunthorpe (31):
      iommu: Generic support for RMRs during device release
      genpt: Generic Page Table base API
      genpt: Add Documentation/ files
      iommupt: Add the basic structure of the iommu implementation
      iommupt: Add the AMD IOMMU v1 page table format
      iommupt: Add iova_to_phys op
      iommupt: Add unmap_pages op
      iommupt: Add map_pages op
      iommupt: Add read_and_clear_dirty op
      iommupt: Add a kunit test for Generic Page Table
      iommupt: Add a mock pagetable format for iommufd selftest to use
      iommufd: Change the selftest to use iommupt instead of xarray
      iommupt: Add the x86 64 bit page table format
      iommu/amd: Remove AMD io_pgtable support
      iommupt: Add a kunit test for the IOMMU implementation
      iommu/pages: Add support for incoherent IOMMU page table walkers
      iommupt: Add basic support for SW bits in the page table
      iommupt: Use the incoherent start/stop functions for PT_FEAT_DMA_INCOHERENT
      iommupt: Flush the CPU cache after any writes to the page table
      iommupt: Add the Intel VT-d second stage page table format
      iommupt/x86: Set the dirty bit only for writable PTEs
      iommupt/x86: Support SW bits and permit PT_FEAT_DMA_INCOHERENT
      iommu/vt-d: Use the generic iommu page table
      iommu/vt-d: Follow PT_FEAT_DMA_INCOHERENT into the PASID entry
      iommupt: Add a kunit test for the SW bits
      iommupt: Documentation fixes
      iommupt: Fix unlikely flows in increase_top()
      iommupt: Avoid a compiler bug with sw_bit
      powerpc/pseries/svm: Make mem_encrypt.h self contained
      iommupt/vtd: Allow VT-d to have a larger table top than the vasz requires
      iommupt/vtd: Support mgaw's less than a 4 level walk for first stage

Jean-Philippe Brucker (1):
      MAINTAINERS: Update my email address

Jingyi Wang (1):
      dt-bindings: arm-smmu: Add compatible for Kaanapali and Glymur SoCs

Jinhui Guo (2):
      iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
      iommu/amd: Propagate the error code returned by __modify_irte_ga() in modify_irte_ga()

Joerg Roedel (2):
      iommu/iommupt: Fix build error in genericpt unit-tests
      Merge branches 'arm/smmu/updates', 'arm/smmu/bindings', 'mediatek', 'nvidia/tegra', 'intel/vt-d', 'amd/amd-vi' and 'core' into next

Johan Hovold (16):
      amba: tegra-ahb: enable compile testing
      iommu: tegra: enable compile testing
      iommu/apple-dart: fix device leak on of_xlate()
      iommu/qcom: fix device leak on of_xlate()
      iommu/exynos: fix device leak on of_xlate()
      iommu/ipmmu-vmsa: fix device leak on of_xlate()
      iommu/mediatek: fix device leak on of_xlate()
      iommu/mediatek: fix use-after-free on probe deferral
      iommu/mediatek: simplify dt parsing error handling
      iommu/mediatek-v1: fix device leak on probe_device()
      iommu/mediatek-v1: fix device leaks on probe()
      iommu/mediatek-v1: add missing larb count sanity check
      iommu/omap: fix device leaks on probe_device()
      iommu/omap: simplify probe_device() error handling
      iommu/sun50i: fix device leak on of_xlate()
      iommu/tegra: fix device leak on probe_device()

Konrad Dybcio (1):
      dt-bindings: iommu: qcom_iommu: Allow 'tbu' clock

Lu Baolu (1):
      iommu/vt-d: Restore previous domain::aperture_end calculation

Mostafa Saleh (4):
      iommu/io-pgtable-arm: Remove arm_lpae_dump_ops()
      iommu/io-pgtable-arm: Move selftests to a separate file
      iommu/io-pgtable-arm-selftests: Modularize the test
      iommu/io-pgtable-arm-selftests: Use KUnit

Nicolin Chen (5):
      iommu/arm-smmu-v3: Set release_domain to arm_smmu_blocked_domain
      iommu/exynos-iommu: Set release_domain to exynos_identity_domain
      iommu/amd: Set release_domain to blocked_domain
      iommu: Do not revert set_domain for the last gdev
      iommu: Pass in old domain to attach_dev callback functions

Pedro Demarchi Gomes (1):
      iommu/pages: use folio_nr_pages() instead of shift operation

Ryan Huang (1):
      iommu/arm-smmu-v3: Fix error check in arm_smmu_alloc_cd_tables

Songtang Liu (1):
      iommu/amd: Fix potential out-of-bounds read in iommu_mmio_show

Stephan Gerhold (1):
      iommu/arm-smmu-qcom: Enable use of all SMR groups when running bare-metal

Vineeth Pillai (Google) (1):
      iommu/vt-d: Set INTEL_IOMMU_FLOPPY_WA depend on BLK_DEV_FD

Zhengnan Chen (5):
      dt-bindings: mediatek: mt8189: Add bindings for MM & APU & INFRA IOMMU
      iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
      iommu/mediatek: mt8189: Add APU IOMMUs support
      iommu/mediatek: mt8189: Add INFRA IOMMUs support
      iommu/mediatek: mt8189: Add MM IOMMUs support

 .clang-format                                      |    1 +
 .mailmap                                           |    3 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |    2 +
 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |    8 +
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |    4 +
 Documentation/driver-api/generic_pt.rst            |  137 +++
 Documentation/driver-api/index.rst                 |    1 +
 MAINTAINERS                                        |    6 +-
 arch/powerpc/include/asm/mem_encrypt.h             |    3 +
 arch/powerpc/kernel/iommu.c                        |    5 +-
 drivers/amba/Kconfig                               |    2 +-
 drivers/iommu/Kconfig                              |   15 +-
 drivers/iommu/Makefile                             |    2 +
 drivers/iommu/amd/Kconfig                          |    5 +-
 drivers/iommu/amd/Makefile                         |    2 +-
 drivers/iommu/amd/amd_iommu.h                      |    1 -
 drivers/iommu/amd/amd_iommu_types.h                |  114 +-
 drivers/iommu/amd/debugfs.c                        |    2 +-
 drivers/iommu/amd/init.c                           |   15 +-
 drivers/iommu/amd/io_pgtable.c                     |  577 ---------
 drivers/iommu/amd/io_pgtable_v2.c                  |  370 ------
 drivers/iommu/amd/iommu.c                          |  572 ++++-----
 drivers/iommu/apple-dart.c                         |   11 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |    5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   33 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   28 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |    9 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   21 +-
 drivers/iommu/exynos-iommu.c                       |   20 +-
 drivers/iommu/fsl_pamu_domain.c                    |   12 +-
 drivers/iommu/generic_pt/.kunitconfig              |   14 +
 drivers/iommu/generic_pt/Kconfig                   |   79 ++
 drivers/iommu/generic_pt/fmt/Makefile              |   28 +
 drivers/iommu/generic_pt/fmt/amdv1.h               |  411 +++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h          |   21 +
 drivers/iommu/generic_pt/fmt/defs_vtdss.h          |   21 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h         |   21 +
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c         |   15 +
 drivers/iommu/generic_pt/fmt/iommu_mock.c          |   10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h      |   48 +
 drivers/iommu/generic_pt/fmt/iommu_vtdss.c         |   10 +
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c        |   11 +
 drivers/iommu/generic_pt/fmt/vtdss.h               |  285 +++++
 drivers/iommu/generic_pt/fmt/x86_64.h              |  279 +++++
 drivers/iommu/generic_pt/iommu_pt.h                | 1289 ++++++++++++++++++++
 drivers/iommu/generic_pt/kunit_generic_pt.h        |  823 +++++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h             |  184 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h          |  487 ++++++++
 drivers/iommu/generic_pt/pt_common.h               |  389 ++++++
 drivers/iommu/generic_pt/pt_defs.h                 |  332 +++++
 drivers/iommu/generic_pt/pt_fmt_defaults.h         |  295 +++++
 drivers/iommu/generic_pt/pt_iter.h                 |  636 ++++++++++
 drivers/iommu/generic_pt/pt_log2.h                 |  122 ++
 drivers/iommu/intel/Kconfig                        |    6 +-
 drivers/iommu/intel/iommu.c                        |  931 +++-----------
 drivers/iommu/intel/iommu.h                        |   99 +-
 drivers/iommu/intel/nested.c                       |    7 +-
 drivers/iommu/intel/pasid.c                        |   44 +-
 drivers/iommu/intel/pasid.h                        |    1 +
 drivers/iommu/intel/svm.c                          |    1 +
 drivers/iommu/io-pgtable-arm-selftests.c           |  214 ++++
 drivers/iommu/io-pgtable-arm.c                     |  203 ---
 drivers/iommu/io-pgtable.c                         |    4 -
 drivers/iommu/iommu-pages.c                        |  136 ++-
 drivers/iommu/iommu-pages.h                        |   51 +-
 drivers/iommu/iommu.c                              |   44 +-
 drivers/iommu/iommufd/Kconfig                      |    1 +
 drivers/iommu/iommufd/iommufd_test.h               |   11 +-
 drivers/iommu/iommufd/selftest.c                   |  426 +++----
 drivers/iommu/ipmmu-vmsa.c                         |   12 +-
 drivers/iommu/msm_iommu.c                          |   11 +-
 drivers/iommu/mtk_iommu.c                          |  174 ++-
 drivers/iommu/mtk_iommu_v1.c                       |   35 +-
 drivers/iommu/omap-iommu.c                         |   19 +-
 drivers/iommu/omap-iommu.h                         |    2 -
 drivers/iommu/riscv/iommu.c                        |    9 +-
 drivers/iommu/rockchip-iommu.c                     |   20 +-
 drivers/iommu/s390-iommu.c                         |   13 +-
 drivers/iommu/sprd-iommu.c                         |    3 +-
 drivers/iommu/sun50i-iommu.c                       |   10 +-
 drivers/iommu/tegra-smmu.c                         |   15 +-
 drivers/iommu/virtio-iommu.c                       |    6 +-
 .../memory/mediatek,mt8189-memory-port.h           |  283 +++++
 include/linux/generic_pt/common.h                  |  191 +++
 include/linux/generic_pt/iommu.h                   |  293 +++++
 include/linux/io-pgtable.h                         |    2 -
 include/linux/iommu.h                              |    3 +-
 include/linux/irqchip/riscv-imsic.h                |    3 +-
 tools/testing/selftests/iommu/iommufd.c            |   60 +-
 tools/testing/selftests/iommu/iommufd_utils.h      |   12 +
 90 files changed, 8284 insertions(+), 2867 deletions(-)
 create mode 100644 Documentation/driver-api/generic_pt.rst
 delete mode 100644 drivers/iommu/amd/io_pgtable.c
 delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c
 create mode 100644 drivers/iommu/generic_pt/.kunitconfig
 create mode 100644 drivers/iommu/generic_pt/Kconfig
 create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
 create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_vtdss.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_vtdss.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/vtdss.h
 create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_generic_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h
 create mode 100644 drivers/iommu/generic_pt/pt_common.h
 create mode 100644 drivers/iommu/generic_pt/pt_defs.h
 create mode 100644 drivers/iommu/generic_pt/pt_fmt_defaults.h
 create mode 100644 drivers/iommu/generic_pt/pt_iter.h
 create mode 100644 drivers/iommu/generic_pt/pt_log2.h
 create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c
 create mode 100644 include/dt-bindings/memory/mediatek,mt8189-memory-port.h
 create mode 100644 include/linux/generic_pt/common.h
 create mode 100644 include/linux/generic_pt/iommu.h

Please pull.

Thanks,

	Joerg
