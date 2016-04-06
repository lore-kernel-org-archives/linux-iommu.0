From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V2 0/5] iommu/msm: Add DT adaptation and generic bindings support
Date: Wed,  6 Apr 2016 19:59:30 +0530
Message-ID: <1459952975-1250-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, robin.murphy@arm.com, robdclark@gmail.com, joro@8bytes.org, srinivas.kandagatla@linaro.org, laurent.pinchart@ideasonboard.com, Will.Deacon@arm.com, stepanm@codeaurora.org, treding@nvidia.com
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

The msm_iommu.c driver currently works based on platform data.
A single master device can be connected to more than one iommu
and multiple contexts in each of the iommu. This association
between master and iommus was represented from platform data
using parent/child devices. The master drivers were responsible
for attaching all of the iommus/context to a domain. Now the
platform data support is removed and DT support is added. The
master/iommus are added through generic iommu bindings.

This is essentially rework of the patch posted earlier by
Rob Clark <robdclark@gmail.com>. This series folds the changes
in to the existing driver with the addition of generic bindings.

        http://www.spinics.net/lists/linux-arm-msm/msg10077.html

This series is based on the IOMMU probe deferral series from
Laurent Pinchart <laurent.pinchart@ideasonboard.com>.

        https://lkml.org/lkml/2015/5/14/786

Tested this series on ifc6410 board.

[V2] Adapted the driver to use generic ARMV7S short descriptor pagetable ops
     and addressed comments.

[V1]
   https://lists.linuxfoundation.org/pipermail/iommu/2015-August/014074.html

Sricharan R (5):
  iommu/msm: Add DT adaptation
  iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
  iommu/msm: Add support for generic master bindings
  iommu/msm: use generic ARMV7S short descriptor pagetable ops
  iommu/msm: Remove driver BROKEN

 .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  59 ++
 drivers/iommu/Kconfig                              |   2 +-
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/msm_iommu.c                          | 836 +++++++++++----------
 drivers/iommu/msm_iommu.h                          |  73 +-
 drivers/iommu/msm_iommu_dev.c                      | 381 ----------
 6 files changed, 523 insertions(+), 830 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 delete mode 100644 drivers/iommu/msm_iommu_dev.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
