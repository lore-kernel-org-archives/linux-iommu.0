From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH v2] iommu: qcom: wire up fault handler
Date: Wed, 25 Oct 2017 11:30:32 -0400
Message-ID: <20171025153034.9676-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This is quite useful for debugging.  Currently, always TERMINATE the
translation when the fault handler returns (since this is all we need
for debugging drivers).  But I expect the SVM work should eventually
let us do something more clever.

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
v2: add back a hunk that was lost when rebasing

 drivers/iommu/qcom_iommu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c8a587d034b0..eeed1ce0cdde 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -66,6 +66,7 @@ struct qcom_iommu_ctx {
 	void __iomem		*base;
 	bool			 secure_init;
 	u8			 asid;      /* asid and ctx bank # are 1:1 */
+	struct iommu_domain	*domain;
 };
 
 struct qcom_iommu_domain {
@@ -194,12 +195,15 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	fsynr = iommu_readl(ctx, ARM_SMMU_CB_FSYNR0);
 	iova = iommu_readq(ctx, ARM_SMMU_CB_FAR);
 
-	dev_err_ratelimited(ctx->dev,
-			    "Unhandled context fault: fsr=0x%x, "
-			    "iova=0x%016llx, fsynr=0x%x, cb=%d\n",
-			    fsr, iova, fsynr, ctx->asid);
+	if (!report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {
+		dev_err_ratelimited(ctx->dev,
+				    "Unhandled context fault: fsr=0x%x, "
+				    "iova=0x%016llx, fsynr=0x%x, cb=%d\n",
+				    fsr, iova, fsynr, ctx->asid);
+	}
 
 	iommu_writel(ctx, ARM_SMMU_CB_FSR, fsr);
+	iommu_writel(ctx, ARM_SMMU_CB_RESUME, RESUME_TERMINATE);
 
 	return IRQ_HANDLED;
 }
@@ -274,12 +278,14 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 
 		/* SCTLR */
 		reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE |
-			SCTLR_M | SCTLR_S1_ASIDPNE;
+			SCTLR_M | SCTLR_S1_ASIDPNE | SCTLR_CFCFG;
 
 		if (IS_ENABLED(CONFIG_BIG_ENDIAN))
 			reg |= SCTLR_E;
 
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, reg);
+
+		ctx->domain = domain;
 	}
 
 	mutex_unlock(&qcom_domain->init_mutex);
@@ -395,6 +401,8 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
 
 		/* Disable the context bank: */
 		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
+
+		ctx->domain = NULL;
 	}
 	pm_runtime_put_sync(qcom_iommu->dev);
 
-- 
2.13.6
