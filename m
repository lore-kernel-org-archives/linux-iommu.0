From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH] iommu/io-pgtable-arm-v7s: Need dma-sync while there is no QUIRK_NO_DMA
Date: Mon, 25 Sep 2017 17:28:47 +0800
Message-ID: <1506331727-25018-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, yong.wu@mediatek.com
List-Id: iommu@lists.linux-foundation.org

Fix the commit 81b3c2521844 ("iommu/io-pgtable: Introduce explicit
coherency"). If there is no IO_PGTABLE_QUIRK_NO_DMA, we should call
dma_sync_single_for_device for cache synchronization.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
Rebased on v4.14-rc1.
---
 drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index d665d0d..6961fc3 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -245,7 +245,7 @@ static void __arm_v7s_free_table(void *table, int lvl,
 static void __arm_v7s_pte_sync(arm_v7s_iopte *ptep, int num_entries,
 			       struct io_pgtable_cfg *cfg)
 {
-	if (!(cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA))
+	if (cfg->quirks & IO_PGTABLE_QUIRK_NO_DMA)
 		return;
 
 	dma_sync_single_for_device(cfg->iommu_dev, __arm_v7s_dma_addr(ptep),
-- 
1.8.1.1.dirty
