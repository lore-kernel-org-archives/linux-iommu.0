From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V2 0/3] iommu/arm-smmu: Add runtime pm/sleep support
Date: Thu,  2 Feb 2017 22:40:17 +0530
Message-ID: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mathieu.poirier@linaro.org
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

Sricharan R (3):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu

 .../devicetree/bindings/iommu/arm,smmu.txt         |  16 +++
 drivers/iommu/arm-smmu.c                           | 143 ++++++++++++++++++++-
 2 files changed, 158 insertions(+), 1 deletion(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
