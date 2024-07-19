Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AC7E1;
	Fri, 19 Jul 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388103; cv=none; b=Pj3D/xfEGaURjotcbfSYm3xImXWgo9fvQmoWdMVg44XUtIawQP5S8OUbjbEPe6fHXNF12CFBGEbA7+3+A3Nv+6WEwPpSQ9+CuFgDB77m6gpFKoO82/LXrQi21cdD4eGTVEgsOh2WUDYS37LOrKPmgkAL4eDNMJMEiMYN9jYjXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388103; c=relaxed/simple;
	bh=eZ+obv4Ku3pmovISvlAxpXKfThcg4XzyQw8gPNi8Vic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X/Bl6xxNZpKfWGhee2WSEXNZAhqEUkjHmSAz9MPBhunP1e3skPdctVmsEVqAZdV42JskvwBj/5LdXFEMhSFOb2MHVlQBI0CWbjI1VwZtQZamvKz2Zbzzq/fN/uk5Gyq02iF52XE06Cy5eB8iWtk7qnTU5GjGYDT+/2WCwyZhnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsejdBNd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsejdBNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3B5C32782;
	Fri, 19 Jul 2024 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721388102;
	bh=eZ+obv4Ku3pmovISvlAxpXKfThcg4XzyQw8gPNi8Vic=;
	h=Date:From:To:Cc:Subject:From;
	b=KsejdBNdcq2CmF+fNU8Ad0GAzaR1XMiaA9/nmxOcIDMMW7xb7oevyO1ud+Qewbapx
	 KMHxVz1/6PcL40POGKBzH23B9NQifLcoTc2x6jBjxGcmjLts8aXJNJE1P6PmvCLcwF
	 J00Q7gsN3o4dVWvE0dTV/4wQCFtzINSUUpifo/BOvFmZvSw0K2Gv5wY9UXL56c2LKz
	 SZy3xekLid50OgCMAY0Owoe3bQKdTV+6PwaTyUY/Az8MS/e3T8HzJG1wbmUKHo5si5
	 lwEWFcURKNwisl8QnJeTuHaE5SwVyZ5P1tdgwjjwJmfjpOqFCdAxv90+NqXAMsoQ7N
	 LH40DeunWV4zQ==
Date: Fri, 19 Jul 2024 12:21:38 +0100
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] IOMMU Updates for Linux v6.11
Message-ID: <20240719112138.GA22869@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull these IOMMU updates for v6.11.

I've been looking after the IOMMU tree in Joerg's absence [1] for the
past few weeks and I was expecting him back at the start of this week to
send the pull. However, I've not heard from him at all and figured that
I may as well send this now rather than wait until the second week of
the merge window.

A few minor fixes have started showing up too, so I may end up sending
you a follow-up next week anyway.

A summary of all the changes is included in the tag.

Cheers,

Will

[1] https://lore.kernel.org/r/Zn6xFZanlWhN5kw3@8bytes.org

--->8

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.11

for you to fetch changes up to 8b6c32e831ef4496b51a68ddc5be9bb9e8d2337d:

  Merge branch 'iommu/iommufd/paging-domain-alloc' into iommu/next (2024-07-12 16:57:47 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.11

- Core:
  * Support for the "ats-supported" device-tree property.

  * Removal of the 'ops' field from 'struct iommu_fwspec'.

  * Introduction of iommu_paging_domain_alloc() and partial conversion
    of existing users.

  * Introduce 'struct iommu_attach_handle' and provide corresponding
    IOMMU interfaces which will be used by the IOMMUFD subsystem.

  * Remove stale documentation.

  * Add missing MODULE_DESCRIPTION() macro.

  * Misc cleanups.

- Allwinner Sun50i:
  * Ensure bypass mode is disabled on H616 SoCs.

  * Ensure page-tables are allocated below 4GiB for the 32-bit
    page-table walker.

  * Add new device-tree compatible strings.

- AMD Vi:
  * Use try_cmpxchg64() instead of cmpxchg64() when updating pte.

- Arm SMMUv2:
  * Print much more useful information on context faults.

  * Fix Qualcomm TBU probing when CONFIG_ARM_SMMU_QCOM_DEBUG=n.

  * Add new Qualcomm device-tree bindings.

- Arm SMMUv3:
  * Support for hardware update of access/dirty bits and reporting via
    IOMMUFD.

  * More driver rework from Jason, this time updating the PASID/SVA support
    to prepare for full IOMMUFD support.

  * Add missing MODULE_DESCRIPTION() macro.

  * Minor fixes and cleanups.

- NVIDIA Tegra:

  * Fix for benign fwspec initialisation issue exposed by rework on the
    core branch.

- Intel VT-d:

  * Use try_cmpxchg64() instead of cmpxchg64() when updating pte.

  * Use READ_ONCE() to read volatile descriptor status.

  * Remove support for handling Execute-Requested requests.

  * Avoid calling iommu_domain_alloc().

  * Minor fixes and refactoring.

- Qualcomm MSM:

  * Updates to the device-tree bindings.

----------------------------------------------------------------
Akhil P Oommen (1):
      dt-bindings: arm-smmu: Add X1E80100 GPU SMMU

Andre Przywara (3):
      iommu: sun50i: allocate page tables from below 4 GiB
      dt-bindings: iommu: add new compatible strings
      iommu: sun50i: Add H616 compatible string

Andy Shevchenko (1):
      iommu/arm-smmu-v3: Use *-y instead of *-objs in Makefile

Bjorn Andersson (1):
      dt-bindings: arm-smmu: Fix Qualcomm SC8180X binding

David Heidelberg (1):
      dt-bindings: iommu: Convert msm,iommu-v0 to yaml

Georgi Djakov (1):
      iommu/arm-smmu-qcom: Register the TBU driver in qcom_smmu_impl_init

Jacob Pan (1):
      iommu/vt-d: Handle volatile descriptor status read

Jason Gunthorpe (16):
      iommu/arm-smmu-v3: Convert to domain_alloc_sva()
      iommu/arm-smmu-v3: Start building a generic PASID layer
      iommu/arm-smmu-v3: Make smmu_domain->devices into an allocated list
      iommu/arm-smmu-v3: Make changing domains be hitless for ATS
      iommu/arm-smmu-v3: Add ssid to struct arm_smmu_master_domain
      iommu/arm-smmu-v3: Do not use master->sva_enable to restrict attaches
      iommu/arm-smmu-v3: Thread SSID through the arm_smmu_attach_*() interface
      iommu/arm-smmu-v3: Make SVA allocate a normal arm_smmu_domain
      iommu/arm-smmu-v3: Keep track of arm_smmu_master_domain for SVA
      iommu/arm-smmu-v3: Put the SVA mmu notifier in the smmu_domain
      iommu/arm-smmu-v3: Allow IDENTITY/BLOCKED to be set while PASID is used
      iommu/arm-smmu-v3: Test the STE S1DSS functionality
      iommu/arm-smmu-v3: Allow a PASID to be set when RID is IDENTITY/BLOCKED
      iommu/arm-smmu-v3: Allow setting a S1 domain to a PASID
      iommu/arm-smmu-v3: Do not zero the strtab twice
      iommu/arm-smmu-v3: Shrink the strtab l1_desc array

Jean-Philippe Brucker (4):
      iommu/arm-smmu-v3: Add feature detection for HTTU
      dt-bindings: PCI: generic: Add ats-supported property
      iommu/of: Support ats-supported device-tree property
      arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP

Jeff Johnson (2):
      iommu/iova: Add missing MODULE_DESCRIPTION() macro
      iommu/arm-smmu-v3: add missing MODULE_DESCRIPTION() macro

Jernej Skrabec (1):
      iommu: sun50i: clear bypass register

Joao Martins (1):
      iommu/arm-smmu-v3: Add support for dirty tracking in domain alloc

Jon Pan-Doh (1):
      iommu/vt-d: Fix identity map bounds in si_domain_init()

Kunkun Jiang (1):
      iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping

Lu Baolu (21):
      iommu: Make iommu_sva_domain_alloc() static
      iommu/vt-d: Remove comment for def_domain_type
      iommu/vt-d: Remove control over Execute-Requested requests
      iommu/vt-d: Downgrade warning for pre-enabled IR
      iommu/vt-d: Add helper to allocate paging domain
      iommu/vt-d: Add helper to flush caches for context change
      iommu/vt-d: Refactor PCI PRI enabling/disabling callbacks
      iommu: Introduce domain attachment handle
      iommu: Remove sva handle list
      iommu: Add attach handle to struct iopf_group
      iommu: Extend domain attach group with handle support
      iommu: Add iommu_paging_domain_alloc() interface
      iommufd: Use iommu_paging_domain_alloc()
      vfio/type1: Use iommu_paging_domain_alloc()
      vhost-vdpa: Use iommu_paging_domain_alloc()
      drm/msm: Use iommu_paging_domain_alloc()
      wifi: ath10k: Use iommu_paging_domain_alloc()
      wifi: ath11k: Use iommu_paging_domain_alloc()
      RDMA/usnic: Use iommu_paging_domain_alloc()
      iommu/vt-d: Limit max address mask to MAX_AGAW_PFN_WIDTH
      iommu/vt-d: Fix aligned pages in calculate_psi_aligned_address()

Mark-PK Tsai (1):
      docs: iommu: Remove outdated Documentation/userspace-api/iommu.rst

Mostafa Saleh (1):
      iommu/arm-smmu-v3: Avoid uninitialized asid in case of error

Neil Armstrong (1):
      dt-bindings: iommu: qcom,iommu: Add MSM8953 GPU IOMMU to SMMUv2 compatibles

Rob Clark (3):
      iommu/arm-smmu: Add CB prefix to register bitfields
      iommu/arm-smmu-qcom-debug: Do not print for handled faults
      iommu/arm-smmu: Pretty-print context fault related regs

Robin Murphy (6):
      iommu/dma: Prune redundant pgprot arguments
      iommu/mediatek-v1: Clean up redundant fwspec checks
      iommu: Resolve fwspec ops automatically
      ACPI: Retire acpi_iommu_fwspec_ops()
      OF: Simplify of_iommu_configure()
      iommu: Remove iommu_fwspec ops

Shameer Kolothum (3):
      iommu/arm-smmu-v3: Add support for domain_alloc_user fn
      iommu/io-pgtable-arm: Add read_and_clear_dirty() support
      iommu: Move IOMMU_DIRTY_NO_CLEAR define

Uros Bizjak (3):
      iommu/amd: Use try_cmpxchg64() in v2_alloc_pte()
      iommu/vt-d: Use try_cmpxchg64() in intel_pasid_get_entry()
      iommufd: Use atomic_long_try_cmpxchg() in incr_user_locked_vm()

Will Deacon (14):
      Merge branch 'for-joerg/arm-smmu/bindings' into for-joerg/arm-smmu/next
      Merge branch 'for-joerg/arm-smmu/updates' into for-joerg/arm-smmu/next
      iommu/tegra-smmu: Pass correct fwnode to iommu_fwspec_init()
      Merge branch 'iommu/allwinner/sun50i' into iommu/next
      Merge branch 'iommu/amd/amd-vi' into iommu/next
      Merge branch 'iommu/arm/smmu' into iommu/next
      Merge branch 'iommu/intel/vt-d' into iommu/next
      Merge branch 'iommu/nvidia/tegra' into iommu/next
      Merge branch 'iommu/qualcomm/msm' into iommu/next
      Merge branch 'iommu/core' into iommu/next
      Merge branch 'iommu/fwspec-ops-removal' into iommu/next
      Merge branch 'iommu/pci/ats' into iommu/next
      Merge branch 'iommu/iommufd/attach-handles' into iommu/next
      Merge branch 'iommu/iommufd/paging-domain-alloc' into iommu/next

Zhenhua Huang (1):
      iommu/arm-smmu-qcom: record reason for deferring probe

 .../bindings/iommu/allwinner,sun50i-h6-iommu.yaml  |   7 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   6 +-
 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 --
 .../bindings/iommu/qcom,apq8064-iommu.yaml         |  78 +++
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |   1 +
 .../devicetree/bindings/pci/host-generic-pci.yaml  |   6 +
 Documentation/userspace-api/index.rst              |   1 -
 Documentation/userspace-api/iommu.rst              | 209 ------
 MAINTAINERS                                        |   1 -
 arch/arm64/boot/dts/arm/fvp-base-revc.dts          |   1 +
 drivers/acpi/arm64/iort.c                          |  19 +-
 drivers/acpi/scan.c                                |  36 +-
 drivers/acpi/viot.c                                |  11 +-
 drivers/dma/idxd/init.c                            |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |   7 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |   6 +-
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/amd/io_pgtable_v2.c                  |   2 +-
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 431 +++---------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   | 117 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 759 ++++++++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  63 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c       |   2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   |  83 +--
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  42 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  77 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |  67 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   4 +-
 drivers/iommu/dma-iommu.c                          |  16 +-
 drivers/iommu/intel/cache.c                        |   3 +-
 drivers/iommu/intel/dmar.c                         |   2 +-
 drivers/iommu/intel/iommu.c                        | 196 ++++--
 drivers/iommu/intel/iommu.h                        |  19 +-
 drivers/iommu/intel/irq_remapping.c                |   4 +-
 drivers/iommu/intel/pasid.c                        | 116 +++-
 drivers/iommu/intel/pasid.h                        |  10 -
 drivers/iommu/io-pgfault.c                         |  61 +-
 drivers/iommu/io-pgtable-arm.c                     | 119 +++-
 drivers/iommu/iommu-priv.h                         |  18 +
 drivers/iommu/iommu-sva.c                          |  48 +-
 drivers/iommu/iommu.c                              | 225 ++++--
 drivers/iommu/iommufd/hw_pagetable.c               |  10 +-
 drivers/iommu/iommufd/pages.c                      |   7 +-
 drivers/iommu/iova.c                               |   1 +
 drivers/iommu/mtk_iommu_v1.c                       |  12 +-
 drivers/iommu/of_iommu.c                           |  59 +-
 drivers/iommu/sun50i-iommu.c                       |  15 +-
 drivers/iommu/tegra-smmu.c                         |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c             |   6 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |   6 +-
 drivers/of/device.c                                |  30 +-
 drivers/vfio/vfio_iommu_type1.c                    |   7 +-
 drivers/vhost/vdpa.c                               |  14 +-
 include/acpi/acpi_bus.h                            |   3 +-
 include/linux/io-pgtable.h                         |   3 +
 include/linux/iommu.h                              |  72 +-
 58 files changed, 1860 insertions(+), 1334 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,apq8064-iommu.yaml
 delete mode 100644 Documentation/userspace-api/iommu.rst
