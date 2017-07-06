From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH V4 3/6] iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
Date: Thu,  6 Jul 2017 15:07:02 +0530
Message-ID: <1499333825-7658-4-git-send-email-vivek.gautam@codeaurora.org>
References: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, will.deacon@arm.com, m.szyprowski@samsung.com, sboyd@codeaurora.org, robdclark@gmail.com, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, sricharan@codeaurora.org, stanimir.varbanov@linaro.org, architt@codeaurora.org, vivek.gautam@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

From: Sricharan R <sricharan@codeaurora.org>

The smmu device probe/remove and add/remove master device callbacks
gets called when the smmu is not linked to its master, that is without
the context of the master device. So calling runtime apis in those places
separately.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[stanimir: added runtime pm in .unmap iommu op]
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
[vivek: Cleanup pm runtime calls]
Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 54 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index bfe613f8939c..ddbfa8ab69e6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -897,11 +897,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	void __iomem *cb_base;
-	int irq;
+	int ret, irq;
 
 	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		return;
+
 	/*
 	 * Disable the context bank and free the page tables before freeing
 	 * it.
@@ -916,6 +920,8 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+
+	pm_runtime_put_sync(smmu->dev);
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1231,12 +1237,18 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 			     size_t size)
 {
-	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
+	size_t ret;
 
 	if (!ops)
 		return 0;
 
-	return ops->unmap(ops, iova, size);
+	pm_runtime_get_sync(smmu_domain->smmu->dev);
+	ret = ops->unmap(ops, iova, size);
+	pm_runtime_put_sync(smmu_domain->smmu->dev);
+
+	return ret;
 }
 
 static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
@@ -1377,12 +1389,20 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
-	ret = arm_smmu_master_alloc_smes(dev);
+	ret = pm_runtime_get_sync(smmu->dev);
 	if (ret)
 		goto out_cfg_free;
 
+	ret = arm_smmu_master_alloc_smes(dev);
+	if (ret) {
+		pm_runtime_put_sync(smmu->dev);
+		goto out_cfg_free;
+	}
+
 	iommu_device_link(&smmu->iommu, dev);
 
+	pm_runtime_put_sync(smmu->dev);
+
 	return 0;
 
 out_cfg_free:
@@ -1397,7 +1417,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
-
+	int ret;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1405,8 +1425,21 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	/*
+	 * The device link between the master device and
+	 * smmu is already purged at this point.
+	 * So enable the power to smmu explicitly.
+	 */
+
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		return;
+
 	iommu_device_unlink(&smmu->iommu, dev);
 	arm_smmu_master_free_smes(fwspec);
+
+	pm_runtime_put_sync(smmu->dev);
+
 	iommu_group_remove_device(dev);
 	kfree(fwspec->iommu_priv);
 	iommu_fwspec_free(dev);
@@ -2103,6 +2136,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	platform_set_drvdata(pdev, smmu);
+	pm_runtime_enable(dev);
+
+	err = pm_runtime_get_sync(dev);
+	if (err)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2144,9 +2184,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
+	pm_runtime_put_sync(dev);
 
 	/*
 	 * For ACPI and generic DT bindings, an SMMU will be probed before
@@ -2185,6 +2225,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	pm_runtime_force_suspend(smmu->dev);
+
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
