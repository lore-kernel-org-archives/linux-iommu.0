From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Subject: [PATCH 2/2] staging: fsl-dpaa2/eth: Map Tx buffers as bidirectional
Date: Wed, 24 May 2017 07:13:28 -0500
Message-ID: <20170524121328.16984-2-ruxandra.radulescu@nxp.com>
References: <20170524121328.16984-1-ruxandra.radulescu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170524121328.16984-1-ruxandra.radulescu@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, stuyoder@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org, agraf@suse.de, iommu@lists.linux-foundation.org, nipun.gupta@nxp.com, bogdan.purcareata@nxp.com, linux-arm-kernel@lists.infradead.org, laurentiu.tudor@nxp.com
List-Id: iommu@lists.linux-foundation.org

WRIOP hardware may need to write to the hardware annotation
area of Tx buffers (e.g. frame status bits) and also to
the data area (e.g. L4 checksum in frame header).

Map these buffers as DMA_BIDIRECTIONAL, otherwise the
write transaction through SMMU will not be allowed.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 3fee0d6f17e0..49c435bad706 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -355,7 +355,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 
 	sg_init_table(scl, nr_frags + 1);
 	num_sg = skb_to_sgvec(skb, scl, 0, skb->len);
-	num_dma_bufs = dma_map_sg(dev, scl, num_sg, DMA_TO_DEVICE);
+	num_dma_bufs = dma_map_sg(dev, scl, num_sg, DMA_BIDIRECTIONAL);
 	if (unlikely(!num_dma_bufs)) {
 		err = -ENOMEM;
 		goto dma_map_sg_failed;
@@ -406,7 +406,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 	swa->num_dma_bufs = num_dma_bufs;
 
 	/* Separately map the SGT buffer */
-	addr = dma_map_single(dev, sgt_buf, sgt_buf_size, DMA_TO_DEVICE);
+	addr = dma_map_single(dev, sgt_buf, sgt_buf_size, DMA_BIDIRECTIONAL);
 	if (unlikely(dma_mapping_error(dev, addr))) {
 		err = -ENOMEM;
 		goto dma_map_single_failed;
@@ -423,7 +423,7 @@ static int build_sg_fd(struct dpaa2_eth_priv *priv,
 dma_map_single_failed:
 	kfree(sgt_buf);
 sgt_buf_alloc_failed:
-	dma_unmap_sg(dev, scl, num_sg, DMA_TO_DEVICE);
+	dma_unmap_sg(dev, scl, num_sg, DMA_BIDIRECTIONAL);
 dma_map_sg_failed:
 	kfree(scl);
 	return err;
@@ -461,7 +461,7 @@ static int build_single_fd(struct dpaa2_eth_priv *priv,
 
 	addr = dma_map_single(dev, buffer_start,
 			      skb_tail_pointer(skb) - buffer_start,
-			      DMA_TO_DEVICE);
+			      DMA_BIDIRECTIONAL);
 	if (unlikely(dma_mapping_error(dev, addr)))
 		return -ENOMEM;
 
@@ -510,7 +510,7 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 		 */
 		dma_unmap_single(dev, fd_addr,
 				 skb_tail_pointer(skb) - buffer_start,
-				 DMA_TO_DEVICE);
+				 DMA_BIDIRECTIONAL);
 	} else if (fd_format == dpaa2_fd_sg) {
 		swa = (struct dpaa2_eth_swa *)skbh;
 		skb = swa->skb;
@@ -519,13 +519,13 @@ static void free_tx_fd(const struct dpaa2_eth_priv *priv,
 		num_dma_bufs = swa->num_dma_bufs;
 
 		/* Unmap the scatterlist */
-		dma_unmap_sg(dev, scl, num_sg, DMA_TO_DEVICE);
+		dma_unmap_sg(dev, scl, num_sg, DMA_BIDIRECTIONAL);
 		kfree(scl);
 
 		/* Unmap the SGT buffer */
 		unmap_size = priv->tx_data_offset +
 		       sizeof(struct dpaa2_sg_entry) * (1 + num_dma_bufs);
-		dma_unmap_single(dev, fd_addr, unmap_size, DMA_TO_DEVICE);
+		dma_unmap_single(dev, fd_addr, unmap_size, DMA_BIDIRECTIONAL);
 	} else {
 		/* Unsupported format, mark it as errored and give up */
 		if (status)
-- 
2.11.0
