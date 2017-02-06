From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/10] iommu/arm-smmu: Make use of the iommu_register interface
Date: Mon,  6 Feb 2017 17:10:25 +0100
Message-ID: <1486397429-29327-7-git-send-email-joro@8bytes.org>
References: <1486397429-29327-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486397429-29327-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Also add the smmu devices to sysfs.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 20 +++++++++++++++++++-
 drivers/iommu/arm-smmu.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d6ec44..37094b5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -616,6 +616,9 @@ struct arm_smmu_device {
 	unsigned int			sid_bits;
 
 	struct arm_smmu_strtab_cfg	strtab_cfg;
+
+	/* IOMMU core code handle */
+	struct iommu_device		iommu;
 };
 
 /* SMMU private data for each master */
@@ -1795,8 +1798,10 @@ static int arm_smmu_add_device(struct device *dev)
 	}
 
 	group = iommu_group_get_for_dev(dev);
-	if (!IS_ERR(group))
+	if (!IS_ERR(group)) {
 		iommu_group_put(group);
+		iommu_device_link(&smmu->iommu, dev);
+	}
 
 	return PTR_ERR_OR_ZERO(group);
 }
@@ -1805,14 +1810,17 @@ static void arm_smmu_remove_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct arm_smmu_master_data *master;
+	struct arm_smmu_device *smmu;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
 
 	master = fwspec->iommu_priv;
+	smmu = master->smmu;
 	if (master && master->ste.valid)
 		arm_smmu_detach_dev(dev);
 	iommu_group_remove_device(dev);
+	iommu_device_unlink(&smmu->iommu, dev);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
@@ -2613,6 +2621,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
 	struct resource *res;
+	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	bool bypass;
@@ -2630,6 +2639,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
+	ioaddr = res->start;
 
 	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
@@ -2682,6 +2692,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 
 	/* And we're up. Go go go! */
+	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
+				     "smmu3.%pa", &ioaddr);
+	if (ret)
+		return ret;
+
+	smmu->iommu.ops = &arm_smmu_ops;
+	ret = iommu_device_register(&smmu->iommu);
+
 	iommu_register_instance(dev->fwnode, &arm_smmu_ops);
 
 #ifdef CONFIG_PCI
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a60cded..827e778 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -380,6 +380,9 @@ struct arm_smmu_device {
 	unsigned int			*irqs;
 
 	u32				cavium_id_base; /* Specific to Cavium */
+
+	/* IOMMU core code handle */
+	struct iommu_device		iommu;
 };
 
 enum arm_smmu_context_fmt {
@@ -1444,6 +1447,8 @@ static int arm_smmu_add_device(struct device *dev)
 	if (ret)
 		goto out_free;
 
+	iommu_device_link(&smmu->iommu, dev);
+
 	return 0;
 
 out_free:
@@ -1456,10 +1461,17 @@ static int arm_smmu_add_device(struct device *dev)
 static void arm_smmu_remove_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct arm_smmu_master_cfg *cfg;
+	struct arm_smmu_device *smmu;
+
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
 
+	cfg  = fwspec->iommu_priv;
+	smmu = cfg->smmu;
+
+	iommu_device_unlink(&smmu->iommu, dev);
 	arm_smmu_master_free_smes(fwspec);
 	iommu_group_remove_device(dev);
 	kfree(fwspec->iommu_priv);
@@ -2011,6 +2023,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	int num_irqs, i, err;
@@ -2031,6 +2044,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return err;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ioaddr = res->start;
 	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
@@ -2091,6 +2105,21 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
+				     "smmu.%pa", &ioaddr);
+	if (err) {
+		dev_err(dev, "Failed to register iommu in sysfs\n");
+		return err;
+	}
+
+	smmu->iommu.ops = &arm_smmu_ops;
+
+	err = iommu_device_register(&smmu->iommu);
+	if (err) {
+		dev_err(dev, "Failed to register iommu\n");
+		return err;
+	}
+
 	iommu_register_instance(dev->fwnode, &arm_smmu_ops);
 	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
-- 
1.9.1
