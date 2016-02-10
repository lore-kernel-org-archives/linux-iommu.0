From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] iommu: fix second argument of trace_map() to report correct paddr
Date: Wed, 10 Feb 2016 10:18:04 +0900
Message-ID: <1455067084-6560-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: iommu@lists.linux-foundation.org

Since iommu_map() code added pgsize value to the paddr, trace_map()
used wrong paddr. So, this patch adds "orig_paddr" value in the
iommu_map() to use for the trace_map().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0e3b009..bfd4f7c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1314,6 +1314,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 	size_t orig_size = size;
+	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
 	if (unlikely(domain->ops->map == NULL ||
@@ -1358,7 +1359,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
 	else
-		trace_map(orig_iova, paddr, orig_size);
+		trace_map(orig_iova, orig_paddr, orig_size);
 
 	return ret;
 }
-- 
1.9.1
