Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1C166F33
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263473; cv=none; b=dxXTqwwCxRBb2MKP57T+4URlfDNbui1PGHy2oreqe2sv//2U9Ltp9GC3YcoLcJbpM5eQeH4EzZfpBGyeAhKmTLZsbpAFaN44R12uKI+1A/+E80speOVorFXFCdqKrsFqV3m9i3swGNlyQKK+KQ73mLlWTHmAXlNcxhu6bf1Kmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263473; c=relaxed/simple;
	bh=TaGhmULq3katz+gGyjfGdXQBWz8KzltUV/OLYFggFQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q4t9UcNudsXZJZ2Y/voHGdAoYchsJOZgBz3S7d0znitGLOvXCiA+c5jXAEpaFtVXsxE8qIrgrTBY9hd+c+anS5Wf9Su8iDtdktm2W2C20U+4ItkqPWH7eN02BfSTBgGN/AuVXh9kKEgIHkhmk9/GOga2JgMYWX0QUNRJDMogOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=kKIbZpWi; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="kKIbZpWi"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 510AF2C1D1C;
	Fri, 22 Nov 2024 09:17:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1732263468;
	bh=TaGhmULq3katz+gGyjfGdXQBWz8KzltUV/OLYFggFQQ=;
	h=Date:From:To:Cc:Subject:From;
	b=kKIbZpWi0/N9zvrTES1r4xafqg7LkBrLA+zVgnSeIs0WeApAPm2oDHED0Hr1vqgRf
	 pAX5mgxlRoEe76w/JS18X+1lB0TsqnWfn6eflmjJc2UGxbIlKxT02vjDBm+DeBdwRr
	 81H6lvdVTinZqdAP4O+h+wT/xTCJE0e/AlAE9Kv61h5AnJUUjmxfbonLj0hkYaQwKq
	 Svtjj9ctFmlHoPjFG6bghAY6q6fwiiEZ7Z8yIdys2YMJESsJ9wUNgRdpkt4Khb9QsZ
	 o3aeOkO0de9lOYZnSI5wgsSM9JPltP8BEziJl9nvCu4MHU2Ha48LJ6tIlH/ikk/KeA
	 UyyC1UNHur26w==
Date: Fri, 22 Nov 2024 09:17:47 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.13
Message-ID: <Z0A-K1MiL2CLa7Zd@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lNWcLHXsMnkJjivo"
Content-Disposition: inline


--lNWcLHXsMnkJjivo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This PR also comes with dependencies from the IOMMUFD tree via the
iommufd/arm-smmuv3-nested branch. It is possible that you already pulled
those from Jason. With that being said:

The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:

  Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.13

for you to fetch changes up to 42f0cbb2a253bcd7d4f20e80462014622f19d88e:

  Merge branches 'intel/vt-d', 'amd/amd-vi' and 'iommufd/arm-smmuv3-nested' into next (2024-11-15 09:27:43 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.13:

Including:

	- Core Updates:
	  - Convert call-sites using iommu_domain_alloc() to more specific
	    versions and remove function.
	  - Introduce iommu_paging_domain_alloc_flags().
	  - Extend support for allocating PASID-capable domains to more
	    drivers.
	  - Remove iommu_present().
	  - Some smaller improvements.

	- New IOMMU driver for RISC-V.

	- Intel VT-d Updates:
	  - Add domain_alloc_paging support.
	  - Enable user space IOPFs in non-PASID and non-svm cases.
	  - Small code refactoring and cleanups.
	  - Add domain replacement support for pasid.

	- AMD-Vi Updates:
	  - Adapt to iommu_paging_domain_alloc_flags() interface and alloc V2
	    page-tables by default.
	  - Replace custom domain ID allocator with IDA allocator.
	  - Add ops->release_domain() support.
	  - Other improvements to device attach and domain allocation code
	    paths.

	- ARM-SMMU Updates:
	  - SMMUv2:
	    - Return -EPROBE_DEFER for client devices probing before their SMMU.
	    - Devicetree binding updates for Qualcomm MMU-500 implementations.
	  - SMMUv3:
	    - Minor fixes and cleanup for NVIDIA's virtual command queue driver.
	  - IO-PGTable:
	    - Fix indexing of concatenated PGDs and extend selftest coverage.
	    - Remove unused block-splitting support.

	- S390 IOMMU:
	  - Implement support for blocking domain.

	- Mediatek IOMMU:
	  - Enable 35-bit physical address support for mt8186.

	- OMAP IOMMU driver:
	  - Adapt to recent IOMMU core changes and unbreak driver.

----------------------------------------------------------------
Andy Shevchenko (1):
      iommu/vt-d: Increase buffer size for device name

Bartosz Golaszewski (1):
      iommu/sysfs: constify the class struct

Dmitry Baryshkov (1):
      dt-bindings: iommu: arm,smmu: Add Qualcomm SAR2130P compatible

Dr. David Alan Gilbert (1):
      iommu/vt-d: Remove unused dmar_msi_read

Gan Jie (1):
      iommu/iova: Fix typo 'adderss'

Jason Gunthorpe (15):
      iommu: Remove useless flush from iommu_create_device_direct_mappings()
      iommu/amd: Fix corruption when mapping large pages from 0
      iommu: Refactor __iommu_domain_alloc()
      iommu: Introduce iommu_paging_domain_alloc_flags()
      iommu: Add new flag to explictly request PASID capable domain
      iommu: Put domain allocation in __iommu_group_alloc_blocking_domain()
      iommu: Create __iommu_alloc_identity_domain()
      vfio: Remove VFIO_TYPE1_NESTING_IOMMU
      iommu/arm-smmu-v3: Report IOMMU_CAP_ENFORCE_CACHE_COHERENCY for CANWBS
      iommu/arm-smmu-v3: Implement IOMMU_HWPT_ALLOC_NEST_PARENT
      iommu/arm-smmu-v3: Expose the arm_smmu_attach interface
      iommu/io-pgtable-arm: Remove split on unmap behavior
      iommu/io-pgtable-arm-v7s: Remove split on unmap behavior
      iommu: Add a kdoc to iommu_unmap()
      iommu/arm-smmu-v3: Make set_dev_pasid() op support replace

Jinjie Ruan (1):
      iommu/vt-d: Use PCI_DEVID() macro

Joel Granados (3):
      iommu/vt-d: Separate page request queue from SVM
      iommu/vt-d: Move IOMMU_IOPF into INTEL_IOMMU
      iommufd: Enable PRI when doing the iommufd_hwpt_alloc

Joerg Roedel (6):
      iommu: Fix prototype of iommu_paging_domain_alloc_flags()
      iommu: Restore iommu_flush_iotlb_all()
      Merge branch 'core' into amd/amd-vi
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'arm/smmu', 'mediatek', 's390', 'ti/omap', 'riscv' and 'core' into next
      Merge branches 'intel/vt-d', 'amd/amd-vi' and 'iommufd/arm-smmuv3-nested' into next

Julia Lawall (1):
      iommu: Reorganize kerneldoc parameter names

Klaus Jensen (2):
      iommu/vt-d: Remove the pasid present check in prq_event_thread
      iommu/vt-d: Drop pasid requirement for prq initialization

Konrad Adamczyk (1):
      iommu/mediatek: Add PGTABLE_PA_35_EN to mt8186 platform data

Lu Baolu (13):
      iommu: Remove iommu_present()
      remoteproc: Use iommu_paging_domain_alloc()
      media: nvidia: tegra: Use iommu_paging_domain_alloc()
      drm/nouveau/tegra: Use iommu_paging_domain_alloc()
      iommu: Remove iommu_domain_alloc()
      iommu/vt-d: Add domain_alloc_paging support
      iommu/vt-d: Remove unused domain_alloc callback
      iommu/vt-d: Enhance compatibility check for paging domain attach
      iommu/vt-d: Remove domain_update_iommu_cap()
      iommu/vt-d: Remove domain_update_iommu_superpage()
      iommu/vt-d: Refactor first_level_by_default()
      iommu/vt-d: Refine intel_iommu_domain_alloc_user()
      iommu/vt-d: Drain PRQs when domain removed from RID

Matthew Rosato (1):
      iommu/s390: Implement blocking domain

Mostafa Saleh (2):
      iommu/io-pgtable-arm: Fix stage-2 map/unmap for concatenated tables
      iommu/io-pgtable-arm: Add self test for the last page in the IAS

Nicolin Chen (5):
      iommu/tegra241-cmdqv: Staticize cmdqv_debugfs_dir
      ACPICA: IORT: Update for revision E.f
      ACPI/IORT: Support CANWBS memory access flag
      iommu/arm-smmu-v3: Support IOMMU_GET_HW_INFO via struct arm_smmu_hw_info
      iommu/tegra241-cmdqv: Fix alignment failure at max_n_shift

Pratyush Brahma (1):
      iommu/arm-smmu: Defer probe of clients after smmu device bound

Qingqing Zhou (1):
      dt-bindings: arm-smmu: document QCS615 APPS SMMU

Robin Murphy (2):
      iommu/omap: Add minimal fwnode support
      iommu: Make bus_iommu_probe() static

Tomasz Jeznach (7):
      dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
      iommu/riscv: Add RISC-V IOMMU platform device driver
      iommu/riscv: Add RISC-V IOMMU PCIe device driver
      iommu/riscv: Enable IOMMU registration and device probe.
      iommu/riscv: Device directory management.
      iommu/riscv: Command and fault queue support
      iommu/riscv: Paging domain support

Uros Bizjak (1):
      iommu/amd: Use atomic64_inc_return() in iommu.c

Vasant Hegde (20):
      iommu/amd: Do not try copy old DTE resume path
      iommu/arm-smmu-v3: Enhance domain_alloc_user() to allocate PASID capable domain
      iommu/amd: Add helper function to check GIOSUP/GTSUP
      iommu/amd: Move V2 page table support check to early_amd_iommu_init()
      iommu/amd: Separate page table setup from domain allocation
      iommu/amd: Pass page table type as param to pdom_setup_pgtable()
      iommu/amd: Enhance amd_iommu_domain_alloc_user()
      iommu/amd: Implement global identity domain
      iommu/amd/pgtbl_v2: Take protection domain lock before invalidating TLB
      iommu/amd: Use ida interface to manage protection domain ID
      iommu/amd: Remove protection_domain.dev_cnt variable
      iommu/amd: xarray to track protection_domain->iommu list
      iommu/amd: Remove unused amd_iommus variable
      iommu/amd: Do not detach devices in domain free path
      iommu/amd: Reduce domain lock scope in attach device path
      iommu/amd: Rearrange attach device code
      iommu/amd: Convert dev_data lock from spinlock to mutex
      iommu/amd: Reorder attach device code
      iommu/amd: Add ops->release_domain
      iommu/amd: Improve amd_iommu_release_device()

Will Deacon (2):
      iommu/tegra241-cmdqv: Fix unused variable warning
      Merge branch 'for-joerg/arm-smmu/bindings' into arm/smmu

Yi Liu (13):
      iommu/vt-d: Drop s1_pgtbl from dmar_domain
      iommu: Pass old domain to set_dev_pasid op
      iommu/vt-d: Add a helper to flush cache for updating present pasid entry
      iommu/vt-d: Refactor the pasid setup helpers
      iommu/vt-d: Add pasid replace helpers
      iommu/vt-d: Consolidate the struct dev_pasid_info add/remove
      iommu/vt-d: Add iommu_domain_did() to get did
      iommu/vt-d: Make intel_iommu_set_dev_pasid() to handle domain replacement
      iommu/vt-d: Limit intel_iommu_set_dev_pasid() for paging domain
      iommu/vt-d: Make intel_svm_set_dev_pasid() support domain replacement
      iommu/vt-d: Make identity_domain_set_dev_pasid() to handle domain replacement
      iommu/vt-d: Add set_dev_pasid callback for nested domain
      iommu: Make set_dev_pasid op support domain replacement

Zhenzhong Duan (2):
      iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
      iommu/vt-d: Fix checks and print in pgtable_walk()

 .../devicetree/bindings/iommu/arm,smmu.yaml        |    5 +
 .../devicetree/bindings/iommu/riscv,iommu.yaml     |  147 ++
 MAINTAINERS                                        |    9 +
 arch/s390/include/asm/pci.h                        |    4 +-
 arch/s390/pci/pci.c                                |    3 +
 arch/s390/pci/pci_debug.c                          |   10 +-
 drivers/acpi/arm64/iort.c                          |   13 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |    4 +-
 drivers/iommu/Kconfig                              |   10 +
 drivers/iommu/Makefile                             |    2 +-
 drivers/iommu/amd/amd_iommu.h                      |   11 +-
 drivers/iommu/amd/amd_iommu_types.h                |   23 +-
 drivers/iommu/amd/init.c                           |   63 +-
 drivers/iommu/amd/io_pgtable.c                     |   11 +-
 drivers/iommu/amd/io_pgtable_v2.c                  |    3 +
 drivers/iommu/amd/iommu.c                          |  495 +++---
 drivers/iommu/amd/pasid.c                          |    6 +-
 drivers/iommu/arm/arm-smmu-v3/Makefile             |    1 +
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c    |   31 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |    5 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        |   97 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |   45 +-
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c     |    7 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |   27 +-
 drivers/iommu/intel/Kconfig                        |    2 +-
 drivers/iommu/intel/Makefile                       |    2 +-
 drivers/iommu/intel/dmar.c                         |   15 +-
 drivers/iommu/intel/iommu.c                        |  576 +++----
 drivers/iommu/intel/iommu.h                        |   56 +-
 drivers/iommu/intel/irq_remapping.c                |    4 +-
 drivers/iommu/intel/nested.c                       |   53 +-
 drivers/iommu/intel/pasid.c                        |  409 +++--
 drivers/iommu/intel/pasid.h                        |   22 +-
 drivers/iommu/intel/prq.c                          |  396 +++++
 drivers/iommu/intel/svm.c                          |  433 +----
 drivers/iommu/io-pgtable-arm-v7s.c                 |  149 +-
 drivers/iommu/io-pgtable-arm.c                     |  114 +-
 drivers/iommu/iommu-sysfs.c                        |    2 +-
 drivers/iommu/iommu.c                              |  263 ++--
 drivers/iommu/iommufd/hw_pagetable.c               |    3 +-
 drivers/iommu/iommufd/vfio_compat.c                |    7 +-
 drivers/iommu/iova.c                               |    2 +-
 drivers/iommu/mtk_iommu.c                          |    2 +-
 drivers/iommu/omap-iommu.c                         |   26 +-
 drivers/iommu/riscv/Kconfig                        |   20 +
 drivers/iommu/riscv/Makefile                       |    3 +
 drivers/iommu/riscv/iommu-bits.h                   |  784 +++++++++
 drivers/iommu/riscv/iommu-pci.c                    |  120 ++
 drivers/iommu/riscv/iommu-platform.c               |   92 ++
 drivers/iommu/riscv/iommu.c                        | 1661 ++++++++++++++++++++
 drivers/iommu/riscv/iommu.h                        |   88 ++
 drivers/iommu/s390-iommu.c                         |   73 +-
 drivers/media/platform/nvidia/tegra-vde/iommu.c    |    7 +-
 drivers/remoteproc/remoteproc_core.c               |    6 +-
 drivers/vfio/vfio_iommu_type1.c                    |   12 +-
 include/acpi/actbl2.h                              |    3 +-
 include/linux/dmar.h                               |    1 -
 include/linux/iommu.h                              |   30 +-
 include/uapi/linux/iommufd.h                       |   43 +
 include/uapi/linux/vfio.h                          |    2 +-
 60 files changed, 4797 insertions(+), 1716 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
 create mode 100644 drivers/iommu/intel/prq.c
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h

Please pull.

Thanks,

	Joerg

--lNWcLHXsMnkJjivo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmdAPisACgkQK/BELZcB
GuOXTRAA0UoLAr0nXC4jEJ/XDLxUX4lU9Td+TaMNdKaHAR1osCgAUucPFQKLqKq9
oOHpWl7GNp+edyPQeEKMjhhXQV//1l8CXMpoqYU2cAOy7ok+sWdrkEFhoYk8JTm/
DD21QdcMdoStP50aYoCyLEsV/AKENMejYlEAllMxuMMSWHw0/n8gwn9bnYW8CJ13
ZW6x8bhttUL5RNyZ04MWmTrObLJBJOBC8AtOavIdfMy1SJpNTft7uyte5RQwWNo7
lX+KRY9LRGCEU5C4Ca4JbHZiy30+hcMvqzQXIyjN+INhy1uRdKn9wCBJxhSDpg+P
KyHQ/XYgKnwVxqsdCBj+zM4iWqbVcqb/DCy2XctQGLO7dNDphY4lEyawXbGp7grZ
FNL6QbUfYfz+eMm0YhW6UUuw2w6rYK/tg59P9iJwbFIBsF4wIEQyVxQNoocq5W82
U682XP4lMF7LAm1Gcc1rHt+89vM15OWcCUaJsgMCEr+sjbFS6R1r7VtWXoCnjJkK
6uEM9fXqdHhBjijLbQrmXbtulEP0JcUERd6wSx8zRSTq+hsBB3B0BKB7ARhXpASa
pzUkOG+rDLOQXUJvDHLXA0xZh18tGDy1XaTvWhYH3ynEXriYUKbyOx+CkOyAjMui
1bERmMrdY64VniUOV16aYND5BfjDUQpVQBnP1ohwfg7/xJPp148=
=/8BZ
-----END PGP SIGNATURE-----

--lNWcLHXsMnkJjivo--
