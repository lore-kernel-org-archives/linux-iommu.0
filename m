From: Sricharan R <sricharan@codeaurora.org>
Subject: [RFC PATCH 0/4] iommu/arm-smmu: Add support for adding masters/clocks using generic bindings
Date: Fri, 17 Jul 2015 22:23:21 +0530
Message-ID: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, will.deacon@arm.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

This series adds support for xlate callback to add master
devices configs using generic bindings and clocks/regulators
required to access smmu.

OF_IOMMU_DECLARE is used to register and probe the smmu controller
devices before the masters are added in of_platform_populate.
Here, we are registering only the smmu driver and iommu_ops. The
smmu device registration is not done in OF_IOMMU_DECLARE to avoid
early smmu probe, because the clocks if any required for the controller
are not yet ready.

So the idea here is to get the right direction in adding this support.

Mitchel Humpherys (2):
  iommu/arm-smmu: add support for specifying clocks
  iommu/arm-smmu: Add support for specifying regulators

Sricharan R (2):
  iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE
  iommu/arm-smmu: Add xlate callback for initializing master devices
    from dt

 .../devicetree/bindings/iommu/arm,smmu.txt         |  14 ++
 drivers/iommu/arm-smmu.c                           | 210 +++++++++++++++++++--
 2 files changed, 208 insertions(+), 16 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
