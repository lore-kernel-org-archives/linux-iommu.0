Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677836075C
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721127; cv=none; b=WSUx8j6bYETUoA57w3ZtN5pOoZVoWbu11BUVVVUY0xWhrU7qMqhuc6d4Lti5vGlCLKqSZYr7HqwsO6vWOUYvSggsnMN2soNFodzwnEYAuySpBnoHprjddBBaKb5UCSM8P6n5e/4TI/Lx0jCHfvCzgWxhV2gQBWj3Wm4l3oFGllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721127; c=relaxed/simple;
	bh=Ej/at4LARzdLkPlm2r/eXK+5rV45ZV/hJLFO0ympvVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jYbT4Z9A3MCUKyYPzLimZsgAp7HNZixv4JTjBxYPgZnIqAiz8IvWVmmzk8StTIMPs8cPTq0pUuzkAERYtw8mZsCh8o7jnQCgmmrCd4pp4IzNzKF9UmOj+owMB2iDYM/Fe1y3MJ3AytFPEC4w8lamJjmBmUNtHVekH0hbiKQpVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=YE+oNDGX; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="YE+oNDGX"
Received: from 8bytes.org (p200300f6af1d96006f43e8b67ac86e53.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:6f43:e8b6:7ac8:6e53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 947191C0A22;
	Tue, 10 Feb 2026 11:58:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1770721118;
	bh=Ej/at4LARzdLkPlm2r/eXK+5rV45ZV/hJLFO0ympvVY=;
	h=Date:From:To:Cc:Subject:From;
	b=YE+oNDGX25NLByPpaF+hdoGjR/3DJQNceHumVTNLbxsXnL+n5XJVTQRkin2oQnReE
	 vSS8Zmmj6JhquVdyM3+B45SisPJy4Z+q2avvbUTWv0wninYPxGttEWOHpPqUuQEs6m
	 2Czgakmhi8RlP7efjm3SCvwiEs2TAmrjrjpIsgJOy8pTTgHodVlo5fQ87Vu/1gNO4R
	 l26xh7q2ym6BT8U4671Owb7cRqdUqb0jTBPkz+hKGVFeBwe9mIpynjaUmYYP3cX2dZ
	 Taz+26x4E9NM1RCw4aFsMP1vyccwF5watTLgqqiIwy91EvcnuuDFohMA1pKahFkDm4
	 QwUTrJQ5bUHpQ==
Date: Tue, 10 Feb 2026 11:58:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v7.0
Message-ID: <hwokwarr475oc57disy6m44ojwpjktdwfsmfnwizi34ao75nz7@odsleyef263s>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please note that the patch from the fixes branch included in this pull request
is already part of v6.19 as I did not re-create the merge commit on-top of
v6.19. With that in mind:

The following changes since commit 18f7fcd5e69a04df57b563360b88be72471d6b62:

  Linux 6.19-rc8 (2026-02-01 14:01:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v7.0

for you to fetch changes up to ad095636604604b3574c1920260b1360c25ced6f:

  Merge branches 'fixes', 'arm/smmu/updates', 'intel/vt-d', 'amd/amd-vi' and 'core' into next (2026-02-06 11:10:40 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v7.0

Including:

	- Core changes:
	  - Rust bindings for IO-pgtable code
	  - IOMMU page allocation debugging support
	  - Disable ATS during PCI resets

	- Intel VT-d changes:
	  - Skip dev-iotlb flush for inaccessible PCIe device
	  - Flush cache for PASID table before using it
	  - Use right invalidation method for SVA and NESTED domains
	  - Ensure atomicity in context and PASID entry updates

	- AMD-Vi changes:
	  - Support for nested translations
	  - Other minor improvements

	- ARM-SMMU-v2 changes:
	  - Configure SoC-specific prefetcher settings for Qualcomm's "MDSS".

	- ARM-SMMU-v3 changes:
	  - Improve CMDQ locking fairness for pathetically small queue sizes.
	  - Remove tracking of the IAS as this is only relevant for AArch32 and
	    was causing C_BAD_STE errors.
	  - Add device-tree support for NVIDIA's CMDQV extension.
	  - Allow some hitless transitions for the 'MEV' and 'EATS' STE fields.
	  - Don't disable ATS for nested S1-bypass nested domains.
	  - Additions to the kunit selftests.

----------------------------------------------------------------
Alexander Grest (1):
      iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency

Ankit Soni (2):
      iommu/amd: move wait_on_sem() out of spinlock
      iommu/amd: serialize sequence allocation under concurrent TLB invalidations

Asahi Lina (1):
      rust: iommu: add io_pgtable abstraction

Ashish Mhetre (1):
      iommu/arm-smmu-v3: Add device-tree support for CMDQV driver

Bibek Kumar Patro (1):
      iommu/arm-smmu-qcom: Restore ACTLR settings for MDSS on sa8775p

Can Peng (1):
      iommu: simplify list initialization in iommu_create_device_direct_mappings()

Charan Teja Kalla (1):
      iommu/arm-smmu-qcom: Add actlr settings for mdss on Qualcomm platforms

Dmytro Maluka (1):
      iommu/vt-d: Flush cache for PASID table before using it

Jason Gunthorpe (3):
      iommu/arm-smmu-v3: Add update_safe bits to fix STE update sequence
      iommu/arm-smmu-v3: Mark STE MEV safe when computing the update sequence
      iommu/arm-smmu-v3: Mark EATS_TRANS safe when computing the update sequence

Jinhui Guo (2):
      iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without scalable mode
      iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in scalable mode

Joerg Roedel (1):
      Merge branches 'fixes', 'arm/smmu/updates', 'intel/vt-d', 'amd/amd-vi' and 'core' into next

Krzysztof Kozlowski (1):
      iommu/qcom: Simplify with scoped for each OF child loop

Lu Baolu (3):
      iommu/vt-d: Clear Present bit before tearing down PASID entry
      iommu/vt-d: Clear Present bit before tearing down context entry
      iommu/vt-d: Fix race condition during PASID entry replacement

Miguel Ojeda (2):
      rust: iommu: fix Rust formatting
      rust: iommu: fix `srctree` link warning

Mostafa Saleh (7):
      iommu/arm-smmu-v3: Remove IAS
      iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
      iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
      iommu: debug-pagealloc: Track IOMMU pages
      iommu: debug-pagealloc: Check mapped/unmapped kernel memory
      mm/page_ext: Add page_ext_get_from_phys()
      iommu: debug-pagealloc: Use page_ext_get_from_phys()

Nathan Chancellor (1):
      iommu/amd: Fix type of type parameter to amd_iommufd_hw_info()

Nicolin Chen (8):
      iommu: Lock group->mutex in iommu_deferred_attach()
      iommu: Tidy domain for iommu_setup_dma_ops()
      iommu: Add iommu_driver_get_domain_for_dev() helper
      iommu: Introduce pci_dev_reset_iommu_prepare/done()
      PCI: Suspend iommu function prior to resetting a device
      iommu/tegra241-cmdqv: Decouple driver from ACPI
      iommu/arm-smmu-v3-test: Add nested s1bypass/s1dssbypass coverage
      iommu/arm-smmu-v3: Do not set disable_ats unless vSTE is Translate

Rakuram Eswaran (1):
      iommu/amd: Drop incorrect NULL check for iommu in alloc_irq_table()

Suravee Suthikulpanit (14):
      iommu/amd: Add support for hw_info for iommu capability query
      iommu/amd: Rename DEV_DOMID_MASK to DTE_DOMID_MASK
      iommu/amd: Make amd_iommu_make_clear_dte() non-static inline
      iommu/amd: Introduce helper function amd_iommu_update_dte()
      iommufd: Introduce data struct for AMD nested domain allocation
      iommu/amd: Always enable GCR3TRPMode when supported.
      iommu/amd: Add support for nest parent domain allocation
      iommu/amd: Introduce struct amd_iommu_viommu
      iommu/amd: Add support for nested domain allocation
      iommu/amd: Introduce gDomID-to-hDomID Mapping and handle parent domain invalidation
      iommu/amd: Refactor persistent DTE bits programming into amd_iommu_make_clear_dte()
      iommu/amd: Refactor logic to program the host page table in DTE
      iommu/amd: Add support for nested domain attach/detach
      iommu/amd: Remove unused variable in amd_iommufd_viommu_destroy()

Viktor Kleen (1):
      iommu/vt-d: Treat PAGE_SNOOP and PWSNP separately

Wei Wang (1):
      iommupt: Do not set C-bit on MMIO backed PTEs

Yi Liu (1):
      iommu/vt-d: Flush piotlb for SVM and Nested domain

Yu Zhang (1):
      iommupt: Always add IOVA range to iotlb_gather in gather_range_pages()

 Documentation/admin-guide/kernel-parameters.txt    |   9 +
 MAINTAINERS                                        |   1 +
 drivers/iommu/Kconfig                              |  19 ++
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/amd/Kconfig                          |  10 +
 drivers/iommu/amd/Makefile                         |   1 +
 drivers/iommu/amd/amd_iommu.h                      |  33 +++
 drivers/iommu/amd/amd_iommu_types.h                |  50 +++-
 drivers/iommu/amd/init.c                           |  12 +-
 drivers/iommu/amd/iommu.c                          | 307 +++++++++++++--------
 drivers/iommu/amd/iommufd.c                        |  77 ++++++
 drivers/iommu/amd/iommufd.h                        |  20 ++
 drivers/iommu/amd/nested.c                         | 294 ++++++++++++++++++++
 drivers/iommu/arm/Kconfig                          |   1 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   |  78 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 153 +++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   6 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |  84 +-----
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  28 ++
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |   8 +-
 drivers/iommu/dma-iommu.c                          |   4 +-
 drivers/iommu/dma-iommu.h                          |   5 +-
 drivers/iommu/generic_pt/fmt/amdv1.h               |   3 +-
 drivers/iommu/generic_pt/fmt/x86_64.h              |   3 +-
 drivers/iommu/generic_pt/iommu_pt.h                |   3 +-
 drivers/iommu/intel/cache.c                        |   9 +-
 drivers/iommu/intel/iommu.c                        |  33 +--
 drivers/iommu/intel/iommu.h                        |  21 +-
 drivers/iommu/intel/nested.c                       |   9 +-
 drivers/iommu/intel/pasid.c                        | 212 ++------------
 drivers/iommu/intel/pasid.h                        |  30 +-
 drivers/iommu/iommu-debug-pagealloc.c              | 164 +++++++++++
 drivers/iommu/iommu-priv.h                         |  58 ++++
 drivers/iommu/iommu.c                              | 234 +++++++++++++++-
 drivers/pci/pci-acpi.c                             |  13 +-
 drivers/pci/pci.c                                  |  65 ++++-
 drivers/pci/quirks.c                               |  19 +-
 include/linux/iommu-debug-pagealloc.h              |  32 +++
 include/linux/iommu.h                              |  14 +
 include/linux/mm.h                                 |   5 +
 include/linux/page_ext.h                           |   6 +
 include/uapi/linux/iommufd.h                       |  39 +++
 include/uapi/linux/vfio.h                          |   4 +
 mm/page_ext.c                                      |  27 ++
 rust/bindings/bindings_helper.h                    |   3 +-
 rust/kernel/iommu/mod.rs                           |   5 +
 rust/kernel/iommu/pgtable.rs                       | 279 +++++++++++++++++++
 rust/kernel/lib.rs                                 |   1 +
 49 files changed, 1997 insertions(+), 499 deletions(-)
 create mode 100644 drivers/iommu/amd/iommufd.c
 create mode 100644 drivers/iommu/amd/iommufd.h
 create mode 100644 drivers/iommu/amd/nested.c
 create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
 create mode 100644 include/linux/iommu-debug-pagealloc.h
 create mode 100644 rust/kernel/iommu/mod.rs
 create mode 100644 rust/kernel/iommu/pgtable.rs

Please pull.

Thanks,

	Joerg
