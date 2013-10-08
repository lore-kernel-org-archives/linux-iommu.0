From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/5] iommu/arm-smmu: Introduce bus notifier block
Date: Tue,  8 Oct 2013 11:27:21 +0200
Message-ID: <1381224444-27303-3-git-send-email-andreas.herrmann@calxeda.com>
References: <1381224444-27303-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1381224444-27303-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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

At the moment just handle BUS_NOTIFY_BIND_DRIVER to conditionally
isolate all master devices for an SMMU.

Depending on DT information each device is put into its own protection
domain (if possible).  For configuration with one or just a few
masters per SMMU that is easy to achieve.

In case of many devices per SMMU (e.g. MMU-500 with it's distributed
translation support) isolation of each device might not be possible --
depending on number of available SMR groups and/or context banks.

Default is that device isolation is contolled per SMMU with SMMU node
property "arm,smmu-isolate-devices" in a DT. If this property is set
for an SMMU node, device isolation is performed.

W/o device isolation the driver detects SMMUs but no translation is
configured (transactions just bypass translation process).

Note that for device isolation dma_base and size are fixed as 0 and
SZ_128M at the moment.

Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index b127f0f..9a73618 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -46,6 +46,7 @@
 #include <linux/amba/bus.h>
 
 #include <asm/pgalloc.h>
+#include <asm/dma-iommu.h>
 
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		8
@@ -1996,6 +1997,56 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int arm_smmu_device_notifier(struct notifier_block *nb,
+				unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct dma_iommu_mapping *mapping;
+	struct arm_smmu_device *smmu;
+	void __iomem *gr0_base;
+	u32 cr0;
+	int ret;
+
+	switch (action) {
+	case BUS_NOTIFY_BIND_DRIVER:
+
+		arm_smmu_add_device(dev);
+		smmu = dev->archdata.iommu;
+		if (!smmu || !(arm_smmu_has_option(smmu, ISOLATE_DEVICES)))
+			break;
+
+		mapping = arm_iommu_create_mapping(&platform_bus_type,
+						0, SZ_128M, 0);
+		if (IS_ERR(mapping)) {
+			ret = PTR_ERR(mapping);
+			dev_info(dev, "arm_iommu_create_mapping failed\n");
+			break;
+		}
+
+		ret = arm_iommu_attach_device(dev, mapping);
+		if (ret < 0) {
+			dev_info(dev, "arm_iommu_attach_device failed\n");
+			arm_iommu_release_mapping(mapping);
+		}
+
+		gr0_base = ARM_SMMU_GR0_NS(smmu);
+		cr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
+		cr0 |= sCR0_USFCFG;
+		writel(cr0, gr0_base + ARM_SMMU_GR0_sCR0);
+
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block device_nb = {
+	.notifier_call = arm_smmu_device_notifier,
+};
+
 #ifdef CONFIG_OF
 static struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", },
@@ -2032,6 +2083,8 @@ static int __init arm_smmu_init(void)
 	if (!iommu_present(&amba_bustype))
 		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
 
+	bus_register_notifier(&platform_bus_type, &device_nb);
+
 	return 0;
 }
 
-- 
1.7.9.5
