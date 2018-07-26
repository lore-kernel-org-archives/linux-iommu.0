From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
Date: Fri, 27 Jul 2018 02:16:18 +0300
Message-ID: <20180726231624.21084-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

There is a trouble on ARM with DMA allocations made by device drivers,
the trouble is that DMA allocations are getting implicitly backed with
IOMMU mapping by the driver core if IOMMU presents in a system and IOMMU
could handle device. This is an undesired behaviour for drivers that
manage IOMMU by themselves, like NVIDIA Tegra GPU driver. On arm32 the
implicit backing happens if CONFIG_ARM_DMA_USE_IOMMU=y (multiplatform
kernel configuration), on arm64 it happens if IOMMU domain type for a
device is equal to IOMMU_DOMAIN_DMA.

The proposed solution adds a new option to the base device driver
structure that allows device drivers to explicitly convey to the drivers
core that the implicit IOMMU backing for devices must not happen.

Dmitry Osipenko (6):
  driver core: Add option for disabling of backing devices DMA with
    IOMMU
  of/device: Don't back devices DMA with IOMMU if that's undesired by
    driver
  drm/tegra: Avoid implicit DMA backing with IOMMU
  gpu: host1x: Avoid implicit DMA backing with IOMMU
  drm/nouveau: tegra: Universally avoid implicit DMA backing with IOMMU
  Revert "drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping"

 drivers/gpu/drm/nouveau/nouveau_platform.c         |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 -------------
 drivers/gpu/drm/tegra/dc.c                         |  1 +
 drivers/gpu/drm/tegra/gr2d.c                       |  1 +
 drivers/gpu/drm/tegra/gr3d.c                       |  1 +
 drivers/gpu/drm/tegra/vic.c                        |  1 +
 drivers/gpu/host1x/dev.c                           |  1 +
 drivers/of/device.c                                |  7 +++++++
 include/linux/device.h                             |  2 ++
 9 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.18.0
