From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 00/23] Unified SMMU driver among Tegra SoCs
Date: Wed, 26 Jun 2013 12:28:03 +0300
Message-ID: <1372238906-9346-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

This series provides:

(1) Unified SMMU driver among Tegra SoCs
(2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
(3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.

There's some discussion[1] about device population order, which can
solve the following patches.

  ARM: dt: tegra114: Register AHB/IOMMU device first
  amba: Move AHB to core_initcall
  iommu/tegra: smmu: Move IOMMU to core_initcall

Also "ARM: dma-mapping: Drop GFP_COMP for DMA memory allocations" may
not be necessary by [2]

Tested IOMMU functionality with T30 SD/MMC. Any further testing with
T114 and/or other devices would be really appreciated.

[1] https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/thread.html#36542
[2] http://marc.info/?l=linux-tegra&m=137173895620957&w=1

Hiroshi Doyu (23):
  ARM: tegra: Create a DT header defining swgroups ID
  ARM: dt: tegra30: iommu: Add "nvidia,swgroups"
  ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
  ARM: dt: tegra30: Register AHB/IOMMU device first
  ARM: dt: tegra114: iommu: Fix IOMMU register address
  ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
  ARM: dt: tegra114: Add "nvidia,memory-clients"
  ARM: dt: tegra114: Register AHB/IOMMU device first
  amba: Move AHB to core_initcall
  iommu/tegra: smmu: Move IOMMU to core_initcall
  iommu/tegra: smmu: Add of_mach_id for T114
  iommu/tegra: smmu: Select ARM_DMA_USE_IOMMU in Kconfig
  iommu/tegra: smmu: Create default IOVA maps
  iommu/tegra: smmu: Register platform_device to IOMMU dynamically
  iommu/tegra: smmu: Calculate ASID register offset by ID
  iommu/tegra: smmu: Get "nvidia,swgroups" from DT
  iommu/tegra: smmu: Use swgroups instead of pdata
  iommu/tegra: smmu: Workaround PCIe IOMMU'able
  iommu/tegra: smmu: Unfied driver for Tegra SoCs
  iommu/tegra: smmu: Use dt-bindings MACRO
  iommu/tegra: smmu: Get swgroup ID from DT
  iommu/tegra: smmu: Support Multiple ASID
  ARM: dma-mapping: Drop GFP_COMP for DMA memory allocations

 .../bindings/iommu/nvidia,tegra30-smmu.txt         |  17 +-
 arch/arm/boot/dts/tegra114.dtsi                    |  37 ++--
 arch/arm/boot/dts/tegra30.dtsi                     |  50 +++--
 arch/arm/mm/dma-mapping.c                          |   7 +
 drivers/amba/tegra-ahb.c                           |   7 +-
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/tegra-smmu.c                         | 215 +++++++++++----------
 include/dt-bindings/iommu/tegra-swgid.h            |  47 +++++
 8 files changed, 250 insertions(+), 131 deletions(-)
 create mode 100644 include/dt-bindings/iommu/tegra-swgid.h

-- 
1.8.1.5
