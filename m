From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/3] constify iommu_ops
Date: Mon, 28 Aug 2017 17:41:37 +0530
Message-ID: <1503922298-25862-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: m.szyprowski@samsung.com, joro@8bytes.org, kgene@kernel.org, krzk@kernel.org, matthias.bgg@gmail.com, gerald.schaefer@de.ibm.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

iommu_ops are not supposed to change at runtime.
Functions 'iommu_device_set_ops' and 'bus_set_iommu' working with
const iommu_ops provided by <linux/iommu.h>. So mark the non-const
structs as const.

Arvind Yadav (3):
  [PATCH 1/3] iommu: exynos: constify iommu_ops
  [PATCH 2/3] iommu: mtk: constify iommu_ops
  [PATCH 3/3] iommu: s390: constify iommu_ops

 drivers/iommu/exynos-iommu.c | 4 ++--
 drivers/iommu/mtk_iommu.c    | 4 ++--
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 drivers/iommu/s390-iommu.c   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.9.1
