From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/10] swiotlb: remove a pointless comment
Date: Mon,  8 Oct 2018 10:02:37 +0200
Message-ID: <20181008080246.20543-2-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008080246.20543-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

This comments describes an aspect of the map_sg interface that isn't
even exploited by swiotlb.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4f8a6dbf0b60..9062b14bc7f4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -925,12 +925,6 @@ swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
  * appropriate dma address and length.  They are obtained via
  * sg_dma_{address,length}(SG).
  *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
  * Device ownership issues as mentioned above for swiotlb_map_page are the
  * same here.
  */
-- 
2.19.0
