From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V2 2/3] iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
Date: Thu,  2 Feb 2017 22:40:19 +0530
Message-ID: <1486055420-19671-3-git-send-email-sricharan@codeaurora.org>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, sboyd@codeaurora.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mathieu.poirier@linaro.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

The smmu device probe/remove and add/remove master device callbacks
gets called when the smmu is not linked to its master, that is without
the context of the master device. So calling runtime apis in those places
separately.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index cd2e3db..5170523 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1021,11 +1021,15 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	void __iomem *cb_base;
-	int irq;
+	int irq, ret;
 
 	if (!smmu)
 		return;
 
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		dev_warn(smmu->dev, "runtime resume failed");
+
 	/*
 	 * Disable the context bank and free the page tables before freeing
 	 * it.
@@ -1040,6 +1044,10 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+
+	ret = pm_runtime_put_sync(smmu->dev);
+	if (ret)
+		dev_warn(smmu->dev, "runtime suspend failed");
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1508,10 +1516,18 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		goto out_free;
+
 	ret = arm_smmu_master_alloc_smes(dev);
 	if (ret)
 		goto out_free;
 
+	ret = pm_runtime_put_sync(smmu->dev);
+	if (ret)
+		goto out_free;
+
 	return 0;
 
 out_free:
@@ -1524,11 +1540,27 @@ static int arm_smmu_add_device(struct device *dev)
 static void arm_smmu_remove_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
+	int ret;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
 
+	/*
+	 * The device link between the master device and
+	 * smmu is already purged at this point.
+	 * So enable the power to smmu explicitly.
+	 */
+
+	ret = pm_runtime_get_sync(smmu->dev);
+	if (ret)
+		dev_warn(smmu->dev, "runtime resume failed");
+
 	arm_smmu_master_free_smes(fwspec);
+
+	ret = pm_runtime_put_sync(smmu->dev);
+	if (ret)
+		dev_warn(smmu->dev, "runtime suspend failed");
 	iommu_group_remove_device(dev);
 	kfree(fwspec->iommu_priv);
 	iommu_fwspec_free(dev);
@@ -2190,7 +2222,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	platform_set_drvdata(pdev, smmu);
 	pm_runtime_enable(dev);
+	err = pm_runtime_get_sync(dev);
+	if (err)
+		return err;
+
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2217,9 +2254,11 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 
 	iommu_register_instance(dev->fwnode, &arm_smmu_ops);
-	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
+	err = pm_runtime_put_sync(dev);
+	if (err)
+		return err;
 
 	/* Oh, for a proper bus abstraction */
 	if (!iommu_present(&platform_bus_type))
@@ -2249,6 +2288,8 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	pm_runtime_force_suspend(smmu->dev);
+
 	return 0;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
