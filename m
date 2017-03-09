From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V3 4/5] iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
Date: Thu,  9 Mar 2017 21:05:47 +0530
Message-ID: <1489073748-3659-5-git-send-email-sricharan@codeaurora.org>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mathieu.poirier@linaro.org, mark.rutland@arm.com
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

The smmu device probe/remove and add/remove master device callbacks
gets called when the smmu is not linked to its master, that is without
the context of the master device. So calling runtime apis in those places
separately.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f29e28bf..6370421 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1216,11 +1216,16 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	void __iomem *cb_base;
+	unsigned long ret;
 	int irq;
 
 	if (!smmu)
 		return;
 
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (IS_ERR_VALUE(ret))
+		dev_warn(smmu->dev, "runtime resume failed");
+
 	/*
 	 * Disable the context bank and free the page tables before freeing
 	 * it.
@@ -1235,6 +1240,10 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+
+	ret = pm_runtime_put_sync(smmu->dev);
+	if (IS_ERR_VALUE(ret))
+		dev_warn(smmu->dev, "runtime suspend failed");
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1663,6 +1672,7 @@ static int arm_smmu_add_device(struct device *dev)
 	struct arm_smmu_master_cfg *cfg;
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	int i, ret;
+	unsigned long err;
 
 	if (using_legacy_binding) {
 		ret = arm_smmu_register_legacy_master(dev, &smmu);
@@ -1703,12 +1713,20 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
+	err = pm_runtime_get_sync(smmu->dev);
+	if (IS_ERR_VALUE(err))
+		goto out_free;
+
 	ret = arm_smmu_master_alloc_smes(dev);
 	if (ret)
 		goto out_free;
 
 	iommu_device_link(&smmu->iommu, dev);
 
+	err = pm_runtime_put_sync(smmu->dev);
+	if (IS_ERR_VALUE(err))
+		goto out_free;
+
 	return 0;
 
 out_free:
@@ -1723,7 +1741,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
-
+	unsigned long ret;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1731,8 +1749,23 @@ static void arm_smmu_remove_device(struct device *dev)
 	cfg  = fwspec->iommu_priv;
 	smmu = cfg->smmu;
 
+	/*
+	 * The device link between the master device and
+	 * smmu is already purged at this point.
+	 * So enable the power to smmu explicitly.
+	 */
+
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (IS_ERR_VALUE(ret))
+		dev_warn(smmu->dev, "runtime resume failed");
+
 	iommu_device_unlink(&smmu->iommu, dev);
 	arm_smmu_master_free_smes(fwspec);
+
+	ret = pm_runtime_put_sync(smmu->dev);
+	if (IS_ERR_VALUE(ret))
+		dev_warn(smmu->dev, "runtime suspend failed");
+
 	iommu_group_remove_device(dev);
 	kfree(fwspec->iommu_priv);
 	iommu_fwspec_free(dev);
@@ -2316,6 +2349,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	int num_irqs, i, err;
+	unsigned long ret;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2375,7 +2409,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	platform_set_drvdata(pdev, smmu);
 	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2417,9 +2456,11 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
+	ret = pm_runtime_put_sync(dev);
+	if (IS_ERR_VALUE(ret))
+		return err;
 
 	/* Oh, for a proper bus abstraction */
 	if (!iommu_present(&platform_bus_type))
@@ -2449,6 +2490,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	pm_runtime_force_suspend(smmu->dev);
+
 	return 0;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
