From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH] Revert "iommu/io-pgtable-arm: Check for v7s-incapable systems"
Date: Thu, 13 Dec 2018 17:19:48 +0800
Message-ID: <1544692788-24427-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, yong.wu@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, CK Hu <ck.hu@mediatek.com>, Stephen Boyd <swboyd@chromium.org>
List-Id: iommu@lists.linux-foundation.org

This reverts commit 82db33dc5e49fb625262d81125625d07a0d6184e.

After the commit 29859aeb8a6e ("iommu/io-pgtable-arm-v7s: Abort
allocation when table address overflows the PTE"), v7s will return fail
if the page table allocation isn't expected. this PHYS_OFFSET check
is unnecessary now.

And this check may lead to fail. For example, If CONFIG_RANDOMIZE_BASE
is enabled, the "memstart_addr" will be updated randomly, then the
PHYS_OFFSET may be random.

Reported-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bd..cec29bf 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -709,10 +709,6 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 {
 	struct arm_v7s_io_pgtable *data;
 
-#ifdef PHYS_OFFSET
-	if (upper_32_bits(PHYS_OFFSET))
-		return NULL;
-#endif
 	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
 		return NULL;
 
-- 
1.9.1
