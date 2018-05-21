From: Huaisheng Ye <yehs2007@gmail.com>
Subject: [RFC PATCH v2 04/12] drivers/iommu/amd_iommu: update usage of address zone modifiers
Date: Mon, 21 May 2018 23:20:25 +0800
Message-ID: <1526916033-4877-5-git-send-email-yehs2007@gmail.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: mhocko@suse.com, willy@infradead.org, vbabka@suse.cz, mgorman@techsingularity.net, kstewart@linuxfoundation.org, alexander.levin@verizon.com, gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com, hehy1@lenovo.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

From: Huaisheng Ye <yehs1@lenovo.com>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated by OR.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 74788fd..3921d53 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2614,7 +2614,7 @@ static void *alloc_coherent(struct device *dev, size_t size,
 	dma_dom   = to_dma_ops_domain(domain);
 	size	  = PAGE_ALIGN(size);
 	dma_mask  = dev->coherent_dma_mask;
-	flag     &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
+	flag     &= ~__GFP_ZONE_MASK;
 	flag     |= __GFP_ZERO;
 
 	page = alloc_pages(flag | __GFP_NOWARN,  get_order(size));
-- 
1.8.3.1
