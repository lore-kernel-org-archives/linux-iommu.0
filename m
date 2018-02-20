From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/rockchip: Perform a reset on shutdown
Date: Tue, 20 Feb 2018 20:25:04 +0000
Message-ID: <20180220202504.19275-1-marc.zyngier@arm.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Trying to do a kexec whilst the iommus are still on is proving to be
a challenging exercise. It is terribly unsafe, as we're reusing the
memory allocated for the page tables, leading to a likely crash.

Let's implement a shutdown method that will at least try to stop
DMA from going crazy behind our back. Note that we need to be
extra cautious when doing so, as the IOMMU may not be clocked
if controlled by a another master, as typical on Rockchip system.

Suggested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 9d991c2d8767..6a3719e118da 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1209,6 +1209,23 @@ static int rk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void rk_iommu_shutdown(struct platform_device *pdev)
+{
+	struct rk_iommu *iommu = platform_get_drvdata(pdev);
+
+	/*
+	 * Be careful not to try to shutdown an otherwise unused
+	 * IOMMU, as it is likely not to be clocked, and accessing it
+	 * would just block. An IOMMU without a domain is likely to be
+	 * unused, so let's use this as a (weak) guard.
+	 */
+	if (iommu && iommu->domain) {
+		rk_iommu_enable_stall(iommu);
+		rk_iommu_disable_paging(iommu);
+		rk_iommu_force_reset(iommu);
+	}
+}
+
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
@@ -1218,6 +1235,7 @@ MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
 	.remove = rk_iommu_remove,
+	.shutdown = rk_iommu_shutdown,
 	.driver = {
 		   .name = "rk_iommu",
 		   .of_match_table = rk_iommu_dt_ids,
-- 
2.14.2
