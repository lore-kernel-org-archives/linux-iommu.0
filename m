From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv7 00/12] Unifying SMMU driver among Tegra SoCs
Date: Thu, 12 Dec 2013 09:57:01 +0200
Message-ID: <1386835033-4701-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

This series provide:

(0) IOMMU standard DT binding("iommus")
(1) Unified IOMMU(SMMU) driver among Tegra SoCs
(2) Multiple Address Space support(MASID) in IOMMU(SMMMU)
(3) Tegra IOMMU'able devices, most of platform devices are IOMMU'able.

There's been some discussion[1] about device population order. Some
devices needs to be populated earlier than other devices regardless of
their bus topology. For the solution I implemented an IOMMU hook in
driver core:

  [PATCHv7 04/13] driver/core: populate devices in order for IOMMUs

which is based on:
  http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006933.html

The main problem here is,

IOMMU devices on the bus need to be poplulated first, then iommu
master devices are done later.

With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
whether a device can be an iommu msater or not. If a device can, we'll
defer to populate that device till an iommu device is populated. Then,
those defered iommu master devices are populated and configured with
help of the already populated iommu device via a new IOMMU API
iommu_ops->driver_bound().

This "iommus=" binding is expected used as the global/standard binding.

Tested IOMMU functionality with T30 SD/MMC. Any further testing with
T114 and/or other devices would be really appreciated.

v6:
Minior fixes.
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/213082.html

v5:
Use "iommus=" DT bindings as a standard IOMMU binding.
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/212331.html

v4:
Add a hook in driver core to control device populatin order.
Introduced arm,smmu "mmu-master" binding instead of tegra own.
Removed DT patches from this series.
  http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006931.html

v3:
Updated based on Stephen Warren's feedback
  http://lists.linuxfoundation.org/pipermail/iommu/2013-October/006724.html

v2:
Updated based on Thierry Reding's and Stephen Warren's feedback
  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/181888.html

v1:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/180267.html

Available in the git repository at:

  git://git-HoETi0wPbwRDw2glCA4ptUEOCMrvLtNR@public.gmane.org/user/hdoyu/linux.git smmu-upstreaming@20131212

Hiroshi Doyu (12):
  of: introduce of_property_for_each_phandle_with_args()
  iommu/of: introduce a global iommu device list
  iommu/of: check if dependee iommu is ready or not
  driver/core: populate devices in order for IOMMUs
  iommu/core: add ops->{bound,unbind}_driver()
  ARM: tegra: create a DT header defining SWGROUP ID
  iommu/tegra: smmu: register device to iommu dynamically
  iommu/tegra: smmu: calculate ASID register offset by ID
  iommu/tegra: smmu: get swgroups from DT "iommus="
  iommu/tegra: smmu: allow duplicate ASID wirte
  iommu/tegra: smmu: Rename hwgrp -> swgroups
  iommu/tegra: smmu: add SMMU to an global iommu list

 .../bindings/iommu/nvidia,tegra30-smmu.txt         |  30 +-
 drivers/base/dd.c                                  |   5 +
 drivers/iommu/Kconfig                              |   1 +
 drivers/iommu/iommu.c                              |  13 +-
 drivers/iommu/of_iommu.c                           |  51 +++
 drivers/iommu/tegra-smmu.c                         | 383 +++++++++++++--------
 drivers/of/base.c                                  |  46 +++
 include/dt-bindings/memory/tegra-swgroup.h         |  50 +++
 include/linux/iommu.h                              |   4 +
 include/linux/of.h                                 |  32 ++
 include/linux/of_iommu.h                           |  22 ++
 11 files changed, 487 insertions(+), 150 deletions(-)
 create mode 100644 include/dt-bindings/memory/tegra-swgroup.h

-- 
1.8.1.5

[1]
  "[RFC] early init and DT platform devices allocation/registration"
    https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/thread.html#36542
  "Report from 2013 ARM kernel summit"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210426.html
  "[RFC PATCH] Documentation: devicetree: add description for generic bus properties"
    http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/215042.html
