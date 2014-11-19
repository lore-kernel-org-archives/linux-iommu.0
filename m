From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Wed, 19 Nov 2014 12:15:29 +0100
Message-ID: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello Everyone,

This is another attempt to finally make Exynos SYSMMU driver fully
integrated with DMA-mapping subsystem. The main change from previous
version is a rebase onto latest "automatic DMA configuration for IOMMU
masters" patches from Will Deacon.

This patchset demonstrates that Will's proposal works fine and
significantly simplifies the driver code.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v3:
- rebased onto "[RFC PATCH v4 0/8] Introduce automatic DMA
  configuration for IOMMU masters"
- added some minor fixes for iommu and dma-mapping frameworks

v2: http://thread.gmane.org/gmane.linux.kernel.iommu/6472/
- rebased onto "[RFC PATCH v3 0/7] Introduce automatic DMA
  configuration for IOMMU masters" patches:
  http://www.spinics.net/lists/arm-kernel/msg362076.html
- changed initialization from bus notifiers to DT related callbacks
- removed support for separate IO address spaces - this will be
  discussed separately after the basic support gets merged
- removed support for power domain notifier-based runtime power
  management - this also will be discussed separately later

v1: https://lkml.org/lkml/2014/8/5/183
- initial version, feature complete, completely rewrote integration
  approach


Patch summary:

Marek Szyprowski (19):
  iommu: fix const qualifier in of_iommu_set_ops
  iommu: fix initialization without 'add_device' callback
  arm: dma-mapping: add missing check for iommu
  drm: exynos: detach from default dma-mapping domain on init
  arm: exynos: pm_domains: add support for devices registered before
    arch_initcall
  ARM: dts: exynos4: add sysmmu nodes
  iommu: exynos: don't read version register on every tlb operation
  iommu: exynos: remove unused functions
  iommu: exynos: remove useless spinlock
  iommu: exynos: refactor function parameters to simplify code
  iommu: exynos: remove unused functions, part 2
  iommu: exynos: remove useless device_add/remove callbacks
  iommu: exynos: add support for binding more than one sysmmu to master
    device
  iommu: exynos: add support for runtime_pm
  iommu: exynos: rename variables to reflect their purpose
  iommu: exynos: document internal structures
  iommu: exynos: remove excessive includes and sort others
    alphabetically
  iommu: exynos: init from dt-specific callback instead of initcall
  iommu: exynos: add callback for initializing devices from device tree

 arch/arm/boot/dts/exynos4.dtsi            | 117 +++++++
 arch/arm/boot/dts/exynos4210.dtsi         |  23 ++
 arch/arm/boot/dts/exynos4x12.dtsi         |  82 +++++
 arch/arm/mach-exynos/pm_domains.c         |   9 +-
 arch/arm/mm/dma-mapping.c                 |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.c |   3 +
 drivers/iommu/exynos-iommu.c              | 490 ++++++++++++++----------------
 drivers/iommu/iommu.c                     |   2 +-
 include/linux/of_iommu.h                  |   4 +-
 9 files changed, 459 insertions(+), 273 deletions(-)

-- 
1.9.2
