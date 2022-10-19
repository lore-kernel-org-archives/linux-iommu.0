Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD4D1867
	for <iommu@lists.linux.dev>; Wed, 19 Oct 2022 00:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666140675; x=1697676675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3fKg8f+rUsRhq8820aHbFsfSRtqarBvNZDHgn9EN1Lo=;
  b=FLya86G0I2xEL/4U6cSZcq+UG1ZNrjc/k8T8C+LsWO9RrEcmYcnCMyN8
   5rBLsUSWTuLvTVP3gpd10WIVoZe9KdcFpX279ICDTvNj1/V8clm61NI2r
   d/ZqnRGSBsGDVHkuIF6BASIdwlz14J7Aqq/4qeKwYKlpl2t09pobQhC+d
   +Wb5BYztzhJuBpahUgvGXHsT8cdXiME0b5++cDP4ptUhIpjOjuay/v9jm
   537GYxLFiajSkheJZSfr2okSB/xLUp/lwQ+tryM6oKUf8UHyCBTYieU9Z
   B0L+QXnsa+lVusTgRYXrjdG/AF2vmXLaW4ttNa84TTSkqxJ1DJtiWmxL3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="368325489"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="368325489"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 17:51:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="606824799"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="606824799"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 18 Oct 2022 17:51:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>,
	Charlotte Tan <charlotte@extrahop.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] [PULL REQUEST] iommu/vt-d: Fixes for v6.1-rc2
Date: Wed, 19 Oct 2022 08:44:43 +0800
Message-Id: <20221019004447.4563-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

Below fixes are queued for v6.1. They aim to fix:

- A lockdep splat issue in intel_iommu_init().
- Allow NVS regions to pass RMRR check.
- Domain cleanup in error path.

This series is also available at github.
https://github.com/LuBaolu/intel-iommu/commits/vtd-fix-for-v6.1-rc2

Please consider it for the iommu/fix branch.

Best regards,
Lu Baolu

Charlotte Tan (1):
  iommu/vt-d: Allow NVS regions in arch_rmrr_sanity_check()

Jerry Snitselaar (1):
  iommu/vt-d: Clean up si_domain in the init_dmars() error path

Lu Baolu (2):
  iommu: Add gfp parameter to iommu_alloc_resv_region
  iommu/vt-d: Use rcu_lock in get_resv_regions

 include/linux/iommu.h                       |  2 +-
 arch/x86/include/asm/iommu.h                |  4 +++-
 drivers/acpi/arm64/iort.c                   |  3 ++-
 drivers/iommu/amd/iommu.c                   |  7 ++++---
 drivers/iommu/apple-dart.c                  |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
 drivers/iommu/intel/iommu.c                 | 17 ++++++++++++-----
 drivers/iommu/iommu.c                       |  7 ++++---
 drivers/iommu/mtk_iommu.c                   |  3 ++-
 drivers/iommu/virtio-iommu.c                |  9 ++++++---
 11 files changed, 37 insertions(+), 21 deletions(-)

-- 
2.34.1
