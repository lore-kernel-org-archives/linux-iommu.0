From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [RFC PATCH 1/1] iommu/arm-smmu: Add support for multiple TBU child
	devices
Date: Tue, 12 Sep 2017 17:31:07 +0530
Message-ID: <1505217667-31184-1-git-send-email-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

ARM MMU-500 implements a TBU (uTLB) for each connected master
besides a single TCU which controls and manages the address
translations. Each of these TBUs can either be in the same
power domain as the master, or they can have a independent
power switch.
This design addresses the challenges to control TBU power.
Adding child devices for each TBUs present in the configuration
lets us control the power and clocks to TLBs having individual
power domains. The device link between master devices (such as,
display, and GPU) and TBU devices ensures that the master takes
care of powering the smmu as long as it's available.
When the master is not available, the TBUs are identified with
sid and powered on.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---

 - The idea behind this patch is to handle the distributed smmu
   architectures, similar to MMU-500.
 - Untested yet.
 - There are still few instances where the correct tbu device has
   to be referenced and thus powered on to handle TLB maintenance
   operations.

 .../devicetree/bindings/iommu/arm,smmu.txt         |  27 +++
 drivers/iommu/arm-smmu.c                           | 191 +++++++++++++++++++--
 2 files changed, 205 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index d97a6bc8e608..7cf67e75022e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -98,6 +98,18 @@ conditions.
                   accessed before master gets enabled and linked to its
                   SMMU.
 
+- child nodes:    ARM MMU-500 implements a TBU (page table cache or TLB) for
+                  each connected master besides a single TCU that controls
+                  and manages the address translations.
+                  Each of the child nodes represents a TBU that is attached to
+                  the master. This child node will have following property:
+
+  - compatibe:       must be "arm,mmu-500-tbu" for TBU child nodes of arm,mmu-500
+                     smmu.
+  - stream-id-range: array representing the starting stream id and the number
+                     of supported stream-ids. This gives information about
+                     the range of stream-ids that are supported by this TBU.
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
@@ -187,3 +199,18 @@ conditions.
 			 <&mmcc SMMU_MDP_AHB_CLK>;
 		clock-names = "bus", "iface";
 	};
+
+	smmu4: iommu {
+		compatible = "arm,mmu-500";
+		reg = <0xd00000 0x10000>;
+                ...
+                ...
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                tbu: tbu@0 {
+                         compatible = "arm,mmu-500-tbu";
+                         reg = <0>;
+                         stream-id-range = <0x0 0x400>;
+                };
+        };
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 14137e389071..ba84693e2de3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -224,6 +224,8 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	struct list_head		tbu_list;
 };
 
 enum arm_smmu_context_fmt {
@@ -333,6 +335,33 @@ static int __find_legacy_master_phandle(struct device *dev, void *data)
 static struct platform_driver arm_smmu_driver;
 static struct iommu_ops arm_smmu_ops;
 
+struct arm_smmu500_tbu {
+	struct device *dev;
+	u32 sid_range[2];
+	struct list_head list;
+	struct arm_smmu_device *smmu;
+};
+
+static struct device *find_tbu(struct device *parent, u16 sid)
+{
+	struct arm_smmu_device *smmu = dev_get_drvdata(parent);
+	struct arm_smmu500_tbu *tbu;
+	u32 start, end;
+	struct device *dev = NULL;
+
+	list_for_each_entry(tbu, &smmu->tbu_list, list) {
+		start = tbu->sid_range[0];
+		end = start + tbu->sid_range[1];
+
+		if (start <= sid && sid < end) {
+			dev = tbu->dev;
+			break;
+		}
+	}
+
+	return dev;
+}
+
 static int arm_smmu_register_legacy_master(struct device *dev,
 					   struct arm_smmu_device **smmu)
 {
@@ -927,6 +956,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
+	/* TODO Get the TBU dev power it on; or turn on all the TBUs? */
 	ret = pm_runtime_get_sync(smmu->dev);
 	if (ret)
 		return;
@@ -1379,6 +1409,8 @@ static int arm_smmu_add_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
 	struct device_link *link;
 	int i, ret;
+	u16 sid;
+	struct device *tbu_dev;
 
 	if (using_legacy_binding) {
 		ret = arm_smmu_register_legacy_master(dev, &smmu);
@@ -1425,29 +1457,42 @@ static int arm_smmu_add_device(struct device *dev)
 	while (i--)
 		cfg->smendx[i] = INVALID_SMENDX;
 
-	ret = pm_runtime_get_sync(smmu->dev);
+	/*
+	 * Find out the correct TBU for this master based on the
+	 * steamID, and then create the device link between them.
+	 */
+	/* TODO: Iterate over all the SIDs, and turn them on? */
+	sid = fwspec->ids[0];
+	tbu_dev = find_tbu(smmu->dev, sid);
+	if (!tbu_dev)
+		tbu_dev = smmu->dev;
+
+	ret = pm_runtime_get_sync(tbu_dev);
 	if (ret)
 		goto out_cfg_free;
 
 	ret = arm_smmu_master_alloc_smes(dev);
 	if (ret) {
-		pm_runtime_put_sync(smmu->dev);
+		pm_runtime_put_sync(tbu_dev);
 		goto out_cfg_free;
 	}
 
 	iommu_device_link(&smmu->iommu, dev);
 
-	pm_runtime_put_sync(smmu->dev);
+	pm_runtime_put_sync(tbu_dev);
 
 	/*
 	 * Establish the link between smmu and master, so that the
 	 * smmu gets runtime enabled/disabled as per the master's
 	 * needs.
+	 * TBU devices are children to the smmu device, so creating link
+	 * between TBU devices and master takes care of turning on the smmu
+	 * as well.
 	 */
-	link = device_link_add(dev, smmu->dev, DL_FLAG_PM_RUNTIME);
+	link = device_link_add(dev, tbu_dev, DL_FLAG_PM_RUNTIME);
 	if (!link)
 		dev_warn(smmu->dev, "Unable to create device link between %s and %s\n",
-			 dev_name(smmu->dev), dev_name(dev));
+			 dev_name(tbu_dev), dev_name(dev));
 
 	return 0;
 
@@ -1464,6 +1509,8 @@ static void arm_smmu_remove_device(struct device *dev)
 	struct arm_smmu_master_cfg *cfg;
 	struct arm_smmu_device *smmu;
 	int ret;
+	u16 sid;
+	struct device *tbu_dev;
 
 	if (!fwspec || fwspec->ops != &arm_smmu_ops)
 		return;
@@ -1476,15 +1523,20 @@ static void arm_smmu_remove_device(struct device *dev)
 	 * smmu is already purged at this point.
 	 * So enable the power to smmu explicitly.
 	 */
+	sid = fwspec->ids[0];
 
-	ret = pm_runtime_get_sync(smmu->dev);
+	tbu_dev = find_tbu(smmu->dev, sid);
+	if (!tbu_dev)
+		tbu_dev = smmu->dev;
+
+	ret = pm_runtime_get_sync(tbu_dev);
 	if (ret)
 		return;
 
 	iommu_device_unlink(&smmu->iommu, dev);
 	arm_smmu_master_free_smes(fwspec);
 
-	pm_runtime_put_sync(smmu->dev);
+	pm_runtime_put_sync(tbu_dev);
 
 	iommu_group_remove_device(dev);
 	kfree(fwspec->iommu_priv);
@@ -2012,6 +2064,32 @@ struct arm_smmu_match_data {
 };
 MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
+static const struct of_device_id arm_smmu_tbu_of_match[] = {
+	{ .compatible = "arm,mmu-500-tbu", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, arm_smmu_tbu_of_match);
+
+static int arm_smmu_tbu_register(struct device *dev, void *cookie)
+{
+	struct arm_smmu_device *smmu = cookie;
+	struct arm_smmu500_tbu *tbu;
+
+	if (!dev->driver) {
+		dev_err(dev, "TBU failed probe, SMMUV500 cannot continue!\n");
+		return -EINVAL;
+	}
+
+	tbu = dev_get_drvdata(dev);
+
+	INIT_LIST_HEAD(&tbu->list);
+	tbu->smmu = smmu;
+	list_add_tail(&tbu->list, &smmu->tbu_list);
+
+	return 0;
+}
+
+
 #ifdef CONFIG_ACPI
 static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
 {
@@ -2140,6 +2218,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	resource_size_t ioaddr;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
+	struct arm_smmu500_tbu *tbu;
 	int num_irqs, i, err;
 
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
@@ -2157,6 +2236,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	INIT_LIST_HEAD(&smmu->tbu_list);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ioaddr = res->start;
 	smmu->base = devm_ioremap_resource(dev, res);
@@ -2194,16 +2275,32 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		smmu->irqs[i] = irq;
 	}
 
+	/* MMU 500 has one TCU and multiple TBU config */
+	if (of_device_is_compatible(dev->of_node, "arm,mmu-500")) {
+		err = of_platform_populate(dev->of_node, NULL, NULL, dev);
+		if (err) {
+			dev_err(dev, "failed to register TBU children\n");
+			return err;
+		}
+
+		err = device_for_each_child(dev, smmu, arm_smmu_tbu_register);
+		if (err)
+			return -EPROBE_DEFER;
+	}
+
 	err = arm_smmu_init_clocks(smmu);
 	if (err)
 		return err;
 
 	platform_set_drvdata(pdev, smmu);
+
 	pm_runtime_enable(dev);
 
-	err = pm_runtime_get_sync(dev);
-	if (err)
-		return err;
+	/* enable all TBUs */
+	list_for_each_entry(tbu, &smmu->tbu_list, list)
+		err = pm_runtime_get_sync(tbu->dev);
+		if (err)
+			return err;
 
 	err = arm_smmu_device_cfg_probe(smmu);
 	if (err)
@@ -2248,7 +2345,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
-	pm_runtime_put_sync(dev);
+
+	list_for_each_entry(tbu, &smmu->tbu_list, list)
+		pm_runtime_put_sync(tbu->dev);
 
 	/*
 	 * For ACPI and generic DT bindings, an SMMU will be probed before
@@ -2278,6 +2377,7 @@ static int arm_smmu_legacy_bus_init(void)
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+	struct arm_smmu500_tbu *tbu;
 
 	if (!smmu)
 		return -ENODEV;
@@ -2287,7 +2387,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
-	pm_runtime_force_suspend(smmu->dev);
+
+	list_for_each_entry(tbu, &smmu->tbu_list, list)
+		pm_runtime_force_suspend(tbu->dev);
 
 	return 0;
 }
@@ -2336,7 +2438,70 @@ static int __maybe_unused arm_smmu_suspend(struct device *dev)
 	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-module_platform_driver(arm_smmu_driver);
+
+static int arm_smmu_tbu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct arm_smmu500_tbu *tbu;
+	int err;
+
+	tbu = devm_kzalloc(dev, sizeof(*tbu), GFP_KERNEL);
+	if (!tbu)
+		return -ENOMEM;
+
+	tbu->dev = &pdev->dev;
+
+	err = of_property_read_u32_array(dev->of_node, "stream-id-range",
+					 tbu->sid_range, 2);
+	if (err)
+		dev_err(dev, "failed to read stream id range\n");
+
+	pm_runtime_enable(dev);
+
+	dev_set_drvdata(dev, tbu);
+
+	return 0;
+}
+
+static int arm_smmu_tbu_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver arm_smmu_tbu_driver = {
+	.driver	= {
+		.name		= "arm-mmu-500-tbu",
+		.of_match_table	= of_match_ptr(arm_smmu_tbu_of_match),
+	},
+	.probe	= arm_smmu_tbu_probe,
+	.remove	= arm_smmu_tbu_remove,
+};
+
+static int __init arm_smmu_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&arm_smmu_tbu_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&arm_smmu_driver);
+	if (ret)
+		platform_driver_unregister(&arm_smmu_tbu_driver);
+
+	return ret;
+}
+
+static void __init arm_smmu_exit(void)
+{
+	platform_driver_unregister(&arm_smmu_driver);
+	platform_driver_unregister(&arm_smmu_tbu_driver);
+}
+
+module_init(arm_smmu_init);
+module_exit(arm_smmu_exit);
 
 IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", NULL);
 IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", NULL);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
