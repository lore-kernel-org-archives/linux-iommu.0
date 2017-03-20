From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] iommu/exynos: Block SYSMMU while invalidating FLPD cache
Date: Mon, 20 Mar 2017 10:17:56 +0100
Message-ID: <1490001484-18890-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170320091820eucas1p22b62f2d7e089cd997aecc62a4c5b7730@eucas1p2.samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Documentation specifies that SYSMMU should be in blocked state while
performing TLB/FLPD cache invalidation, so add needed calls to
sysmmu_block/unblock.

Fixes: 66a7ed84b345d ("iommu/exynos: Apply workaround of caching fault page table entries")
CC: stable@vger.kernel.org # v4.10+
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This issue has been introduced long time ago, but this fix applies only for
v4.10+ kernels due to other changes in the surrounding code.
---
 drivers/iommu/exynos-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a7e0821c9967..32d43f1994e4 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -512,7 +512,10 @@ static void sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 	spin_lock_irqsave(&data->lock, flags);
 	if (data->active && data->version >= MAKE_MMU_VER(3, 3)) {
 		clk_enable(data->clk_master);
-		__sysmmu_tlb_invalidate_entry(data, iova, 1);
+		if (sysmmu_block(data)) {
+			__sysmmu_tlb_invalidate_entry(data, iova, 1);
+			sysmmu_unblock(data);
+		}
 		clk_disable(data->clk_master);
 	}
 	spin_unlock_irqrestore(&data->lock, flags);
-- 
1.9.1
