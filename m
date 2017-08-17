From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/13] drm/nouveau/imem/gk20a: Use sychronized interface of
	the IOMMU-API
Date: Thu, 17 Aug 2017 14:56:31 +0200
Message-ID: <1502974596-23835-9-git-send-email-joro@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502974596-23835-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The map and unmap functions of the IOMMU-API changed their
semantics: They do no longer guarantee that the hardware
TLBs are synchronized with the page-table updates they made.

To make conversion easier, new synchronized functions have
been introduced which give these guarantees again until the
code is converted to use the new TLB-flush interface of the
IOMMU-API, which allows certain optimizations.

But for now, just convert this code to use the synchronized
functions so that it will behave as before.

Cc: Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
index cd5adbe..3f0de47 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c
@@ -322,8 +322,9 @@ gk20a_instobj_dtor_iommu(struct nvkm_memory *memory)
 
 	/* Unmap pages from GPU address space and free them */
 	for (i = 0; i < node->base.mem.size; i++) {
-		iommu_unmap(imem->domain,
-			    (r->offset + i) << imem->iommu_pgshift, PAGE_SIZE);
+		iommu_unmap_sync(imem->domain,
+				 (r->offset + i) << imem->iommu_pgshift,
+				 PAGE_SIZE);
 		dma_unmap_page(dev, node->dma_addrs[i], PAGE_SIZE,
 			       DMA_BIDIRECTIONAL);
 		__free_page(node->pages[i]);
@@ -458,14 +459,15 @@ gk20a_instobj_ctor_iommu(struct gk20a_instmem *imem, u32 npages, u32 align,
 	for (i = 0; i < npages; i++) {
 		u32 offset = (r->offset + i) << imem->iommu_pgshift;
 
-		ret = iommu_map(imem->domain, offset, node->dma_addrs[i],
-				PAGE_SIZE, IOMMU_READ | IOMMU_WRITE);
+		ret = iommu_map_sync(imem->domain, offset, node->dma_addrs[i],
+				     PAGE_SIZE, IOMMU_READ | IOMMU_WRITE);
 		if (ret < 0) {
 			nvkm_error(subdev, "IOMMU mapping failure: %d\n", ret);
 
 			while (i-- > 0) {
 				offset -= PAGE_SIZE;
-				iommu_unmap(imem->domain, offset, PAGE_SIZE);
+				iommu_unmap_sync(imem->domain, offset,
+						 PAGE_SIZE);
 			}
 			goto release_area;
 		}
-- 
2.7.4
