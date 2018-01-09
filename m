From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 1/3] iommu/msm: Claim bus ops on probe
Date: Tue,  9 Jan 2018 16:17:25 +0000
Message-ID: <da664cf8f60c77cbb657cc2e3849560604eaf6da.1515512134.git.robin.murphy@arm.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: alex.williamson@redhat.com, joro@8bytes.org
Cc: sricharan@codeaurora.org, laurent.pinchart+renesas@ideasonboard.com, damm+renesas@opensource.se, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Since the MSM IOMMU driver now probes via DT exclusively rather than
platform data, dependent masters should be deferred until the IOMMU
itself is ready. Thus we can do away with the early initialisation
hook to unconditionally claim the bus ops, and instead do that only
once an IOMMU is actually probed. Furthermore, this should also make
the driver safe for multiplatform kernels on non-MSM SoCs.

Reviewed-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Rebase to 4.15-rc, add tags

 drivers/iommu/msm_iommu.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 04f4d51ffacb..dda1ce87a070 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -823,6 +823,8 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
+	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
+
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
@@ -875,19 +877,7 @@ static void __exit msm_iommu_driver_exit(void)
 subsys_initcall(msm_iommu_driver_init);
 module_exit(msm_iommu_driver_exit);
 
-static int __init msm_iommu_init(void)
-{
-	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
-	return 0;
-}
-
-static int __init msm_iommu_of_setup(struct device_node *np)
-{
-	msm_iommu_init();
-	return 0;
-}
-
-IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", msm_iommu_of_setup);
+IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", NULL);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Stepan Moskovchenko <stepanm@codeaurora.org>");
-- 
2.13.4.dirty
