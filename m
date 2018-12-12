From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH] iommu/io-pgtable-arm-v7s: Don't check PHYS_OFFSET if RAMDOMIZE_BASE is enabled
Date: Wed, 12 Dec 2018 21:02:17 +0800
Message-ID: <1544619737-6313-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, yong.wu@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, CK Hu <ck.hu@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

If CONFIG_RANDOMIZE_BASE is enabled, the "memstart_addr" will be updated
randomly, then the PHYS_OFFSET may be random.

Fixes: 82db33dc5e49 ("iommu/io-pgtable-arm: Check for v7s-incapable
systems")
Reported-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 445c3bd..70941e6 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -709,7 +709,7 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 {
 	struct arm_v7s_io_pgtable *data;
 
-#ifdef PHYS_OFFSET
+#if defined(PHYS_OFFSET) && !defined(CONFIG_RANDOMIZE_BASE)
 	if (upper_32_bits(PHYS_OFFSET))
 		return NULL;
 #endif
-- 
1.9.1
