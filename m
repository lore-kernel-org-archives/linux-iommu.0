Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464E3264C4
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566758; cv=none; b=TIWThfl66dgoxcATKeRT4oNk+2mgT6X1/lkVJsqYh7OI7rxsdb/irdPAruu+zrKDUdtbiNnAbM+abb9blSVCUAnu3jj13rMe1m8/0DHzg3FMCEdRgppIX/r2/8gmTHXa3RF/F9HAVR2dufrBROuLq2tWAJ7ozRkeKQmqU1UuqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566758; c=relaxed/simple;
	bh=XvBhOgOzClPsUiT1Uvtm0FSGgqKtIWeYY1JEeRexcOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hz/v1admp0v/NTk3b82rAmaum7ubpbWpBIUDpr9ytC+8Gn2o9lzWoDs1RzidA6TFgLg8ctGMgAzNfsQgSEBwUIDjYgOb7bhCrrw0ox6y6KOH5iP6zQ3E2/vBNHEGRwuHXOGTNPMzsM/m0tFo6cKHXnNm3AHAvjO7s7zlX1cCoJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKWvYIia; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKWvYIia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566756; x=1822102756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XvBhOgOzClPsUiT1Uvtm0FSGgqKtIWeYY1JEeRexcOw=;
  b=EKWvYIia0b4K1ZoOEt00VVPAP0JmHA49+hcNM5Jbaf+cmyB8nnZs3hcr
   dHPvVTAY7vgahqtUxY4ABj/KOlfflETzZwLvACqWHhfWsH6OB40QlC/DT
   Oy7d7R/FhbmM8JPwheRgY1OgaT9/zfzYNTjZjkEeLLU2mnKLL/tKdtTuu
   ZW8eQ9Vf4Gtg17/S+HaLpm5toLl4pAq0GnChYt2Xyy2/5KIvIbqhclGfw
   hb6JTOFTe48ElVpbLghg+vVkCDZcV4+OMJvbzyzFAEYYqlJUJEp9aLYz7
   Uxus9+ooSXstfof2+5MsjoEM9uiefDRrKMkUDOx9PuQEGYEuVpCny8ho7
   w==;
X-CSE-ConnectionGUID: qa59exLzSVWOPb7ptUWgVw==
X-CSE-MsgGUID: QsSnJVXST9eSbmROR4osfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101917171"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101917171"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:39:16 -0700
X-CSE-ConnectionGUID: d6ZRM+2FRO61WLq0LJlgag==
X-CSE-MsgGUID: 4pHNXMGYRUCvYaWDZXMtEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="283004073"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 20:39:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9][PULL REQUEST] Intel IOMMU updates for v7.4
Date: Mon, 28 Sep 2026 11:27:13 +0800
Message-ID: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes are queued for v7.4-rc1. This update includes a
set of quick fixes and cleanups, including:

- Enhanced IQE fault handling for batched multiple descriptors,
- Optimization of page-table level calculation in compute_vasz_lg2_ss(),
- Fixes for several pre-existing issues reported by Sashiko,
- General cleanup and refinement.

These patches are based on v7.3-rc5. The full series is also available
on GitHub:

https://github.com/LuBaolu/intel-iommu/commits/iommu/vt-d/next

Please consider pulling this series into the iommu/vt-d branch.

Best regards,
baolu

Guanghui Feng (1):
  iommu/vt-d: Fix IQE handling to cover all descriptors in submission
    range

Lu Baolu (7):
  iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()
  iommu/vt-d: Do not ignore context table copy failures
  iommu/vt-d: Handle DID reservation errors when copying context tables
  iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
  iommu/vt-d: Use old domain parameter when attaching the blocking
    domain
  iommu/vt-d: Fix iopf refcount leak in nested attach
  iommu/vt-d: Drop old iopf ref only after attach succeeds

Zhenzhong Duan (1):
  iommu/vt-d: Fix page table level calculation in compute_vasz_lg2_ss()

 drivers/iommu/intel/iommu.h  |  17 +++-
 drivers/iommu/intel/dmar.c   |  70 +++++++++++++---
 drivers/iommu/intel/iommu.c  | 156 ++++++++++++++++++++++++++++++-----
 drivers/iommu/intel/nested.c |   2 +
 4 files changed, 211 insertions(+), 34 deletions(-)

-- 
2.43.0

