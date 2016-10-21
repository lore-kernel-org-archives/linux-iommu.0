From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 2/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Fri, 21 Oct 2016 22:44:24 +0530
Message-ID: <1477070066-15044-3-git-send-email-sricharan@codeaurora.org>
References: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1477070066-15044-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The smmu needs to be functional when the respective
master/s using it are active. As there is a device_link
between the master and smmu, the pm runtime ops for the smmu
gets invoked in sync with the master's runtime, thus the
smmu remains powered only when needed.

There are couple of places in the driver during probe,
master attach, where the smmu needs to be clocked without
the context of the master. So doing a pm_runtime_get/put sync
in those places separately.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 083489e4..45f2762 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -45,6 +45,7 @@
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -373,6 +374,8 @@ struct arm_smmu_device {
 	u32				num_global_irqs;
 	u32				num_context_irqs;
 	unsigned int			*irqs;
+	int                             num_clocks;
+	struct clk                      **clocks;
 
 	u32				cavium_id_base; /* Specific to Cavium */
 };
@@ -430,6 +433,31 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < smmu->num_clocks; ++i) {
+		ret = clk_prepare_enable(smmu->clocks[i]);
+		if (ret) {
+			dev_err(smmu->dev, "Couldn't enable clock #%d\n", i);
+			while (i--)
+				clk_disable_unprepare(smmu->clocks[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void arm_smmu_disable_clocks(struct arm_smmu_device *smmu)
+{
+	int i;
+
+	for (i = 0; i < smmu->num_clocks; ++i)
+		clk_disable_unprepare(smmu->clocks[i]);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -1187,11 +1215,13 @@ static void arm_smmu_master_free_smes(struct iommu_fwspec *fwspec)
 	int i, idx;
 
 	mutex_lock(&smmu->stream_map_mutex);
+	pm_runtime_get_sync(smmu->dev);
 	for_each_cfg_sme(fwspec, i, idx) {
 		if (arm_smmu_free_sme(smmu, idx))
 			arm_smmu_write_sme(smmu, idx);
 		cfg->smendx[i] = INVALID_SMENDX;
 	}
+	pm_runtime_put_sync(smmu->dev);
 	mutex_unlock(&smmu->stream_map_mutex);
 }
 
@@ -1424,9 +1454,11 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
+	pm_runtime_get_sync(smmu->dev);
 	ret = arm_smmu_master_alloc_smes(dev);
 	if (ret)
 		goto out_free;
+	pm_runtime_put_sync(smmu->dev);
 
 	return 0;
 
@@ -1650,6 +1682,44 @@ static int arm_smmu_id_size_to_bits(int size)
 	}
 }
 
+static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
+{
+	const char *cname;
+	struct property *prop;
+	int i;
+	struct device *dev = smmu->dev;
+
+	smmu->num_clocks =
+		of_property_count_strings(dev->of_node, "clock-names");
+
+	if (smmu->num_clocks < 1)
+		return 0;
+
+	smmu->clocks = devm_kzalloc(dev,
+				    sizeof(*smmu->clocks) * smmu->num_clocks,
+				    GFP_KERNEL);
+
+	if (!smmu->clocks) {
+		dev_err(dev, "Failed to allocate memory for clocks\n");
+		return -ENODEV;
+	}
+
+	i = 0;
+	of_property_for_each_string(dev->of_node, "clock-names", prop, cname) {
+		struct clk *c = devm_clk_get(dev, cname);
+
+		if (IS_ERR(c)) {
+			dev_err(dev, "Couldn't get clock: %s", cname);
+			return -EPROBE_DEFER;
+		}
+
+		smmu->clocks[i] = c;
+		++i;
+	}
+
+	return 0;
+}
+
 static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned long size;
@@ -1968,6 +2038,13 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = arm_smmu_init_clocks(smmu);
+	if (err)
+		return err;
+
+	platform_set_drvdata(pdev, smmu);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -1996,8 +2073,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 
 	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
-	platform_set_drvdata(pdev, smmu);
 	arm_smmu_device_reset(smmu);
+	pm_runtime_put_sync(dev);
 
 	/* Oh, for a proper bus abstraction */
 	if (!iommu_present(&platform_bus_type))
@@ -2027,13 +2104,43 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
+
+	pm_runtime_force_suspend(smmu->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int arm_smmu_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+
+	return arm_smmu_enable_clocks(smmu);
+}
+
+static int arm_smmu_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+
+	arm_smmu_disable_clocks(smmu);
+
 	return 0;
 }
+#endif
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(arm_smmu_suspend, arm_smmu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.pm = &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_dt_probe,
 	.remove	= arm_smmu_device_remove,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
