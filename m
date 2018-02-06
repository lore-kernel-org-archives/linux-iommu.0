From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH RFC 1/1] iommu/arm-smmu: Fix context fault message considering non-NTS
Date: Tue,  6 Feb 2018 15:46:53 +0530
Message-ID: <1517912213-3962-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

SMMU_CBn_FSYNR0 definition from SMMU v2 architecture document
says that, the S1CBNDX[23:16] field is only valid if SMMU_IDR0.NTS==1.
So, update the fsynr in context bank fault handler, so that the
fault message displays cbndx only when we have nested translations
enabled.
Otherwise, it is confusing when 'cb' gives the actual context
bank, while the 'fsynr' gives a different value.

Example, on a sdm845 system:
Before this patch -
arm-smmu 15000000.apps-smmu: Unhandled context fault:
                          fsr=0x402, iova=0x9e0fb600, fsynr=0x3c0020, cb=0
After this patch -
arm-smmu 15000000.apps-smmu: Unhandled context fault:
                          fsr=0x402, iova=0x9e0aa000, fsynr=0x20, cb=0

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---

Hi Robin,
Does it make sense to mask fsynr like this?
Would it still be confusing for CB==0?
Tagging the patch as RFC to get your comments. If looks good,
then i will send the patch for your ack.
Thanks.

 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 69e7c60792a8..827659515b22 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -550,6 +550,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
 	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
 
+	if (!smmu->features & ARM_SMMU_FEAT_TRANS_NESTED)
+		fsynr &= 0xffff;
+
 	dev_err_ratelimited(smmu->dev,
 	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
 			    fsr, iova, fsynr, cfg->cbndx);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
