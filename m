From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RESEND PATCH v6 01/14] iommu/rockchip: Prohibit unbind and remove
Date: Thu,  1 Mar 2018 18:18:24 +0800
Message-ID: <20180301101837.27969-2-jeffy.chen@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Removal of IOMMUs cannot be done reliably.

This is similar to exynos iommu driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---

Changes in v6: None
Changes in v5: None
Changes in v4:
Rewrite commit message.

Changes in v3:
Also remove remove() and module_exit() as Tomasz suggested.

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9d991c2d8767..16cd8780c289 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1197,18 +1197,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int rk_iommu_remove(struct platform_device *pdev)
-{
-	struct rk_iommu *iommu = platform_get_drvdata(pdev);
-
-	if (iommu) {
-		iommu_device_sysfs_remove(&iommu->iommu);
-		iommu_device_unregister(&iommu->iommu);
-	}
-
-	return 0;
-}
-
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
@@ -1217,10 +1205,10 @@ MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
 
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
-	.remove = rk_iommu_remove,
 	.driver = {
 		   .name = "rk_iommu",
 		   .of_match_table = rk_iommu_dt_ids,
+		   .suppress_bind_attrs = true,
 	},
 };
 
@@ -1248,14 +1236,7 @@ static int __init rk_iommu_init(void)
 		platform_driver_unregister(&rk_iommu_domain_driver);
 	return ret;
 }
-static void __exit rk_iommu_exit(void)
-{
-	platform_driver_unregister(&rk_iommu_driver);
-	platform_driver_unregister(&rk_iommu_domain_driver);
-}
-
 subsys_initcall(rk_iommu_init);
-module_exit(rk_iommu_exit);
 
 MODULE_DESCRIPTION("IOMMU API for Rockchip");
 MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
-- 
2.11.0
