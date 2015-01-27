From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 6/6] dmaengine: rcar-dmac: Disable channel 0 when using IOMMU
Date: Tue, 27 Jan 2015 19:25:16 +0200
Message-ID: <1422379516-1633-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1422379516-1633-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422379516-1633-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

A still unconfirmed hardware bug prevents the IPMMU microTLB 0 to be
flushed correctly, resulting in memory corruption. DMAC 0 channel 0 is
connected to microTLB 0 on currently supported platforms, so we can't
use it with the IPMMU. As the IOMMU API operates at the device level we
can't disable it selectively, so ignore channel 0 for now if the device
is part of an IOMMU group.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/dma/sh/rcar-dmac.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

As this patch works around an IOMMU bug in a DMA engine driver it would
benefit from review from IOMMU developers.

Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index d345d3d81813..e0bf38a7284e 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1595,6 +1595,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES |
 		DMA_SLAVE_BUSWIDTH_8_BYTES | DMA_SLAVE_BUSWIDTH_16_BYTES |
 		DMA_SLAVE_BUSWIDTH_32_BYTES | DMA_SLAVE_BUSWIDTH_64_BYTES;
+	unsigned int channels_offset = 0;
 	struct dma_device *engine;
 	struct rcar_dmac *dmac;
 	struct resource *mem;
@@ -1614,6 +1615,19 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * A still unconfirmed hardware bug prevents the IPMMU microTLB 0 to be
+	 * flushed correctly, resulting in memory corruption. DMAC 0 channel 0
+	 * is connected to microTLB 0 on currently supported platforms, so we
+	 * can't use it with the IPMMU. As the IOMMU API operates at the device
+	 * level we can't disable it selectively, so ignore channel 0 for now if
+	 * the device is part of an IOMMU group.
+	 */
+	if (pdev->dev.iommu_group) {
+		dmac->n_channels--;
+		channels_offset = 1;
+	}
+
 	dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
 				      sizeof(*dmac->channels), GFP_KERNEL);
 	if (!dmac->channels)
@@ -1664,7 +1678,8 @@ static int rcar_dmac_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&dmac->engine.channels);
 
 	for (i = 0; i < dmac->n_channels; ++i) {
-		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], i);
+		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i],
+					   i + channels_offset);
 		if (ret < 0)
 			goto error;
 	}
-- 
2.0.5
