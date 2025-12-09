Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C3C1D88D7
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 05:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257098; cv=none; b=Qm1r5/hML3/u5iwMHnO0DJARJxhPUYJWrQzlqDo3tXOlYED0KbxwnxRXE/YpYCxEy+e1F3eb7vHvicXKHm7OBnLx1H5RdxCkugDFqTGjVXjXT57PtwQlWQMXzQvY7W13xewDsrC9cvg/PUXGa0R05EM4DN2nn3jOU7orc/nyTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257098; c=relaxed/simple;
	bh=YlS1lX2SuhkJ8xqnIY2o4bySf5QLWSEKS6WSbIPDFng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCcMxbLulA8d64PpAhw57qvghHfOBS0/V3JtNIoUEYNgs5IZtP83FJUvTZcXSU3umFEhT76g2ppYceb9f/70zFZzM6EnZgXp9zMzlyOWfNy0aCvzAWwWLQy62fjHRmYB3LwIsDC/5+1nVbKGH2EQ8C+MNUWZUVRRdQyFMTvWqTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RoTBUhJR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RoTBUhJR"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id CCBE22015683;
	Mon,  8 Dec 2025 21:11:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCBE22015683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765257094;
	bh=OQ6TLAOaCSprKnv/FtE/IFGdid/GlGde9q0jlRuJG7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=RoTBUhJRME3T4HDvDodDoQ0le+W6QkKdb+n8SJvjdabYDw+6MHiKQALBxtlPyHgVk
	 pirtkMqgVypjzwbZrgudCOx4/iSWBuH0lOo+JbWMdAUpg9vDrZ2gvRfP8ru22Q08gK
	 F7zLWpWyER0eG4s6xLY8qwSrDEPt3OFLI0KaUw1Q=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	easwar.hariharan@linux.microsoft.com,
	jacob.pan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	peterz@infradead.org,
	linux-arch@vger.kernel.org
Subject: [RFC v1 0/5] Hyper-V: Add para-virtualized IOMMU support for Linux guests
Date: Tue,  9 Dec 2025 13:11:23 +0800
Message-ID: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a para-virtualized IOMMU driver for
Linux guests running on Microsoft Hyper-V. The primary objective
is to enable hardware-assisted DMA isolation and scalable device
assignment for Hyper-V child partitions, bypassing the performance
overhead and complexity associated with emulated IOMMU hardware.

The driver implements the following core functionality:
*   Hypercall-based Enumeration
    Unlike traditional ACPI-based discovery (e.g., DMAR/IVRS),
    this driver enumerates the Hyper-V IOMMU capabilities directly
    via hypercalls. This approach allows the guest to discover
    IOMMU presence and features without requiring specific virtual
    firmware extensions or modifications.

*   Domain Management
    The driver manages IOMMU domains through a new set of Hyper-V
    hypercall interfaces, handling domain allocation, attachment,
    and detachment for endpoint devices.

*   IOTLB Invalidation
    IOTLB invalidation requests are marshaled and issued to the
    hypervisor through the same hypercall mechanism.

*   Nested Translation Support
    This implementation leverages guest-managed stage-1 I/O page
    tables nested with host stage-2 translations. It is built
    upon the consolidated IOMMU page table framework designed by
    Jason Gunthorpe [1]. This design eliminates the need for complex
    emulation during map operations and ensures scalability across
    different architectures.

Implementation Notes:
*   Architecture Independence
    While the current implementation only supports x86 platforms (Intel
    VT-d and AMD IOMMU), the driver design aims to be as architecture-
    agnostic as possible. To achieve this, initialization occurs via
    `device_initcall` rather than `x86_init.iommu.iommu_init`, and shutdown
    is handled via `syscore_ops` instead of `x86_platform.iommu_shutdown`.

*   MSI Region Handling
    In this RFC, the hardware MSI region is hard-coded to the standard
    x86 interrupt range (0xfee00000 - 0xfeefffff). Future updates may
    allow this configuration to be queried via hypercalls if new hardware
    platforms are to be supported.

*   Reserved Regions (RMRR)
    There is currently no requirement to support assigned devices with
    ACPI RMRR limitations. Consequently, this patch series does not specify
    or query reserved memory regions.

Testing:
This series has been validated using dmatest with Intel DSA devices
assigned to the child partition. The tests confirmed successful DMA
transactions under the para-virtualized IOMMU.

Future Work:
*   Page-selective IOTLB Invalidation
    The current implementation relies on full-domain flushes. Support
    for page-selective invalidation is planned for a future series.

*   Advanced Features
    Support for vSVA and virtual PRI will be addressed in subsequent
    updates.

*   Root Partition Co-existence
    Ensure compatibility with the distinct para-virtualized IOMMU driver
    used by Hyper-V's Linux root partition, in which the DMA remapping
    is not achieved by stage-1 IO page tables and another set of iommu
    ops is provided.

[1] https://github.com/jgunthorpe/linux/tree/iommu_pt_all

Easwar Hariharan (2):
  PCI: hv: Create and export hv_build_logical_dev_id()
  iommu: Move Hyper-V IOMMU driver to its own subdirectory

Wei Liu (1):
  hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU

Yu Zhang (2):
  hyperv: allow hypercall output pages to be allocated for child
    partitions
  iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest

 drivers/hv/hv_common.c                        |  21 +-
 drivers/iommu/Kconfig                         |  10 +-
 drivers/iommu/Makefile                        |   2 +-
 drivers/iommu/hyperv/Kconfig                  |  24 +
 drivers/iommu/hyperv/Makefile                 |   3 +
 drivers/iommu/hyperv/iommu.c                  | 608 ++++++++++++++++++
 drivers/iommu/hyperv/iommu.h                  |  53 ++
 .../irq_remapping.c}                          |   2 +-
 drivers/pci/controller/pci-hyperv.c           |  28 +-
 include/asm-generic/mshyperv.h                |   2 +
 include/hyperv/hvgdk_mini.h                   |   8 +
 include/hyperv/hvhdk_mini.h                   | 123 ++++
 12 files changed, 850 insertions(+), 34 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/Makefile
 create mode 100644 drivers/iommu/hyperv/iommu.c
 create mode 100644 drivers/iommu/hyperv/iommu.h
 rename drivers/iommu/{hyperv-iommu.c => hyperv/irq_remapping.c} (99%)

-- 
2.49.0

