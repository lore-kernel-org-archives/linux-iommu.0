From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 07/11] drivers: iommu: arm-smmu: allow ACPI based streamid
	translation
Date: Thu, 14 Apr 2016 18:25:39 +0100
Message-ID: <1460654743-7896-8-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1460654743-7896-1-git-send-email-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The ACPI IORT table provides data to ARM IOMMU drivers to carry out
streamid mappings and the kernel has the infrastructure to implement
it through the fw_xlate() struct iommu_ops hook.

By relying on the DT agnostic struct iommu_fwspec fields, this
patch adds code in the ARM SMMU fw_xlate() callback that allows
streamid translation on ACPI based ARM system.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 84bcff7..0f1e784 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1440,6 +1440,20 @@ out_unlock:
 	return ret;
 }
 
+static int arm_smmu_dev_node_match(struct device *dev, void *data)
+{
+	return is_fwnode_iommu(dev->fwnode) && dev->fwnode == data;
+}
+
+static struct platform_device *arm_smmu_get_dev(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&platform_bus_type, NULL, fwnode,
+			      arm_smmu_dev_node_match);
+	return dev ? to_platform_device(dev) : NULL;
+}
+
 static int arm_smmu_fw_xlate(struct device *dev, struct iommu_fwspec *args)
 {
 	struct arm_smmu_device *smmu;
@@ -1447,6 +1461,8 @@ static int arm_smmu_fw_xlate(struct device *dev, struct iommu_fwspec *args)
 
 	if (is_of_node(args->fwnode))
 		smmu_pdev = of_find_device_by_node(to_of_node(args->fwnode));
+	else if (is_fwnode_iommu(args->fwnode))
+		smmu_pdev = arm_smmu_get_dev(args->fwnode);
 
 	if (!smmu_pdev)
 		return -ENODEV;
-- 
2.6.4
