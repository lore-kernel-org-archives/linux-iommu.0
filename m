From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 6/6] iommu/arm-smmu: Introduce iommu_group notifier block
Date: Thu, 30 Jan 2014 19:18:09 +0100
Message-ID: <1391105889-32718-7-git-send-email-andreas.herrmann@calxeda.com>
References: <1391105889-32718-1-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1391105889-32718-1-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
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
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

At the moment just handle IOMMU_GROUP_NOTIFY_BIND_DRIVER to
conditionally isolate all master devices for an SMMU.

Depending on DT information each device is put into its own protection
domain (if possible). For configuration with one or just a few
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
SZ_128M at the moment. Additional patches will address this
restriction and allow automatic growth of mapping size.

Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d1f166f..bee88c8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -47,6 +47,7 @@
 #include <linux/amba/bus.h>
 
 #include <asm/pgalloc.h>
+#include <asm/dma-iommu.h>
 
 /* Maximum number of stream IDs assigned to a single device */
 #define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
@@ -1677,6 +1678,47 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 	return !!(cap & caps);
 }
 
+static int arm_smmu_group_notifier(struct notifier_block *nb,
+				unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct dma_iommu_mapping *mapping;
+	struct arm_smmu_device *smmu;
+	int ret;
+
+	switch (action) {
+	case IOMMU_GROUP_NOTIFY_BIND_DRIVER:
+
+		smmu = dev->archdata.iommu;
+		if (!smmu || !(smmu->options & ARM_SMMU_OPT_ISOLATE_DEVICES))
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
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block group_nb = {
+	.notifier_call = arm_smmu_group_notifier,
+};
+
 static int arm_smmu_add_device(struct device *dev)
 {
 	struct arm_smmu_device *child, *parent, *smmu;
@@ -1726,6 +1768,8 @@ static int arm_smmu_add_device(struct device *dev)
 		return PTR_ERR(group);
 	}
 
+	iommu_group_register_notifier(group, &group_nb);
+
 	ret = iommu_group_add_device(group, dev);
 	iommu_group_put(group);
 	dev->archdata.iommu = smmu;
-- 
1.7.9.5
