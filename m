Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CFF1891AB
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748607576; cv=none; b=nfIWETRMrUPGWuDJqLcmFEWu8Tp0cgHr4VAgizeHwjVyj+QZJ/cr4egRVLMzbUsC6e4ZR0hjzMH2Fr/qLkjd+rS/uJvRklxpf+x+7T0ECI2ekJ5AmtOYsgcuZZ0ObPVRL6oN84qXpA/Es9dWw+tWHsqaOpC+BuPPbtJh6z9uo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748607576; c=relaxed/simple;
	bh=brnWk11xz+8EDtLCZYLVYfCnLv1msbsfbcC4wsfPTss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d7tTZi4m+dsBT0ZzGEigriCJYF7+NK8uzaqJBRNwZu4SMq3dU2K/ftSrLw9GBSVvpMQLWftQgeE6t2GLSuj7Tf0FRXrICA8YV51jWsRL9dFmTbFCVVTm6++Q6uo3LqoqOjKS6L7MwBuLgC08mc1hlqggrqk9+pHTOwF4+A4N9Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=aci+aISz; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aci+aISz"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 66F184AC4C;
	Fri, 30 May 2025 14:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1748607111;
	bh=brnWk11xz+8EDtLCZYLVYfCnLv1msbsfbcC4wsfPTss=;
	h=Date:From:To:Cc:Subject:From;
	b=aci+aISzd4JecodwFwT88niBcJcm8fsTJs9RWZpAizzef2jgaxphDPM/Jd3GBmzxd
	 2gZd0V/+YE5IwRlrk2+xMautGnY9B1sObVAiMSpia1VURC2qSKhD8DXCIcrtnLP0z8
	 5CdalWS0n57BaTij+r9ATa4TCB5CGxwxKNHL1c2uTKgPE5fNDHzrRKgLQhZuKy0FjM
	 r3rUwiCnhJ71as/Mu/pZYaDBE6tFNTyGx5MWWRA7ORD+c4NVFEdDA7oVCDskFDBhQx
	 e7mI77b/i5IRge7QNi51uBaickm2Ry8J6C0JwTYJbybciq/PqfIgNA3rsBqWOe0FZB
	 GW5pbRtQVkJRA==
Date: Fri, 30 May 2025 14:11:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.16
Message-ID: <aDmght5YpHmJ6qZ2@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please note that I alread sent you the fixes branch for v6.15-rc7, thus
the actual merge diff-stat you will get is different from the one below.
With that in mind:

The following changes since commit a5806cd506af5a7c19bcd596e4708b5c464bfd21:

  Linux 6.15-rc7 (2025-05-18 13:57:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.16

for you to fetch changes up to 879b141b7cfa09763f932f15f19e9bc0bcb020d5:

  Merge branches 'fixes', 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 'fsl/pamu', 'mediatek', 'renesas/ipmmu', 's390', 'intel/vt-d', 'amd/amd-vi' and 'core' into next (2025-05-23 17:14:32 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v6.16:

Including:

	- Core:
	  - Introduction of iommu-pages infrastructure to consolitate page-table
	    allocation code among hardware drivers. This is ground-work for more
	    generalization in the future.
	  - Remove IOMMU_DEV_FEAT_SVA and IOMMU_DEV_FEAT_IOPF feature flags.
	  - Convert virtio-iommu to domain_alloc_paging().
	  - KConfig cleanups.
	  - Some small fixes for possible overflows and race conditions.

	- Intel VT-d driver:
	   - Restore WO permissions on second-level paging entries.
	   - Use ida to manage domain id.
	   - Miscellaneous cleanups.

	- AMD-Vi:
	  - Make sure notifiers finish running before module unload.
	  - Add support for HTRangeIgnore feature.
	  - Allow matching ACPI HID devices without matching UIDs.

	- ARM-SMMU:
	  - SMMUv2:
	    - Recognise the compatible string for SAR2130P MDSS in the Qualcomm
	      driver, as this device requires an identity domain.
	    - Fix Adreno stall handling so that GPU debugging is more robust and
	      doesn't e.g. result in deadlock.
	  - SMMUv3:
	    - Fix ->attach_dev() error reporting for unrecognised domains.
	  - IO-pgtable:
	    - Allow clients (notably, drivers that process requests from
	      userspace) to silence warnings when mapping an already-mapped IOVA.

	- S390:
	  - Add support for additional table regions.

	- Mediatek:
	  - Add support for MT6893 MM IOMMU.

	- Some smaller fixes and improvements in various other drivers.

----------------------------------------------------------------
AngeloGioacchino Del Regno (3):
      dt-bindings: iommu: mediatek: Add binding for MT6893 MM IOMMU
      iommu/mediatek: Add support for Dimensity 1200 MT6893 MM IOMMU
      iommu/mediatek: Fix compatible typo for mediatek,mt6893-iommu-mm

Arnd Bergmann (2):
      iommu: ipmmu-vmsa: avoid Wformat-security warning
      iommu/io-pgtable-arm: dynamically allocate selftest device struct

Chen Ni (1):
      iommu: apple-dart: Remove unnecessary NULL check before free_io_pgtable_ops()

Colin Ian King (1):
      iommu/fsl_pamu: remove trailing space after \n

Connor Abbott (3):
      iommu/arm-smmu-qcom: Enable threaded IRQ for Adreno SMMUv2/MMU500
      iommu/arm-smmu: Move handing of RESUME to the context fault handler
      iommu/arm-smmu-qcom: Make set_stall work when the device is on

Dmitry Baryshkov (1):
      iommu/arm-smmu-qcom: Add SAR2130P MDSS compatible

Jason Gunthorpe (33):
      iommu/terga: Do not use struct page as the handle for as->pd memory
      iommu/tegra: Do not use struct page as the handle for pts
      iommu/pages: Remove __iommu_alloc_pages()/__iommu_free_pages()
      iommu/pages: Make iommu_put_pages_list() work with high order allocations
      iommu/pages: Remove the order argument to iommu_free_pages()
      iommu/pages: Remove iommu_free_page()
      iommu/pages: De-inline the substantial functions
      iommu/pages: Formalize the freelist API
      iommu/riscv: Convert to use struct iommu_pages_list
      iommu/amd: Convert to use struct iommu_pages_list
      iommu: Change iommu_iotlb_gather to use iommu_page_list
      iommu/pages: Remove iommu_put_pages_list_old and the _Generic
      iommu/pages: Move from struct page to struct ioptdesc and folio
      iommu/pages: Move the __GFP_HIGHMEM checks into the common code
      iommu/pages: Allow sub page sizes to be passed into the allocator
      iommu/amd: Change rlookup, irq_lookup, and alias to use kvalloc()
      iommu/amd: Use roundup_pow_two() instead of get_order()
      iommu/riscv: Update to use iommu_alloc_pages_node_lg2()
      iommu: Update various drivers to pass in lg2sz instead of order to iommu pages
      iommu/pages: Remove iommu_alloc_page/pages()
      iommu/pages: Remove iommu_alloc_page_node()
      iommu/amd: Use iommu_alloc_pages_node_sz() for the IRT
      iommu/vtd: Remove iommu_alloc_pages_node()
      iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
      iommu: Remove IOMMU_DEV_FEAT_SVA
      iommu/virtio: Break out bypass identity support into a global static
      iommu: Add domain_alloc_identity()
      iommu/virtio: Move to domain_alloc_paging()
      iommu: Do not call domain_alloc() in iommu_sva_domain_alloc()
      iommu: Hide ops.domain_alloc behind CONFIG_FSL_PAMU
      iommu: Protect against overflow in iommu_pgsize()
      iommu/vt-d: Restore WO permissions on second-level paging entries
      iommu: Clear the freelist after iommu_put_pages_list()

Joerg Roedel (1):
      Merge branches 'fixes', 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 'fsl/pamu', 'mediatek', 'renesas/ipmmu', 's390', 'intel/vt-d', 'amd/amd-vi' and 'core' into next

Lu Baolu (11):
      iommu/vt-d: Put iopf enablement in domain attach path
      iommufd/selftest: Put iopf enablement in domain attach path
      dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
      uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
      iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
      iommu: Remove iommu_dev_enable/disable_feature()
      iommu: Allow attaching static domains in iommu_attach_device_pasid()
      iommu: Cleanup comments for dev_enable/disable_feat
      iommu/vt-d: Use ida to manage domain id
      iommu/vt-d: Replace spin_lock with mutex to protect domain ida
      iommu/vt-d: Restore context entry setup order for aliased devices

Mario Limonciello (1):
      iommu/amd: Allow matching ACPI HID devices without matching UIDs

Matthew Rosato (5):
      iommu/s390: set appropriate IOTA region type
      iommu/s390: support cleanup of additional table regions
      iommu/s390: support iova_to_phys for additional table regions
      iommu/s390: support map/unmap for additional table regions
      iommu/s390: allow larger region tables

Qinxin Xia (1):
      iommu/arm-smmu-v3: Fix incorrect return in arm_smmu_attach_dev

Rob Clark (1):
      iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()

Robin Murphy (3):
      iommu: Avoid introducing more races
      iommu: Split out and tidy up Arm Kconfig
      iommu: Handle yet another race around registration

Rolf Eike Beer (5):
      iommu: remove duplicate selection of DMAR_TABLE
      iommu: make inclusion of intel directory conditional
      iommu: make inclusion of amd directory conditional
      iommu: make inclusion of riscv directory conditional
      iommu: make inclusion of arm/arm-smmu-v3 directory conditional

Sairaj Kodilkar (1):
      iommu/amd: Add support for HTRangeIgnore feature

Sean Christopherson (1):
      iommu/amd: Ensure GA log notifier callbacks finish running before module unload

Tushar Dave (1):
      iommu: Skip PASID validation for devices without PASID capability

Wei Wang (2):
      iommu/vt-d: Eliminate pci_physfn() in dmar_find_matched_satc_unit()
      iommu/vt-d: Change dmar_ats_supported() to return boolean

 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |   4 +
 arch/s390/include/asm/pci_dma.h                    |   3 +
 drivers/accel/amdxdna/aie2_pci.c                   |  13 +-
 drivers/dma/idxd/init.c                            |  41 +--
 drivers/iommu/Kconfig                              | 158 +---------
 drivers/iommu/Makefile                             |   6 +-
 drivers/iommu/amd/Makefile                         |   2 +-
 drivers/iommu/amd/amd_iommu.h                      |   2 +
 drivers/iommu/amd/amd_iommu_types.h                |  10 +-
 drivers/iommu/amd/init.c                           |  94 +++---
 drivers/iommu/amd/io_pgtable.c                     |  38 +--
 drivers/iommu/amd/io_pgtable_v2.c                  |  12 +-
 drivers/iommu/amd/iommu.c                          |  94 +++---
 drivers/iommu/amd/ppr.c                            |   2 +-
 drivers/iommu/apple-dart.c                         |   3 +-
 drivers/iommu/arm/Kconfig                          | 144 +++++++++
 drivers/iommu/arm/Makefile                         |   3 +-
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |  86 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 138 +++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  39 +--
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   |   9 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  44 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   6 +
 drivers/iommu/dma-iommu.c                          |  11 +-
 drivers/iommu/exynos-iommu.c                       |  12 +-
 drivers/iommu/fsl_pamu_domain.c                    |   2 +-
 drivers/iommu/intel/Makefile                       |   7 +-
 drivers/iommu/intel/dmar.c                         |  14 +-
 drivers/iommu/intel/iommu.c                        | 244 ++++++---------
 drivers/iommu/intel/iommu.h                        |  62 +++-
 drivers/iommu/intel/irq_remapping.c                |  12 +-
 drivers/iommu/intel/nested.c                       |  20 +-
 drivers/iommu/intel/pasid.c                        |  13 +-
 drivers/iommu/intel/pasid.h                        |   1 -
 drivers/iommu/intel/prq.c                          |   7 +-
 drivers/iommu/intel/svm.c                          |   9 +-
 drivers/iommu/io-pgtable-arm.c                     |  58 ++--
 drivers/iommu/io-pgtable-dart.c                    |  23 +-
 drivers/iommu/iommu-pages.c                        | 119 +++++++
 drivers/iommu/iommu-pages.h                        | 195 ++++--------
 drivers/iommu/iommu-sva.c                          |  18 +-
 drivers/iommu/iommu.c                              | 150 ++++-----
 drivers/iommu/iommufd/device.c                     |  59 ++--
 drivers/iommu/iommufd/eventq.c                     |  48 +--
 drivers/iommu/iommufd/iommufd_private.h            |   6 -
 drivers/iommu/iommufd/selftest.c                   |  57 +++-
 drivers/iommu/ipmmu-vmsa.c                         |   3 +-
 drivers/iommu/mtk_iommu.c                          |  37 ++-
 drivers/iommu/riscv/Makefile                       |   2 +-
 drivers/iommu/riscv/iommu.c                        |  43 +--
 drivers/iommu/rockchip-iommu.c                     |  14 +-
 drivers/iommu/s390-iommu.c                         | 345 +++++++++++++++++++--
 drivers/iommu/sun50i-iommu.c                       |   6 +-
 drivers/iommu/tegra-smmu.c                         | 111 +++----
 drivers/iommu/virtio-iommu.c                       | 187 ++++++-----
 drivers/misc/uacce/uacce.c                         |  40 ---
 .../memory/mediatek,mt6893-memory-port.h           | 288 +++++++++++++++++
 include/linux/adreno-smmu-priv.h                   |   6 +-
 include/linux/io-pgtable.h                         |   8 +
 include/linux/iommu.h                              |  65 ++--
 61 files changed, 1884 insertions(+), 1371 deletions(-)
 create mode 100644 drivers/iommu/arm/Kconfig
 create mode 100644 drivers/iommu/iommu-pages.c
 create mode 100644 include/dt-bindings/memory/mediatek,mt6893-memory-port.h

Please pull.

Thanks,

	Joerg
