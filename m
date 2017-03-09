From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V3 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date: Thu,  9 Mar 2017 21:05:43 +0530
Message-ID: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mathieu.poirier@linaro.org, mark.rutland@arm.com
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

This series provides the support for turning on the arm-smmu's
clocks/power domains using runtime pm. This is done using the
recently introduced device links patches, which lets the symmu's
runtime to follow the master's runtime pm, so the smmu remains
powered only when the masters use it.

Took some reference from the exynos runtime patches [2].
Tested this with MDP, GPU, VENUS devices on apq8096-db820c board.

Previous version of the patchset [1].

[V3]
   * Reworked the patches to keep the clocks init/enabling function
     seperately for each compatible.

   * Added clocks bindings for MMU40x/500.

   * Added a new compatible for qcom,smmu-v2 implementation and
     the clock bindings for the same.

   * Rebased on top of 4.11-rc1

[V2]
   * Split the patches little differently.

   * Addressed comments.

   * Removed the patch #4 [3] from previous post
     for arm-smmu context save restore. Planning to
     post this separately after reworking/addressing Robin's
     feedback.

   * Reversed the sequence to disable clocks than enabling.
     This was required for those cases where the
     clocks are populated in a dependent order from DT.

[1] https://www.spinics.net/lists/linux-arm-msm/msg23870.html
[2] https://lkml.org/lkml/2016/10/20/70
[3] https://patchwork.kernel.org/patch/9389717/

Sricharan R (5):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Add support for MMU40x/500 clocks
  drivers: arm-smmu: Add clock support for QCOM_SMMUV2
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

 .../devicetree/bindings/iommu/arm,smmu.txt         |  35 +++
 drivers/iommu/arm-smmu.c                           | 349 ++++++++++++++++++++-
 2 files changed, 373 insertions(+), 11 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

