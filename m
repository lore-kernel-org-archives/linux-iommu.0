Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB83205
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 16:20:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA976106F;
	Mon, 15 Aug 2022 09:20:23 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9013D3F70D;
	Mon, 15 Aug 2022 09:20:21 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com,
	mjrosato@linux.ibm.com,
	schnelle@linux.ibm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/16] iommu: retire bus_set_iommu()
Date: Mon, 15 Aug 2022 17:20:01 +0100
Message-Id: <cover.1660572783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: https://lore.kernel.org/linux-iommu/cover.1657034827.git.robin.murphy@arm.com/

Hi all,

As promised, here's the rebased v4 which I hope is ready to go now.
Besides the new patch for s390, there are just a few small improvements
over v3 to make things even simpler and clearer.

Thanks,
Robin.


Matthew Rosato (1):
  iommu/s390: Fail probe for non-PCI devices

Robin Murphy (15):
  iommu/vt-d: Handle race between registration and device probe
  iommu/amd: Handle race between registration and device probe
  iommu: Always register bus notifiers
  iommu: Move bus setup to IOMMU device registration
  iommu/amd: Clean up bus_set_iommu()
  iommu/arm-smmu: Clean up bus_set_iommu()
  iommu/arm-smmu-v3: Clean up bus_set_iommu()
  iommu/dart: Clean up bus_set_iommu()
  iommu/exynos: Clean up bus_set_iommu()
  iommu/ipmmu-vmsa: Clean up bus_set_iommu()
  iommu/mtk: Clean up bus_set_iommu()
  iommu/omap: Clean up bus_set_iommu()
  iommu/tegra-smmu: Clean up bus_set_iommu()
  iommu/virtio: Clean up bus_set_iommu()
  iommu: Clean up bus_set_iommu()

 drivers/iommu/amd/amd_iommu.h               |   1 -
 drivers/iommu/amd/init.c                    |   9 +-
 drivers/iommu/amd/iommu.c                   |  25 +---
 drivers/iommu/apple-dart.c                  |  30 +----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  53 +-------
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  84 +-----------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |   4 -
 drivers/iommu/exynos-iommu.c                |   9 --
 drivers/iommu/fsl_pamu_domain.c             |   4 -
 drivers/iommu/intel/iommu.c                 |   4 +-
 drivers/iommu/iommu.c                       | 137 +++++++++-----------
 drivers/iommu/ipmmu-vmsa.c                  |  35 +----
 drivers/iommu/msm_iommu.c                   |   2 -
 drivers/iommu/mtk_iommu.c                   |  24 +---
 drivers/iommu/mtk_iommu_v1.c                |  13 +-
 drivers/iommu/omap-iommu.c                  |   6 -
 drivers/iommu/rockchip-iommu.c              |   2 -
 drivers/iommu/s390-iommu.c                  |  13 +-
 drivers/iommu/sprd-iommu.c                  |   5 -
 drivers/iommu/sun50i-iommu.c                |   2 -
 drivers/iommu/tegra-smmu.c                  |  29 +----
 drivers/iommu/virtio-iommu.c                |  25 ----
 include/linux/iommu.h                       |   1 -
 23 files changed, 86 insertions(+), 431 deletions(-)

-- 
2.36.1.dirty

