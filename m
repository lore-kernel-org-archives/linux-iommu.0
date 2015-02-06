From: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH/RFC 4/4] iommu/arm-smmu: Support deferred probing
Date: Thu,  5 Feb 2015 16:32:02 -0800
Message-ID: <1423182722-16646-5-git-send-email-lauraa@codeaurora.org>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1423182722-16646-1-git-send-email-lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


With the addition of clocks in the SMMU driver, the driver
now may need to be deferred if the clocks are not ready. Apart from
just the probe function though, we may need to defer attachment as
well. Support both of these.

Signed-off-by: Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
I went with the simplest approach ('started_probe') to indicate
we should defer probing. Another possibility I considered was to have
a 'masters added before probe completed' list and keep all masters
there until probe completes at which point we can bind the masters
to the SMMUs.
---
 drivers/iommu/arm-smmu.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d9f7cf48..7e8194c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -43,6 +43,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 
 #include <linux/amba/bus.h>
 
@@ -330,6 +332,7 @@ static int force_stage;
 module_param_named(force_stage, force_stage, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
+static bool started_probe;
 
 enum arm_smmu_arch_version {
 	ARM_SMMU_V1 = 1,
@@ -1284,7 +1287,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	smmu = find_smmu_for_device(dev);
 	if (!smmu) {
 		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
-		return -ENXIO;
+		return started_probe ? -EPROBE_DEFER : -ENXIO;
 	}
 
 	if (dev->archdata.iommu) {
@@ -1677,7 +1680,7 @@ static int arm_smmu_add_device(struct device *dev)
 
 	smmu = find_smmu_for_device(dev);
 	if (!smmu)
-		return -ENODEV;
+		return started_probe ? -EPROBE_DEFER : -ENODEV;
 
 	group = iommu_group_alloc();
 	if (IS_ERR(group)) {
@@ -1761,6 +1764,11 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 	}
 }
 
+static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *spec)
+{
+	return arm_smmu_add_device(dev);
+}
+
 static int arm_smmu_enable_resources(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
@@ -1814,6 +1822,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.pgsize_bitmap		= (SECTION_SIZE |
 				   ARM_SMMU_PTE_CONT_SIZE |
 				   PAGE_SIZE),
+	.of_xlate		= arm_smmu_of_xlate,
 	.enable_resources	= arm_smmu_enable_resources,
 	.disable_resources	= arm_smmu_disable_resources,
 };
@@ -2108,6 +2117,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct of_phandle_args masterspec;
 	int num_irqs, i, err;
 
+	started_probe = true;
+
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate arm_smmu_device\n");
@@ -2282,6 +2293,8 @@ static struct platform_driver arm_smmu_driver = {
 	.remove	= arm_smmu_device_remove,
 };
 
+static int init_done;
+
 static int __init arm_smmu_init(void)
 {
 	struct device_node *np;
@@ -2316,6 +2329,7 @@ static int __init arm_smmu_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 #endif
 
+	init_done = true;
 	return 0;
 }
 
@@ -2327,6 +2341,25 @@ static void __exit arm_smmu_exit(void)
 subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
+static int __init arm_smmu_of_setup(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	if (!init_done)
+		arm_smmu_init();
+
+	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	of_iommu_set_ops(np, &arm_smmu_ops);
+	return 0;
+}
+
+IOMMU_OF_DECLARE(arm_smmu_of, "arm,mmu-500",
+		 arm_smmu_of_setup);
+
+
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
 MODULE_LICENSE("GPL v2");
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
