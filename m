From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/13] Introduce IOMMU-API TLB Flushing Interface
Date: Thu, 17 Aug 2017 14:56:23 +0200
Message-ID: <1502974596-23835-1-git-send-email-joro@8bytes.org>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

here is a patch-set to introduce an explicit interface to
the IOMMU-API to flush IOMMU and device IO/TLBs. Currently
the iommu_map(), iommu_map_sg(), and iommu_unmap() functions
have to make sure all IO/TLBs in the system are synchronized
with the page-table updates they made.

This is very inefficient in some scenarios, for example when
a large address space is unmapped and an IO/TLB flush has to
be done in every call of iommu_unmap(). Or in a scenario
where it makes sense to queue up some changes to the
page-tables and flush them together.

To optimize these scenarios, the need to synchronize with
the IOMMU and device TLBs has been removed from the
map/unmap functions of the IOMMU-API and an interface to
explicitly do the flushes has been introduced.

To make the conversion of existing users of the IOMMU-API
easier, new functions - iommu_map_sync(), iommu_map_sg_sync(),
and iommu_unmap_sync() - have been introduced. These
functions guarantee that the IO/TLBs are synchronized with
any page-table update when they return. The optimizations
possible with the new interface are subject to separate
patch-sets.

Patch 1 just renames a few functions in the AMD-Vi driver
that would otherwise collide with the new TLB-flush
functions from the IOMMU-API.

Patch 2 introduces the new IO/TLB Flush-Interface.

Patch 3-13 convert existing users of the IOMMU-API to use
the *_sync functions for now.

Please review.

Thanks,

	Joerg

Joerg Roedel (13):
  iommu/amd: Rename a few flush functions
  iommu: Introduce Interface for IOMMU TLB Flushing
  vfio/type1: Use sychronized interface of the IOMMU-API
  iommu/dma: Use sychronized interface of the IOMMU-API
  arm: dma-mapping: Use sychronized interface of the IOMMU-API
  drm/etnaviv: Use sychronized interface of the IOMMU-API
  drm/msm: Use sychronized interface of the IOMMU-API
  drm/nouveau/imem/gk20a: Use sychronized interface of the IOMMU-API
  drm/rockchip: Use sychronized interface of the IOMMU-API
  drm/tegra: Use sychronized interface of the IOMMU-API
  gpu: host1x: Use sychronized interface of the IOMMU-API
  IB/usnic: Use sychronized interface of the IOMMU-API
  remoteproc: Use sychronized interface of the IOMMU-API

 arch/arm/mm/dma-mapping.c                          | 21 +++---
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              | 10 +--
 drivers/gpu/drm/msm/msm_iommu.c                    |  5 +-
 .../gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c    | 12 ++--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |  6 +-
 drivers/gpu/drm/tegra/drm.c                        |  6 +-
 drivers/gpu/drm/tegra/gem.c                        |  6 +-
 drivers/gpu/host1x/cdma.c                          |  6 +-
 drivers/gpu/host1x/job.c                           |  6 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           | 10 +--
 drivers/iommu/amd_iommu.c                          | 16 ++---
 drivers/iommu/dma-iommu.c                          |  8 +--
 drivers/iommu/iommu.c                              | 26 +++++++
 drivers/remoteproc/remoteproc_core.c               | 10 +--
 drivers/vfio/vfio_iommu_type1.c                    | 38 +++++-----
 include/linux/iommu.h                              | 80 +++++++++++++++++++++-
 16 files changed, 189 insertions(+), 77 deletions(-)

-- 
2.7.4
