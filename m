Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E025291D
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734783; cv=none; b=RtL4PZn0ZF3oNrSZVcZzKNUsKonlAtxgfBKUwQ18AiF0vB6c7VhmVJrMtnk8k2pvRqU1BahAONQvrh3eXKPTTv0xxPYCHM+yN8t2cjGlvezxfc/gwS8qEQA/NfsFmlPNgx7jQIbfFuQj6g0de/uYF1zptPu2gBQyOcJGPjkEnjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734783; c=relaxed/simple;
	bh=mxFGrqU5iySSHO3V8jHgjIhnbhkeDzZZjEqk0JgFK8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPMtCwMK5/Q0Ts7uxjMnck1XUYWmrIsh1GcDZfk0NUXUZIYMkLqklg7OBS4nLc4CYHKYTQVb5cXwU7m29FrJA3SHAOuveVQQepbgrqGqjH+sX1SHeNWUsk3zHhM72+RAAmBYEox367fO9hHCbAQmbkACSGdscu17VmIbWjtsSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4QNDo89; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4QNDo89"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740734781; x=1772270781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mxFGrqU5iySSHO3V8jHgjIhnbhkeDzZZjEqk0JgFK8w=;
  b=H4QNDo89crbqqu9r7SXSbhOgwtph/9Lbhc0SuDZmlxh71U9bZM91pebl
   9CD2IkjsZ5aQIA0PdndFOLjhSjyZeSzdcg3Uu88MnmucyM8MDm6xUXGEB
   KUC7gxkWYtJX0Lns4wu1PMSrpOSJeB034e2mS2jezI/tO7XjxDsP1ubU6
   0roFrR+154qH8MukEFBH6zF0h2eS+nnERIQCseekC0B3HekyWdbtMA48p
   GUrHxUqTc6wqtkNMcJCvVuXTbU667WufKmMi1EP8qckftLacT2IMUPE2b
   2sj4XJ/wOa3HmPCPRla8p+VCtBoxxLjASUdwsJh+5ZvmpBluHZrxixrhR
   A==;
X-CSE-ConnectionGUID: XMhBYNs1TRyNr1zgWpdwkA==
X-CSE-MsgGUID: 8Rh4FKlCRo2UigQEcumXuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438269"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438269"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:26:21 -0800
X-CSE-ConnectionGUID: eZoWFmTDSHOIt79RUOVDjg==
X-CSE-MsgGUID: ppVRpn2PRwa3wAHxHfKY4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148212920"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:26:17 -0800
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
Subject: [PATCH v3 00/12] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
Date: Fri, 28 Feb 2025 17:26:19 +0800
Message-ID: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
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
https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v3

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Change log:
v3:
 - Series has been tested by Zhangfei Gao with arm-smmu-v3 driver.
 - Refined some code according to Kevin's suggestions.
 - No functional change.

v2: https://lore.kernel.org/linux-iommu/20250224051627.2956304-1-baolu.lu@linux.intel.com/
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
 drivers/iommu/amd/iommu.c                     |  34 ---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  86 +-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 137 +++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  39 +--
 drivers/iommu/intel/iommu.c                   | 282 +++++++-----------
 drivers/iommu/intel/iommu.h                   |  42 ++-
 drivers/iommu/intel/nested.c                  |  16 +-
 drivers/iommu/intel/pasid.c                   |  43 +--
 drivers/iommu/intel/prq.c                     |   2 +-
 drivers/iommu/intel/svm.c                     |  52 +++-
 drivers/iommu/iommu-sva.c                     |   3 -
 drivers/iommu/iommu.c                         |  32 --
 drivers/iommu/iommufd/device.c                |   1 -
 drivers/iommu/iommufd/fault.c                 | 111 ++-----
 drivers/iommu/iommufd/iommufd_private.h       |   3 -
 drivers/iommu/iommufd/selftest.c              |  64 +++-
 drivers/misc/uacce/uacce.c                    |  40 ---
 include/linux/iommu.h                         |  35 ---
 20 files changed, 395 insertions(+), 683 deletions(-)

-- 
2.43.0

