Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A354705B;
	Thu, 15 Oct 2026 01:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027180; cv=none; b=WOSAxNpfzLFpfrfV4NONtmbGFEq1VrbBzGmoLse/iQXMfuYcHeMrXZrz+4gH7ViyJm0+QQyWz3sW1ipEuhKaW4QT/jdXbxUztQmgfwBvow7Fbs7qtXOAdDvaj8YHjxzg8/hnR5VCDk+pVYjgQInGExNE2r2TAVWrKhOxvtWtr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027180; c=relaxed/simple;
	bh=zz9y8GxZ2JDrBYgE892VEWJJC2iKAGE3HHocd9sYed0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLKWh13716aC7rfJWv6CbgRc6BFj42jqxrkkniGOe6QnPpMyPtBJgSlhASzNVUxEq2YcSxX9K5f7F8neMIHsETbaTGXbxrjhCpYJQPrLfDn6FqJvEQFVOk96KtXiKY35uaJjzeGmquNHqPrDOO3kGfi/YonJ352q5uDCKtWZMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nu+lfyQp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nu+lfyQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792027179; x=1823563179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zz9y8GxZ2JDrBYgE892VEWJJC2iKAGE3HHocd9sYed0=;
  b=nu+lfyQpOGaD8d0LXp0/0mKE/WJHUkFk2G5gvd2MtTWIBU3gMFapO/T3
   zJTPJcA8n5IY8+PBwZUweJ7HAp5AkS+qnzX28eQFHiSzdcIPDbuvYzrOb
   yuCxIWWYt1bf3N6E7q3DHisbxVBV+EhH8R9aYoxPdRfAhKWm9DB29nDHw
   uKyxBCc7O1hVaa2U7+7Fpb2TIltZJmLVujkfFN0NU0Zh1XPxVuGQ5ccF3
   iO5dPEwFx34E3WBXPpCHEELURBc0Y0q3NS+7tmT8i/5XPtwTYisQ0rwi1
   eYmlH+QCwU901kI7Afndf87ghi9J/4N3S8Juwljx0+f3meLqlOqCAGMs2
   g==;
X-CSE-ConnectionGUID: n7vUvn0tSsmelO3dbBzLSA==
X-CSE-MsgGUID: UWFql0stSDKFhjqzrQg+HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="789199"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="789199"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 18:19:38 -0700
X-CSE-ConnectionGUID: NtOL3hLfQu6kHojhKAXRxw==
X-CSE-MsgGUID: Ym534/kMSjqC6p7RYcgBqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1595513"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa004.fm.intel.com with ESMTP; 14 Oct 2026 18:19:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/4] coco/tdx-host: Introduce trusted DMA initialization support
Date: Thu, 15 Oct 2026 09:07:01 +0800
Message-ID: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds trusted DMA initialization support to the tdx-host and
intel-iommu drivers, as groundwork for TEE I/O trusted DMA support.

Following Jason Gunthorpe's suggestion on v1, this version moves the
host/TDX-module interactions out of the IOMMU driver and into the TDX
host (TSM) driver. It is posted to collect review feedback from TDX, TSM
and IOMMU stakeholders; it is not yet intended for merging.

This is part of the effort to implement the TDX PCIe Link Encryption
feature, which includes the following components:

[ ] TDX module extensions initialization, posted in [3]
[X] Introduce trusted DMA initialization support
[ ] SEAMCALL helpers for TDX PCIe Link Encryption
[ ] PCIe Link Encryption Establishment via TDX platform services

Background:

Intel VT-d hardware gains a second set of DMA translation structures,
owned by the TDX module and used only for devices assigned to
confidential guests.

From the TDX Connect architecture perspective, VT-d is enhanced with:

  1) Trusted DMA translation root table
     - A second root-table address register, restricted to SEAM SAI.
     - Programmed by the TDX module with the root of TDX-managed DMA
       translation tables for TD-assigned devices.

  2) Trusted invalidation queue
     - A second invalidation-queue address register plus dedicated
       head/tail registers, also restricted to SEAM SAI.

  3) IOTLB / DID isolation
     - When TDX Connect is enabled, the TDX module owns the half of the
       domain ID space with the MSB set; the VMM must confine itself to
       the lower half.

This posting covers initialization only: the host hands the TDX module
the memory it needs and asks it to take over trusted DMA management on
each capable IOMMU. The non-trusted DMA path is unchanged, except that
the host's usable domain ID space on TDX-capable IOMMUs is halved. The
TDX guest and device flows come in a later series.

Breakdown:

- Patch 1: Adds the TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR SEAMCALL
  wrappers, exported only to the tdx-host module.

- Patch 2: Reads the IOMMU_MT_PAGES_COUNT global metadata field when
  TDX_FEATURES0 advertises TDX Connect. It tells the host how many
  metadata pages the TDX module needs per IOMMU.

- Patch 3: Adds dmar_tdxcs_iommu_init_all() and
  dmar_tdxcs_iommu_release() to the VT-d driver. init_all() walks the
  active DMAR units, checks the preconditions TDH.IOMMU.SETUP requires,
  confines the host to the lower half of the DID space, and hands each
  TDX-capable unit to a tdx-host callback.

- Patch 4: Implements the setup() callback in the tdx-host driver:
  allocates the trusted invalidation-queue buffers and metadata pages
  on the IOMMU's NUMA node, builds the IOMMU_MT parameter page, and
  issues TDH.IOMMU.SETUP. Units the TDX module does not cover are
  skipped. Teardown uses TDH.IOMMU.CLEAR; if that fails, the pages are
  intentionally leaked.

Change log:

v2:
- Moved the TDX module interactions (page allocation, IOMMU_MT
  construction, SEAMCALLs) from the VT-d driver to the tdx-host driver.
  The VT-d driver now only does the DRHD walk, precondition checks and
  DID reservation, and exposes them via a callback-based API.
- Renamed tdx-host.c to main.c and added iommu.c.

v1:
- https://lore.kernel.org/r/20260915074235.1219183-1-baolu.lu@linux.intel.com

ABI History:

TDH.IOMMU.CLEAR previously required the host to provide, as input, the
parameter page used for TDH.IOMMU.SETUP. The ABI has changed to take
only the TDX IOMMU ID. This change is not yet reflected in the public
ABI specification [1], so the two may differ.

Reference:

Implementation details follow the interfaces and behavior defined in the
TDX Connect Application Binary Interface (ABI) Reference Specification
and Intel TDX Connect Architecture Specification [1].

A full preview of these dependencies and follow-up changes is available
at [4].

Link: https://cdrdv2.intel.com/v1/dl/getContent/858625 # [1]
Link: https://www.intel.com/content/www/us/en/content-details/862706/intel-tdx-connect-architecture-specification.html # [2]
Link: https://lore.kernel.org/r/20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com # [3]
Link: https://github.com/intel-staging/tdx/tree/tdisp_phase1 # [4]

Please review. Any feedback is highly appreciated.

Thanks,
Baolu

Lu Baolu (4):
  x86/virt/tdx: Add SEAMCALL wrappers for IOMMU setup/clear
  x86/virt/tdx: Read global metadata for trusted IOMMU
  iommu/vt-d: Add an API for tdx-host when enabling trusted DMA
  coco/tdx-host: Initialize trusted DMA on all capable IOMMUs

 drivers/virt/coco/tdx-host/Kconfig            |   6 +
 drivers/virt/coco/tdx-host/Makefile           |   3 +
 arch/x86/include/asm/tdx.h                    |   3 +
 arch/x86/include/asm/tdx_global_metadata.h    |   5 +
 arch/x86/virt/vmx/tdx/tdx.h                   |   2 +
 drivers/iommu/intel/iommu.h                   |   6 +
 drivers/virt/coco/tdx-host/private.h          |  33 +++
 include/linux/dmar.h                          |   5 +
 arch/x86/virt/vmx/tdx/tdx.c                   |  56 ++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  20 ++
 drivers/iommu/intel/dmar.c                    | 103 +++++++
 drivers/iommu/intel/iommu.c                   |  19 ++
 drivers/virt/coco/tdx-host/iommu.c            | 255 ++++++++++++++++++
 .../virt/coco/tdx-host/{tdx-host.c => main.c} |  21 +-
 14 files changed, 536 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/coco/tdx-host/private.h
 create mode 100644 drivers/virt/coco/tdx-host/iommu.c
 rename drivers/virt/coco/tdx-host/{tdx-host.c => main.c} (92%)

-- 
2.43.0

