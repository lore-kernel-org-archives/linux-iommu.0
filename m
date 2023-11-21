Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F43D22060
	for <iommu@lists.linux.dev>; Tue, 21 Nov 2023 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 481BF1042;
	Tue, 21 Nov 2023 10:04:58 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B08A3F6C4;
	Tue, 21 Nov 2023 10:04:10 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	jgg@nvidia.com,
	baolu.lu@linux.intel.com,
	linux-kernel@vger.kernel.org,
	jsnitsel@redhat.com
Subject: [PATCH v6 0/7] iommu: Retire bus ops
Date: Tue, 21 Nov 2023 18:03:56 +0000
Message-Id: <cover.1700589539.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5: https://lore.kernel.org/linux-iommu/cover.1697047261.git.robin.murphy@arm.com/

Yet another rebase, this time just tweaking patch #3 for the new
domain_alloc_user() sites, and picking up reviews/acks.

Thanks,
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
 drivers/iommu/iommufd/hw_pagetable.c        |   2 +
 drivers/iommu/mtk_iommu.c                   |   7 +-
 drivers/iommu/mtk_iommu_v1.c                |   3 -
 drivers/iommu/sprd-iommu.c                  |   8 +-
 drivers/iommu/virtio-iommu.c                |   3 -
 include/acpi/acpi_bus.h                     |   2 +
 include/linux/device.h                      |   1 -
 include/linux/device/bus.h                  |   5 -
 include/linux/dma-map-ops.h                 |   1 +
 include/linux/iommu.h                       |   2 +-
 14 files changed, 110 insertions(+), 98 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

