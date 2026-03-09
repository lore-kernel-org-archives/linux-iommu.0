Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B134DCEE
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036585; cv=none; b=TELMkEFIKkA39i6qEKtY0mLHJAwMaZ3Lo+qg2iZflUTYPprmLZaoSqgQ0dehW1y+B9Ta3hGeUy/NWwnB3Aeks12ui5tBZsPup7txQnUTEruDJwxzaKys28+IxlHRTcyPbWR3jw60+DDpnbvvY1Y3btkA1KwotIYNhe7EqrTmaG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036585; c=relaxed/simple;
	bh=za/KzXncnf3ekLHTTMTOlXck5K85rJ7moEnNC5SF2Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QiX/0Nq+PHxjL69mowd12Yqz608nutntH0AsqkiAEwyujZcEYht/5cUf88E19/OAdpiSH9KQriUA0C7Kot0k2mulY235cEoNJWl4JfGlXcQhSNLKfY7gUeHQs9pEqHtNIt7/nDsojVU82IbmyZgx2Sec1+/+whiufn5mTqCm1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaRUHyAc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaRUHyAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773036583; x=1804572583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=za/KzXncnf3ekLHTTMTOlXck5K85rJ7moEnNC5SF2Bk=;
  b=AaRUHyAc3Hh2XlUmNjRdDeuB2oy+nUx/EtAkWGpEyaZVpC2dGmoIRd2X
   nby2baL0riaw1yWAKe5r2IVo03AF217dE0zcxrP0mrbd1KD5Fs6Xek5iv
   6o+v8CvPesBSbmHRoMPemTBHH9vVZ1VqmGjyAmtaMW/Ye1PI25gAJup+S
   fPvsRk1ilvO+gBPmNrECZ2GfThz5LtwRXjzB1x2UjjKHojH5vs5LbWNp4
   p+WyTafEPnQoRHX4Vfc5xIX9QLyXoEmwOaHjQgVzbJAEDNUOi4+6cBKgf
   PfkP4PQk4pDw0l89Z19c4R4bMR2d5SkSbdeb/lxpwZDKXOnFV1baGQF/r
   w==;
X-CSE-ConnectionGUID: ARUcw+U4QsyvvrAoWNi4pQ==
X-CSE-MsgGUID: 0thaX+5hSNy3PYz9f8sFbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73248236"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73248236"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:09:43 -0700
X-CSE-ConnectionGUID: 5pG1FFv3RxGg51LzTUn0ew==
X-CSE-MsgGUID: Hln5txkjSgqK3tgd2YN78Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245669155"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2026 23:09:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/8] iommu/vt-d: Hitless PASID updates via entry_sync
Date: Mon,  9 Mar 2026 14:06:40 +0800
Message-ID: <20260309060648.276762-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to recent discussions on the iommu community mailing
list [1] [2] regarding potential race conditions in table entry updates.
After addressing atomicity in context and PASID entry updates [3], this
series modernizes Intel IOMMU driver by introducing a "hitless" update
mechanism.

The core of this series lifts the synchronization logic originally found
in the ARM SMMUv3 driver into a generic IOMMU library (entry_sync) and
plumbs it into the Intel IOMMU driver.

Traditionally, updating a PASID table entry while the hardware is
performing DMA required a disruptive "clear-then-update" sequence. By
analyzing "used bits" and enforcing 128-bit atomicity via CMPXCHG16B,
this library allows the driver to transition between translation modes
hitlessly whenever possible.

[1] https://lore.kernel.org/linux-iommu/20251227175728.4358-1-dmaluka@chromium.org/
[2] https://lore.kernel.org/linux-iommu/20260107201800.2486137-1-skhawaja@google.com/
[3] https://lore.kernel.org/linux-iommu/20260120061816.2132558-1-baolu.lu@linux.intel.com/

This series is also available on github:
[4] https://github.com/LuBaolu/intel-iommu/commits/pasid-entry-sync-v1

Best regards,
baolu

Jason Gunthorpe (1):
  iommu: Lift and generalize the STE/CD update code from SMMUv3

Lu Baolu (7):
  iommu/vt-d: Add entry_sync support for PASID entry updates
  iommu/vt-d: Require CMPXCHG16B for PASID support
  iommu/vt-d: Add trace events for PASID entry sync updates
  iommu/vt-d: Use intel_pasid_write() for first-stage setup
  iommu/vt-d: Use intel_pasid_write() for second-stage setup
  iommu/vt-d: Use intel_pasid_write() for pass-through setup
  iommu/vt-d: Use intel_pasid_write() for nested setup

 drivers/iommu/Kconfig               |  14 ++
 drivers/iommu/intel/Kconfig         |   4 +-
 drivers/iommu/Makefile              |   1 +
 drivers/iommu/entry_sync.h          |  66 +++++++
 drivers/iommu/entry_sync_template.h | 143 ++++++++++++++
 drivers/iommu/intel/iommu.h         |   8 +-
 drivers/iommu/intel/trace.h         | 107 ++++++++++
 drivers/iommu/entry_sync.c          |  68 +++++++
 drivers/iommu/intel/iommu.c         |  51 ++---
 drivers/iommu/intel/nested.c        |  13 +-
 drivers/iommu/intel/pasid.c         | 291 +++++++++++++++++++---------
 drivers/iommu/intel/svm.c           |   5 +-
 12 files changed, 620 insertions(+), 151 deletions(-)
 create mode 100644 drivers/iommu/entry_sync.h
 create mode 100644 drivers/iommu/entry_sync_template.h
 create mode 100644 drivers/iommu/entry_sync.c

-- 
2.43.0

