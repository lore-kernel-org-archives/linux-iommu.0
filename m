From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 00/19] Unifying SMMU driver among Tegra SoCs
Date: Fri, 18 Oct 2013 13:26:41 +0300
Message-ID: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

This series provides:

(1) Unified SMMU driver among Tegra SoCs
(2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
(3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.

There's some discussion[1] about device population order, which could
solve the following patches.

  patch 1: [HACK] of: dev_node has struct device pointer
  patch 2: [HACK] ARM: tegra: Populate AHB/IOMMU earlier than others
  patch 3: [HACK] amba: Move AHB to core_initcall
  patch 4: [HACK] iommu/tegra: smmu: Move IOMMU to core_initcall

Tested IOMMU functionality with T30 SD/MMC. Any further testing with
T114 and/or other devices would be really appreciated.

v3:
Updated based on Stephen Warren's feedback

v2:
Updated based on Thierry Reding's and Stephen Warren's feedback

v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/181888.html
v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/180267.html

Available in the git repository at:

  git://git-HoETi0wPbwRDw2glCA4ptUEOCMrvLtNR@public.gmane.org/user/hdoyu/linux.git smmu-upstreaming@20131018

Hiroshi Doyu (19):
  [HACK] of: dev_node has struct device pointer
  [HACK] ARM: tegra: Populate AHB/IOMMU earlier than others
  [HACK] amba: Move AHB to core_initcall
  [HACK] iommu/tegra: smmu: Move IOMMU to core_initcall
  ARM: dt: tegra114: iommu: Fix IOMMU register address
  iommu/tegra: smmu: Select ARM_DMA_USE_IOMMU in Kconfig
  iommu/tegra: smmu: Create default IOVA maps
  iommu/tegra: smmu: Register platform_device to IOMMU dynamically
  iommu/tegra: smmu: Calculate ASID register offset by ID
  iommu/tegra: smmu: Get "nvidia,swgroups" from DT
  ARM: dt: tegra30: iommu: Add "nvidia,swgroups"
  ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
  iommu/tegra: smmu: Workaround PCIe IOMMU'able
  iommu/tegra: smmu: Get "nvidia,memory-clients" from DT
  ARM: tegra: Create a DT header defining SWGROUP ID
  iommu/tegra: smmu: Use dt-bindings MACRO
  ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
  ARM: dt: tegra114: iommu: Add "nvidia,memory-clients"
  iommu/tegra: smmu: Support Multiple ASID

 .../bindings/iommu/nvidia,tegra30-smmu.txt         |  22 ++-
 arch/arm/boot/dts/tegra114.dtsi                    |  15 +-
 arch/arm/boot/dts/tegra30.dtsi                     |  23 ++-
 arch/arm/mach-tegra/tegra.c                        |  22 +++
 drivers/amba/tegra-ahb.c                           |   7 +-
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/tegra-smmu.c                         | 198 ++++++++++++---------
 drivers/of/platform.c                              |   6 +
 include/dt-bindings/memory/tegra-swgroup.h         |  46 +++++
 include/linux/of.h                                 |   1 +
 10 files changed, 253 insertions(+), 88 deletions(-)
 create mode 100644 include/dt-bindings/memory/tegra-swgroup.h

-- 
1.8.1.5
