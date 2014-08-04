From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [PATCH v1 1/2] iommu/arm-smmu: Fix programming of SMMU_CBn_TCR for stage 1
Date: Sun,  3 Aug 2014 17:47:43 -0700
Message-ID: <1407113264-23426-2-git-send-email-ohaugan@codeaurora.org>
References: <1407113264-23426-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1407113264-23426-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: will.deacon@arm.com
Cc: mitchelh@codeaurora.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Stage-1 context bank does not have SMMU_CBn_TCR[SL0] field. SL0 field
is only applicable to stage-2 context banks.

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ff6633d..a83ca6a 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -833,6 +833,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 				reg |= (TTBCR2_ADDR_48 << TTBCR_PASIZE_SHIFT);
 				break;
 			}
+			reg |= (TTBCR_SL0_LVL_1 << TTBCR_SL0_SHIFT);
+
 		} else {
 			reg |= (64 - smmu->input_size) << TTBCR_T0SZ_SHIFT;
 		}
@@ -843,8 +845,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	reg |= TTBCR_EAE |
 	      (TTBCR_SH_IS << TTBCR_SH0_SHIFT) |
 	      (TTBCR_RGN_WBWA << TTBCR_ORGN0_SHIFT) |
-	      (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT) |
-	      (TTBCR_SL0_LVL_1 << TTBCR_SL0_SHIFT);
+	      (TTBCR_RGN_WBWA << TTBCR_IRGN0_SHIFT);
 	writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBCR);
 
 	/* MAIR0 (stage-1 only) */
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
