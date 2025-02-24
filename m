Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F828DB3
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374181; cv=none; b=nsR78yaQu1Gc01upHLliAGEJ5z111UunqDNZVK0By/g8f0qhx20zNe6SG20iExC9Mg+l0c6NeaArQ0Wp25/oSa3Fe6FXf/u0MGs8530qOjuBcOR2NZU2JRQim3opzQnnRfH+Arb3jWQWdQZ3s0tuoijeUG8a5MGyi7YPWhO2p80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374181; c=relaxed/simple;
	bh=bX0c1Z3pgAFM9CQVFkDvu+efIZ3/7VYogn//aiasHQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pm1xqdi2ZEc4K497zGuXuV8Gk8DNDOXj/dvxYfihgwGtgD/YkGUIE6GqpaMFbPEkHcxpOGwkqPLyTZr7i7qMkdZZ2pDW/qiTLvfORuLYlpg4FTXF7vts5M5yKi2Ovlo+k5tOiHEWi+AWQLB6xERdgEuITa0kKHVXKLzougwpDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAzZSGA6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAzZSGA6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740374180; x=1771910180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bX0c1Z3pgAFM9CQVFkDvu+efIZ3/7VYogn//aiasHQs=;
  b=kAzZSGA6NdsXyKVq4L3XOySTN9n+jItOksh+lxYCCII9M73NlgvOyYmS
   v2D67Phllk9AqTpc4nwcUrFsM184YnhPwudg/DdUdW03DXbMBZpX6zaVS
   4R3yYxNJVAn4ssbnFeQ7IDAZIPlKXtDe41eJf4DJVbjVAhcQwZ0VSbIV0
   wanV8GLtdhkaMlVRV2kj1Zfpr0TToUQycdYNQw0ipMdjNve6WfqxMEGy7
   H00Cj6/Xgg214iE6XeWyacwIsgep2RvrhKOUW46l9sro5dJIqrWq4VyBZ
   N+tXsSA9YP4ovlapxmhlWPmHS4ma0tvmd4xSsAkSmvUfAqEphEt5mhNag
   Q==;
X-CSE-ConnectionGUID: OLZg1gTiT6Cfza3ysqvVEg==
X-CSE-MsgGUID: z4+D2VPtR1qQGJaJDNSjEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="45024166"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45024166"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:16:20 -0800
X-CSE-ConnectionGUID: 9Fw76pA/Qa2DvyGsn1CJ1Q==
X-CSE-MsgGUID: BSZ85JlKTySZBOypzh1IDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116143349"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2025 21:16:16 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Date: Mon, 24 Feb 2025 13:16:14 +0800
Message-ID: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new method for driver fault reporting support relies on the domain
to specify a iopf_handler. The driver should detect this and setup the
HW when fault capable domains are attached.

Move SMMUv3 to use this method and have VT-D validate support during
attach so that all three fault capable drivers have a no-op FEAT_SVA and
_IOPF. Then remove them.

This was initiated by Jason. I'm following up to remove FEAT_IOPF and
further clean up.

The whole series is also available at github:
https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v2

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Change log:
v2:
 - Fix removing wrong nesting master_domain in
   arm_smmu_remove_master_domain().
 - Fix iopf enable/disable in iommufd mock driver for domain
   replacement. 

v1: https://lore.kernel.org/linux-iommu/20250214061104.1959525-1-baolu.lu@linux.intel.com/

Jason Gunthorpe (3):
  iommu/arm-smmu-v3: Put iopf enablement in the domain attach path
  iommu/vt-d: Check if SVA is supported when attaching the SVA domain
  iommu: Remove IOMMU_DEV_FEAT_SVA

Lu Baolu (9):
  iommu/vt-d: Move scalable mode ATS enablement to probe path
  iommu/vt-d: Move PRI enablement in probe path
  iommu/vt-d: Cleanup intel_context_flush_present()
  iommu/vt-d: Put iopf enablement in domain attach path
  iommufd/selftest: Put iopf enablement in domain attach path
  dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
  iommu: Remove iommu_dev_enable/disable_feature()

 drivers/accel/amdxdna/aie2_pci.c              |  13 +-
 drivers/dma/idxd/init.c                       |  43 +--
 drivers/iommu/amd/iommu.c                     |  34 --
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  86 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 137 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  39 +--
 drivers/iommu/intel/iommu.c                   | 301 ++++++------------
 drivers/iommu/intel/iommu.h                   |  50 ++-
 drivers/iommu/intel/nested.c                  |  16 +-
 drivers/iommu/intel/pasid.c                   |  41 +--
 drivers/iommu/intel/prq.c                     |   2 +-
 drivers/iommu/intel/svm.c                     |  52 ++-
 drivers/iommu/iommu-sva.c                     |   3 -
 drivers/iommu/iommu.c                         |  32 --
 drivers/iommu/iommufd/device.c                |   1 -
 drivers/iommu/iommufd/fault.c                 | 111 ++-----
 drivers/iommu/iommufd/iommufd_private.h       |   3 -
 drivers/iommu/iommufd/selftest.c              |  63 +++-
 drivers/misc/uacce/uacce.c                    |  40 ---
 include/linux/iommu.h                         |  35 --
 20 files changed, 401 insertions(+), 701 deletions(-)

-- 
2.43.0

