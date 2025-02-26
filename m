Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF14A21
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532733; cv=none; b=rIvqWsAhNdGgzWYyuT1e3paK3FegU1bElrlauwiZDpFCpmQEFEsm13CYNI6GaKmOOe/0snI5j8XWumWU1o+vaSw0XUBO0HfiMjWZosFcAPy+n/48SyUbk8o9sPTZhetbdpFVWLZtUltQdP+SdTwxJiRro94R5k7XgJaHqLzVK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532733; c=relaxed/simple;
	bh=xI3+lP0+x6N0tCgXxzXZHSssPG9C7gh3XR0xzKwKi7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KUNXa2v0d8Sb3gRrhI8AOTNiTtMAOLfXY+I2VyIA8u2567fXjGjgrPVB8Ip2ZE9kyq5H7hOjPN5xaXmvwN+06jwr5OiN2SDwngi+uVo9FGHPV2SZZz1KfDblQis5+S7O2ugJQtWZ4+yu5z8hxeLdkIMOTsUFT5sWP2r4HVpdiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ky1z9oxK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ky1z9oxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532731; x=1772068731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xI3+lP0+x6N0tCgXxzXZHSssPG9C7gh3XR0xzKwKi7w=;
  b=ky1z9oxKlhWM/MGpJAhbtm0Aln0DBpNTtQmki4xtFYbA/DjAbiCsKHVt
   xQfjmIKlLSHrtSIsAvwc6YyV+TAuQJ0M0SoKSvDuuxx9K2pVLbSqDJdy9
   bkpOFqIblhuNNO3IOiksZxErq8T3dJ8eV/b8+00Pl3D5vVyDhi0ap7mrJ
   GEgGiRVtih4PoUDcGvBEcVBS+Fq68Xrspky/LUfnIB5yzfONjmcyXrNZB
   ztWY4eHBOHns7Kotd6HjDEYg88wDpd25duyE5s9VeAz/cecbweAQZxRmy
   8E9+9vYf0FT28eKhoG3ZJPR+R3/937YXee9cu3Nrp2K7OM6z/kHWJRKcn
   g==;
X-CSE-ConnectionGUID: 0DYThWKBRv+AthzYJ8fZHA==
X-CSE-MsgGUID: 3aG6rcZZQSKKs7AxV5AZTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45015857"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45015857"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:18:51 -0800
X-CSE-ConnectionGUID: qMkMTYirRpuM3KuJeYqcFg==
X-CSE-MsgGUID: YIekbMwaTmGT/heV6qLEwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116563249"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 25 Feb 2025 17:18:51 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com
Cc: kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org
Subject: [PATCH v3 0/4] Misc iommu_attach_handle enhancements in iommu core
Date: Tue, 25 Feb 2025 17:18:45 -0800
Message-Id: <20250226011849.5102-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to enhance the iommu_attach_handle-related APIs
in the IOMMU core. The changes build upon Nic's previous series[1], which
ensured that users of the attach/replace handle APIs always provide a
valid handle. With this foundation, the series refactors the IOMMU core
to share code between the normal attach/replace APIs and the
handle-supporting APIs. Additionally, it seeks to avoid processing Page
Request Interrupts (PRIs) before the attach operation succeeds.

This series also covers the prior series[2] which only takes care of the
iommu_attach_device_pasid().

[1] https://lore.kernel.org/linux-iommu/cover.1738645017.git.nicolinc@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/20250120030840.4171-1-yi.l.liu@intel.com/

Base: https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?h=for-next&id=dc10ba25d43f433ad5d9e8e6be4f4d2bb3cd9ddb

Change log:

v3:
 - Refine iommu_attach_handle_get() (Baolu)
 - More r-b tags

v2: https://lore.kernel.org/linux-iommu/20250221143335.49874-1-yi.l.liu@intel.com/
 - Move handl->domain under group->mutex protect (Nic)
 - Refine the patch 04 per the model of reserve xa first and then xa_store in
   the end which does not suppose to fail (Jason)
 - Drop the patch 05 of v1 as retire group->domain requires further effort
 - Add r-b tags

v1: https://lore.kernel.org/linux-iommu/20250212060540.261436-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Yi Liu (4):
  iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
  iommu: Drop iommu_group_replace_domain()
  iommu: Store either domain or handle in group->pasid_array
  iommu: Swap the order of setting group->pasid_array and calling attach
    op of iommu drivers

 drivers/iommu/iommu-priv.h |   3 -
 drivers/iommu/iommu.c      | 135 +++++++++++++++++++++----------------
 2 files changed, 77 insertions(+), 61 deletions(-)

-- 
2.34.1

