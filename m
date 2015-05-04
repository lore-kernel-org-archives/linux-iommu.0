From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v6 00/25] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Mon, 04 May 2015 10:15:55 +0200
Message-ID: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: iommu@lists.linux-foundation.org

Hello Everyone,

This is yet another attempt to get Exynos SYSMMU driver with integrated
with IOMMU & DMA-mapping subsystems. The main change from previous
version is addition of the patches to define iommu-mapping, which need
to be created during system boot to avoid IOMMU fault by devices, which
has been left enabled by bootloader (i.e. framebuffer displaying slash
screen).

Patches has been also rebased onto v4.1-rc2 with 'arm: dma-mapping: fix
off-by-one check in arm_setup_iommu_dma_ops' patch applied (see commit
1424532b2163bf1580f4b1091a5801e12310fac5 on fixes branch in
git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git,
more information:
http://www.spinics.net/lists/arm-kernel/msg414722.html).

All patches are also available in the following git repository:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git
branch v4.1-exynos-iommu.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v6:
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
  arm: dma-mapping: add support for creating reserved mappings in iova
    space
  arm: exynos: pm_domains: register power domain driver from
    core_initcall
  drm/exynos: iommu: detach from default dma-mapping domain on init
  drm/exynos: fimd: ensure proper hw state in fimd_clear_channel()
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
  iommu: exynos: use struct exynos_iommu_domain in internal structures
  iommu: exynos: document internal structures
  iommu: exynos: remove excessive includes and sort others
    alphabetically
  iommu: exynos: init from dt-specific callback instead of initcall
  iommu: exynos: add callback for initializing devices from device tree
  iommu: exynos: remove unneeded code
  ARM: dts: exynos4: add sysmmu nodes
  ARM: dts: exynos3250: add sysmmu nodes
  ARM: dts: exynos4415: add sysmmu nodes
  ARM: dts: exynos5250: add sysmmu nodes
  ARM: dts: exynos5420: add sysmmu nodes
  ARM: dts: exynos: add iommu reserved regions for bootloader's splash
    screen

 Documentation/devicetree/bindings/iommu/iommu.txt |  44 ++
 arch/arm/boot/dts/exynos3250-rinato.dts           |   1 +
 arch/arm/boot/dts/exynos3250.dtsi                 |  22 +
 arch/arm/boot/dts/exynos4.dtsi                    | 118 ++++++
 arch/arm/boot/dts/exynos4210-trats.dts            |   1 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts   |   1 +
 arch/arm/boot/dts/exynos4210.dtsi                 |  23 +
 arch/arm/boot/dts/exynos4412-trats2.dts           |   1 +
 arch/arm/boot/dts/exynos4415.dtsi                 |  11 +
 arch/arm/boot/dts/exynos4x12.dtsi                 |  82 ++++
 arch/arm/boot/dts/exynos5250-snow.dts             |   1 +
 arch/arm/boot/dts/exynos5250-spring.dts           |   1 +
 arch/arm/boot/dts/exynos5250.dtsi                 | 250 +++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts        |   1 +
 arch/arm/boot/dts/exynos5420.dtsi                 | 181 ++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts         |   1 +
 arch/arm/mach-exynos/pm_domains.c                 |  18 +-
 arch/arm/mm/dma-mapping.c                         | 112 +++++
 drivers/gpu/drm/exynos/exynos_drm_fimd.c          |  27 +-
 drivers/gpu/drm/exynos/exynos_drm_iommu.c         |   3 +
 drivers/iommu/exynos-iommu.c                      | 495 ++++++++++------------
 21 files changed, 1098 insertions(+), 296 deletions(-)

-- 
1.9.2
