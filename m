Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65937CD2F
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113214; cv=none; b=P+yhodj711E2ubGYi3orbmELmcQShzkKiKgMgAJRsnFHYo+WFQQruJ7IVgNwA2I7X6ksq0OFoKUPkWL8KgYkHErlrqYVnSi4AnHPzJFl/fPUEX8BPl9YVcSAS+MLbm5FwKCAZRMCH7DvZjhMrP+EuIR+JVXm5hgpI/dg9yvVfyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113214; c=relaxed/simple;
	bh=SeUFqBqhnZNSyGmCd8YnVCEfmD6tSnYcrkiYRDzBzKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRqYivlU734fjAh3xNlUKCJ8FOPR2H3ZbucdwrSVnM3yW87wW63gV3aDs0L1sOaToB7dSkXQW0l6W5zm735J/Dmt3bvM83eUaQRV4iWdULxVpeU2NkxuvMcNLZ0ZKaYcOv/UIyZPCbTSuOwWUBYv8ZH0LZvYY0uoMJPdL7a0ruE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5DxdIY3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5DxdIY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775113213; x=1806649213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SeUFqBqhnZNSyGmCd8YnVCEfmD6tSnYcrkiYRDzBzKY=;
  b=F5DxdIY3SfvlILpsEzyrttcFgAsKZfga2ged39Ryo1n/PlwOuUVKrFYb
   sX2X9S6oRclo+qUrKiGUaRfA1G/sgK1RRlCeUvOlo1Gp1L+ZHyHqEdHro
   8Q4rhtq7c8Nn/ewZt2NRFIMECwzxdgMtuSdCsF/bvm8sUT1HZCQy6aN3M
   9Bz/Gz/iUnSEWr1I25cq6Rh8YMINgFCUSRHg/2CTIR4jsHM7B5J9uIX3c
   8npBB/x6uoLE4a5TkQFMdl6e5GjeG986AQIGC8UO7VclqIeGrs+xGhAuM
   3h4Z7Tc1SUsXeC2A65Cu8IOdkj8cQ76WkxZu2mMNVO1Co7BpS9xLhBYdo
   Q==;
X-CSE-ConnectionGUID: 7yLvjygnS0SXYLlYCmhEnw==
X-CSE-MsgGUID: 3sNbzIhfTUqzAjjhzELl8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76053611"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76053611"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 00:00:13 -0700
X-CSE-ConnectionGUID: NkVTMhB7Sy2ZGiZwePrpdQ==
X-CSE-MsgGUID: rTjwJ4SnQKa+l1Mso7qJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="231847666"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa005.jf.intel.com with ESMTP; 02 Apr 2026 00:00:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] [PULL REQUEST] Intel IOMMU updates for v7.1
Date: Thu,  2 Apr 2026 14:57:23 +0800
Message-ID: <20260402065734.1687476-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following changes are queued for v7.1-rc1. This update introduces a
new feature and several refactorings, including:

- Support for dirty tracking on domains attached to PASID.
- Removal of unnecessary read*()/write*() wrappers.
- Improvements to the invalidation paths.

These patches are based on v7.0-rc6. Please consider them for the
iommu/vt-d branch.

Best regards,
baolu

Bjorn Helgaas (2):
  iommu/vt-d: Remove dmar_readl() and dmar_readq()
  iommu/vt-d: Remove dmar_writel() and dmar_writeq()

Jason Gunthorpe (4):
  iommu/vt-d: Split piotlb invalidation into range and all
  iommu/vt-d: Pass size_order to qi_desc_piotlb() not npages
  iommu/vt-d: Remove the remaining pages along the invalidation path
  iommu/vt-d: Simplify calculate_psi_aligned_address()

Zhenzhong Duan (4):
  iommu/vt-d: Block PASID attachment to nested domain with dirty
    tracking
  iommu/vt-d: Rename device_set_dirty_tracking() and pass dmar_domain
    pointer
  iommu/vt-d: Support dirty tracking on PASID
  iommufd/selftest: Test dirty tracking on PASID

 drivers/iommu/intel/iommu.h             |  47 +++++------
 drivers/iommu/intel/trace.h             |  18 ++---
 drivers/iommu/intel/cache.c             | 100 ++++++++++--------------
 drivers/iommu/intel/debugfs.c           |  18 ++---
 drivers/iommu/intel/dmar.c              |  43 ++++------
 drivers/iommu/intel/iommu.c             |  55 +++++++------
 drivers/iommu/intel/irq_remapping.c     |   6 +-
 drivers/iommu/intel/pasid.c             |   6 +-
 drivers/iommu/intel/perfmon.c           |  50 ++++++------
 drivers/iommu/intel/prq.c               |  28 +++----
 tools/testing/selftests/iommu/iommufd.c |  27 +++++++
 11 files changed, 193 insertions(+), 205 deletions(-)

-- 
2.43.0

