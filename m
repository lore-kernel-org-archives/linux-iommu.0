Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B191DE4F3
	for <iommu@lists.linux.dev>; Mon, 14 Jul 2025 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468769; cv=none; b=G1pQgH0yp0N6QNF4fFedxEhqoY1s/KlQhLqIU2Smaxd17TArqZpQcP1RNH95ax89zfsRCU+095kQCGAx/bqaowVLjDUNqX1OLGeige46l2mjWQdILK/0BiHqh5rrDPbUVOexRwklUdBh8kyjG//JlEseTYUmSYpWsj9pr/wU9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468769; c=relaxed/simple;
	bh=CFwvR4QIuUoDSCq+EWNNCPtqZ6tCHCMK6vhI/yh3rKs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhSWfWI7QDJmuRhqFlk2KxRHExgbjxLwBAlcSubvO5yd/bbPg84m7B3w7N2o2Nq+aCvoixZikd4D6hnQD9mKP0fC5lI305WQxCAjHY4+lHATLhT+/UJ8jiYATBe8ZYxoM5aYkvSP2/Kej1VVIPkD4ikjHdr2QWEvtKpkfw9sMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4lHQHEK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4lHQHEK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752468767; x=1784004767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CFwvR4QIuUoDSCq+EWNNCPtqZ6tCHCMK6vhI/yh3rKs=;
  b=j4lHQHEKhfFkA+8nEBjKuBL6f/OZmwD6c2yo0fPIDQ48UyZ69ZkhpMUs
   0MdeDPCns9Qsro35J+C93tvUemfFaNut0Aznz1GS7Fpvl1iFgx7fauAST
   h9ukMo+yoTnhWXJrgFm1STd6DxrreTPJo4vbzWBCwiYBOLlsvzZbcle6f
   d60a/4bqrrl92007zU9FLcEIp6iTenZ4lN2i2p0TYTRiOz9pf+W11Atdk
   NJiIGUC4icXt/nZ7lnpJ+WwXDclUnauaxfrWr8SeoFwiICR8BIOpu+G8F
   TkQpe0/5xDeTi+NBY/Z1vTj2Aj5bEKt3K86H2hTlDK16hgPO5O7kf15Sa
   Q==;
X-CSE-ConnectionGUID: IRTkJRbbSTubkZHLp5y01g==
X-CSE-MsgGUID: rEDavBivQzeeFDyHY9ud7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53765034"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="53765034"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 21:52:47 -0700
X-CSE-ConnectionGUID: k0CKCGoQSguF5gsKGOpnZQ==
X-CSE-MsgGUID: IhYjCzxpQK2owadY1Ht11g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="161166142"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa003.jf.intel.com with ESMTP; 13 Jul 2025 21:52:46 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] [PULL REQUEST] Intel IOMMU updates for v6.17
Date: Mon, 14 Jul 2025 12:50:17 +0800
Message-ID: <20250714045028.958850-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes have been queued for v6.17-rc1. They are about new
features and code refactoring, including:

 - Reorganize Intel VT-d to be ready for iommupt
 - Optimize iotlb_sync_map for non-caching/non-RWBF modes
 - Fix missed PASID in dev TLB invalidation in cache_tag_flush_all()
 - Miscellaneous cleanups

These patches are based on v6.16-rc6. Please consider them for the
iommu/vt-d branch.

Best regards,
baolu

Ethan Milon (2):
  iommu/vt-d: Fix missing PASID in dev TLB flush with
    cache_tag_flush_all
  iommu/vt-d: Deduplicate cache_tag_flush_all by reusing flush_range

Jason Gunthorpe (7):
  iommu/vt-d: Lift the __pa to
    domain_setup_first_level/intel_svm_set_dev_pasid()
  iommu/vt-d: Fold domain_exit() into intel_iommu_domain_free()
  iommu/vt-d: Do not wipe out the page table NID when devices detach
  iommu/vt-d: Split intel_iommu_domain_alloc_paging_flags()
  iommu/vt-d: Create unique domain ops for each stage
  iommu/vt-d: Split intel_iommu_enforce_cache_coherency()
  iommu/vt-d: Split paging_domain_compatible()

Lu Baolu (1):
  iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes

Vineeth Pillai (Google) (1):
  iommu/vt-d: Remove the CONFIG_X86 wrapping from iommu init hook

 drivers/iommu/intel/cache.c  |  55 ++----
 drivers/iommu/intel/dmar.c   |   3 -
 drivers/iommu/intel/iommu.c  | 336 ++++++++++++++++++++++-------------
 drivers/iommu/intel/iommu.h  |  22 ++-
 drivers/iommu/intel/nested.c |   4 +-
 drivers/iommu/intel/pasid.c  |  17 +-
 drivers/iommu/intel/pasid.h  |  11 +-
 drivers/iommu/intel/svm.c    |   3 +-
 drivers/iommu/intel/trace.h  |   5 -
 9 files changed, 259 insertions(+), 197 deletions(-)

-- 
2.43.0

