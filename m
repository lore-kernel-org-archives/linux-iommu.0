From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] iommu/rockchip: Free irqs in shutdown handler
Date: Mon, 27 Aug 2018 12:56:24 +0200
Message-ID: <20180827105624.5593-1-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, marc.zyngier-5wv7dgnIgG8@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

In the iommu's shutdown handler we disable runtime-pm which could
result in the irq-handler running unclocked and since commit
    3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
we warn about that fact.

This can cause warnings on shutdown on some Rockchip machines, so
free the irqs in the shutdown handler before we disable runtime-pm.

Reported-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Fixes: 3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
Signed-off-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 258115b10fa9..ad3e2b97469e 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1241,6 +1241,12 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 static void rk_iommu_shutdown(struct platform_device *pdev)
 {
+	struct rk_iommu *iommu = platform_get_drvdata(pdev);
+	int i = 0, irq;
+
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO)
+		devm_free_irq(iommu->dev, irq, iommu);
+
 	pm_runtime_force_suspend(&pdev->dev);
 }
 
-- 
2.17.0
