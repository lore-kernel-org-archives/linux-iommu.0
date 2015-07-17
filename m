From: Sricharan R <sricharan@codeaurora.org>
Subject: [RFC PATCH 1/4] iommu/arm-smmu: Init driver using IOMMU_OF_DECLARE
Date: Fri, 17 Jul 2015 22:23:22 +0530
Message-ID: <1437152005-25092-2-git-send-email-sricharan@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, will.deacon@arm.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, mitchelh@codeaurora.org
Cc: sricharan@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

This patch uses IOMMU_OF_DECLARE to register the driver
and the iommu_ops. So when master devices of the iommu are
registered, of_xlate callback can be used to add the master
configurations to the smmu driver.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 drivers/iommu/arm-smmu.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fc13dd5..8c4eb43 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -41,6 +41,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 
 #include <linux/amba/bus.h>
 
@@ -254,6 +256,8 @@
 #define FSYNR0_WNR			(1 << 4)
 
 static int force_stage;
+static bool init_done;
+
 module_param_named(force_stage, force_stage, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
@@ -1848,20 +1852,8 @@ static struct platform_driver arm_smmu_driver = {
 
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
@@ -1880,15 +1872,33 @@ static int __init arm_smmu_init(void)
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
