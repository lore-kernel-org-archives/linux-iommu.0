Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C38482
	for <iommu@lists.linux.dev>; Fri,  7 Apr 2023 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680890511; x=1712426511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XPLAtKzAfcKSPyY+GyxcvvkfUGKFQVLUMA8YHZypMgs=;
  b=R/ep9xEO1HVkXrrTSv8mSqoCGoM0cwFCKP9gayWGnSRQ996XACHdD/Pu
   8AyuncCWON5EAahuS9F/yWkoIBmtm+5Ufb3V0mMixyXycB/Qa8BO+quDd
   MKWqbx2qlEylAOIe88Ghh6qY7X6qbASZg0ArCVaIT5+ap1sHR5LFnNger
   EfPENnY/dISxxVurxQ6GuEmETYaIpBSqksqHC+sm2MO/RxyXDgCRAUK5B
   xKWATR81W87KTeDLP43GgEEMXBJH3m4iYbIvlHjXGVv4vMmKHh9Dn0Yvy
   CHIkGbOoUnV8sOCwC2OwLKERCJzX7CGIa53pQYXf6qkQ9pwqP3Q8bjdjF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="343046463"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="343046463"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 11:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="776910032"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="776910032"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2023 11:01:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 0/7] Re-enable IDXD kernel workqueue under DMA API
Date: Fri,  7 Apr 2023 11:05:47 -0700
Message-Id: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

IDXD kernel work queues were disabled due to the flawed use of kernel VA
and SVA API.
Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/

The solution is to enable it under DMA API where IDXD shared workqueue users
can use ENQCMDS to submit work on buffers mapped by DMA API.

This patchset adds support for attaching PASID to the device's default
domain and the ability to reserve global PASIDs from SVA APIs. We can then
re-enable the kernel work queues and use them under DMA API.

This depends on the IOASID removal series.
https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/


Thanks,

Jacob

---
Changelog:
v4:
	- move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
	- dropped domain type check while disabling idxd system PASID (Baolu)

v3:
	- moved global PASID allocation API from SVA to IOMMU (Kevin)
	- remove #ifdef around global PASID reservation during boot (Baolu)
	- remove restriction on PASID 0 allocation (Baolu)
	- fix a bug in sysfs domain change when attaching devices
	- clear idxd user interrupt enable bit after disabling device( Fenghua)
v2:
	- refactored device PASID attach domain ops based on Baolu's early patch
	- addressed TLB flush gap
	- explicitly reserve RID_PASID from SVA PASID number space
	- get dma domain directly, avoid checking domain types



Jacob Pan (7):
  iommu/vt-d: Use non-privileged mode for all PASIDs
  iommu/vt-d: Remove PASID supervisor request support
  iommu: Support allocation of global PASIDs outside SVA
  iommu/vt-d: Reserve RID_PASID from global PASID space
  iommu/vt-d: Make device pasid attachment explicit
  iommu/vt-d: Implement set_dev_pasid domain op
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

 drivers/dma/idxd/device.c   |  30 +-----
 drivers/dma/idxd/init.c     |  60 +++++++++++-
 drivers/dma/idxd/sysfs.c    |   7 --
 drivers/iommu/intel/iommu.c | 180 +++++++++++++++++++++++++++++-------
 drivers/iommu/intel/iommu.h |   8 ++
 drivers/iommu/intel/pasid.c |  43 ---------
 drivers/iommu/intel/pasid.h |   7 --
 drivers/iommu/iommu-sva.c   |  10 +-
 drivers/iommu/iommu.c       |  33 +++++++
 include/linux/iommu.h       |  11 +++
 10 files changed, 262 insertions(+), 127 deletions(-)

-- 
2.25.1

