Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422D1F418F
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000991; cv=none; b=VtyDtTpzkzE+vIj50PQhLmHgqgjamd15ehG6BEL6PfstNBNqIWkKDEMU2IApiOBAYQprQZrPMlmKFsC98zg2EHp4Zz6o2g0iBg470xkUaJxuck8GX4XSv+K+wKbVYoqbHwc108wGNgucXmT55xsBMhitQB3saRLmEpXCdlNF6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000991; c=relaxed/simple;
	bh=YEtFk1JQFtsBcNa4csbscW/Ycl71wUDecYWJHRWWilY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RkNDN7rjXk23L3qGaiXkoTId2OTy/H1OPtI3WZf9o7v34xVETD4ksbQfKvHJO8xXaw+KSMOkzXhvmFZFOVJ/V4NQ/W3+1YPaqzO8VPcO8N/OGzAqP+TYwAb7BBIQlqu0wtMzPmcNKPJEruIwv6j/Z45VnPxj0tmEvMeoNioMy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=hDR8W7Vc; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="hDR8W7Vc"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A3B2946D92;
	Wed, 26 Mar 2025 15:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1743000986;
	bh=YEtFk1JQFtsBcNa4csbscW/Ycl71wUDecYWJHRWWilY=;
	h=Date:From:To:Cc:Subject:From;
	b=hDR8W7VcSgpyhNM83m9wxIrQsuWMrX04gQtAYflldIfIAw4VlJiZ4te4q9FEk5xpg
	 fEDoiSqa3M/5wwVkF3u50V7t8vOatIbo24/KrGdTLHFuE1jC4Z3P6hX9C30N48NkXy
	 JFgyNqmvRaVktF/KHybgmGOzPko/Jb8K73p1072f/4yhjDx3pGvKtgzr5iLkJhn6Zq
	 pQT2pr55dYEYgBuLKz+DBlNNGUyvT1exeuW8dizBdZK/fM/Xp3MZnBn7WgOoMOFj53
	 YkbOtRO/hWdYjM7aQFOlrnruHRwZzEDF0Jn2rLWRiVKpDqCzf2ZuGiCyuauyN+O3CF
	 9Y1mJcE08jmTw==
Date: Wed, 26 Mar 2025 15:56:25 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [git pull] IOMMU Updates for Linux v6.15
Message-ID: <Z-QVmVGmFhromIEy@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 4701f33a10702d5fc577c32434eb62adde0a1ae1:

  Linux 6.14-rc7 (2025-03-16 12:55:17 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git tags/iommu-updates-v6.15

for you to fetch changes up to 22df63a23a9e53d06ff2c67f863e9ce1640b73cb:

  Merge branches 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 'rockchip', 's390', 'core', 'intel/vt-d' and 'amd/amd-vi' into next (2025-03-20 09:11:09 +0100)

----------------------------------------------------------------
IOMMU Updates for Linux v6.15

Including:

	- Core: IOMMUFD dependencies from Jason:
	  - Change the iommufd fault handle into an always present hwpt handle in
	    the domain
	  - Give iommufd its own SW_MSI implementation along with some IRQ layer
	    rework
	  - Improvements to the handle attach API

	- Core: Fixes for probe-issues from Robin

	- Intel VT-d changes:
	  - Checking for SVA support in domain allocation and attach paths
	  - Move PCI ATS and PRI configuration into probe paths
	  - Fix a pentential hang on reboot -f
	  - Miscellaneous cleanups

	- AMD-Vi changes:
	  - Support for up to 2k IRQs per PCI device function
	  - Set of smaller fixes

	- ARM-SMMU changes:
	  - SMMUv2 devicetree binding updates for Qualcomm implementations
	    (QCS8300 GPU and MSM8937)
	  - Clean up SMMUv2 runtime PM implementation to help with wider rework of
	    pm_runtime_put_autosuspend()

	- Rockchip driver changes:
	  - Driver adjustments for recent DT probing changes

	- S390 IOMMU changes:
	  - Support for IOMMU passthrough

	- Apple Dart changes:
	  - Driver adjustments to meet ISP device requirements
	  - Null-ptr deref fix
	  - Disable subpage protection for DART 1

----------------------------------------------------------------
Asahi Lina (1):
      iommu/io-pgtable-dart: Only set subpage protection disable for DART 1

Barnabás Czémán (1):
      dt-bindings: iommu: qcom,iommu: Add MSM8937 IOMMU to SMMUv1 compatibles

Hector Martin (2):
      iommu: apple-dart: Increase MAX_DARTS_PER_DEVICE to 3
      iommu: apple-dart: Allow mismatched bypass support

Jason Gunthorpe (7):
      genirq/msi: Store the IOMMU IOVA directly in msi_desc instead of iommu_cookie
      genirq/msi: Refactor iommu_dma_compose_msi_msg()
      iommu: Make iommu_dma_prepare_msi() into a generic operation
      irqchip: Have CONFIG_IRQ_MSI_IOMMU be selected by irqchips that need it
      iommufd: Implement sw_msi support natively
      iommu/vt-d: Use virt_to_phys()
      iommu/vt-d: Check if SVA is supported when attaching the SVA domain

Joerg Roedel (2):
      Merge tag 'for-joerg' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd into core
      Merge branches 'apple/dart', 'arm/smmu/updates', 'arm/smmu/bindings', 'rockchip', 's390', 'core', 'intel/vt-d' and 'amd/amd-vi' into next

Kishon Vijay Abraham I (1):
      iommu/amd: Enable support for up to 2K interrupts per function

Lu Baolu (4):
      iommu/vt-d: Move scalable mode ATS enablement to probe path
      iommu/vt-d: Move PRI enablement in probe path
      iommu/vt-d: Cleanup intel_context_flush_present()
      iommu/vt-d: Fix possible circular locking dependency

Matthew Rosato (4):
      s390/pci: check for relaxed translation capability
      s390/pci: store DMA offset in bus_dma_region
      iommu/s390: handle IOAT registration based on domain
      iommu/s390: implement iommu passthrough via identity domain

Nicolin Chen (3):
      iommufd: Make attach_handle generic than fault specific
      iommufd/fault: Remove iommufd_fault_domain_attach/detach/replace_dev()
      iommu: Turn fault_data to iommufd private pointer

Pranjal Shrivastava (1):
      iommu/arm-smmu: Set rpm auto_suspend once during probe

Pratyush Brahma (1):
      dt-bindings: arm-smmu: Document QCS8300 GPU SMMU

Qasim Ijaz (1):
      iommu: apple-dart: fix potential null pointer deref

Robin Murphy (11):
      iommu/dma: Remove redundant locking
      iommu: Unexport iommu_fwspec_free()
      iommu: Handle race with default domain setup
      iommu: Resolve ops in iommu_init_device()
      iommu: Keep dev->iommu state consistent
      iommu: Get DT/ACPI parsing into the proper probe path
      iommu: Don't warn prematurely about dodgy probes
      iommu/mediatek-v1: Support COMPILE_TEST
      iommu/rockchip: Allocate per-device data sensibly
      iommu/rockchip: Register in a sensible order
      iommu/rockchip: Retire global dma_dev workaround

Sairaj Kodilkar (3):
      iommu/amd: Introduce generic function to set multibit feature value
      iommu/amd: Replace slab cache allocator with page allocator
      iommu/amd: Rename DTE_INTTABLEN* and MAX_IRQS_PER_TABLE macro

Sean Christopherson (2):
      iommu/vt-d: Put IRTE back into posted MSI mode if vCPU posting is disabled
      iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ affinity changes

Vasant Hegde (7):
      iommu/amd: Log IOMMU control register in event log path
      iommu/amd: Remove unused variable
      iommu/amd/pgtbl_v2: Improve error handling
      iommu/amd: Remove outdated comment
      iommu/amd: Fix header file
      iommu/amd: Remove unused forward declaration
      iommu/amd: Consolidate protection domain free code

Yi Liu (4):
      iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
      iommu: Drop iommu_group_replace_domain()
      iommu: Store either domain or handle in group->pasid_array
      iommu: Swap the order of setting group->pasid_array and calling attach op of iommu drivers

Yunhui Cui (1):
      iommu/vt-d: Fix system hang on reboot -f

 .../devicetree/bindings/iommu/arm,smmu.yaml        |   3 +-
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |   1 +
 arch/s390/include/asm/pci.h                        |   4 +-
 arch/s390/include/asm/pci_clp.h                    |   4 +-
 arch/s390/kvm/pci.c                                |  17 +-
 arch/s390/pci/pci.c                                |  35 +--
 arch/s390/pci/pci_bus.c                            |  25 ++
 arch/s390/pci/pci_clp.c                            |   1 +
 arch/s390/pci/pci_sysfs.c                          |  11 +-
 drivers/acpi/arm64/dma.c                           |   5 +
 drivers/acpi/scan.c                                |   7 -
 drivers/amba/bus.c                                 |   3 +-
 drivers/base/platform.c                            |   3 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   3 +-
 drivers/cdx/cdx.c                                  |   3 +-
 drivers/iommu/Kconfig                              |   4 +-
 drivers/iommu/amd/amd_iommu.h                      |   8 +-
 drivers/iommu/amd/amd_iommu_types.h                |  30 +--
 drivers/iommu/amd/init.c                           |  65 ++---
 drivers/iommu/amd/io_pgtable.c                     |   7 -
 drivers/iommu/amd/io_pgtable_v2.c                  |   2 +-
 drivers/iommu/amd/iommu.c                          |  91 ++++---
 drivers/iommu/amd/pasid.c                          |   2 +-
 drivers/iommu/apple-dart.c                         |  22 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c              |  11 +-
 drivers/iommu/dma-iommu.c                          |  82 ++-----
 drivers/iommu/intel/iommu.c                        | 239 +++++++-----------
 drivers/iommu/intel/iommu.h                        |  28 +--
 drivers/iommu/intel/irq_remapping.c                |  42 ++--
 drivers/iommu/intel/pasid.c                        |  43 +---
 drivers/iommu/intel/prq.c                          |   2 +-
 drivers/iommu/intel/svm.c                          |  43 ++++
 drivers/iommu/io-pgtable-dart.c                    |   2 +-
 drivers/iommu/iommu-priv.h                         |   5 +-
 drivers/iommu/iommu.c                              | 220 +++++++++++------
 drivers/iommu/iommufd/device.c                     | 266 +++++++++++++++++++--
 drivers/iommu/iommufd/fault.c                      | 130 +---------
 drivers/iommu/iommufd/hw_pagetable.c               |   5 +-
 drivers/iommu/iommufd/iommufd_private.h            |  64 ++---
 drivers/iommu/iommufd/main.c                       |   9 +
 drivers/iommu/mtk_iommu_v1.c                       |  25 +-
 drivers/iommu/of_iommu.c                           |  13 +-
 drivers/iommu/rockchip-iommu.c                     |  61 ++---
 drivers/iommu/s390-iommu.c                         | 138 +++++++++--
 drivers/iommu/tegra-smmu.c                         |   1 -
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/irq-gic-v2m.c                      |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  13 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   |  12 +-
 drivers/irqchip/irq-ls-scfg-msi.c                  |   5 +-
 drivers/of/device.c                                |   7 +-
 drivers/pci/pci-driver.c                           |   3 +-
 include/linux/iommu.h                              |  61 ++---
 include/linux/msi.h                                |  55 +++--
 kernel/irq/Kconfig                                 |   1 +
 55 files changed, 1091 insertions(+), 860 deletions(-)

Please pull.

Thanks,

	Joerg
