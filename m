Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5043B1DD866
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513461; cv=none; b=bp6e9wZ7U/OvmIKvDzPOQ/6nfn6V+OcLVmChQeuJLUJIwY1063rcSjcmuup69JKtol2mt1/VaQgULtTGsBwogjvSLJA6aa4lJZRPTQgX+1mN9+Hvo3HpMZbx1iAdPs4afSpp6lQ4iyJ2/c6oiTlszX9tO14vK/V6zSMrkKjxq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513461; c=relaxed/simple;
	bh=ro5xkK8yo/KndYQDY5G/N/Su5NsLJ2Xcrw1UPYjyoa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Krp9x/7WraWT/sq/W08lmYyf+xRStwJ+hQVT6C3gzXExxBG4ySUa10SwgkVqHO9HrHlDpUNv4FRtv8+1egujZ6UFpTi6RQEKqCsUHDLqk2GdRJoLJLY0o08VGmBiwPS4FQ5OB4IynC4przcXQ/3MRZ4ZRcrZ3SuWV8o8p0UEP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfBALzGf; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfBALzGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513460; x=1771049460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ro5xkK8yo/KndYQDY5G/N/Su5NsLJ2Xcrw1UPYjyoa4=;
  b=IfBALzGfz90RuGmneQv+C0p99IoMkTLDsUz+M1gyHTHDtIUZAaa6d/bm
   qslmwDV54oKviBwfnIl4Bm+WzfsRbroyGTRhd0eRB+PFILpv3Bd3rM3gA
   aYvzZLkMOA8yP3DhHFFvtmU1h0aNEIGSQkN5cIyZA2IyUNszLSKFzcgF3
   1qeADSEwON4vKhjasB+yZ0vJFZzHygFh0MNXOtcxw7DKZqdGn6s2tS2d8
   o01usatNv7A9SQ8hPwOify4WfJ25PKJbZKBbH25Ux9z/Gm/E8fE8fXbjF
   WrV1K+QFUa/1rFm1Wfpa0S/mrtz9R5m7k0aGDdchqP5qwCHAMTFDbjJU5
   Q==;
X-CSE-ConnectionGUID: qBdxBZLfTrSmWHnZbxg6ig==
X-CSE-MsgGUID: 5CqbTmLGQ7+5Eo1q3vUGZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124443"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124443"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:00 -0800
X-CSE-ConnectionGUID: wVpSM2PQQvCo3DVnaeEv7Q==
X-CSE-MsgGUID: 5ZcLeNMmSKCVjI3nhGwtNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268011"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:10:56 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Date: Fri, 14 Feb 2025 14:10:52 +0800
Message-ID: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
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
https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v1

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 130 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  34 +-
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
 drivers/iommu/iommufd/selftest.c              |  52 ++-
 drivers/misc/uacce/uacce.c                    |  40 ---
 include/linux/iommu.h                         |  35 --
 20 files changed, 380 insertions(+), 699 deletions(-)

-- 
2.43.0

