From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/6] iommu/tegra124: smmu: add T124 enhancement
Date: Thu, 5 Dec 2013 14:25:13 +0200
Message-ID: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

The basics of Tegra SMMU has been same over generations except that
each SoC has its own combination of HardWare Accelerators(HWA). This
combination is presented by swgroup ID. This difference is handled by
the previous "Unifying SMMU driver among Tegra SoCs" patch
series[1]. For the new Tegra SoC 124 SMMU has been slightly
enhanced. To support this minor changes, Tegra SMMU platfrom data is
introduced. This data set can be choosen by DT ".comptibility"
flag. If the further tegra SoC need to tweak those parameters, we can
think of moving some of them into DT bindings eventually.

This series depend on v6 of:
     "[PATCHv6 00/13] Unifying SMMU driver among Tegra SoCs"[1]

A whole patches is available in the git repository at:

  git://git-HoETi0wPbwRDw2glCA4ptUEOCMrvLtNR@public.gmane.org/user/hdoyu/linux.git smmu-upstreaming@20131205

Hiroshi Doyu (6):
  iommu/tegra124: smmu: optionaly AHB enables SMMU
  iommu/tegra124: smmu: convert swgroup ID to asid offset
  iommu/tegra124: smmu: add support platform data
  iommu/tegra124: smmu: support more than 32 bit pa
  iommu/tegra124: smmu: {TLB,PTC} reset value per SoC
  yiommu/tegra124: smmu: adjust TLB_FLUSH_ASID bit range

 .../bindings/iommu/nvidia,tegra30-smmu.txt         |   4 +-
 drivers/iommu/tegra-smmu.c                         | 157 +++++++++++++++------
 2 files changed, 115 insertions(+), 46 deletions(-)

-- 
1.8.1.5

[1] http://lists.linuxfoundation.org/pipermail/iommu/2013-November/007048.html
