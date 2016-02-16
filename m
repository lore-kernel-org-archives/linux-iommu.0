From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 00/11] SYSMMU driver update and support for Exynos 5433
Date: Tue, 16 Feb 2016 15:56:53 +0100
Message-ID: <1455634624-18130-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

This patchset updates Exynos SYSMMU (IOMMU) driver to make use of the
new features in the IOMMU core (support for IOMMU_DOMAIN_DMA) and adds
support for SYSMMU v5 controllers, which are available in Samsung Exynos
5433 SoCs. The driver has been also updated to compile and work on ARM64
architecture.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (11):
  iommu: exynos: rework iommu group initialization
  iommu: exynos: add support for IOMMU_DOMAIN_DMA domain type
  iommu: exynos: remove ARM-specific cache flush interface
  iommu: exynos: simplify master clock operations
  iommu: exynos: refactor code (no direct register access)
  iommu: exynos: refactor fault handling code
  iommu: exynos: refactor init config code
  iommu: exynos: unify code for fldp cache invalidation
  iommu: exynos: update device tree documentation
  iommu: exynos: add support for v5 SYSMMU
  iommu: exynos: add Maintainers entry for Exynos SYSMMU driver

 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |  22 +-
 MAINTAINERS                                        |   6 +
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/exynos-iommu.c                       | 514 ++++++++++++---------
 4 files changed, 318 insertions(+), 226 deletions(-)

-- 
1.9.2
