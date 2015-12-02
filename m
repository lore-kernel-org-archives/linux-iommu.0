From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] iommu/msm: Use platform_register/unregister_drivers()
Date: Wed,  2 Dec 2015 17:26:01 +0100
Message-ID: <1449073561-11875-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding@nvidia.com>

These new helpers simplify implementing multi-driver modules and
properly handle failure to register one driver by unregistering all
previously registered drivers.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/msm_iommu_dev.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev.c
index b6d01f97e537..4b09e815accf 100644
--- a/drivers/iommu/msm_iommu_dev.c
+++ b/drivers/iommu/msm_iommu_dev.c
@@ -359,30 +359,19 @@ static struct platform_driver msm_iommu_ctx_driver = {
 	.remove		= msm_iommu_ctx_remove,
 };
 
+static struct platform_driver * const drivers[] = {
+	&msm_iommu_driver,
+	&msm_iommu_ctx_driver,
+};
+
 static int __init msm_iommu_driver_init(void)
 {
-	int ret;
-	ret = platform_driver_register(&msm_iommu_driver);
-	if (ret != 0) {
-		pr_err("Failed to register IOMMU driver\n");
-		goto error;
-	}
-
-	ret = platform_driver_register(&msm_iommu_ctx_driver);
-	if (ret != 0) {
-		platform_driver_unregister(&msm_iommu_driver);
-		pr_err("Failed to register IOMMU context driver\n");
-		goto error;
-	}
-
-error:
-	return ret;
+	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
 }
 
 static void __exit msm_iommu_driver_exit(void)
 {
-	platform_driver_unregister(&msm_iommu_ctx_driver);
-	platform_driver_unregister(&msm_iommu_driver);
+	platform_unregister_drivers(drivers, ARRAY_SIZE(drivers));
 }
 
 subsys_initcall(msm_iommu_driver_init);
-- 
2.5.0
