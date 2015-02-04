From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/4] iommu/rockchip: Play nice in multi-platform builds
Date: Wed,  4 Feb 2015 08:58:09 +0100
Message-ID: <1423036690-3862-4-git-send-email-thierry.reding@gmail.com>
References: <1423036690-3862-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1423036690-3862-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The Rockchip IOMMU driver unconditionally executes code and registers a
struct iommu_ops with the platform bus irrespective of whether it runs
on a Rockchip SoC or not. This causes problems in multi-platform kernels
where drivers for other SoCs will no longer be able to register their
own struct iommu_ops or even try to use a struct iommu_ops for an IOMMU
that obviously isn't there.

The smallest fix I could think of is to check for the existence of any
Rockchip IOMMU devices in the device tree and skip initialization
otherwise.

This fixes a problem on Tegra20 where the DRM driver will try to use the
obviously non-existent Rockchip IOMMU.

Reported-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/rockchip-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 6a8b1ec4a48a..869e9c9d5df7 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1017,6 +1017,9 @@ static int __init rk_iommu_init(void)
 {
 	int ret;
 
+	if (!of_find_matching_node(NULL, rk_iommu_dt_ids))
+		return 0;
+
 	ret = bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
 	if (ret)
 		return ret;
@@ -1025,6 +1028,9 @@ static int __init rk_iommu_init(void)
 }
 static void __exit rk_iommu_exit(void)
 {
+	if (!of_find_matching_node(NULL, rk_iommu_dt_ids))
+		return;
+
 	platform_driver_unregister(&rk_iommu_driver);
 }
 
-- 
2.1.3
