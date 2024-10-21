Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F70D8C0B
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500983; cv=none; b=f3PZxJdsXrSWYzlJVxq0qS8sMHdTFcDYJGG1I6h2NTid9BWqLoO368zxVdRP7MsBrq82/gxtK9CkwguQFJR25xt9YSJN8vC3cKqP1IUI9W4VG1lOjgcklOlByc9b0vcjmMGeh10XbhUrjTchsa5R8VBZEoLAFVkikOEaoMzghvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500983; c=relaxed/simple;
	bh=DqVHfaNMpCWAdbipf6aWWFv0/jE/1zXx0gTstlzsYZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXwvXDMfvQ1al0wo1zWTc6ozXsuIKzbDrr/3XkqmaWS/ZaoEcAAIHyRbPXSmhbvbjsEGt+6K3j3vFKro55OQC0jXeTC8xl7OiMI+GtutIsnR55CDZubNig7KDQjauujnIxm0Ux9zloKKZ17UDlUfbvxtfmFPGr+kN9jEsFMnces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbMYqbwN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbMYqbwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500982; x=1761036982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DqVHfaNMpCWAdbipf6aWWFv0/jE/1zXx0gTstlzsYZ4=;
  b=jbMYqbwN9bz6okay3imqhIpnjVCqaXORL4WwrqDlxiGQirwFN4a2JVRL
   bFLd2dKMQzE4Bq5AfSyGnsqiDZyB01zwHlI9hpgSmysHVVsokvByn3UhK
   FYtHJRkafRriQG5bQvT5sP/djvD/dvsgSDFq23yPO6TBVAnW5W4Ji9jC7
   n6f4S5KvIAU6u+co/ifT4jZuQL4bi34ukBYQ57s64/LfKBDVeu3vq9hX7
   mKe1P0+eSk3ypO8OGbQ0KPL3D5vniSkef049UQCHJ/6vXppKELSfd3XCV
   DdINQPy7gLYodaGlAsyxRyQFlmSVOPDV9ntcPG9P5MdOkNYuqgbXVSIVJ
   A==;
X-CSE-ConnectionGUID: gIm+fngeSoWTa+Yf88+aSw==
X-CSE-MsgGUID: 5R/175+RTsudEvRJcHanJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32780308"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32780308"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:56:22 -0700
X-CSE-ConnectionGUID: Z7mWkbAvQf22FK5z1vpvdw==
X-CSE-MsgGUID: N7C7zREfSJaUjp8wz0NYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79812701"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 01:56:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/7] iommu/vt-d: Add domain_alloc_paging support
Date: Mon, 21 Oct 2024 16:51:17 +0800
Message-ID: <20241021085125.192333-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel iommu driver will now use the domain_alloc_paging callback and
remove the legacy domain_alloc callback. This ensures that a valid
device pointer is provided whenever a paging domain is allocated, and
all dmar_domain attributes can be set up at the time of allocation.

Both first-stage and second-stage page tables can be used for a paging
domain. Unless IOMMU_HWPT_ALLOC_NEST_PARENT or
IOMMU_HWPT_ALLOC_DIRTY_TRACKING is specified during paging domain
allocation, this driver will try to use first-stage page tables if the
hardware is capable. This is assuming that the first-stage page table is
compatible with both the host and guest kernels.

The whole series is also available on GitHub:
https://github.com/LuBaolu/intel-iommu/commits/vtd-domain_alloc_paging-v2

Please help review and comment.

Change log:

v2:
 - Make prepare_domain_attach_device() a specific helper to check
   whether a paging domain is compatible with the iommu hardware
   capability.
 - Rename prepare_domain_attach_device() to paging_domain_compatible()
   to make it more meaningful.

v1: https://lore.kernel.org/linux-iommu/20241011042722.73930-1-baolu.lu@linux.intel.com/

Lu Baolu (7):
  iommu/vt-d: Add domain_alloc_paging support
  iommu/vt-d: Remove unused domain_alloc callback
  iommu/vt-d: Enhance compatibility check for paging domain attach
  iommu/vt-d: Remove domain_update_iommu_cap()
  iommu/vt-d: Remove domain_update_iommu_superpage()
  iommu/vt-d: Refactor first_level_by_default()
  iommu/vt-d: Refine intel_iommu_domain_alloc_user()

 drivers/iommu/intel/iommu.h  |   4 +-
 drivers/iommu/intel/iommu.c  | 328 +++++++----------------------------
 drivers/iommu/intel/nested.c |   2 +-
 drivers/iommu/intel/pasid.c  |  28 +--
 4 files changed, 64 insertions(+), 298 deletions(-)

-- 
2.43.0

