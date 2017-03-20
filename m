From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] iommu/exynos: Workaround FLPD cache flush issues for
	SYSMMU v5
Date: Mon, 20 Mar 2017 10:17:57 +0100
Message-ID: <1490001484-18890-2-git-send-email-m.szyprowski@samsung.com>
References: <1490001484-18890-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20170320091825eucas1p19e9ee18390287c275c9406144e88eef8@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1490001484-18890-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

For some unknown reasons, in some cases, FLPD cache invalidation doesn't
work properly with SYSMMU v5 controllers found in Exynos5433 SoCs. This
can be observed by a firmware crash during initialization phase of MFC
video decoder available in the mentioned SoCs when IOMMU support is
enabled. To workaround this issue perform a full TLB/FLPD invalidation
in case of replacing any first level page descriptors in case of SYSMMU v5.

Fixes: 740a01eee9ada ("iommu/exynos: Add support for v5 SYSMMU")
CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.10+
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
The mentioned commit has been merged to v4.6, but this fix applies only for
v4.10+ kernels due to other changes in the surrounding code.
---
 drivers/iommu/exynos-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 32d43f1994e4..c01bfcdb2383 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -513,7 +513,10 @@ static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 	if (data->active && data->version >= MAKE_MMU_VER(3, 3)) {
 		clk_enable(data->clk_master);
 		if (sysmmu_block(data)) {
-			__sysmmu_tlb_invalidate_entry(data, iova, 1);
+			if (data->version >= MAKE_MMU_VER(5, 0))
+				__sysmmu_tlb_invalidate(data);
+			else
+				__sysmmu_tlb_invalidate_entry(data, iova, 1);
 			sysmmu_unblock(data);
 		}
 		clk_disable(data->clk_master);
-- 
1.9.1
