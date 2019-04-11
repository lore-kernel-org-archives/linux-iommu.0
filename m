From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH 0/9] iommu/amd: Convert the AMD iommu driver to the dma-iommu api
Date: Thu, 11 Apr 2019 19:47:29 +0100
Message-ID: <20190411184741.27540-1-tmurphy@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-rockchi
List-Id: iommu@lists.linux-foundation.org

Convert the AMD iommu driver to the dma-iommu api and remove the iova
handling code from the AMD iommu driver.

Tom Murphy (9):
  iommu/dma-iommu: Add iommu_map_atomic
  iommu/dma-iommu: Add function to flush any cached not present IOTLB
    entries
  iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
    iommu_dma_apply_resv_region to the dma-iommu api
  iommu/dma-iommu: Add iommu_dma_map_page_coherent
  iommu/amd: Implement .flush_np_cache
  iommu/amd: Implement map_atomic
  iommu/amd: Use the dma-iommu api
  iommu/amd: Clean up unused functions
  iommu/amd: Add allocated domain to global list earlier

 drivers/iommu/Kconfig          |   1 +
 drivers/iommu/amd_iommu.c      | 468 ++++++++-------------------------
 drivers/iommu/arm-smmu-v3.c    |   1 +
 drivers/iommu/arm-smmu.c       |   1 +
 drivers/iommu/dma-iommu.c      |  68 ++++-
 drivers/iommu/exynos-iommu.c   |   1 +
 drivers/iommu/iommu.c          |  46 +++-
 drivers/iommu/ipmmu-vmsa.c     |   1 +
 drivers/iommu/mtk_iommu.c      |   1 +
 drivers/iommu/qcom_iommu.c     |   1 +
 drivers/iommu/rockchip-iommu.c |   1 +
 include/linux/dma-iommu.h      |  10 +
 include/linux/iommu.h          |  25 ++
 13 files changed, 253 insertions(+), 372 deletions(-)

-- 
2.17.1
