From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] iommu/exynos: Don't open-code loop unrolling
Date: Fri, 24 Mar 2017 10:18:44 +0100
Message-ID: <1490347124-17937-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170324091857eucas1p1e7980473922826b7dba5f043be168e6a@eucas1p1.samsung.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

IOMMU domain allocation is not performance critical operation, so remove
hand made optimisation of unrolled initialization loop and leave this to
the compiler.

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/exynos-iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 48b5dabd06ce..2395478dde75 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -759,16 +759,8 @@ static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
 		goto err_counter;
 
 	/* Workaround for System MMU v3.3 to prevent caching 1MiB mapping */
-	for (i = 0; i < NUM_LV1ENTRIES; i += 8) {
-		domain->pgtable[i + 0] = ZERO_LV2LINK;
-		domain->pgtable[i + 1] = ZERO_LV2LINK;
-		domain->pgtable[i + 2] = ZERO_LV2LINK;
-		domain->pgtable[i + 3] = ZERO_LV2LINK;
-		domain->pgtable[i + 4] = ZERO_LV2LINK;
-		domain->pgtable[i + 5] = ZERO_LV2LINK;
-		domain->pgtable[i + 6] = ZERO_LV2LINK;
-		domain->pgtable[i + 7] = ZERO_LV2LINK;
-	}
+	for (i = 0; i < NUM_LV1ENTRIES; i++)
+		domain->pgtable[i] = ZERO_LV2LINK;
 
 	handle = dma_map_single(dma_dev, domain->pgtable, LV1TABLE_SIZE,
 				DMA_TO_DEVICE);
-- 
1.9.1
