From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 6/9] iommu/qcom: Make it explicitly non-modular
Date: Sat, 1 Dec 2018 14:19:14 -0500
Message-ID: <1543691957-17608-7-git-send-email-paul.gortmaker@windriver.com>
References: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543691957-17608-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The Kconfig currently controlling compilation of this code is:

drivers/iommu/Kconfig:config MTK_IOMMU_V1
drivers/iommu/Kconfig:  bool "MTK IOMMU Version 1 (M4U gen1) Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init just becomes device_initcall for non-modules, the
init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Rob Clark <robdclark@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/iommu/qcom_iommu.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index ee70e9921cf1..4c8f4fc54106 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -29,7 +29,7 @@
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/kconfig.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -908,7 +908,6 @@ static const struct of_device_id qcom_iommu_of_match[] = {
 	{ .compatible = "qcom,msm-iommu-v1" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, qcom_iommu_of_match);
 
 static struct platform_driver qcom_iommu_driver = {
 	.driver	= {
@@ -934,15 +933,4 @@ static int __init qcom_iommu_init(void)
 
 	return ret;
 }
-
-static void __exit qcom_iommu_exit(void)
-{
-	platform_driver_unregister(&qcom_iommu_driver);
-	platform_driver_unregister(&qcom_iommu_ctx_driver);
-}
-
-module_init(qcom_iommu_init);
-module_exit(qcom_iommu_exit);
-
-MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
-MODULE_LICENSE("GPL v2");
+device_initcall(qcom_iommu_init);
-- 
2.7.4
