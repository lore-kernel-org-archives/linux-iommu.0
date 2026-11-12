Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458629;
	b=35MiW/eno+b80c3Y3I23fVQgKK02l7VhFsn2z7RX/qqz9EnMhUExLqvI1DuILxnZBHFD
	 U0VYQFxa0c2pc/5xizR6uXiMvFcMYRuIlrQfRKt0vkRCnK5OOmBQf62c9Jb8xxw9pJCUM
	 iMIlGU358LuFf+SGk1wICKGtN7hoXWm91sCzL50oGljuF49e4GA/S0QYhMwiFfOo3gTcb
	 kkmuHR7G1HOcpBmtQ2Efdw+m9WHstDH5vYL/+LbH6pwm0vAbiYQQr/U1ofkE6B8YtWj+c
	 kG+SqomzUO1S1M6Vq5GjYsFTx4+60Pz32trZy/WCeqwxcy4swdXhmsbVc7kWzDh+Xrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458629;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vzANmFX5Gn3prIT7c5E8QRJsQJ4q1JmFSUb4E1XNV58=;
	b=RRnX7EhWYwvw3Ke4pL4eh63EjYjb50cMKE3j7H4kAwNV01Ep84dtto+/f39Sv22Tqacu
	 nnEsdFsYr5FHncCKv8eIvqDDlVC6dgfSBv0aITChIeDyWUAnNgqw6Yzv7L39duOW4iUvA
	 aKs6IR6j1fQuoLWdJdfovTJEiJaQ0brmbWlsYZfNX94uxtrCuxr99X2jcMfm9Dr0X2SBH
	 OXu/i7AiQrd0gldV1Qn9FTRQEULalp8gtDikrbzOZOCAAopu5D688JF6KDMEDKIa7LR4O
	 5L5MjDw6Cvv/4klAketLNdL1Jw+VtwEIRSa53cmaWy16JGT79S9Fgo3a0AKT1feBvEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TsJPAQO3;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD00606A321;
	Thu, 12 Nov 2026 04:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABD00606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TsJPAQO3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794458629; x=1825994629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=msfF03kMDRcUmcGxlw8xw3056jHMTBZ/No+mFNozNlo=;
  b=TsJPAQO3lg8PP9cvJXZM3ySk/ZAZAC5sRNj8tv00JQEIKzzJGp28jbSQ
   U2lDkAtzKJLTfKWpY9lDoJJaR/5JnVAI2Lt0kDcWM/6hzh9u2cfvKnZaa
   jzou0axPuTQLPQ58H3jAxcCbpOOGxKE4W5ZntEwEt5EttmvvkgQqN5rd+
   ZEzB45CEQLExMyuHKr+BTp46Qv8RiWhsNDd+TxasZbGjkDUBILS7HEJXO
   ZhrZ4akuKCuGNyvRfe2i9lXeOZZChdV52ncktVOvQvk+eyPnkcbJ6lrSD
   pb8DhcxTTKMAYjreSHSEvWQuDxvaoxZSgaczLzWQh6Hj/YCbBdTZOJq9R
   Q==;
X-CSE-ConnectionGUID: f0Hjk9q2Q0GUGP6y4G7ZOg==
X-CSE-MsgGUID: iaiXwxmSTs6CSwlnoTlz3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3318312"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3318312"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 20:43:48 -0800
X-CSE-ConnectionGUID: nwVxLacIQce52E4+haDMTA==
X-CSE-MsgGUID: h4lu0Zi/QXacD7GPbLPkpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8728610"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2026 20:43:44 -0800
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
Subject: [PATCH v3 0/9] coco/tdx-host: Introduce trusted DMA initialization support
Date: Thu, 12 Nov 2026 12:30:45 +0800
Message-ID: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds trusted DMA initialization support to the tdx-host and
intel-iommu drivers, as groundwork for TEE I/O trusted DMA support.

As in v2, the host/TDX-module interactions live in the tdx-host (TSM)
driver, and the VT-d driver only provides the iommu-side pieces. v3
moves trusted DMA setup from driver probe to the TSM connect path. It is
posted to collect review feedback from TDX, TSM and IOMMU stakeholders;
it is not yet intended for merging.

This is part of the effort to implement the TDX PCIe Link Encryption
feature, which includes the following components:

[ ] TDX module extensions initialization, posted in [3]
[X] Introduce trusted DMA initialization support
[ ] SEAMCALL helpers for TDX PCIe Link Encryption
[ ] PCIe Link Encryption Establishment via TDX platform services

The series is based on the latest tip/x86/tdx branch, with these
dependent series applied:

 - TDX module extensions initialization

The full stack is available at:

  https://github.com/LuBaolu/intel-iommu/commits/iommu/tdxc/enablement-v3

Background:

Intel VT-d hardware gains a second set of DMA translation structures,
managed by the TDX module and used only for devices assigned to
confidential guests. Per the TDX Connect architecture specification [2],
VT-d is enhanced with:

  1) Trusted DMA translation root table
     - A second root-table address register, restricted to SEAM SAI.
     - Programmed by the TDX module with the root of TDX-managed DMA
       translation tables for TD-assigned devices.

  2) Trusted invalidation queue
     - A second invalidation-queue address register plus dedicated
       head/tail registers, also restricted to SEAM SAI.

  3) IOTLB / DID isolation
     - While an IOMMU is in Secure TDX Mode, the TDX module owns the
       half of the domain ID space with the MSB set; the VMM must
       confine itself to the lower half.

This posting covers IOMMU initialization only. The current Link TSM
connect callback obtains and immediately drops a trusted-DMA reference,
so it exercises TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR, then returns -ENXIO;
it does not establish a TSM connection. Once TDISP connect is
implemented, the intended lifetime is for the first connected device
behind a trusted DMA-capable IOMMU to trigger TDH.IOMMU.SETUP and the
last disconnect to trigger TDH.IOMMU.CLEAR. The untrusted DMA path is
unchanged, except that while an IOMMU is in Secure TDX Mode the host is
confined to the lower half of its domain ID space and must not touch its
global command (GCMD) or enhanced command (ECMD) interfaces. The TDX
guest and device flows come in a later series.

Breakdown:

- Patch 1: Adds the TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR SEAMCALL
  wrappers, exported only to the tdx-host module, together with a
  structure that mirrors the IOMMU_MT parameter page layout.

- Patch 2: Reads the IOMMU_MT_PAGES_COUNT global metadata field when
  TDX_FEATURES0 advertises TDX Connect. It tells the host how many
  metadata pages the TDX module needs per IOMMU.

- Patch 3: Exports the Dynamic PAMT helpers to tdx-host, which needs
  PAMT backing for the pages it hands to the TDX module.

- Patch 4: Adds a per-device interface to the VT-d driver:
  dmar_tdxc_get_params(), dmar_tdxc_acquire() and dmar_tdxc_release().
  acquire() checks the preconditions TDH.IOMMU.SETUP requires and
  confines the host to the lower half of the DID space; release()
  undoes it. Trusted DMA-capable units are excluded from DMAR hotplug.

- Patch 5: Blocks GCMD and ECMD on an IOMMU while it is acquired.
  IOMMUs that need write buffer flushing are refused, and the remaining
  GCMD writers are guarded. intel_iommu_shutdown() is exempt because
  TDH.SYS.DISABLE has already run by then.

- Patch 6: Refuses system suspend while any IOMMU is acquired by the TDX
  module, avoiding suspend/resume callbacks that would change its state.

- Patch 7: Adds the tdx-host Link TSM skeleton that the TSM connect and
  disconnect callbacks hang off. It is carried here as a dependency.

- Patch 8: Renames tdx-host.c to main.c in preparation for adding more
  source files. No functional change.

- Patch 9: Adds per-IOMMU reference-counted trusted DMA setup and teardown
  and invokes it from the TSM connect callback. The setup path allocates
  the trusted invalidation-queue buffers and metadata pages on the
  IOMMU's NUMA node, takes Dynamic PAMT backing for them, and builds the
  IOMMU_MT parameter page. If TDH.IOMMU.CLEAR fails, the pages are
  intentionally leaked and the IOMMU is not reused.

Change log:

v3:
- Replaced the callback-based "initialize all IOMMUs at probe time" API
  with a per-device interface. Trusted DMA is now set up on TSM device
  connect and torn down on disconnect, refcounted per IOMMU.
- Blocked both the GCMD and ECMD interfaces while an IOMMU is in Secure
  TDX Mode, and refused IOMMUs that need write buffer flushing.
- Add a patch to refuse system suspend while an IOMMU has been acquired
  by the TDX module to avoid global state change in
  iommu_suspend/resume().
- Added Dynamic PAMT backing for the IOMMU_MT pages.
- Replaced the untyped parameter page with a dedicated structure that
  mirrors the IOMMU_MT parameter layout in the ABI spec.
- Split the tdx-host.c to main.c rename into its own patch, and renamed
  the new file from iommu.c to viommu.c.
- Reworked commit messages per review feedback.

v2:
- Moved the TDX module interactions (page allocation, IOMMU_MT
  construction, SEAMCALLs) from the VT-d driver to the tdx-host driver.
  The VT-d driver now only does the DRHD walk, precondition checks and
  DID reservation, and exposes them via a callback-based API.
- Renamed tdx-host.c to main.c and added iommu.c.
- https://lore.kernel.org/r/20261015010705.1973284-1-baolu.lu@linux.intel.com

v1:
- https://lore.kernel.org/r/20260915074235.1219183-1-baolu.lu@linux.intel.com

ABI History:

TDH.IOMMU.CLEAR previously required the host to provide, as input, the
parameter page used for TDH.IOMMU.SETUP. The ABI has changed to take
only the TDX IOMMU ID. This change is not yet reflected in the public
ABI specification [1], so the two may differ.

The TDX Connect ABI specification should include a dedicated section
listing all IOMMU registers whose use must be coordinated between legacy,
host-managed operation and trusted, TDX-module-managed operation. This
would let host IOMMU drivers avoid accesses that interfere with the TDX
module while an IOMMU is in Secure TDX Mode. GCMD and ECMD are confirmed
to be in scope; additional registers may be identified as the
specification is clarified.

Reference:

Implementation details follow the interfaces and behavior defined in the
Intel TDX Connect ABI Specification [1] and the Intel TDX Connect
Architecture Specification [2].

A full preview of these dependencies and follow-up changes is available
at [4].

Link: https://cdrdv2.intel.com/v1/dl/getContent/858625 # [1]
Link: https://www.intel.com/content/www/us/en/content-details/862706/intel-tdx-connect-architecture-specification.html # [2]
Link: https://lore.kernel.org/r/20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com # [3]
Link: https://github.com/intel-staging/tdx/tree/tdisp_phase1 # [4]

Please review. Any feedback is highly appreciated.

Thanks,
Baolu

Lu Baolu (9):
  x86/virt/tdx: Add SEAMCALL wrappers for IOMMU setup/clear
  x86/virt/tdx: Read global metadata for trusted IOMMU
  x86/virt/tdx: Export Dynamic PAMT helpers to tdx-host
  iommu/vt-d: Add interface for tdx-host when enabling trusted DMA
  iommu/vt-d: Block GCMD and ECMD while acquired by the TDX module
  iommu/vt-d: Refuse system suspend while acquired by the TDX module
  coco/tdx-host: Add skeleton to support PCI link encryption
  coco/tdx-host: Rename tdx-host.c to main.c
  coco/tdx-host: Enable trusted DMA on IOMMUs on device connect

 drivers/virt/coco/tdx-host/Kconfig            |   7 +
 drivers/virt/coco/tdx-host/Makefile           |   3 +
 arch/x86/include/asm/tdx.h                    |  23 +
 arch/x86/include/asm/tdx_global_metadata.h    |   5 +
 arch/x86/virt/vmx/tdx/tdx.h                   |   2 +
 drivers/iommu/intel/iommu.h                   |  10 +
 drivers/virt/coco/tdx-host/private.h          |  21 +
 include/linux/dmar.h                          |  25 ++
 arch/x86/virt/vmx/tdx/tdx.c                   |  57 ++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  20 +
 drivers/iommu/intel/dmar.c                    | 278 +++++++++++-
 drivers/iommu/intel/iommu.c                   |  34 +-
 drivers/iommu/intel/irq_remapping.c           |  10 +
 .../virt/coco/tdx-host/{tdx-host.c => main.c} | 129 +++++-
 drivers/virt/coco/tdx-host/viommu.c           | 401 ++++++++++++++++++
 15 files changed, 1016 insertions(+), 9 deletions(-)
 create mode 100644 drivers/virt/coco/tdx-host/private.h
 rename drivers/virt/coco/tdx-host/{tdx-host.c => main.c} (66%)
 create mode 100644 drivers/virt/coco/tdx-host/viommu.c

-- 
2.43.0

