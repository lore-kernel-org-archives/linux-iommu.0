From: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [RFC PATCH 1/6] iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE
Date: Wed, 27 Jan 2016 10:51:14 +0530
Message-ID: <1453872079-27140-2-git-send-email-anup.patel@broadcom.com>
References: <1453872079-27140-1-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453872079-27140-1-git-send-email-anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Device Tree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vikram Prakash <vikramp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

This patch uses IOMMU_OF_DECLARE to register the driver
and the iommu_ops. So when master devices of the iommu are
registered, of_xlate callback can be used to add the master
configurations to the smmu driver.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Tested-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 59ee4b8..22b9668 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -38,6 +38,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -257,6 +258,8 @@
 #define FSYNR0_WNR			(1 << 4)
 
 static int force_stage;
+static bool init_done;
+
 module_param_named(force_stage, force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
@@ -1885,20 +1888,8 @@ static struct platform_driver arm_smmu_driver = {
 
 static int __init arm_smmu_init(void)
 {
-	struct device_node *np;
 	int ret;
 
-	/*
-	 * Play nice with systems that don't have an ARM SMMU by checking that
-	 * an ARM SMMU exists in the system before proceeding with the driver
-	 * and IOMMU bus operation registration.
-	 */
-	np = of_find_matching_node(NULL, arm_smmu_of_match);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
 	ret = platform_driver_register(&arm_smmu_driver);
 	if (ret)
 		return ret;
@@ -1917,15 +1908,33 @@ static int __init arm_smmu_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 #endif
 
+	init_done = true;
+
 	return 0;
 }
 
+static int __init arm_smmu_of_setup(struct device_node *np)
+{
+
+	if (!init_done)
+		arm_smmu_init();
+
+	of_iommu_set_ops(np, &arm_smmu_ops);
+
+	return 0;
+}
+
+IOMMU_OF_DECLARE(arm_smmu_v1, "arm,smmu-v1", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_v2, "arm,smmu-v2", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_400, "arm,mmu-400", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_401, "arm,mmu-401", arm_smmu_of_setup);
+IOMMU_OF_DECLARE(arm_smmu_500, "arm,mmu-500", arm_smmu_of_setup);
+
 static void __exit arm_smmu_exit(void)
 {
 	return platform_driver_unregister(&arm_smmu_driver);
 }
 
-subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
-- 
1.9.1
