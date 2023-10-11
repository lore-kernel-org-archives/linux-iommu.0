Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7F39925
	for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48EBF14BF;
	Wed, 11 Oct 2023 11:15:39 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A87B23F5A1;
	Wed, 11 Oct 2023 11:14:57 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	jgg@nvidia.com,
	baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] iommu: Retire bus ops
Date: Wed, 11 Oct 2023 19:14:47 +0100
Message-Id: <cover.1697047261.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4: https://lore.kernel.org/linux-iommu/cover.1696253096.git.robin.murphy@arm.com/

Hi all,

Really really hoping this is done now... same as v4 except I've
rewritten patch #4 to be a lot less ambitious and not require any
troublesome new reasoning.

Cheers,
Robin.


Robin Murphy (7):
  iommu: Factor out some helpers
  iommu: Decouple iommu_present() from bus ops
  iommu: Validate that devices match domains
  iommu: Decouple iommu_domain_alloc() from bus ops
  iommu/arm-smmu: Don't register fwnode for legacy binding
  iommu: Retire bus ops
  iommu: Clean up open-coded ownership checks

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   3 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  12 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  16 +--
 drivers/iommu/iommu.c                       | 143 +++++++++++++-------
 drivers/iommu/mtk_iommu.c                   |   7 +-
 drivers/iommu/mtk_iommu_v1.c                |   3 -
 drivers/iommu/sprd-iommu.c                  |   8 +-
 drivers/iommu/virtio-iommu.c                |   3 -
 include/acpi/acpi_bus.h                     |   2 +
 include/linux/device.h                      |   1 -
 include/linux/device/bus.h                  |   5 -
 include/linux/dma-map-ops.h                 |   1 +
 include/linux/iommu.h                       |   1 +
 13 files changed, 108 insertions(+), 97 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

