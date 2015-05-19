From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 00/25] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Tue, 19 May 2015 15:20:20 +0200
Message-ID: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hello Everyone,

This is yet another attempt to get Exynos SYSMMU driver with integrated
with IOMMU & DMA-mapping subsystems. This version includes minor fixes
suggested by Joerg Roedel, Cho KyongHo and Robin Murphy.

All patches are also available in the following git repository:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
branch v4.1-exynos-iommu-v7.

My plan for merging this patchset is as follows:
- DTS changes and power domain changes should go via Samsung tree to avoid
  conflicts with other pending DTS patches
- all exynos-iommu patches and dma-mapping/reserved iommu region should go
  via IOMMU tree,
- all Exynos DRM patches should go via DRM/Exynos tree.

There are no build cross-subsystem dependencies and IOMMU on Exynos is
already nonfunctional (and disabled in defconfig), so merging patches in
parts doesn't break anything.

There are knowns issues with Exynos DRM driver and IOMMU support
(i.e. Xorg freeze reported by Javier Martinez Canillas:
http://www.spinics.net/lists/linux-samsung-soc/msg44350.html ). They
will be handled by a separate fixes to Exynos DRM drivers. This patchset
fixes only those issues in Exynos DRM FIMD driver, which prevents
booting to console.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v7:
- rebased onto v4.1-rc4
- restored iommu_gruops support
- added missing suspend/resume support patch
- rearanged patch order and squashed some patches for better code readability
- changed patch prefixes to match maintainer's requirements
- fixed minor issues pointed by Joerg Roedel, Cho KyongHo and Robin Murphy
- added Krzysztof's acks for dts patches

v6: http://www.spinics.net/lists/linux-samsung-soc/msg44065.html
- rebased onto v4.1-rc2 with 'arm: dma-mapping: fix off-by-one check in
  arm_setup_iommu_dma_ops' patch
- added exynos 3250 and 4415 dts patches
- added support for devices, which have been left enabled by bootloader
  (i.e. framebuffer displaying slash screen)
- fixed freeze in fimd iommu initialization caused by lack of proper
  runtime pm management
- resolved issues with power domains by moving pd initialization to
  core_initcall

v5: https://lists.linaro.org/pipermail/linaro-mm-sig/2015-February/004442.html
- rebased onto 'Add HDMI support for Exynos5420 platform' patchset
- fixed 'const' issue in 'iommu: exynos: init from dt-specific callback
  instead of initcall' patch, thanks to Tobias Jakobi for reporting it
- fixed copy-paste typo in exynos5250 dts patch

v4: http://www.spinics.net/lists/linux-samsung-soc/msg41177.html
- rebased onto v3.19-rc4 and other Exynos DTS queued patches
- added DTS patch for Exynos 5250 & 5420/5422/5800

v3: http://www.spinics.net/lists/linux-samsung-soc/msg39168.html
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

Marek Szyprowski (25):
  drm/exynos: iommu: detach from default dma-mapping domain on init
  drm/exynos: fimd: ensure proper hw state in fimd_clear_channel()
  iommu: Init iommu-groups support earlier, in core_initcall
  iommu/exynos: Don't read version register on every tlb operation
  iommu/exynos: Remove unused functions
  iommu/exynos: Remove useless members from exynos_iommu_owner structure
  iommu/exynos: Refactor function parameters to simplify code
  iommu/exynos: Rename variables to reflect their purpose
  iommu/exynos: Use struct exynos_iommu_domain in internal structures
  iommu/exynos: Remove excessive includes and sort others alphabetically
  iommu/exynos: Document internal structures
  iommu/exynos: Add/remove callbacks should fail if no iommu is
    available
  iommu/exynos: Add support for binding more than one sysmmu to master
    device
  iommu/exynos: Add support for runtime_pm
  iommu/exynos: Add system suspend/resume support
  iommu/exynos: Init from dt-specific callback instead of initcall
  iommu/exynos: Add callback for initializing devices from device tree
  ARM: Exynos: pm_domains: register power domain driver from
    core_initcall
  ARM: dts: exynos4: add sysmmu nodes
  ARM: dts: exynos3250: add sysmmu nodes
  ARM: dts: exynos4415: add sysmmu nodes
  ARM: dts: exynos5250: add sysmmu nodes
  ARM: dts: exynos5420: add sysmmu nodes
  ARM: DMA-mapping: add support for creating reserved mappings in iova
    space
  ARM: dts: exynos: add iommu reserved regions for bootloader's splash
    screen

 Documentation/devicetree/bindings/iommu/iommu.txt |  44 ++
 arch/arm/boot/dts/exynos3250-rinato.dts           |   1 +
 arch/arm/boot/dts/exynos3250.dtsi                 |  22 +
 arch/arm/boot/dts/exynos4.dtsi                    | 118 +++++
 arch/arm/boot/dts/exynos4210-trats.dts            |   1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts   |   1 +
 arch/arm/boot/dts/exynos4210.dtsi                 |  23 +
 arch/arm/boot/dts/exynos4412-trats2.dts           |   1 +
 arch/arm/boot/dts/exynos4415.dtsi                 |  11 +
 arch/arm/boot/dts/exynos4x12.dtsi                 |  82 ++++
 arch/arm/boot/dts/exynos5250-snow.dts             |   1 +
 arch/arm/boot/dts/exynos5250-spring.dts           |   1 +
 arch/arm/boot/dts/exynos5250.dtsi                 | 250 ++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts        |   1 +
 arch/arm/boot/dts/exynos5420.dtsi                 | 181 ++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts         |   1 +
 arch/arm/mach-exynos/pm_domains.c                 |  18 +-
 arch/arm/mm/dma-mapping.c                         | 121 +++++
 drivers/gpu/drm/exynos/exynos_drm_fimd.c          |  27 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.c         |   3 +
 drivers/iommu/exynos-iommu.c                      | 526 +++++++++++-----------
 drivers/iommu/iommu.c                             |   2 +-
 22 files changed, 1156 insertions(+), 280 deletions(-)

-- 
1.9.2
