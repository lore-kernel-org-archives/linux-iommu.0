Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91213D2A7
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466038; cv=none; b=S20GMdz26RqZY3WTKXuk+BuO3EKLhc71piBlry2nUGxx4kYRTBVjPCoNttSUbHd4G3BOR/mww81GZba1GOLYiJwP18kLeN/dhx/nMfIY6YKKBWwdgZnmv/mH9M4l3O7YNoHV4ENrp/lRVLGIJK03l0s/RnYeFW0x7Z+qfDyuiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466038; c=relaxed/simple;
	bh=FDw/JYGsFECGdpr3U7icWMaqh/hY73ji20ol+xtCKUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JsciptzUJ3YwIy2AqP6Rhy8mLYOLwxTb3bfPQIttci/f/DYDPx4JvpAtZLwlxemqMs+eheJn9eNsq80+gqFZXJ71p6sGqA6I1jcQp2jLt7EloVRFSHX3xoJcMMdjV9/LvXc6Qb5Tw+aso/YJiRr17bjaG0C31+grdr7ptkKzLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icHwdoW+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icHwdoW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717466036; x=1749002036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FDw/JYGsFECGdpr3U7icWMaqh/hY73ji20ol+xtCKUk=;
  b=icHwdoW+rcYLvTwyqajAAzwd8oFHSN0N0gZlhnVz3HJTsBF77ClJvXWz
   aVwUmMjVp8BacY+rwqJ7fmmGHn2Ttng647+vZryW6wbWhU/RbG4lSoGua
   88UXs+FYGaXVwQvIyl93YV/+Ve1bReKOX2rKiLRYBx+vUd6kHdEYPxhuB
   l3f2fv86ZSdB1BZ8320abSWnSRAjhHFGIK85wK6bOqH9Uv1HdG7lcxAjK
   dGsbl4fnNOWaZTXGjKehPR5D9UkS6IxzHZi4tYB2R6Xmw4ypQebXjG44e
   CCwiSlGZVCgXi7pgkTa3t9ulK1lq7T+y7WoyoR4zt8bp6Q5uFj4mhjI3L
   A==;
X-CSE-ConnectionGUID: j6+k9d6yTVadnbWC8F8xsw==
X-CSE-MsgGUID: PwTbjS2GSmeD56aPo3QE6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25384821"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="25384821"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 18:53:54 -0700
X-CSE-ConnectionGUID: puBVw6JySxmadLGN/9Xe0g==
X-CSE-MsgGUID: tG6p/y8uStKjcWtzoSQveg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37661769"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 18:53:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 00/22] iommu: Refactoring domain allocation interface
Date: Tue,  4 Jun 2024 09:51:12 +0800
Message-Id: <20240604015134.164206-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU subsystem has undergone some changes, including the removal
of iommu_ops from the bus structure. Consequently, the existing domain
allocation interface, which relies on a bus type argument, is no longer
relevant:

    struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)

This series is designed to refactor the use of this interface. It
proposes two new interfaces to replace iommu_domain_alloc():

- iommu_user_domain_alloc(): This interface is intended for allocating
  iommu domains managed by userspace for device passthrough scenarios,
  such as those used by iommufd, vfio, and vdpa. It clearly indicates
  that the domain is for user-managed device DMA.

  If an IOMMU driver does not implement iommu_ops->domain_alloc_user,
  this interface will rollback to the generic paging domain allocation.

- iommu_paging_domain_alloc(): This interface is for allocating iommu
  domains managed by kernel drivers for kernel DMA purposes. It takes a
  device pointer as a parameter, which better reflects the current
  design of the IOMMU subsystem.

The majority of device drivers currently using iommu_domain_alloc() do
so to allocate a domain for a specific device and then attach that
domain to the device. These cases can be straightforwardly migrated to
the new interfaces.

The drm/tegra driver is a bit different in that the device pointer
passed to the helper, which allocates the iommu domain, is not the one
that will be used for the kernel DMA API. Move the existing logic in
iommu_domain_alloc() into the driver to ensure it works as intended.

Now that all consumers of iommu_domain_alloc() have switched to the new
interfaces, we can finally remove iommu_domain_alloc(). This removal
paves the way for the IOMMU subsystem to support multiple iommu drivers.
Additionally, the individual iommu driver implementation for domain
allocation could also be simplified, as there will always be a valid
device pointer passed along the path.

The whole series is also available on GitHub:
https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-allocation-refactor-v2

Change log:

v2:
 - Drop the vt-d patches which implement paging domain support from this
   series. I will post them in a separate series later.
 - Convert all drivers that call iommu_domain_alloc() to use the new
   interface and remove iommu_domain_alloc() from the tree.
 - For the drm/msm driver, make the code compatible with the no-IOMMU
   case.
 - Various cleanups and refinements.

v1: https://lore.kernel.org/linux-iommu/20240529053250.91284-1-baolu.lu@linux.intel.com/

Lu Baolu (21):
  iommu: Add iommu_user_domain_alloc() interface
  iommufd: Use iommu_user_domain_alloc()
  vfio/type1: Use iommu_user_domain_alloc()
  vhost-vdpa: Use iommu_user_domain_alloc()
  iommu: Add iommu_paging_domain_alloc() interface
  drm/msm: Use iommu_paging_domain_alloc()
  drm/nouveau/tegra: Use iommu_paging_domain_alloc()
  gpu: host1x: Use iommu_paging_domain_alloc()
  media: nvidia: tegra: Use iommu_paging_domain_alloc()
  media: venus: firmware: Use iommu_paging_domain_alloc()
  ath10k: Use iommu_paging_domain_alloc()
  wifi: ath11k: Use iommu_paging_domain_alloc()
  remoteproc: Use iommu_paging_domain_alloc()
  soc/fsl/qbman: Use iommu_paging_domain_alloc()
  RDMA/usnic: Use iommu_paging_domain_alloc()
  iommu/vt-d: Add helper to allocate paging domain
  ARM: dma-mapping: Use iommu_paging_domain_alloc()
  drm/rockchip: Use iommu_paging_domain_alloc()
  drm/tegra: Remove call to iommu_domain_alloc()
  iommu: Remove iommu_present()
  iommu: Remove iommu_domain_alloc()

Robin Murphy (1):
  ARM: dma-mapping: Pass device to arm_iommu_create_mapping()

 include/linux/iommu.h                         |  18 +--
 arch/arm/include/asm/dma-iommu.h              |   2 +-
 arch/arm/mm/dma-mapping.c                     |  12 +-
 drivers/gpu/drm/exynos/exynos_drm_dma.c       |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c               |   7 +-
 .../drm/nouveau/nvkm/engine/device/tegra.c    |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |  10 +-
 drivers/gpu/drm/tegra/drm.c                   |  34 ++++--
 drivers/gpu/host1x/dev.c                      |   7 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c      |   6 +-
 drivers/iommu/intel/iommu.c                   |  87 +++++++++++++--
 drivers/iommu/iommu.c                         | 103 +++++++++---------
 drivers/iommu/iommufd/hw_pagetable.c          |  20 +---
 drivers/iommu/ipmmu-vmsa.c                    |   3 +-
 drivers/iommu/mtk_iommu_v1.c                  |   3 +-
 .../media/platform/nvidia/tegra-vde/iommu.c   |   7 +-
 drivers/media/platform/qcom/venus/firmware.c  |   6 +-
 drivers/media/platform/ti/omap3isp/isp.c      |   2 +-
 drivers/net/wireless/ath/ath10k/snoc.c        |   6 +-
 drivers/net/wireless/ath/ath11k/ahb.c         |   6 +-
 drivers/remoteproc/remoteproc_core.c          |   6 +-
 drivers/soc/fsl/qbman/qman_portal.c           |   5 +-
 drivers/vfio/vfio_iommu_type1.c               |   7 +-
 drivers/vhost/vdpa.c                          |  14 +--
 24 files changed, 231 insertions(+), 146 deletions(-)

-- 
2.34.1

