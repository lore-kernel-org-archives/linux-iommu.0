From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: [PATCH 8/9] iommu: arm-smmu: make it explicitly non-modular
Date: Mon, 26 Nov 2018 17:31:37 -0500
Message-ID: <1543271498-28966-9-git-send-email-paul.gortmaker@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1543271498-28966-1-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The Kconfig currently controlling compilation of this code is:

drivers/iommu/Kconfig:config ARM_SMMU
drivers/iommu/Kconfig:  bool "ARM Ltd. System MMU (SMMU) Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We explicitly disallow a driver unbind, since that doesn't have a
sensible use case anyway, but unlike most drivers, we can't delete the
function tied to the ".remove" field.  This is because as of commit
7aa8619a66ae ("iommu/arm-smmu-v3: Implement shutdown method") the
.remove function was given a one line wrapper and re-used to provide a
.shutdown service.  So we delete the wrapper and re-name the function
from remove to shutdown.

We add a moduleparam.h include since the file does actually declare
some module parameters, and leaving them as such is the easiest way
currently to remain backwards compatible with existing use cases.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Signed-off-by: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5a28ae892504..4a2e143fdf52 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -41,7 +41,8 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -101,6 +102,10 @@
 #define MSI_IOVA_LENGTH			0x100000
 
 static int force_stage;
+/*
+ * not really modular, but the easiest way to keep compat with existing
+ * bootargs behaviour is to continue using module_param() here.
+ */
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
@@ -1964,7 +1969,6 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 #ifdef CONFIG_ACPI
 static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
@@ -2224,24 +2228,18 @@ static int arm_smmu_legacy_bus_init(void)
 }
 device_initcall_sync(arm_smmu_legacy_bus_init);
 
-static int arm_smmu_device_remove(struct platform_device *pdev)
+static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	if (!smmu)
-		return -ENODEV;
+		return;
 
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
 
 	/* Turn the thing off */
 	writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
-	return 0;
-}
-
-static void arm_smmu_device_shutdown(struct platform_device *pdev)
-{
-	arm_smmu_device_remove(pdev);
 }
 
 static int __maybe_unused arm_smmu_pm_resume(struct device *dev)
@@ -2256,16 +2254,12 @@ static SIMPLE_DEV_PM_OPS(arm_smmu_pm_ops, NULL, arm_smmu_pm_resume);
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-		.name		= "arm-smmu",
-		.of_match_table	= of_match_ptr(arm_smmu_of_match),
-		.pm		= &arm_smmu_pm_ops,
+		.name			= "arm-smmu",
+		.of_match_table		= of_match_ptr(arm_smmu_of_match),
+		.pm			= &arm_smmu_pm_ops,
+		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
-	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-module_platform_driver(arm_smmu_driver);
-
-MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
-MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(arm_smmu_driver);
-- 
2.7.4
