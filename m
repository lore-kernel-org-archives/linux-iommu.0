From: Shunqian Zheng <zhengsq@rock-chips.com>
Subject: [PATCH v3 0/6] fix bugs; enable iommu for ARM64
Date: Wed, 15 Jun 2016 20:04:39 +0800
Message-ID: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, mark.yao@rock-chips.com, airlied@linux.ie, tfiga@google.com, xxm@rock-chips.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Shunqian Zheng <zhengsq@rock-chips.com>
List-Id: iommu@lists.linux-foundation.org

This series patches mainly for ARM64 supporting.
To do this, it first add virtual iommu slave device which DRM can attach to,
convert DRM driver to use common iommu API instead of the ARM32
functions, and then use DMA API in iommu driver to map, to flush cache.

Mainly changes of V3:
    - Instead of registering virtual iommu in DTS, V3
      creates a iommu when attaching.
    - Fix some bugs according to Tomasz's comments,
      most of them are offline, locally.

Shunqian Zheng (3):
  iommu/rockchip: support virtual iommu slave device
  drm: rockchip: use common iommu api to attach iommu
  iommu/rockchip: use DMA API to map, to flush cache

Simon Xue (3):
  iommu/rockchip: fix devm_{request,free}_irq parameter
  iommu/rockchip: add map_sg callback for rk_iommu_ops
  iommu/rockchip: enable rockchip iommu on ARM64 platform

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 112 ++++++++-----
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
 drivers/iommu/Kconfig                       |   2 +-
 drivers/iommu/rockchip-iommu.c              | 251 ++++++++++++++++++++++------
 4 files changed, 273 insertions(+), 93 deletions(-)

-- 
1.9.1
