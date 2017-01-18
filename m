From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 0/5] Remove qcom SoC configs
Date: Wed, 18 Jan 2017 15:27:21 -0800
Message-ID: <20170118232726.22876-1-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

We want to remove the ARCH_MSM* configs in mach-qcom/Kconfig
because they are proxy configs for selecting the right
clocksource driver and adjusting the text offset and there is no
difference between ARCH_MSM8X60 and ARCH_MSM8960 anymore.
Furthermore, there aren't configs for all the SoCs supported by
the mainline kernel, leading to confusion about which SoCs are
supported. This patch series removes them, leading to less confusion
with the minor downside of always forcing a text offset shift and
the selection of the qcom specific clocksource driver. The size
increase from the clocksource driver is already taken in
the qcom_defconfig, so most likely nobody will care.

Cc: Joerg Roedel <joro@8bytes.org>

Stephen Boyd (5):
  iommu: Generalize MSM_IOMMU config to ARCH_QCOM
  ARM: Makefile: Generalize qcom platform text offset
  ARM: qcom: Remove SoC specific configs
  ARM: qcom_defconfig: Drop SoC specific configs
  ARM: multi_v7_defconfig: Remove qcom SoC configs

 arch/arm/Makefile                   |  3 +--
 arch/arm/configs/multi_v7_defconfig |  3 ---
 arch/arm/configs/qcom_defconfig     |  4 ----
 arch/arm/mach-qcom/Kconfig          | 23 ++---------------------
 drivers/iommu/Kconfig               |  2 +-
 5 files changed, 4 insertions(+), 31 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
