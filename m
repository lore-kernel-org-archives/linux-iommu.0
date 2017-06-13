From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] iommu/io-pgtable-arm-v7s: constify dummy_tlb_ops.
Date: Tue, 13 Jun 2017 15:58:30 +0530
Message-ID: <897ee913564b40242149e464c1f3d7d8df393056.1497349602.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

File size before:
   text	   data	    bss	    dec	    hex	filename
   6146	     56	      9	   6211	   1843	drivers/iommu/io-pgtable-arm-v7s.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   6170	     24	      9	   6203	   183b	drivers/iommu/io-pgtable-arm-v7s.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 8d6ca28..f886995 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -749,7 +749,7 @@ static void dummy_tlb_sync(void *cookie)
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static struct iommu_gather_ops dummy_tlb_ops = {
+static const struct iommu_gather_ops dummy_tlb_ops = {
 	.tlb_flush_all	= dummy_tlb_flush_all,
 	.tlb_add_flush	= dummy_tlb_add_flush,
 	.tlb_sync	= dummy_tlb_sync,
-- 
1.9.1
