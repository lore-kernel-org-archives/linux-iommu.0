From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v6 06/16] drivers: iommu: arm-smmu-v3: convert struct device
	of_node to fwnode usage
Date: Tue, 18 Oct 2016 17:04:04 +0100
Message-ID: <20161018160414.1228-7-lorenzo.pieralisi@arm.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161018160414.1228-1-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Current ARM SMMU v3 driver rely on the struct device.of_node pointer for
device look-up and iommu_ops retrieval.

In preparation for ACPI probing enablement, convert the driver to use
the struct device.fwnode member for device and iommu_ops look-up so that
the driver infrastructure can be used also on systems that do not
associate an of_node pointer to a struct device (eg ACPI), making the
device look-up and iommu_ops retrieval firmware agnostic.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 15c01c3..bbc2818 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1723,13 +1723,14 @@ static struct platform_driver arm_smmu_driver;
 
 static int arm_smmu_match_node(struct device *dev, void *data)
 {
-	return dev->of_node == data;
+	return dev->fwnode == data;
 }
 
-static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
+static
+struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
 {
 	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
-						np, arm_smmu_match_node);
+						fwnode, arm_smmu_match_node);
 	put_device(dev);
 	return dev ? dev_get_drvdata(dev) : NULL;
 }
@@ -1765,7 +1766,7 @@ static int arm_smmu_add_device(struct device *dev)
 		master = fwspec->iommu_priv;
 		smmu = master->smmu;
 	} else {
-		smmu = arm_smmu_get_by_node(to_of_node(fwspec->iommu_fwnode));
+		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 		if (!smmu)
 			return -ENODEV;
 		master = kzalloc(sizeof(*master), GFP_KERNEL);
@@ -2634,7 +2635,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		return ret;
 
 	/* And we're up. Go go go! */
-	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
+	fwnode_iommu_set_ops(dev->fwnode, &arm_smmu_ops);
+
 #ifdef CONFIG_PCI
 	pci_request_acs();
 	ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
-- 
2.10.0
