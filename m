From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 15/72] iommu/amd: Unmap all mapped pages in error path of map_sg
Date: Sat, 23 Feb 2019 16:03:25 -0500
Message-ID: <20190223210422.199966-15-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

[ Upstream commit f1724c0883bb0ce93b8dcb94b53dcca3b75ac9a7 ]

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
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index ce543ecbb4158..9d06bc36a2c19 100644
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
2.19.1
