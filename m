From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/8] iommu/fsl: Convert to device_group call-back
Date: Wed, 21 Oct 2015 23:51:40 +0200
Message-ID: <1445464303-18206-6-git-send-email-joro@8bytes.org>
References: <1445464303-18206-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445464303-18206-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Convert the fsl pamu driver to make use of the new
device_group call-back.

Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/fsl_pamu_domain.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 1d45293..da0e1e3 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -923,7 +923,7 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 	pci_endpt_partioning = check_pci_ctl_endpt_part(pci_ctl);
 	/* We can partition PCIe devices so assign device group to the device */
 	if (pci_endpt_partioning) {
-		group = iommu_group_get_for_dev(&pdev->dev);
+		group = pci_device_group(&pdev->dev);
 
 		/*
 		 * PCIe controller is not a paritionable entity
@@ -956,44 +956,34 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 	return group;
 }
 
-static int fsl_pamu_add_device(struct device *dev)
+static struct iommu_group *fsl_pamu_device_group(struct device *dev)
 {
 	struct iommu_group *group = ERR_PTR(-ENODEV);
-	struct pci_dev *pdev;
-	const u32 *prop;
-	int ret = 0, len;
+	int len;
 
 	/*
 	 * For platform devices we allocate a separate group for
 	 * each of the devices.
 	 */
-	if (dev_is_pci(dev)) {
-		pdev = to_pci_dev(dev);
-		/* Don't create device groups for virtual PCI bridges */
-		if (pdev->subordinate)
-			return 0;
+	if (dev_is_pci(dev))
+		group = get_pci_device_group(to_pci_dev(dev));
+	else if (of_get_property(dev->of_node, "fsl,liodn", &len))
+		group = get_device_iommu_group(dev);
 
-		group = get_pci_device_group(pdev);
+	return group;
+}
 
-	} else {
-		prop = of_get_property(dev->of_node, "fsl,liodn", &len);
-		if (prop)
-			group = get_device_iommu_group(dev);
-	}
+static int fsl_pamu_add_device(struct device *dev)
+{
+	struct iommu_group *group;
 
+	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
-	/*
-	 * Check if device has already been added to an iommu group.
-	 * Group could have already been created for a PCI device in
-	 * the iommu_group_get_for_dev path.
-	 */
-	if (!dev->iommu_group)
-		ret = iommu_group_add_device(group, dev);
-
 	iommu_group_put(group);
-	return ret;
+
+	return 0;
 }
 
 static void fsl_pamu_remove_device(struct device *dev)
@@ -1072,6 +1062,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.domain_get_attr = fsl_pamu_get_domain_attr,
 	.add_device	= fsl_pamu_add_device,
 	.remove_device	= fsl_pamu_remove_device,
+	.device_group   = fsl_pamu_device_group,
 };
 
 int __init pamu_domain_init(void)
-- 
1.9.1
