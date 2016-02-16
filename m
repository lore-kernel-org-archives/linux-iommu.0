From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/11] iommu: exynos: unify code for fldp cache invalidation
Date: Tue, 16 Feb 2016 15:57:01 +0100
Message-ID: <1455634624-18130-9-git-send-email-m.szyprowski@samsung.com>
References: <1455634624-18130-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1455634624-18130-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch simplifies the code for handling of flpdcache invalidation.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 15787a1..e42a76c 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -440,13 +440,6 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
 	return ret;
 }
 
-static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
-					      sysmmu_iova_t iova)
-{
-	if (data->version == MAKE_MMU_VER(3, 3))
-		__raw_writel(iova | 0x1, data->sfrbase + REG_MMU_FLUSH_ENTRY);
-}
-
 static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 					    sysmmu_iova_t iova)
 {
@@ -455,8 +448,10 @@ static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 	clk_enable(data->clk_master);
 
 	spin_lock_irqsave(&data->lock, flags);
-	if (is_sysmmu_active(data))
-		__sysmmu_tlb_invalidate_flpdcache(data, iova);
+	if (is_sysmmu_active(data)) {
+		if (data->version >= MAKE_MMU_VER(3, 3))
+			__sysmmu_tlb_invalidate_entry(data, iova, 1);
+	}
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	clk_disable(data->clk_master);
-- 
1.9.2
