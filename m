From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 0/9] iommu/rockchip: Use OF_IOMMU
Date: Thu, 11 Jan 2018 16:22:20 +0800
Message-ID: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org, Frank Rowand <frowand.list@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-rockchip@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org


This series fixes some issues in rockchip iommu driver, and add of_iommu
support in it.

Also drop of_iommu early initialisation hooks as Robin suggested.


Jeffy Chen (5):
  iommu/of: Drop early initialisation hooks
  iommu/rockchip: Fix error handling in probe
  iommu/rockchip: Fix error handling in init
  iommu/rockchip: Use IOMMU device for dma mapping operations
  iommu/rockchip: Use OF_IOMMU to attach devices automatically

Tomasz Figa (4):
  iommu/rockchip: Fix error handling in attach
  iommu/rockchip: Use iopoll helpers to wait for hardware
  iommu/rockchip: Fix TLB flush of secondary IOMMUs
  iommu/rockchip: Use iommu_group_get_for_dev() for add_device

 drivers/iommu/arm-smmu-v3.c    |   2 +-
 drivers/iommu/arm-smmu.c       |  12 +-
 drivers/iommu/exynos-iommu.c   |   2 +-
 drivers/iommu/ipmmu-vmsa.c     |  17 +--
 drivers/iommu/msm_iommu.c      |  24 +--
 drivers/iommu/of_iommu.c       |  16 --
 drivers/iommu/qcom_iommu.c     |   2 +-
 drivers/iommu/rockchip-iommu.c | 331 ++++++++++++++++++++---------------------
 include/linux/of_iommu.h       |   6 +-
 9 files changed, 184 insertions(+), 228 deletions(-)

-- 
2.11.0
