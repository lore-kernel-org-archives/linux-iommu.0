From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH] iommu: arm-smmu: handle client iommu translation fault handlers
Date: Wed, 10 Oct 2018 17:44:07 +0300
Message-ID: <20181010144407.23336-1-stanimir.varbanov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Stanimir Varbanov <stanimir.varbanov@linaro.org>
List-Id: iommu@lists.linux-foundation.org

Call iommu client translation fault handler(s).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 066f4c8daf4e..02a8aab0cc59 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -568,6 +568,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 			    fsr, iova, fsynr, cfg->cbndx);
 
 	writel(fsr, cb_base + ARM_SMMU_CB_FSR);
+
+	report_iommu_fault(domain, smmu->dev, iova, 0);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1
