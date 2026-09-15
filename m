Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B53947B8;
	Tue, 15 Sep 2026 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458884; cv=none; b=l26qgPZ/+VnM0qCs7fszSEZFCu1GILzuiil13s5A+g82SyT/dKtYEXbWCNkd1v6t++sTK+l0ki2UqCyDmlEQpAmYw6uMDPuRLCndrWW+g94Zfr2M+b8n+Zb3jqqU3/uf3AOxje2lTbOpjy7BxmUrYARZD8f30EmLTzra6+cBkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458884; c=relaxed/simple;
	bh=+5UWXHwJeOt0Hc8dPnMATDTS2OAN7EFFOL08oPuC3l8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4c9z+OfLzbZXty6ZaWTXke/30LYTFsg+OE8kYhiK3wBxSqJrAGzyeDwgFbUzV9tcMa+iBvGxofC9oxLrpRqDKsZF14xakpghEeI17OwQt6E3QxJr/WfzHXb8NW2Y++/8qJ/5c2I2RanmE6dWiYTwQUPdf/xdgHmJgOW9ZJyiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFyiLNRv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFyiLNRv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789458882; x=1820994882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+5UWXHwJeOt0Hc8dPnMATDTS2OAN7EFFOL08oPuC3l8=;
  b=bFyiLNRvDLGWDXsWOmLi6wcgU48iluxZoq+2vlCTsHMVph1xRKQUDmsO
   lQivLj4H51ZxujJ0/dzzSo4AR8XAhMVZdpKyvVKeUNxIsKXp5N4+nMRU6
   iafCy3hhvoqZg3aNAPnxhJm6dWm2q0G5adH4IkICXPjvIe7toaT3zOXF8
   /EafiHk5alnT827ec0AAnv6xhTizblgLTeLNZRq3UDERyHxtq9x8KR4g0
   f1qgrmjeIxWvWMcxu7I+gQFHYbSXp7rGG0zfH/Ps8Lyx5t1ReGHMhGuSK
   68szQ+jOl+AitDBT8+PswRjzIW4RdOljCDyEYFMHF5Lj2Ptb6ytcgK3w7
   w==;
X-CSE-ConnectionGUID: 3qUCpN/0Sf6VwlabGvZEkg==
X-CSE-MsgGUID: oiyWYKksS06DJgaJ0A1hhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101163763"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101163763"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 00:54:41 -0700
X-CSE-ConnectionGUID: ntZYtCX7R7KkXpBIwLfNWw==
X-CSE-MsgGUID: 496booTBRXe/ga0RmXoyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269205397"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2026 00:54:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Introduce trusted DMA initialization support
Date: Tue, 15 Sep 2026 15:42:28 +0800
Message-ID: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds Intel VT-d trusted extension support to the host Intel
IOMMU driver as groundwork for TEE I/O trusted DMA (e.g. TDX Connect).

The trusted extension introduces a parallel, extension-specific path for
trusted DMA assets used by confidential device assignment. Existing VT-d
functionality remains unchanged for regular host DMA paths.

From the TDX Connect architecture perspective, VT-d is enhanced with:

  1) Trusted DMA translation root table
     - A second root-table address register, restricted to SEAM SAI.
     - Programmed by the TDX module with the root of TDX-managed DMA
       translation tables for TD-assigned devices.

  2) Trusted invalidation queue
     - A second invalidation-queue address register plus dedicated
       head/tail registers, also restricted to SEAM SAI.

  3) IOTLB / DID isolation
     - When TDX Connect is enabled, VT-d restricts VMM DID usage and
       reserves the DID MSB namespace bit for TDX-module use.

This posting focuses on VT-d-side enablement only: it enables those
extension-defined resources and control points while preserving existing
host VT-d behavior for non-trusted flows. Higher-layer integration
(TDX guest/device flows) will be posted separately.

The trusted IOMMU extensions establish an architecture where only
TEE-I/O DMA requests can access TD private memory, and only the TDX
module can configure TEE-I/O access-control permissions. The host
allocates memory for data structures used by the TDX module to 
manage trusted DMA, then requests the TDX module (via SEAMCALL) to
enable the extension in each IOMMU. 

Non-TEE-I/O DMA requests are unaffected and continue to be managed 
by the host through existing IOMMU interfaces.

Patch Breakdown:

- Patch 1: Implements low-level SEAMCALL wrappers (TDH.IOMMU.SETUP/CLEAR)
  to interface with the TDX module.
- Patch 2: Parses platform global metadata fields to calculate required
  IOMMU metadata page requirements.
- Patch 3: Introduces the core driver entry points.
- Patch 4: Implements the metadata page allocation and SEAMCALL
  sequences required to configure and release IOMMU units in trusted
  mode.
- Patch 5: Restricts the domain ID (DID) space allocated to the host by
  reserving the MSB for exclusive use by the TDX module.

ABI History:

TDH.IOMMU.CLEAR previously required the host to provide, as input, the
parameter page used for TDH.IOMMU.SETUP. This ABI has changed to remove
that requirement. Because this ABI change is not yet public, it may
cause confusion when referring to the ABI specification.

Reference:

Implementation details follow the interfaces and behavior defined in the
TDX Connect Application Binary Interface (ABI) Reference Specification
and Intel TDX Connect Architecture Specification:

Link: https://cdrdv2.intel.com/v1/dl/getContent/858625 # [1]
Link: https://www.intel.com/content/www/us/en/content-details/862706/intel-tdx-connect-architecture-specification.html # [2]

This is part of the effort to implement the TDX PCIe Link Encryption
feature, which includes the following components:

[ ] TDX module extensions initialization, posted in [3]
[X] Introduce trusted DMA initialization support
[ ] SEAMCALL helpers for TDX PCIe Link Encryption
[ ] PCIe Link Encryption Establishment via TDX platform services

A full preview of these dependencies and follow-up changes is avaiable
at [4].

Link: https://lore.kernel.org/r/20260618081355.3253581-1-yilun.xu@linux.intel.com # [3]
Link: https://github.com/intel-staging/tdx/tree/tdisp_phase1 # [4]

Please review. Any feedback is highly appreciated.

Thanks,
Baolu

Lu Baolu (5):
  x86/virt/tdx: Add SEAMCALL wrappers for IOMMU setup/clear
  x86/virt/tdx: Read global metadata for trusted IOMMU
  iommu/vt-d: Add interfaces for trusted DMA initialization
  iommu/vt-d: Add helpers to set up and tear down TDX extensions
  iommu/vt-d: Reserve MSB of domain ID space for TDX module

 drivers/iommu/intel/Kconfig                 |  14 ++
 drivers/iommu/intel/Makefile                |   1 +
 arch/x86/include/asm/tdx.h                  |   3 +
 arch/x86/include/asm/tdx_global_metadata.h  |   5 +
 arch/x86/virt/vmx/tdx/tdx.h                 |   2 +
 drivers/iommu/intel/iommu.h                 |  24 ++
 include/linux/dmar.h                        |  12 +
 arch/x86/virt/vmx/tdx/tdx.c                 |  56 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  20 ++
 drivers/iommu/intel/dmar.c                  |   3 +
 drivers/iommu/intel/iommu.c                 |  11 +
 drivers/iommu/intel/tdxc.c                  | 248 ++++++++++++++++++++
 12 files changed, 399 insertions(+)
 create mode 100644 drivers/iommu/intel/tdxc.c

-- 
2.43.0

