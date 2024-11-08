Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2451E5721
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067476; cv=none; b=DocZvT6nRbS5fReFa5jZqIalm2O2EzV8zSqg84+WswwPJF5pHKxP0AQ4CsQmP7IoSQ8WSPSsH8+1gSCAOHCmrwoXK6ADnH4MIjv+aZ4SlT/GX8XAtnrirvELk5wqaAaqAmPZCOg5qVoRhVRGgrmiqiWlAPq+A2ioNCk5AiTxZ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067476; c=relaxed/simple;
	bh=BvuhGDkQ5Q/eUzXO09pJmHXIx5K3lL48DuqpFV4pfes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIYc/3O7yVrZNLEyz68puZYv5c/JV4T45ekILw5hgxp096rbS0twdfxPmEVo5uU4iyVazHZ3hl5BeLFqPhMjKYolOg8VpEhzaEzzOJF1hazZ38EnkT6pGpZtNTpJp2WRYepHzXTXYklBAJawSspL3ITSnYX7w/dkMMO8/av/yHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGGTY/3y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGGTY/3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731067475; x=1762603475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BvuhGDkQ5Q/eUzXO09pJmHXIx5K3lL48DuqpFV4pfes=;
  b=HGGTY/3yTNCq708FKafK269Yvl9kM5jzsAGWiwyKt1ODCY30bn1wNkin
   JmWBc1a9LJhkUYbv46Olj6zuTj813UcBPO3NmNFtUuYQNxEZS3IlaHin9
   W3O2alxJlxtazejVNXNu/GhWr/syhY8H6OzFWF9eKye86d5fQlIaO+6NC
   gR3CjSqr4ZXLV4wFYyn2smNit5tLLRZ8cVPSc3/qZw5/PCnboCN7O2gVP
   pDyYuuXkw9wf3nJQbV/0cS6qJ4qEvmpfAQLosaYMZzACypKwKw3SQnlWs
   XR0gw4NEIrdgq1q63O9X3FuDextra+Nq5NQp2DNqWU+DGMXWkJWmaa4Xd
   w==;
X-CSE-ConnectionGUID: 0mbTDCgIShGFQ9KnmAKKmg==
X-CSE-MsgGUID: cgD7KMRTS+WE5/4BflNcdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31116398"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31116398"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:04:30 -0800
X-CSE-ConnectionGUID: fv3my8bwRAe5kGPUoDC7kg==
X-CSE-MsgGUID: rPOg7a+GSmagIiPRkInLkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85679015"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2024 04:04:29 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	willy@infradead.org
Subject: [PATCH v4 0/7] Support attaching PASID to the blocked_domain
Date: Fri,  8 Nov 2024 04:04:20 -0800
Message-Id: <20241108120427.13562-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the review of iommufd pasid series, Kevin and Jason suggested
attaching PASID to the blocked domain hence replacing the usage of
remove_dev_pasid() op [1]. This makes sense as it makes the PASID path
aligned with the RID path which attaches the RID to the blocked_domain
when it is to be blocked. To do it, it requires passing the old domain
to the iommu driver. This has been done in [2].

This series makes the Intel iommu driver, ARM SMMUv3 driver and AMD iommu
driver support attaching PASID to the blocked domain. And in the end remove
the remove_dev_pasid op from iommu_ops.

[1] https://lore.kernel.org/linux-iommu/20240816130202.GB2032816@nvidia.com/
[2] https://lore.kernel.org/linux-iommu/20241104131842.13303-1-yi.l.liu@intel.com/

v4:
 - Remove unnecessary braces in patch 02 (Vasant)
 - Minor tweaks to patch 01 and 03 (Kevin)
 - Add r-b tags from Jason, Vasant, Kevin

v3: https://lore.kernel.org/linux-iommu/20241104132033.14027-1-yi.l.liu@intel.com/
 - Add a patch to check remove_dev_pasid() in iommu_attach_device_pasid()
 - Split patch 01 of v2 into two patches, drop the r-b of this patch due the
   split.
 - Add AMD iommu blocked domain pasid support (Jason)
 - Remove the remove_dev_pasid op as all the iommu drivers that support pasid
   attach have supported attaching pasid to blocked domain.

v2: https://lore.kernel.org/linux-iommu/20241018055824.24880-1-yi.l.liu@intel.com/#t
 - Add Kevin's r-b
 - Adjust the order of patch 03 of v1, it should be the first patch (Baolu)

v1: https://lore.kernel.org/linux-iommu/20240912130653.11028-1-yi.l.liu@intel.com/

Regards,
	Yi Liu

Jason Gunthorpe (1):
  iommu/arm-smmu-v3: Make the blocked domain support PASID

Yi Liu (6):
  iommu: Prevent pasid attach if no ops->remove_dev_pasid
  iommu: Consolidate the ops->remove_dev_pasid usage into a helper
  iommu: Detaching pasid by attaching to the blocked_domain
  iommu/vt-d: Make the blocked domain support PASID
  iommu/amd: Make the blocked domain support PASID
  iommu: Remove the remove_dev_pasid op

 drivers/iommu/amd/iommu.c                   | 10 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 ++++-----
 drivers/iommu/intel/iommu.c                 | 15 ++++++++---
 drivers/iommu/iommu.c                       | 28 +++++++++++++--------
 include/linux/iommu.h                       |  5 ----
 5 files changed, 44 insertions(+), 26 deletions(-)

-- 
2.34.1

