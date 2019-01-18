From: Dongli Zhang <dongli.zhang@oracle.com>
Subject: [PATCH v3 3/3] swiotlb: checking whether swiotlb buffer is full with io_tlb_used
Date: Fri, 18 Jan 2019 15:10:28 +0800
Message-ID: <1547795428-10595-3-git-send-email-dongli.zhang@oracle.com>
References: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, joe.jin@oracle.com, dongli.zhang@oracle.com
List-Id: iommu@lists.linux-foundation.org

This patch uses io_tlb_used to help check whether swiotlb buffer is full.
io_tlb_used is no longer used for only debugfs. It is also used to help
optimize swiotlb_tbl_map_single().

Suggested-by: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
Changed since v2:
  * move #ifdef folding to previous patch (suggested by Konrad Rzeszutek Wilk)

 kernel/dma/swiotlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index bedc9f9..a01b83e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * request and allocate a buffer from that IO TLB pool.
 	 */
 	spin_lock_irqsave(&io_tlb_lock, flags);
+
+	if (unlikely(nslots > io_tlb_nslabs - io_tlb_used))
+		goto not_found;
+
 	index = ALIGN(io_tlb_index, stride);
 	if (index >= io_tlb_nslabs)
 		index = 0;
-- 
2.7.4
