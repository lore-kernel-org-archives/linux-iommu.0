From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 0/3] Enable smmu support on sdm845
Date: Thu, 19 Jul 2018 23:23:53 +0530
Message-ID: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com, will.deacon@arm.com, andy.gross@linaro.org
Cc: mark.rutland@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tfiga@chromium.org, sricharan@codeaurora.org, linux-arm-msm@vger.kernel.org, david.brown@linaro.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

This series enables apps-smmu (arm,mmu-500) and gpu-smmu (qcom,smmu-v2)
on sdm845. gpu-smmu needs one power domain from gpu clock controller
whose driver was sent by Amit [1].

This series also contains a patch to split the check for num_context_irqs
and num_context_banks in two. We now error out only if num_context_irqs
is greater than num_context_banks.
There are cases such as on sdm845, in which few of the context banks are
reserved by the bootloader (secure software), and thus kernel view
lesser number than the total available context banks.
So, we shouldn't error out simply when the num_context_irqs is not equal
to num_context_banks.

[1] https://lore.kernel.org/patchwork/cover/962208/

Vivek Gautam (3):
  dts: arm64/sdm845: Add node for arm,mmu-500
  dts: arm64/sdm845: Add node for qcom,smmu-v2
  iommu/arm-smmu: Error out only if not enough context interrupts

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    | 96 +++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c                | 19 ++++---
 3 files changed, 117 insertions(+), 6 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
