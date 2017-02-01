From: Rob Clark <robdclark@gmail.com>
Subject: [RFC 0/3] iommu/arm-smmu: stalling support (v2)
Date: Wed,  1 Feb 2017 10:23:38 -0500
Message-ID: <20170201152341.29142-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sricharan R <sricharan@codeaurora.org>, Jordan Crouse <jcrouse@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Now, as was previously discussed[1], now we have a dt property on the
smmu, to indicate that the smmu supports stalling, as well as a flag
on the domain (set when fault-handler is registered) to indicate that
the domain supports stalling.

I ran into one snag, thanks to the auto-attached DMA domain, since
that doesn't support stalling.  I think when the driver is explicitly
managing the iommu, we should just get rid of the DMA domain.  (But
maybe there is a cleaner way to do this than what I came up with, so
suggestions welcome.)

[1] http://www.spinics.net/lists/linux-arm-msm/msg25357.html

Rob Clark (3):
  iommu: introduce stall/resume support
  iommu/arm-smmu: Add support to opt-in to stalling
  iommu/arm-smmu: detach DMA domain if driver is managing iommu

 .../devicetree/bindings/iommu/arm,smmu.txt         |   3 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c              |   2 +-
 drivers/gpu/drm/msm/msm_iommu.c                    |  12 ++-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |   2 +-
 drivers/iommu/arm-smmu.c                           | 100 +++++++++++++++++++--
 drivers/iommu/iommu.c                              |  24 ++++-
 drivers/remoteproc/remoteproc_core.c               |   2 +-
 include/linux/iommu.h                              |   5 +-
 8 files changed, 136 insertions(+), 14 deletions(-)

-- 
2.9.3
