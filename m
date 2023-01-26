Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC8446A7
	for <iommu@lists.linux.dev>; Thu, 26 Jan 2023 18:26:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83DFF4B3;
	Thu, 26 Jan 2023 10:27:11 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C2CE3F71E;
	Thu, 26 Jan 2023 10:26:28 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jgg@nvidia.com,
	baolu.lu@linux.intel.com,
	rafael.j.wysocki@intel.com,
	gregkh@linuxfoundation.org
Subject: [PATCH v2 0/8] iommu: The early demise of bus ops
Date: Thu, 26 Jan 2023 18:26:15 +0000
Message-Id: <cover.1674753627.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-iommu/cover.1673978700.git.robin.murphy@arm.com/

Hi all,

Here's v2, now rebased on today's iommu/core and with just a few minor
changes. I've dropped "iommu: Pass device through ops->domain_alloc"
for now since I have nothing ready to take advantage of it yet, and I've
also realised that cleaning up set_pgtable_quirks will likely need yet
another change there anyway.

Cheers,
Robin.


Robin Murphy (8):
  iommu: Decouple iommu_present() from bus ops
  iommu: Validate that devices match domains
  iommu: Add lockdep annotations for group list iterators
  iommu: Factor out some helpers
  iommu: Switch __iommu_domain_alloc() to device ops
  iommu/arm-smmu: Don't register fwnode for legacy binding
  iommu: Retire bus ops
  iommu: Clean up open-coded ownership checks

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   3 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  12 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  14 +-
 drivers/iommu/iommu.c                       | 151 +++++++++++++-------
 drivers/iommu/mtk_iommu.c                   |   7 +-
 drivers/iommu/mtk_iommu_v1.c                |   3 -
 drivers/iommu/sprd-iommu.c                  |   8 +-
 drivers/iommu/virtio-iommu.c                |   3 -
 include/acpi/acpi_bus.h                     |   2 +
 include/linux/device.h                      |   1 -
 include/linux/device/bus.h                  |   5 -
 include/linux/dma-map-ops.h                 |   1 +
 include/linux/iommu.h                       |   1 +
 13 files changed, 113 insertions(+), 98 deletions(-)

-- 
2.36.1.dirty

