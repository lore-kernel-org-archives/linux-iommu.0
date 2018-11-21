From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH] iommu: use memunmap to free memremap
Date: Wed, 21 Nov 2018 17:53:47 +0800
Message-ID: <1542794027-93141-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

memunmap() should be used to free the return of memremap(), not
iounmap().

Fixes: dfddb969edf0("iommu/vt-d: Switch from ioremap_cache to memremap")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f3ccf02..41a4b88 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3075,7 +3075,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			}
 
 			if (old_ce)
-				iounmap(old_ce);
+				memunmap(old_ce);
 
 			ret = 0;
 			if (devfn < 0x80)
-- 
2.7.4
