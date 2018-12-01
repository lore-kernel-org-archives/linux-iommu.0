From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 9/9] iommu/arm-smmu: Make arm-smmu-v3 explicitly non-modular
Date: Sat, 1 Dec 2018 14:19:17 -0500
Message-ID: <1543691957-17608-10-git-send-email-paul.gortmaker@windriver.com>
References: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

The Kconfig currently controlling compilation of this code is:

drivers/iommu/Kconfig:config ARM_SMMU_V3
drivers/iommu/Kconfig:  bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"

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

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Nate Watterson <nwatters@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/arm-smmu-v3.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 6947ccf26512..1189c06079d4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -20,7 +20,8 @@
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/moduleparam.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -356,6 +357,10 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
+/*
+ * not really modular, but the easiest way to keep compat with existing
+ * bootargs behaviour is to continue using module_param_named here.
+ */
 static bool disable_bypass = 1;
 module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
@@ -2928,37 +2933,25 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int arm_smmu_device_remove(struct platform_device *pdev)
+static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	arm_smmu_device_disable(smmu);
-
-	return 0;
-}
-
-static void arm_smmu_device_shutdown(struct platform_device *pdev)
-{
-	arm_smmu_device_remove(pdev);
 }
 
 static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v3", },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu-v3",
 		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.suppress_bind_attrs = true,
 	},
 	.probe	= arm_smmu_device_probe,
-	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-module_platform_driver(arm_smmu_driver);
-
-MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
-MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(arm_smmu_driver);
-- 
2.7.4
