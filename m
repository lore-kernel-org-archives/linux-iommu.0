From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 3/3] iommu: Clean up of_iommu_init_fn
Date: Tue,  9 Jan 2018 16:17:27 +0000
Message-ID: <4f15ffc754799866388d9e022333d73156257b89.1515512134.git.robin.murphy@arm.com>
References: <da664cf8f60c77cbb657cc2e3849560604eaf6da.1515512134.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <da664cf8f60c77cbb657cc2e3849560604eaf6da.1515512134.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Now that no more drivers rely on arbitrary early initialisation via an
of_iommu_init_fn hook, let's clean up the redundant remnants. The
IOMMU_OF_DECLARE() macro needs to remain for now, as the probe-deferral
mechanism has no other nice way to detect built-in drivers before they
have registered themselves, such that it can make the right decision.

Reviewed-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v2: Rebase to 4.15-rc, add tags

 drivers/iommu/arm-smmu-v3.c  |  2 +-
 drivers/iommu/arm-smmu.c     | 12 ++++++------
 drivers/iommu/exynos-iommu.c |  2 +-
 drivers/iommu/ipmmu-vmsa.c   |  4 ++--
 drivers/iommu/msm_iommu.c    |  2 +-
 drivers/iommu/of_iommu.c     | 16 ----------------
 drivers/iommu/qcom_iommu.c   |  2 +-
 include/linux/of_iommu.h     |  5 +----
 8 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f122071688fd..7f186beaa1a6 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2962,7 +2962,7 @@ static struct platform_driver arm_smmu_driver = {
 };
 module_platform_driver(arm_smmu_driver);
 
-IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", NULL);
+IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3");
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 78d4c6b8f1ba..69e7c60792a8 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2211,12 +2211,12 @@ static struct platform_driver arm_smmu_driver = {
 };
 module_platform_driver(arm_smmu_driver);
 
-IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", NULL);
-IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", NULL);
-IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", NULL);
-IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", NULL);
-IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", NULL);
-IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", NULL);
+IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1");
+IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2");
+IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400");
+IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
+IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
+IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
 
 MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
 MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 736d4552d96f..2138102ef611 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1401,4 +1401,4 @@ static int __init exynos_iommu_init(void)
 }
 core_initcall(exynos_iommu_init);
 
-IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu", NULL);
+IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu");
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 331dad909301..40ae6e87cb88 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1108,8 +1108,8 @@ static void __exit ipmmu_exit(void)
 subsys_initcall(ipmmu_init);
 module_exit(ipmmu_exit);
 
-IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa", NULL);
-IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795", NULL);
+IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa");
+IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795");
 
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>");
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index dda1ce87a070..0d3350463a3f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -877,7 +877,7 @@ static void __exit msm_iommu_driver_exit(void)
 subsys_initcall(msm_iommu_driver_init);
 module_exit(msm_iommu_driver_exit);
 
-IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", NULL);
+IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu");
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>");
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 50947ebb6d17..5c36a8b7656a 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -231,19 +231,3 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 	return ops;
 }
-
-static int __init of_iommu_init(void)
-{
-	struct device_node *np;
-	const struct of_device_id *match, *matches = &__iommu_of_table;
-
-	for_each_matching_node_and_match(np, matches, &match) {
-		const of_iommu_init_fn init_fn = match->data;
-
-		if (init_fn && init_fn(np))
-			pr_err("Failed to initialise IOMMU %pOF\n", np);
-	}
-
-	return 0;
-}
-postcore_initcall_sync(of_iommu_init);
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index e07f02d00c68..65b9c99707f8 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -947,7 +947,7 @@ static void __exit qcom_iommu_exit(void)
 module_init(qcom_iommu_init);
 module_exit(qcom_iommu_exit);
 
-IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1", NULL);
+IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1");
 
 MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
index cddfaff4d0b7..4fa654e4b5a9 100644
--- a/include/linux/of_iommu.h
+++ b/include/linux/of_iommu.h
@@ -34,9 +34,6 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
 
 extern struct of_device_id __iommu_of_table;
 
-typedef int (*of_iommu_init_fn)(struct device_node *);
-
-#define IOMMU_OF_DECLARE(name, compat, fn) \
-	_OF_DECLARE(iommu, name, compat, fn, of_iommu_init_fn)
+#define IOMMU_OF_DECLARE(name, compat)	OF_DECLARE_1(iommu, name, compat, NULL)
 
 #endif /* __OF_IOMMU_H */
-- 
2.13.4.dirty
