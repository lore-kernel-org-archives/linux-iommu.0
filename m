From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH v4 0/2] Enable smmu support on sdm845
Date: Thu, 11 Oct 2018 15:12:43 +0530
Message-ID: <20181011094245.7943-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, andy.gross@linaro.org, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: mark.rutland@arm.com, david.brown@linaro.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, will.deacon@arm.com, dianders@chromium.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

This series enables apps-smmu, the "arm,mmu-500" instance
on sdm845.

Changes since v3:
 - Refined the dt binding documentation more to align with
   Rob's comments for qcom,smmu-v2 binding documentation [1]
   on SoC specific compatibles and state things similar
   to qcom,smmu-v2 [2].

Changes since v2:
 - Dropped patch for gpu-smmu [3] as the same has been pushed by
   Jordan [4] after incorporating the dt binding update.
 - Updated binding doc to include valid value for '<soc>'
   in "qcom,<soc>-smmu-500" compatible string.

Changes since v1:
 - Addressed Rob's review comments by adding a SoC specific compatible.
   Have added a new dt-bindings patch for this.
 - Updated node name to 'iommu'.
 - Addressed Doug's review comment about removing status property from
   smmu's nodes, as smmu is either present on the soc or not. Enabling
   it is not a board-level decision.

[1] https://patchwork.kernel.org/patch/10576937/
[1] https://patchwork.kernel.org/patch/10581911/
[3] https://patchwork.kernel.org/patch/10565295/
[4] https://patchwork.kernel.org/patch/10577297/

Vivek Gautam (2):
  dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
  dts: arm64/sdm845: Add node for arm,mmu-500

 .../devicetree/bindings/iommu/arm,smmu.txt         |  4 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 72 ++++++++++++++++++++++
 2 files changed, 76 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
