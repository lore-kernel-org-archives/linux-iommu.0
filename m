Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4418C14
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687380906; x=1718916906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uRdgEoZTkjy+SEdnhmnRlcCE88Nj+MRwVpT6jrLUnmE=;
  b=nactn4NwRHorDOFM2uRoMuRd53IO3BOdJmczOs6bt/4RQ+rABkF4RPFp
   HzXUjCqhHfIJM0q/ymM0XCJe88+ygQrlb9P4xURMyBYc9dvQ9YasLk+9Q
   LdDeXeUwWZP9F4B5aW+AFT5NW9qSWUE3x2+usdB17xUF4OXGsYnMp4imr
   AQCHbloWszel1747tfFaQNJjP4WYznwMwmcCeCuoC1OQTm/b3EdIuDcNK
   yuBC0UQNZI2CQrN6MJ4auu4yPGcMedo2xWg4we7YVsJOIqxG1gMuc/Xb7
   w6muA4x/3ZkWb2OyPI1HtIaa3u9x8GowCv34tfRd9otERu8qaY4DNy3+L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359168881"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359168881"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 13:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="827597874"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="827597874"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2023 13:55:01 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
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
	rex.zhang@intel.com,
	xiaochen.shen@intel.com,
	narayan.ranganathan@intel.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v9 0/7] Re-enable IDXD kernel workqueue under DMA API
Date: Wed, 21 Jun 2023 13:59:40 -0700
Message-Id: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg and all,

IDXD kernel work queues were disabled due to the flawed use of kernel VA
and SVA API.
Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/

The solution is to enable it under DMA API where IDXD shared workqueue users
can use ENQCMDS to submit work on buffers mapped by DMA API.

This patchset adds support for attaching PASID to the device's default
domain and the ability to allocate global PASIDs from IOMMU APIs. IDXD driver
can then re-enable the kernel work queues and use them under DMA API.

This depends on the IOASID removal series. (merged)
https://lore.kernel.org/all/ZCaUBJvUMsJyD7EW@8bytes.org/


Thanks,

Jacob

---
Changelog:
v9:
	- Fix an IDXD driver issue where user interrupt enable bit got cleared
	  during device enable/disable cycle. Reported and tested by
	  Tony Zhu <tony.zhu@intel.com>
	- Rebased to v6.4-rc7
v8:
	- further vt-d driver refactoring (3-6) around set/remove device PASID
	  (Baolu)
	- make consistent use of NO_PASID in SMMU code (Jean)
	- fix off-by-one error in max PASID check (Kevin)
v7:
	- renamed IOMMU_DEF_RID_PASID to be IOMMU_NO_PASID to be more generic
	  (Jean)
	- simplify range checking for sva PASID (Baolu) 
v6:
	- use a simplified version of vt-d driver change for set_device_pasid
	  from Baolu.
	- check and rename global PASID allocation base
v5:
	- exclude two patches related to supervisor mode, taken by VT-d
	maintainer Baolu.
	- move PASID range check into allocation API so that device drivers
	  only need to pass in struct device*. (Kevin)
	- factor out helper functions in device-domain attach (Baolu)
	- make explicit use of RID_PASID across architectures
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

Jacob Pan (3):
  iommu: Generalize PASID 0 for normal DMA w/o PASID
  iommu: Move global PASID allocation from SVA to core
  dmaengine/idxd: Re-enable kernel workqueue under DMA API

Lu Baolu (4):
  iommu/vt-d: Add domain_flush_pasid_iotlb()
  iommu/vt-d: Remove pasid_mutex
  iommu/vt-d: Make prq draining code generic
  iommu/vt-d: Add set_dev_pasid callback for dma domain

 drivers/dma/idxd/device.c                     |  39 ++---
 drivers/dma/idxd/dma.c                        |   5 +-
 drivers/dma/idxd/idxd.h                       |   9 +
 drivers/dma/idxd/init.c                       |  54 +++++-
 drivers/dma/idxd/sysfs.c                      |   7 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  16 +-
 drivers/iommu/intel/iommu.c                   | 161 +++++++++++++++---
 drivers/iommu/intel/iommu.h                   |   9 +
 drivers/iommu/intel/pasid.c                   |   2 +-
 drivers/iommu/intel/pasid.h                   |   2 -
 drivers/iommu/intel/svm.c                     |  53 +-----
 drivers/iommu/iommu-sva.c                     |  28 ++-
 drivers/iommu/iommu.c                         |  28 +++
 include/linux/iommu.h                         |  11 ++
 15 files changed, 291 insertions(+), 135 deletions(-)

-- 
2.25.1

