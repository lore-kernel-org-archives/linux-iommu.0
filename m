From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V2 1/3] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Thu,  2 Feb 2017 22:40:18 +0530
Message-ID: <1486055420-19671-2-git-send-email-sricharan@codeaurora.org>
References: <1486055420-19671-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486055420-19671-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The smmu needs to be functional only when the respective
master's using it are active. The device_link feature
helps to track such functional dependencies, so that the
iommu gets powered when the master device enables itself
using pm_runtime. So by adapting the smmu driver for
runtime pm, above said dependency can be addressed.

This patch adds the pm runtime/sleep callbacks to the
driver and also the functions to parse the smmu clocks
from DT and enable them in resume/suspend.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/iommu/arm,smmu.txt         | 16 ++++
 drivers/iommu/arm-smmu.c                           | 97 ++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index e862d148..2376828 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -60,6 +60,18 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
+- clock-names:    Should be a pair of "smmu_iface_clk" and "smmu_bus_clk"
+                  required for smmu's register group access and interface
+                  clk for the smmu's underlying bus access.
+
+- clocks:         Phandles for respective clocks described by clock-names.
+
+- power-domains:  Phandles to SMMU's power domain specifier. This is
+                  required even if SMMU belongs to the master's power
+                  domain, as the SMMU will have to be enabled and
+                  accessed before master gets enabled and linked to its
+                  SMMU.
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
@@ -84,6 +96,10 @@ conditions.
                              <0 36 4>,
                              <0 37 4>;
                 #iommu-cells = <1>;
+		clocks = <&mmcc SMMU_MDP_AHB_CLK>,
+			 <&mmcc SMMU_MDP_AXI_CLK>;
+		clock-names = "smmu_iface_clk",
+			      "smmu_bus_clk";
         };
 
         /* device with two stream IDs, 0 and 7 */
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 091d4a6..cd2e3db 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -48,6 +48,7 @@
 #include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -387,6 +388,8 @@ struct arm_smmu_device {
 	u32				num_global_irqs;
 	u32				num_context_irqs;
 	unsigned int			*irqs;
+	int                             num_clocks;
+	struct clk                      **clocks;
 
 	u32				cavium_id_base; /* Specific to Cavium */
 };
@@ -444,6 +447,31 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
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
+	int i = smmu->num_clocks;
+
+	while (i--)
+		clk_disable_unprepare(smmu->clocks[i]);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -1740,6 +1768,43 @@ static int arm_smmu_id_size_to_bits(int size)
 	}
 }
 
+static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
+{
+	const char *cname;
+	struct property *prop;
+	int i = 0;
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
@@ -2121,6 +2186,11 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	err = arm_smmu_init_clocks(smmu);
+	if (err)
+		return err;
+
+	pm_runtime_enable(dev);
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
 		return err;
@@ -2182,10 +2252,37 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
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
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops arm_smmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(arm_smmu_suspend, arm_smmu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.pm = &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
