From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [RFC 9/9] drivers: iommu: arm-smmu: Set iommu_ops in probe
Date: Mon, 25 Apr 2016 21:28:14 +0530
Message-ID: <1461599894-1969-10-git-send-email-sricharan@codeaurora.org>
References: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461599894-1969-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

iommu_ops should be set after the iommu is probed.
This ensures that the iommu is really ready when master's
iommu ops are set during their probe or else deferred.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2d65de4..f103d35 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1919,6 +1919,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "mmu-masters"))
 		arm_smmu_probe_mmu_masters(smmu);
 	arm_smmu_device_reset(smmu);
+	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
 	return 0;
 
 out_free_irqs:
@@ -1957,24 +1958,13 @@ static struct platform_driver arm_smmu_driver = {
 	.remove	= arm_smmu_device_remove,
 };
 
-static int __init arm_smmu_init(void)
+static int __init arm_smmu_of_init(struct device_node *np)
 {
-	struct device_node *np;
 	static bool done;
 	int ret;
 
 	if (done)
 		return 0;
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
 
 	ret = platform_driver_register(&arm_smmu_driver);
 	if (ret)
@@ -2002,28 +1992,8 @@ static void __exit arm_smmu_exit(void)
 {
 	return platform_driver_unregister(&arm_smmu_driver);
 }
-
-subsys_initcall(arm_smmu_init);
 module_exit(arm_smmu_exit);
 
-static int __init arm_smmu_of_init(struct device_node *np)
-{
-	struct arm_smmu_device *smmu;
-	struct platform_device *pdev;
-	int ret = arm_smmu_init();
-
-	if (ret)
-		return ret;
-
-	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (!pdev)
-		return -ENODEV;
-
-	smmu = platform_get_drvdata(pdev);
-	of_iommu_set_ops(np, &arm_smmu_ops);
-
-	return 0;
-}
 IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", arm_smmu_of_init);
 IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", arm_smmu_of_init);
 IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", arm_smmu_of_init);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
