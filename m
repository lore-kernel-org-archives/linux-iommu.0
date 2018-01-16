From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 05/13] iommu/rockchip: Fix error handling in init
Date: Tue, 16 Jan 2018 21:25:32 +0800
Message-ID: <20180116132540.18939-6-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180116132540.18939-1-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

It's hard to undo bus_set_iommu() in the error path, so move it to the
end of rk_iommu_probe().

Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2:
Move bus_set_iommu() to rk_iommu_probe().

 drivers/iommu/rockchip-iommu.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index bd8b32dc0db6..d2a0b0daf40d 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1187,6 +1187,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
+
 	return 0;
 }
 
@@ -1218,27 +1220,19 @@ static struct platform_driver rk_iommu_driver = {
 
 static int __init rk_iommu_init(void)
 {
-	struct device_node *np;
 	int ret;
 
-	np = of_find_matching_node(NULL, rk_iommu_dt_ids);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
-	ret = bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
-	if (ret)
-		return ret;
-
 	ret = platform_driver_register(&rk_iommu_domain_driver);
 	if (ret)
 		return ret;
 
 	ret = platform_driver_register(&rk_iommu_driver);
-	if (ret)
+	if (ret) {
 		platform_driver_unregister(&rk_iommu_domain_driver);
-	return ret;
+		return ret;
+	}
+
+	return 0;
 }
 static void __exit rk_iommu_exit(void)
 {
-- 
2.11.0
