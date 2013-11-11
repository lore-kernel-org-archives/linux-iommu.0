From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 0/7] Unifying SMMU driver among Tegra SoCs
Date: Mon, 11 Nov 2013 10:31:51 +0200
Message-ID: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

This series provides:

(1) Unified SMMU driver among Tegra SoCs
(2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
(3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.

There's been some discussion[1] about device population order, and I
added a IOMMU hook in driver core:

  [PATCHv4 2/7] driver/core: Populate IOMMU'able devices in order

which is based on the following RFC patch:

  [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
  http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html

Tested IOMMU functionality with T30 SD/MMC. Any further testing with
T114 and/or other devices would be really appreciated.

v4:
Add a hook in driver core to control device populatin order.
Introduced arm,smmu "mmu-master" binding instead of tegra own.
Removed DT patches from this series.

v3:
Updated based on Stephen Warren's feedback

v2:
Updated based on Thierry Reding's and Stephen Warren's feedback

v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/181888.html
v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/180267.html

Available in the git repository at:

  git://git-HoETi0wPbwRDw2glCA4ptUEOCMrvLtNR@public.gmane.org/user/hdoyu/linux.git smmu-upstreaming@20131111

Hiroshi Doyu (7):
  ARM: tegra: Create a DT header defining SWGROUP ID
  driver/core: Populate IOMMU'able devices in order
  iommu/tegra: smmu: Register IOMMU'able devices dynamically
  iommu/tegra: smmu: Calculate ASID register offset by ID
  iommu/tegra: smmu: Support "mmu-masters" binding
  iommu/tegra: smmu: Rename hwgrp -> swgroups
  iommu/tegra: smmu: Allow duplicate ASID wirte

 .../bindings/iommu/nvidia,tegra30-smmu.txt         |  28 +-
 drivers/base/dd.c                                  |   5 +
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/of_iommu.c                           |  33 +++
 drivers/iommu/tegra-smmu.c                         | 301 ++++++++++++++-------
 include/dt-bindings/memory/tegra-swgroup.h         |  48 ++++
 include/linux/of_iommu.h                           |   7 +
 7 files changed, 318 insertions(+), 105 deletions(-)
 create mode 100644 include/dt-bindings/memory/tegra-swgroup.h

-- 
1.8.1.5
