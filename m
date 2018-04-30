From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] media: videobuf-dma-sg: Fix dma_{sync,unmap}_sg() calls
Date: Mon, 30 Apr 2018 17:56:28 +0100
Message-ID: <453f27adfa6563d43a17a57b37c9c7db36c2114b.1525107326.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This reverts commit fc7f8fd42c2b934ac348995e0c530c917fc277d5.

Whilst the rationale for the above commit was in general correct, i.e.
that users *consuming* the DMA addresses should rely on sglen rather
than num_pages, it has always been the case that the DMA API itself
still requires that dma_{sync,unmap}_sg() are called with the original
number of entries as passed to dma_map_sg(), not the number of mapped
entries it returned. Thus the particular changes made in that patch
were erroneous.

At worst this might lead to data loss at the tail end of mapped buffers
on non-coherent hardware, while at best it's an example of incorrect
DMA API usage which has proven to mislead readers.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/media/v4l2-core/videobuf-dma-sg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
index add2edb23eac..37550f81cc29 100644
--- a/drivers/media/v4l2-core/videobuf-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
@@ -334,7 +334,7 @@ int videobuf_dma_unmap(struct device *dev, struct videobuf_dmabuf *dma)
 	if (!dma->sglen)
 		return 0;
 
-	dma_unmap_sg(dev, dma->sglist, dma->sglen, dma->direction);
+	dma_unmap_sg(dev, dma->sglist, dma->nr_pages, dma->direction);
 
 	vfree(dma->sglist);
 	dma->sglist = NULL;
@@ -581,7 +581,7 @@ static int __videobuf_sync(struct videobuf_queue *q,
 	MAGIC_CHECK(mem->dma.magic, MAGIC_DMABUF);
 
 	dma_sync_sg_for_cpu(q->dev, mem->dma.sglist,
-			    mem->dma.sglen, mem->dma.direction);
+			    mem->dma.nr_pages, mem->dma.direction);
 
 	return 0;
 }
-- 
2.17.0.dirty
