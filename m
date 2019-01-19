From: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH] iommu/amd: unmap all mapped pages in error path of map_sg
Date: Sat, 19 Jan 2019 10:38:05 -0700
Message-ID: <20190119173805.1753-1-jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

In the error path of map_sg there is an incorrect if condition
for breaking out of the loop that searches the scatterlist
for mapped pages to unmap. Instead of breaking out of the
loop once all the pages that were mapped have been unmapped,
it will break out of the loop after it has unmapped 1 page.
Fix the condition, so it breaks out of the loop only after
all the mapped pages have been unmapped.

Fixes: 80187fd39dcb ("iommu/amd: Optimize map_sg and unmap_sg")
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..aeeca479f914 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2548,7 +2548,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
 			iommu_unmap_page(domain, bus_addr, PAGE_SIZE);
 
-			if (--mapped_pages)
+			if (--mapped_pages == 0)
 				goto out_free_iova;
 		}
 	}
-- 
2.20.1.98.gecbdaf0899
