Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15A107B5
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 16:58:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 711AC1FB;
	Fri, 15 Sep 2023 09:58:55 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A6A73F5A1;
	Fri, 15 Sep 2023 09:58:16 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	jgg@nvidia.com,
	baolu.lu@linux.intel.com
Subject: [PATCH v3 0/7] Iommu: Retire bus ops
Date: Fri, 15 Sep 2023 17:58:04 +0100
Message-Id: <cover.1694693889.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: https://lore.kernel.org/linux-iommu/cover.1674753627.git.robin.murphy@arm.com/

Hi all,

I've finally been able to get back to this again, and I think it is now
hopefully ready to go. Changes from v3 are quite minor - basically a few
cosmetics and small tweaks (where I've taken the liberty of keeping
Baolu and Jason's review tags; hope that's OK!), the one functional
thing around blocking domains fixed, and plenty of reshuffling from
rebases. I'm happy to see that the IOMMUFD selftest problem has resolved
itself in the meantime, and it might even be able to use the standard
registration flow after this, however I'll leave that for someone else
more motivated, since my follow-up priority will be moving the of_xlate
business around at the bus level to sort out the probe_device ordering
mess once and for all.

Thanks,
Robin.


Robin Murphy (7):
  iommu: Factor out some helpers
  iommu: Decouple iommu_present() from bus ops
  iommu: Validate that devices match domains
  iommu: Switch __iommu_domain_alloc() to device ops
  iommu/arm-smmu: Don't register fwnode for legacy binding
  iommu: Retire bus ops
  iommu: Clean up open-coded ownership checks

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   3 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  12 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  14 +-
 drivers/iommu/iommu.c                       | 140 ++++++++++++++------
 drivers/iommu/mtk_iommu.c                   |   7 +-
 drivers/iommu/mtk_iommu_v1.c                |   3 -
 drivers/iommu/sprd-iommu.c                  |   8 +-
 drivers/iommu/virtio-iommu.c                |   3 -
 include/acpi/acpi_bus.h                     |   2 +
 include/linux/device.h                      |   1 -
 include/linux/device/bus.h                  |   5 -
 include/linux/dma-map-ops.h                 |   1 +
 include/linux/iommu.h                       |   1 +
 13 files changed, 108 insertions(+), 92 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

