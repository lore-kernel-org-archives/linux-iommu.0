From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] swiotlb: mark is_swiotlb_buffer static
Date: Wed, 25 Jul 2018 13:38:00 +0200
Message-ID: <20180725113802.18943-5-hch@lst.de>
References: <20180725113802.18943-1-hch@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725113802.18943-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 1 -
 kernel/dma/swiotlb.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 965be92c33b5..7ef541ce8f34 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -121,7 +121,6 @@ static inline unsigned int swiotlb_max_segment(void) { return 0; }
 #endif
 
 extern void swiotlb_print_info(void);
-extern int is_swiotlb_buffer(phys_addr_t paddr);
 extern void swiotlb_set_max_segment(unsigned int);
 
 extern const struct dma_map_ops swiotlb_dma_ops;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 03016221fc64..5555e1fd03cf 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -429,7 +429,7 @@ void __init swiotlb_exit(void)
 	max_segment = 0;
 }
 
-int is_swiotlb_buffer(phys_addr_t paddr)
+static int is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
-- 
2.18.0
