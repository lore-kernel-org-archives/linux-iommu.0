From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 7/9] iommu/arm-smmu: Add function that conditionally isolates
	all masters of all SMMUs
Date: Fri, 27 Sep 2013 00:36:19 +0200
Message-ID: <1380234982-1677-8-git-send-email-andreas.herrmann@calxeda.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380234982-1677-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

(Depending on DT information and module parameters) each device is put
into its own protection domain (if possible).  For configuration with
one or just a few masters per SMMU that is easy to achieve.

In case of many devices per SMMU (e.g. MMU-500 with it's distributed
translation support) isolation of each device might not be possible --
depending on number of available SMR groups and/or context banks.

Default is that device isolation is contolled per SMMU with SMMU node
property "linux,arm-smmu-isolate-devices" in a DT. If the property is
set for an SMMU node device isolation is performed.

Also introduce a module parameter:

 arm-smmu=off|force_isolation|disable_isolation

  arm-smmu=     arm-smmu driver option

        off     Disable arm-smmu driver (ie. ignore available SMMUs)

        force_isolation
                Try to attach each master device on every SMMU to a
                separate iommu_domain.
                (Even for SMMUs that don't have the property
                "linux,arm-smmu-isolate-devices" set in device
                tree.)

        disable_isolation
                Disable device_isolation globally.
                (ie. no isolation even for SMMUs for which
                "linux,arm-smmu-isolate-devices" is set.)

W/o device isolation the driver detects SMMUs but no translation is
configured (transactions just bypass translation process).

Note that for device isolation dma_base and size are derived from
(coherent_)dma_mask of the master device.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |  101 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5fa34f9..48f3bfb 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -46,6 +46,7 @@
 #include <linux/amba/bus.h>
 
 #include <asm/pgalloc.h>
+#include <asm/dma-iommu.h>
 
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		8
@@ -354,6 +355,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_TRANS_S1		(1 << 2)
 #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
 #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
+#define ARM_SMMU_FEAT_ISOLATE_DEVICES	(1 << 5)
 	u32				features;
 #define ARM_SMMU_BUG_SECURE_CFG_ACCESS	(1 << 0)
 	u32				bugs;
@@ -407,6 +409,10 @@ struct arm_smmu_domain {
 static DEFINE_SPINLOCK(arm_smmu_devices_lock);
 static LIST_HEAD(arm_smmu_devices);
 
+static bool arm_smmu_disabled;
+static bool arm_smmu_force_isolation;
+static bool arm_smmu_disable_isolation;
+
 static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 						struct device_node *dev_node)
 {
@@ -1810,6 +1816,74 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+extern struct platform_device *of_find_device_by_node(struct device_node *np);
+
+static int arm_smmu_isolate_devices(void)
+{
+	struct dma_iommu_mapping *mapping;
+	struct arm_smmu_device *smmu;
+	struct rb_node *rbn;
+	struct arm_smmu_master *master;
+	struct platform_device *pdev;
+	struct device *dev;
+	void __iomem *gr0_base;
+	u32 cr0;
+	int ret = 0;
+	size_t size;
+
+	list_for_each_entry(smmu, &arm_smmu_devices, list) {
+		if (arm_smmu_disable_isolation ||
+			(!(smmu->features & ARM_SMMU_FEAT_ISOLATE_DEVICES)
+				&& !arm_smmu_force_isolation))
+			continue;
+		rbn = rb_first(&smmu->masters);
+		while (rbn) {
+			master = container_of(rbn, struct arm_smmu_master, node);
+			pdev = of_find_device_by_node(master->of_node);
+			if (!pdev)
+				break;
+			dev = &pdev->dev;
+
+			size = (size_t) dev->coherent_dma_mask;
+			size = size ? : (unsigned long) dev->dma_mask;
+			if (!size) {
+				dev_warn(dev, "(coherent_)dma_mask not set\n");
+				continue;
+			}
+
+			mapping = arm_iommu_create_mapping(&platform_bus_type,
+							0, size, 0);
+			if (IS_ERR(mapping)) {
+				ret = PTR_ERR(mapping);
+				dev_info(dev, "arm_iommu_create_mapping failed\n");
+				goto out;
+			}
+
+			ret = arm_iommu_attach_device(dev, mapping);
+			if (ret < 0) {
+				dev_info(dev, "arm_iommu_attach_device failed\n");
+				arm_iommu_release_mapping(mapping);
+			}
+			rbn = rb_next(rbn);
+		}
+
+		gr0_base = ARM_SMMU_GR0(smmu);
+		if (smmu->bugs & ARM_SMMU_BUG_SECURE_CFG_ACCESS) {
+			cr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_nsCR0);
+			cr0 |= sCR0_USFCFG;
+			writel(cr0, gr0_base + ARM_SMMU_GR0_nsCR0);
+		} else {
+			cr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+			cr0 |= sCR0_USFCFG;
+			writel(cr0, gr0_base + ARM_SMMU_GR0_sCR0);
+		}
+	}
+
+out:
+	return ret;
+}
+
+
 static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1820,6 +1894,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	struct of_phandle_args masterspec;
 	int num_irqs, i, err;
 
+	if (arm_smmu_disabled)
+		return -ENODEV;
+
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
 		dev_err(dev, "failed to allocate arm_smmu_device\n");
@@ -1925,6 +2002,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "calxeda,smmu-secure-cfg-access"))
 		smmu->bugs |= ARM_SMMU_BUG_SECURE_CFG_ACCESS;
 
+	if (of_property_read_bool(dev->of_node, "linux,arm-smmu-isolate-devices"))
+		smmu->features |= ARM_SMMU_FEAT_ISOLATE_DEVICES;
+
 	INIT_LIST_HEAD(&smmu->list);
 	spin_lock(&arm_smmu_devices_lock);
 	list_add(&smmu->list, &arm_smmu_devices);
@@ -2015,6 +2095,25 @@ static struct platform_driver arm_smmu_driver = {
 	.remove	= arm_smmu_device_remove,
 };
 
+static int __init arm_smmu_parse_options(char *str)
+{
+	if (*str) {
+		str++;
+		if (!strncmp(str, "off", 3))
+			arm_smmu_disabled = true;
+		else if(!strncmp(str, "force_isolation", 15))
+			arm_smmu_force_isolation = true;
+		else if(!strncmp(str, "disable_isolation", 17))
+			arm_smmu_disable_isolation = true;
+		else {
+			pr_warn("arm_smmu: invalid parameter (\"%s\")\n", str);
+			return 0;
+		}
+	}
+	return 1;
+}
+__setup("arm-smmu", arm_smmu_parse_options);
+
 static int __init arm_smmu_init(void)
 {
 	int ret;
@@ -2030,6 +2129,8 @@ static int __init arm_smmu_init(void)
 	if (!iommu_present(&amba_bustype))
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 
+	arm_smmu_isolate_devices();
+
 	return 0;
 }
 
-- 
1.7.9.5
