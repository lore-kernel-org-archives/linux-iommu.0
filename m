From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 3/3] iommu/arm-smmu: Error out only if not enough context interrupts
Date: Thu, 19 Jul 2018 23:23:56 +0530
Message-ID: <20180719175356.14753-4-vivek.gautam@codeaurora.org>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719175356.14753-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robh+dt@kernel.org, robin.murphy@arm.com, will.deacon@arm.com, andy.gross@linaro.org
Cc: mark.rutland@arm.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tfiga@chromium.org, sricharan@codeaurora.org, linux-arm-msm@vger.kernel.org, david.brown@linaro.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Currently we check if the number of context banks is not equal to
num_context_interrupts. However, there are booloaders such as, one
on sdm845 that reserves few context banks and thus kernel views
less than the total available context banks.
So, although the hardware definition in device tree would mention
the correct number of context interrupts, this number can be
greater than the number of context banks visible to smmu in kernel.
We should therefore error out only when the number of context banks
is greater than the available number of context interrupts.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Suggested-by: Tomasz Figa <tfiga@chromium.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c69736a30f8..4cb53bf4f423 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2229,12 +2229,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	if (smmu->version == ARM_SMMU_V2 &&
-	    smmu->num_context_banks != smmu->num_context_irqs) {
-		dev_err(dev,
-			"found only %d context interrupt(s) but %d required\n",
-			smmu->num_context_irqs, smmu->num_context_banks);
-		return -ENODEV;
+	if (smmu->version == ARM_SMMU_V2) {
+		if (smmu->num_context_banks > smmu->num_context_irqs) {
+			dev_err(dev,
+			      "found only %d context irq(s) but %d required\n",
+			      smmu->num_context_irqs, smmu->num_context_banks);
+			return -ENODEV;
+		} else if (smmu->num_context_banks < smmu->num_context_irqs) {
+			/* loose extra context interrupts */
+			dev_notice(dev,
+			      "found %d context irq(s) but only %d required\n",
+			      smmu->num_context_irqs, smmu->num_context_banks);
+			smmu->num_context_irqs = smmu->num_context_banks;
+		}
 	}
 
 	for (i = 0; i < smmu->num_global_irqs; ++i) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
