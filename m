From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V5 08/12] iommu/arm-smmu: Clean up early-probing workarounds
Date: Thu, 19 Jan 2017 20:35:52 +0530
Message-ID: <1484838356-24962-9-git-send-email-sricharan@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484838356-24962-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Now that the appropriate ordering is enforced via profe-deferral of
masters in core code, rip it all out and bask in the simplicity.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
[Sricharan: Rebased on top of ACPI IORT SMMU series]
Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 * No change

 drivers/iommu/arm-smmu-v3.c | 46 ++---------------------------------
 drivers/iommu/arm-smmu.c    | 58 +++++++--------------------------------------
 2 files changed, 10 insertions(+), 94 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7d45d8b..7fc4e5f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2724,51 +2724,9 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
+module_platform_driver(arm_smmu_driver);
 
-static int __init arm_smmu_init(void)
-{
-	static bool registered;
-	int ret = 0;
-
-	if (!registered) {
-		ret = platform_driver_register(&arm_smmu_driver);
-		registered = !ret;
-	}
-	return ret;
-}
-
-static void __exit arm_smmu_exit(void)
-{
-	return platform_driver_unregister(&arm_smmu_driver);
-}
-
-subsys_initcall(arm_smmu_init);
-module_exit(arm_smmu_exit);
-
-static int __init arm_smmu_of_init(struct device_node *np)
-{
-	int ret = arm_smmu_init();
-
-	if (ret)
-		return ret;
-
-	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
-		return -ENODEV;
-
-	return 0;
-}
-IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
-
-#ifdef CONFIG_ACPI
-static int __init acpi_smmu_v3_init(struct acpi_table_header *table)
-{
-	if (iort_node_match(ACPI_IORT_NODE_SMMU_V3))
-		return arm_smmu_init();
-
-	return 0;
-}
-IORT_ACPI_DECLARE(arm_smmu_v3, ACPI_SIG_IORT, acpi_smmu_v3_init);
-#endif
+IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", NULL);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 73a0a25..c86ae5f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2134,56 +2134,14 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	.probe	= arm_smmu_device_probe,
 	.remove	= arm_smmu_device_remove,
 };
-
-static int __init arm_smmu_init(void)
-{
-	static bool registered;
-	int ret = 0;
-
-	if (!registered) {
-		ret = platform_driver_register(&arm_smmu_driver);
-		registered = !ret;
-	}
-	return ret;
-}
-
-static void __exit arm_smmu_exit(void)
-{
-	return platform_driver_unregister(&arm_smmu_driver);
-}
-
-subsys_initcall(arm_smmu_init);
-module_exit(arm_smmu_exit);
-
-static int __init arm_smmu_of_init(struct device_node *np)
-{
-	int ret = arm_smmu_init();
-
-	if (ret)
-		return ret;
-
-	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
-		return -ENODEV;
-
-	return 0;
-}
-IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", arm_smmu_of_init);
-IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", arm_smmu_of_init);
-IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", arm_smmu_of_init);
-
-#ifdef CONFIG_ACPI
-static int __init arm_smmu_acpi_init(struct acpi_table_header *table)
-{
-	if (iort_node_match(ACPI_IORT_NODE_SMMU))
-		return arm_smmu_init();
-
-	return 0;
-}
-IORT_ACPI_DECLARE(arm_smmu, ACPI_SIG_IORT, arm_smmu_acpi_init);
-#endif
+module_platform_driver(arm_smmu_driver);
+
+IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", NULL);
+IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", NULL);
+IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", NULL);
+IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", NULL);
+IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", NULL);
+IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", NULL);
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
