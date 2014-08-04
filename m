From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [PATCH v2 0/2] arm-smmu fixes for CBn_TCR and S2CR/SMR programming
Date: Mon,  4 Aug 2014 11:01:01 -0700
Message-ID: <1407175263-10699-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: will.deacon@arm.com
Cc: mitchelh@codeaurora.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Here are a couple fixes for the arm smmu driver. The first one deals with
ensuring that we program CBn_TCR correctly when we are programming a stage-1
context bank.
The second patch ensures that SMR registers are not touched when stream
matchign is not supported by the hardware. When stream id matching is not
supported by the hardware the SMR registers does not exists. However, even
if they are UNK/SBZP we prefer not to write to more registers than needed.

v1 -> v2:
* Fixed so that SL0 is programed for SMMUv1 hardware also
* Rebased onto Will's iommu/pci branch which only left one issue to fix
  for the second patch.

Olav Haugan (2):
  iommu/arm-smmu: Fix programming of SMMU_CBn_TCR for stage 1
  iommu/arm-smmu: Do not access non-existing SMR registers

 drivers/iommu/arm-smmu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
