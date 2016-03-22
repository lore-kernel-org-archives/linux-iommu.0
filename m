From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH] iommu/rockchip: Only log stall errors when attaching
Date: Tue, 22 Mar 2016 16:04:33 +0100
Message-ID: <1458659073-13553-1-git-send-email-tomeu.vizoso@collabora.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Move the logging of timeouts when stalling the MMU to
rk_iommu_attach_device, as it's expected that sometimes the MMU won't
get stalled when detaching a device, and it's not a real problem that
would need to be communicated to the user.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0253ab35c33b..65325b6742e6 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -346,13 +346,7 @@ static int rk_iommu_enable_stall(struct rk_iommu *iommu)
 
 	rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_STALL);
 
-	ret = rk_wait_for(rk_iommu_is_stall_active(iommu), 1);
-	if (ret)
-		for (i = 0; i < iommu->num_mmu; i++)
-			dev_err(iommu->dev, "Enable stall request timed out, status: %#08x\n",
-				rk_iommu_read(iommu->bases[i], RK_MMU_STATUS));
-
-	return ret;
+	return rk_wait_for(rk_iommu_is_stall_active(iommu), 1);
 }
 
 static int rk_iommu_disable_stall(struct rk_iommu *iommu)
@@ -798,8 +792,12 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
 		return 0;
 
 	ret = rk_iommu_enable_stall(iommu);
-	if (ret)
+	if (ret) {
+		for (i = 0; i < iommu->num_mmu; i++)
+			dev_err(iommu->dev, "Enable stall request timed out, status: %#08x\n",
+				rk_iommu_read(iommu->bases[i], RK_MMU_STATUS));
 		return ret;
+	}
 
 	ret = rk_iommu_force_reset(iommu);
 	if (ret)
-- 
2.5.0
