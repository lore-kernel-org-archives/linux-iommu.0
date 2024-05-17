Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DFD39FC1
	for <iommu@lists.linux.dev>; Fri, 17 May 2024 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715939865; cv=none; b=Ypk9xUgtADnDgH4GHMacOZe1feuwuRn4B8u7Rg3UVRPoNZxnIK4T2LExQKl2JXnFbhaGN3MeeCy9wV7G2km57/EmKzLBeZcq4m0X5/S04Nms/FgEWm5gklmeb5yo9/iMQRU57byUAVVlwiVVxtiqttZp1YM8Ogw0vPJ+5+TTOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715939865; c=relaxed/simple;
	bh=Q59QUcYATVoiGnVZA4Y30AzDdBYL5H61GMjEm6yTfSU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mnwtu7qRnYXFLu6lw+XDJyMdqmOK8F3NEFL1LEr+xCd+72XmR+XdyssvlOG7u8JXZQ78ffKYeK4iLVV70l7121cq0EOyu6O+GCCcsB9/iLvpTgmlMLNQXGFLnAUtYdtqo255EFcg9paXs1jyQ5yNR0wZLbxynkyN2iTE9dxbNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=P3HZANmW; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="P3HZANmW"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 52B511C0B67;
	Fri, 17 May 2024 11:57:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1715939856;
	bh=Q59QUcYATVoiGnVZA4Y30AzDdBYL5H61GMjEm6yTfSU=;
	h=Date:From:To:Cc:Subject:From;
	b=P3HZANmW0HH9Lc7KLo9yS+wowd4UBo+GuETRE1CZHiVQ1uz+uvNAPV1J7Xp0+OWQR
	 vQ/7aQiM/8z2ZfHoJHjNH05ON+zEQHk+wrSqa1PE0kFsYGV5553C1tZnZH+/wweviM
	 GpbhLDSmu+TQJPKRtDIkQK8WIeOtnMbLacedOpUKRQORD1+FuIjKO+fkICttDi+IKD
	 boxv2Os08eV//mBfTQF8rxBjy1U+bUKUmZjXk/xHlpK+byp2e8iVNmMWfihlQlzZZa
	 vbS1oJ2H/xrx1aXKr+rAnsen9oM4fAbD4G3nc2+P0nO9bZciYLyaC8U2s/hR2qaLxq
	 /9apKzHdBPOBA==
Date: Fri, 17 May 2024 11:57:34 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.10
Message-ID: <ZkcqDrFmd4ZHv7Qf@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

There is a small and easy to resolve conflict with these changes in
drivers/acpi/scan.c. Please take the version that comes from the iommu
tree.  With this being said:

The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v6.10

for you to fetch changes up to 2bd5059c6cc04b02073d4d9f57137ab74e1d8e7a:

  Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'core' and 'x86/vt-d' into next (2024-05-13 14:06:54 +0200)

----------------------------------------------------------------
IOMMU Updates for Linux v6.10

Including:

	- Core:
	  - IOMMU memory usage observability - This will make the memory used
	    for IO page tables explicitly visible.
	  - Simplify arch_setup_dma_ops()

	- Intel VT-d:
	  - Consolidate domain cache invalidation
	  - Remove private data from page fault message
	  - Allocate DMAR fault interrupts locally
	  - Cleanup and refactoring

	- ARM-SMMUv2:
	  - Support for fault debugging hardware on Qualcomm implementations
	  - Re-land support for the ->domain_alloc_paging() callback

	- ARM-SMMUv3:
	  - Improve handling of MSI allocation failure
	  - Drop support for the "disable_bypass" cmdline option
	  - Major rework of the CD creation code, following on directly from the
	    STE rework merged last time around.
	  - Add unit tests for the new STE/CD manipulation logic

	- AMD-Vi:
	  - Final part of SVA changes with generic IO page fault handling

	- Renesas IPMMU:
	  - Add support for R8A779H0 hardware

	- A couple smaller fixes and updates across the sub-tree

----------------------------------------------------------------
Aleksandr Aprelkov (1):
      iommu/arm-smmu-v3: Free MSIs in case of ENOMEM

Andy Shevchenko (1):
      iommu/amd: Fix compilation error

Colin Ian King (1):
      iommu/vt-d: Remove redundant assignment to variable err

Dimitri Sivanich (1):
      iommu/vt-d: Allocate DMAR fault interrupts locally

Georgi Djakov (5):
      dt-bindings: iommu: Add Qualcomm TBU
      iommu/arm-smmu-qcom-debug: Add support for TBUs
      iommu/arm-smmu: Allow using a threaded handler for context interrupts
      iommu/arm-smmu-qcom: Use a custom context fault handler for sdm845
      iommu/arm-smmu-qcom: Use the custom fault handler on more platforms

Jason Gunthorpe (16):
      iommu/arm-smmu-v3: Do not allow a SVA domain to be set on the wrong PASID
      iommu/arm-smmu-v3: Do not ATC invalidate the entire domain
      iommu/arm-smmu-v3: Add a type for the CD entry
      iommu/arm-smmu: Convert to domain_alloc_paging()
      iommu: Add ops->domain_alloc_sva()
      iommu: Add ops->domain_alloc_sva()
      iommu/arm-smmu-v3: Add an ops indirection to the STE code
      iommu/arm-smmu-v3: Make CD programming use arm_smmu_write_entry()
      iommu/arm-smmu-v3: Move the CD generation for S1 domains into a function
      iommu/arm-smmu-v3: Consolidate clearing a CD table entry
      iommu/arm-smmu-v3: Make arm_smmu_alloc_cd_ptr()
      iommu/arm-smmu-v3: Allocate the CD table entry in advance
      iommu/arm-smmu-v3: Move the CD generation for SVA into a function
      iommu/arm-smmu-v3: Build the whole CD in arm_smmu_make_s1_cd()
      iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry
      iommu/arm-smmu-v3: Make the kunit into a module

Jingqi Liu (2):
      iommu/vt-d: Remove debugfs use of private data field
      iommu/vt-d: Remove private data use in fault message

Joerg Roedel (4):
      Merge branch 'iommu/fixes' into x86/amd
      Merge branch 'memory-observability' into x86/amd
      Merge tag 'arm-smmu-updates' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into arm/smmu
      Merge branches 'arm/renesas', 'arm/smmu', 'x86/amd', 'core' and 'x86/vt-d' into next

Lu Baolu (13):
      iommu/vt-d: Remove caching mode check before device TLB flush
      iommu/vt-d: Add cache tag assignment interface
      iommu/vt-d: Add cache tag invalidation helpers
      iommu/vt-d: Add trace events for cache tag interface
      iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
      iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
      iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map
      iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
      iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
      iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
      iommu/vt-d: Remove intel_svm_dev
      iommu/vt-d: Remove struct intel_svm
      iommu/vt-d: Decouple igfx_off from graphic identity mapping

Pasha Tatashin (11):
      iommu/vt-d: add wrapper functions for page allocations
      iommu/dma: use iommu_put_pages_list() to releae freelist
      iommu/amd: use page allocation function provided by iommu-pages.h
      iommu/io-pgtable-arm: use page allocation function provided by iommu-pages.h
      iommu/io-pgtable-dart: use page allocation function provided by iommu-pages.h
      iommu/exynos: use page allocation function provided by iommu-pages.h
      iommu/rockchip: use page allocation function provided by iommu-pages.h
      iommu/sun50i: use page allocation function provided by iommu-pages.h
      iommu/tegra-smmu: use page allocation function provided by iommu-pages.h
      iommu: observability of the IOMMU allocations
      iommu: account IOMMU allocated memory

Robin Murphy (9):
      iommu/arm-smmu-v3: Retire disable_bypass parameter
      OF: Retire dma-ranges mask workaround
      OF: Simplify DMA range calculations
      ACPI/IORT: Handle memory address size limits as limits
      dma-mapping: Add helpers for dma_range_map bounds
      iommu/dma: Make limit checks self-contained
      iommu/dma: Centralise iommu_setup_dma_ops()
      dma-mapping: Simplify arch_setup_dma_ops()
      arm64: Properly clean up iommu-dma remnants

Suravee Suthikulpanit (3):
      iommu/amd: Move PPR-related functions into ppr.c
      iommu/amd: Define per-IOMMU iopf_queue
      iommu/amd: Add support for page response

Thanh Le (1):
      dt-bindings: iommu: renesas,ipmmu-vmsa: add r8a779h0 support

Uros Bizjak (1):
      iommu/vt-d: Use try_cmpxchg64{,_local}() in iommu.c

Vasant Hegde (10):
      iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_pasid_supported()
      iommu/amd: Introduce per device DTE update function
      iommu/amd: Fix PPR interrupt processing logic
      iommu/amd: Introduce iommu_dev_data.max_pasids
      iommu/amd: Setup GCR3 table in advance if domain is SVA capable
      iommu/amd: Enable PCI features based on attached domain capability
      iommu/amd: Add support for enable/disable IOPF
      iommu/amd: Initial SVA support for AMD IOMMU
      iommu/amd: Add SVA domain support
      iommu/amd: Enable Guest Translation after reading IOMMU feature register

Wei Huang (2):
      iommu/amd: Add support for enabling/disabling IOMMU features
      iommu/amd: Add IO page fault notifier handler

Will Deacon (1):
      iommu/arm-smmu-qcom: Don't build debug features as a kernel module

Yi Liu (2):
      iommu: Undo pasid attachment only for the devices that have succeeded
      iommu: Pass domain to remove_dev_pasid() op

 Documentation/admin-guide/cgroup-v2.rst            |   2 +-
 .../devicetree/bindings/iommu/qcom,tbu.yaml        |  69 +++
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   1 +
 Documentation/filesystems/proc.rst                 |   4 +-
 arch/arc/mm/dma.c                                  |   3 +-
 arch/arm/mm/dma-mapping-nommu.c                    |   3 +-
 arch/arm/mm/dma-mapping.c                          |  16 +-
 arch/arm64/Kconfig                                 |   1 -
 arch/arm64/mm/dma-mapping.c                        |  13 +-
 arch/loongarch/kernel/dma.c                        |   9 +-
 arch/mips/mm/dma-noncoherent.c                     |   3 +-
 arch/riscv/mm/dma-noncoherent.c                    |   3 +-
 drivers/acpi/arm64/dma.c                           |  17 +-
 drivers/acpi/arm64/iort.c                          |  20 +-
 drivers/acpi/scan.c                                |   7 +-
 drivers/hv/hv_common.c                             |   6 +-
 drivers/iommu/Kconfig                              |  25 +-
 drivers/iommu/amd/Kconfig                          |   3 +
 drivers/iommu/amd/Makefile                         |   2 +-
 drivers/iommu/amd/amd_iommu.h                      |  60 ++-
 drivers/iommu/amd/amd_iommu_types.h                |  33 ++
 drivers/iommu/amd/init.c                           | 177 +++----
 drivers/iommu/amd/io_pgtable.c                     |  13 +-
 drivers/iommu/amd/io_pgtable_v2.c                  |  18 +-
 drivers/iommu/amd/iommu.c                          | 302 +++++++----
 drivers/iommu/amd/pasid.c                          | 198 +++++++
 drivers/iommu/amd/ppr.c                            | 288 +++++++++++
 drivers/iommu/arm/arm-smmu-v3/Makefile             |   2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 168 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c   | 468 +++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 568 +++++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |  60 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   | 496 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   8 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |   2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  20 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |   3 +
 drivers/iommu/dma-iommu.c                          |  46 +-
 drivers/iommu/dma-iommu.h                          |  14 +-
 drivers/iommu/exynos-iommu.c                       |  14 +-
 drivers/iommu/intel/Makefile                       |   2 +-
 drivers/iommu/intel/cache.c                        | 419 +++++++++++++++
 drivers/iommu/intel/debugfs.c                      |   7 -
 drivers/iommu/intel/dmar.c                         |  26 +-
 drivers/iommu/intel/iommu.c                        | 383 +++-----------
 drivers/iommu/intel/iommu.h                        |  88 +++-
 drivers/iommu/intel/irq_remapping.c                |  16 +-
 drivers/iommu/intel/nested.c                       |  69 +--
 drivers/iommu/intel/pasid.c                        |  18 +-
 drivers/iommu/intel/perf.h                         |   1 -
 drivers/iommu/intel/svm.c                          | 383 ++++----------
 drivers/iommu/intel/trace.h                        |  97 ++++
 drivers/iommu/io-pgtable-arm.c                     |  15 +-
 drivers/iommu/io-pgtable-dart.c                    |  37 +-
 drivers/iommu/iommu-pages.h                        | 186 +++++++
 drivers/iommu/iommu-sva.c                          |  16 +-
 drivers/iommu/iommu.c                              |  48 +-
 drivers/iommu/irq_remapping.c                      |   5 +-
 drivers/iommu/irq_remapping.h                      |   2 +-
 drivers/iommu/rockchip-iommu.c                     |  14 +-
 drivers/iommu/s390-iommu.c                         |   6 -
 drivers/iommu/sun50i-iommu.c                       |   7 +-
 drivers/iommu/tegra-smmu.c                         |  18 +-
 drivers/iommu/virtio-iommu.c                       |  10 -
 drivers/of/device.c                                |  42 +-
 include/linux/acpi_iort.h                          |   4 +-
 include/linux/dma-direct.h                         |  18 +
 include/linux/dma-map-ops.h                        |   6 +-
 include/linux/dmar.h                               |   2 +-
 include/linux/iommu.h                              |  16 +-
 include/linux/mmzone.h                             |   5 +-
 mm/vmstat.c                                        |   3 +
 72 files changed, 3536 insertions(+), 1598 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,tbu.yaml
 create mode 100644 drivers/iommu/amd/pasid.c
 create mode 100644 drivers/iommu/amd/ppr.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
 create mode 100644 drivers/iommu/intel/cache.c
 create mode 100644 drivers/iommu/iommu-pages.h

Please pull.

Thanks,

	Joerg
