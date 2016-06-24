From: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: iommu/rockchip: Fix bugs and enable on ARM64
Date: Fri, 24 Jun 2016 10:13:25 +0800
Message-ID: <1466734413-7453-1-git-send-email-zhengsq@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This series intends mostly to enable support for ARM64 architecture
in the rockchip-iommu driver. On the way to do so, some bugs are also
fixed.

The most important changes here are:
 - making the Rockchip IOMMU driver use DMA API for managing cache
   coherency of page tables,
 - making the Rockchip DRM driver not use DMA API on behalf of a virtual
   device (behind a virtual IOMMU) to allocate and map buffers, but
   instead proper DRM helpers and IOMMU API directly.

Changes since v4:
 - Address some coding style comments on:
    - https://chromium-review.googlesource.com/#/c/346328/38
    - https://chromium-review.googlesource.com/#/c/353591/10
Changes since v3:
 - Drop the idea of virtual IOMMU. Instead replace hacky allocation code
   in DRM driver, with proper management of IOMMU domain.
 - Add one more fix for allocation of IOMMU register base addresses.
Changes since v2:
 - Instead of registering virtual IOMMU from DTS, create it when
   attaching.
 - Fix some bugs found in internal review.

Shunqian Zheng (4):
  iommu/rockchip: Fix allocation of bases array in driver probe
  iommu/rockchip: Use DMA API to manage coherency
  iommu/rockchip: Prepare to support generic DMA mapping
  drm/rockchip: Use common IOMMU API to attach devices

Simon Xue (3):
  iommu/rockchip: Fix devm_{request,free}_irq parameter
  iommu/rockchip: Add map_sg callback for rk_iommu_ops
  iommu/rockchip: Enable Rockchip IOMMU on ARM64

Tomasz Figa (1):
  drm/rockchip: Do not use DMA mapping API if attached to IOMMU domain

 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 100 +++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   3 +
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 221 ++++++++++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   9 ++
 drivers/iommu/Kconfig                       |   2 +-
 drivers/iommu/rockchip-iommu.c              | 181 +++++++++++++++++------
 6 files changed, 413 insertions(+), 103 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
