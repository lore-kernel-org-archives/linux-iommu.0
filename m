From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 2/6] iommu/arm-smmu: add support for specifying regulators
Date: Tue, 12 Aug 2014 17:51:35 -0700
Message-ID: <1407891099-24641-3-git-send-email-mitchelh@codeaurora.org>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1407891099-24641-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On some power-constrained platforms it's useful to disable power when a
device is not in use. Add support for specifying regulators for SMMUs
and only leave power on as long as the SMMU is in use (attached).

Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         |   3 +
 drivers/iommu/arm-smmu.c                           | 102 ++++++++++++++++++---
 2 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index ceae3fe207..dbc1ddad79 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -59,6 +59,9 @@ conditions.
                   Documentation/devicetree/bindings/clock/clock-bindings.txt
                   for more info.
 
+- vdd-supply    : Phandle of the regulator that should be powered on during
+                  SMMU register access.
+
 Example:
 
         smmu {
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e123d75db3..7fdc58d8f8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -402,6 +402,11 @@ struct arm_smmu_device {
 
 	int num_clocks;
 	struct clk **clocks;
+
+	struct regulator *gdsc;
+
+	struct mutex			attach_lock;
+	unsigned int			attach_count;
 };
 
 struct arm_smmu_cfg {
@@ -617,6 +622,22 @@ static void arm_smmu_disable_clocks(struct arm_smmu_device *smmu)
 		clk_disable_unprepare(smmu->clocks[i]);
 }
 
+static int arm_smmu_enable_regulators(struct arm_smmu_device *smmu)
+{
+	if (!smmu->gdsc)
+		return 0;
+
+	return regulator_enable(smmu->gdsc);
+}
+
+static int arm_smmu_disable_regulators(struct arm_smmu_device *smmu)
+{
+	if (!smmu->gdsc)
+		return 0;
+
+	return regulator_disable(smmu->gdsc);
+}
+
 /* Wait for any pending TLB invalidations to complete */
 static void arm_smmu_tlb_sync(struct arm_smmu_device *smmu)
 {
@@ -1275,6 +1296,8 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
 	arm_smmu_disable_clocks(smmu);
 }
 
+static void arm_smmu_device_reset(struct arm_smmu_device *smmu);
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
@@ -1293,7 +1316,15 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EEXIST;
 	}
 
-	arm_smmu_enable_clocks(smmu);
+	mutex_lock(&smmu->attach_lock);
+	if (!smmu->attach_count++) {
+		arm_smmu_enable_regulators(smmu);
+		arm_smmu_enable_clocks(smmu);
+		arm_smmu_device_reset(smmu);
+	} else {
+		arm_smmu_enable_clocks(smmu);
+	}
+	mutex_unlock(&smmu->attach_lock);
 
 	/*
 	 * Sanity check the domain. We don't support domains across
@@ -1304,7 +1335,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		/* Now that we have a master, we can finalise the domain */
 		ret = arm_smmu_init_domain_context(domain, smmu);
 		if (IS_ERR_VALUE(ret))
-			goto disable_clocks;
+			goto err_disable_clocks;
 
 		dom_smmu = smmu_domain->smmu;
 	}
@@ -1314,28 +1345,46 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
 			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
 		ret = -EINVAL;
-		goto disable_clocks;
+		goto err_disable_clocks;
 	}
 
 	/* Looks ok, so add the device to the domain */
 	cfg = find_smmu_master_cfg(dev);
 	if (!cfg) {
 		ret = -ENODEV;
-		goto disable_clocks;
+		goto err_disable_clocks;
 	}
 
 	ret = arm_smmu_domain_add_master(smmu_domain, cfg);
 	if (!ret)
 		dev->archdata.iommu = domain;
-disable_clocks:
 	arm_smmu_disable_clocks(smmu);
 	return ret;
+
+err_disable_clocks:
+	arm_smmu_disable_clocks(smmu);
+	mutex_lock(&smmu->attach_lock);
+	if (!--smmu->attach_count)
+		arm_smmu_disable_regulators(smmu);
+	mutex_unlock(&smmu->attach_lock);
+	return ret;
+}
+
+static void arm_smmu_power_off(struct arm_smmu_device *smmu)
+{
+	/* Turn the thing off */
+	arm_smmu_enable_clocks(smmu);
+	writel_relaxed(sCR0_CLIENTPD,
+		ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+	arm_smmu_disable_clocks(smmu);
+	arm_smmu_disable_regulators(smmu);
 }
 
 static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
 	struct arm_smmu_master_cfg *cfg;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	cfg = find_smmu_master_cfg(dev);
 	if (!cfg)
@@ -1343,6 +1392,10 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 
 	dev->archdata.iommu = NULL;
 	arm_smmu_domain_remove_master(smmu_domain, cfg);
+	mutex_lock(&smmu->attach_lock);
+	if (!--smmu->attach_count)
+		arm_smmu_power_off(smmu);
+	mutex_unlock(&smmu->attach_lock);
 }
 
 static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
@@ -1844,6 +1897,20 @@ static int arm_smmu_id_size_to_bits(int size)
 	}
 }
 
+static int arm_smmu_init_regulators(struct arm_smmu_device *smmu)
+{
+	struct device *dev = smmu->dev;
+
+	if (!of_get_property(dev->of_node, "vdd-supply", NULL))
+		return 0;
+
+	smmu->gdsc = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(smmu->gdsc))
+		return PTR_ERR(smmu->gdsc);
+
+	return 0;
+}
+
 static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
 {
 	const char *cname;
@@ -2065,6 +2132,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	smmu->dev = dev;
+	mutex_init(&smmu->attach_lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	smmu->base = devm_ioremap_resource(dev, res);
@@ -2124,13 +2192,19 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	dev_notice(dev, "registered %d master devices\n", i);
 
+	err = arm_smmu_init_regulators(smmu);
+	if (err)
+		goto out_put_masters;
+
 	err = arm_smmu_init_clocks(smmu);
 	if (err)
 		goto out_put_masters;
 
+	arm_smmu_enable_regulators(smmu);
 	arm_smmu_enable_clocks(smmu);
-
 	err = arm_smmu_device_cfg_probe(smmu);
+	arm_smmu_disable_clocks(smmu);
+	arm_smmu_disable_regulators(smmu);
 	if (err)
 		goto out_disable_clocks;
 
@@ -2163,8 +2237,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	list_add(&smmu->list, &arm_smmu_devices);
 	spin_unlock(&arm_smmu_devices_lock);
 
-	arm_smmu_device_reset(smmu);
-	arm_smmu_disable_clocks(smmu);
 	return 0;
 
 out_free_irqs:
@@ -2173,6 +2245,7 @@ out_free_irqs:
 
 out_disable_clocks:
 	arm_smmu_disable_clocks(smmu);
+	arm_smmu_disable_regulators(smmu);
 
 out_put_masters:
 	for (node = rb_first(&smmu->masters); node; node = rb_next(node)) {
@@ -2216,10 +2289,15 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	for (i = 0; i < smmu->num_global_irqs; ++i)
 		free_irq(smmu->irqs[i], smmu);
 
-	/* Turn the thing off */
-	arm_smmu_enable_clocks(smmu);
-	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
-	arm_smmu_disable_clocks(smmu);
+	mutex_lock(&smmu->attach_lock);
+	/*
+	 * If all devices weren't detached for some reason, we're
+	 * still powered on. Power off now.
+	 */
+	if (smmu->attach_count)
+		arm_smmu_power_off(smmu);
+	mutex_unlock(&smmu->attach_lock);
+
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
