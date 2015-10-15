From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/6] iommu/arm-smmu: Use drvdata instead of maintaining
	smmu_devices list
Date: Thu, 15 Oct 2015 16:04:19 +0100
Message-ID: <1444921464-14895-2-git-send-email-will.deacon@arm.com>
References: <1444921464-14895-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1444921464-14895-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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
Cc: fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Rather than keep a private list of struct arm_smmu_device and searching
this whenever we need to look up the correct SMMU instance, instead use
the drvdata field in the struct device to take care of the mapping for
us.

Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu-v3.c | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index dafaf59dc3b8..637014ab8965 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
@@ -568,7 +569,6 @@ struct arm_smmu_device {
 	unsigned int			sid_bits;
 
 	struct arm_smmu_strtab_cfg	strtab_cfg;
-	struct list_head		list;
 };
 
 /* SMMU private data for an IOMMU group */
@@ -603,10 +603,6 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
-/* Our list of SMMU instances */
-static DEFINE_SPINLOCK(arm_smmu_devices_lock);
-static LIST_HEAD(arm_smmu_devices);
-
 struct arm_smmu_option_prop {
 	u32 opt;
 	const char *prop;
@@ -1722,7 +1718,8 @@ static void __arm_smmu_release_pci_iommudata(void *data)
 static struct arm_smmu_device *arm_smmu_get_for_pci_dev(struct pci_dev *pdev)
 {
 	struct device_node *of_node;
-	struct arm_smmu_device *curr, *smmu = NULL;
+	struct platform_device *smmu_pdev;
+	struct arm_smmu_device *smmu = NULL;
 	struct pci_bus *bus = pdev->bus;
 
 	/* Walk up to the root bus */
@@ -1735,14 +1732,10 @@ static struct arm_smmu_device *arm_smmu_get_for_pci_dev(struct pci_dev *pdev)
 		return NULL;
 
 	/* See if we can find an SMMU corresponding to the phandle */
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(curr, &arm_smmu_devices, list) {
-		if (curr->dev->of_node == of_node) {
-			smmu = curr;
-			break;
-		}
-	}
-	spin_unlock(&arm_smmu_devices_lock);
+	smmu_pdev = of_find_device_by_node(of_node);
+	if (smmu_pdev)
+		smmu = platform_get_drvdata(smmu_pdev);
+
 	of_node_put(of_node);
 	return smmu;
 }
@@ -2609,10 +2602,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 		goto out_free_structures;
 
 	/* Record our private device structure */
-	INIT_LIST_HEAD(&smmu->list);
-	spin_lock(&arm_smmu_devices_lock);
-	list_add(&smmu->list, &arm_smmu_devices);
-	spin_unlock(&arm_smmu_devices_lock);
+	platform_set_drvdata(pdev, smmu);
 	return 0;
 
 out_free_structures:
@@ -2622,21 +2612,7 @@ out_free_structures:
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
 {
-	struct arm_smmu_device *curr, *smmu = NULL;
-	struct device *dev = &pdev->dev;
-
-	spin_lock(&arm_smmu_devices_lock);
-	list_for_each_entry(curr, &arm_smmu_devices, list) {
-		if (curr->dev == dev) {
-			smmu = curr;
-			list_del(&smmu->list);
-			break;
-		}
-	}
-	spin_unlock(&arm_smmu_devices_lock);
-
-	if (!smmu)
-		return -ENODEV;
+	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	arm_smmu_device_disable(smmu);
 	arm_smmu_free_structures(smmu);
-- 
2.1.4
