From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: [PATCH 2/3] cross-tree: phase out dma_zalloc_coherent() on headers
Date: Tue,  8 Jan 2019 08:07:00 -0500
Message-ID: <20190108130701.14161-3-hch@lst.de>
References: <20190108130701.14161-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190108130701.14161-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>, Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

The last few stragglers coccinelle doesn't pick up are on driver
specific header files. Phase those out as well as dma_alloc_coherent()
zeroes out the memory as well now too.

Suggested-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Signed-off-by: Luis Chamberlain <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    | 2 +-
 drivers/net/ethernet/marvell/octeontx2/af/common.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index 5cd3135dfe30..03d131f777bc 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -2081,7 +2081,7 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id,
 			    bool is_pf);
 
 #define BNX2X_ILT_ZALLOC(x, y, size)					\
-	x = dma_zalloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL)
+	x = dma_alloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL)
 
 #define BNX2X_ILT_FREE(x, y, size) \
 	do { \
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 142bc11b9fbb..2462e7aa0c5d 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -52,7 +52,7 @@ extern int bnx2x_num_queues;
 
 #define BNX2X_PCI_ALLOC(y, size)					\
 ({									\
-	void *x = dma_zalloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL); \
+	void *x = dma_alloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL); \
 	if (x)								\
 		DP(NETIF_MSG_HW,					\
 		   "BNX2X_PCI_ALLOC: Physical %Lx Virtual %p\n",	\
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
index ec50a21c5aaf..e332e82fc066 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
@@ -64,7 +64,7 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
 
 	qmem->entry_sz = entry_sz;
 	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
-	qmem->base = dma_zalloc_coherent(dev, qmem->alloc_sz,
+	qmem->base = dma_alloc_coherent(dev, qmem->alloc_sz,
 					 &qmem->iova, GFP_KERNEL);
 	if (!qmem->base)
 		return -ENOMEM;
-- 
2.20.1
