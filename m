From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V6 0/6] iommu/msm: Add DT adaptation and generic bindings support
Date: Mon, 13 Jun 2016 17:06:01 +0530
Message-ID: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, joro@8bytes.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, stepanm@codeaurora.org, architt@codeaurora.org, arnd@arndb.de
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

The msm_iommu.c driver currently works based on platform data.
A single master device can be connected to more than one iommu and multiple
contexts in each of the iommu. This association between master and iommus was
represented from platform data using parent/child devices. The master drivers
were responsible for attaching all of the iommus/context to a domain. Now the
platform data support is removed and DT support is added. The master/iommus are
added through generic iommu bindings.

This is essentially rework of the patch posted earlier by
Rob Clark <robdclark@gmail.com>. This series folds the changes in to the
existing driver with the addition of generic bindings.

        http://www.spinics.net/lists/linux-arm-msm/msg10077.html

Tested this series on ifc6410 board.

[V6] After some discussions on patch 6 [1] from previous post,
     it was concluded that the changes for using relaxed writes
     in all places should not be a part of this series, so should
     be moved it. So removed that patch and added Acked/Tested tags.
     [1] https://patchwork.kernel.org/patch/9129231/

[V5] Changed the compatible binding name as per comments, added comments
     for usage of barriers in patch 6.

[V4] Addressed comments for making the iommu compatible binding more soc
     specific and updated the documentation for the iommu clocks.

[V3] Addressed comments to correct the usage
     of the #iommu-cells binding, improve the flush_iotlb_range function,
     added a new patch to use writel_relaxed for register access and split
     up the documentation patch.

[V2] Adapted the driver to use generic ARMV7S short descriptor pagetable ops
     and addressed comments.

[V1]
   https://lists.linuxfoundation.org/pipermail/iommu/2015-August/014074.html

Sricharan R (6):
  iommu/msm: Add DT adaptation
  documentation: iommu: Add bindings for msm,iommu-v0 ip
  iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
  iommu/msm: Add support for generic master bindings
  iommu/msm: use generic ARMV7S short descriptor pagetable ops
  iommu/msm: Remove driver BROKEN

 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 ++
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/msm_iommu.c                          | 870 +++++++++++----------
 drivers/iommu/msm_iommu.h                          |  73 +-
 drivers/iommu/msm_iommu_dev.c                      | 381 ---------
 6 files changed, 564 insertions(+), 828 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 delete mode 100644 drivers/iommu/msm_iommu_dev.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
