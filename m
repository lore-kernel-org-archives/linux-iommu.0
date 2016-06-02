From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v3 23/45] video: dma-mapping: Use unsigned long for dma_attrs
Date: Thu, 02 Jun 2016 17:39:25 +0200
Message-ID: <1464881987-13203-24-git-send-email-k.kozlowski__29923.297026153$1464882240$gmane$org@samsung.com>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1464881987-13203-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Richard Henderson <rth-hL46jP5Bxq7R7s880joybQ@public.gmane.org>, Ivan Kokshaysky <ink-biIs/Y0ymYJMZLIVYojuPNP0rXTJTi09@public.gmane.org>, Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans-Christian Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Steven Miao <realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>, Mikael Starvik <starvik-VrBV9hrLPhE@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Split out subsystem specific changes for easier reviews. This will be
squashed with main commit.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 12 ++++++------
 drivers/video/fbdev/omap2/omapfb/omapfb.h      |  3 +--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index d3af01c94a58..59172a2185c0 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1332,7 +1332,7 @@ static void omapfb_free_fbmem(struct fb_info *fbi)
 	}
 
 	dma_free_attrs(fbdev->dev, rg->size, rg->token, rg->dma_handle,
-			&rg->attrs);
+			rg->attrs);
 
 	rg->token = NULL;
 	rg->vaddr = NULL;
@@ -1370,7 +1370,7 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omapfb2_mem_region *rg;
 	void *token;
-	DEFINE_DMA_ATTRS(attrs);
+	unsigned long attrs;
 	dma_addr_t dma_handle;
 	int r;
 
@@ -1386,15 +1386,15 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 
 	size = PAGE_ALIGN(size);
 
-	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);
+	attrs = DMA_ATTR_WRITE_COMBINE;
 
 	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
-		dma_set_attr(DMA_ATTR_NO_KERNEL_MAPPING, &attrs);
+		attrs |= DMA_ATTR_NO_KERNEL_MAPPING;
 
 	DBG("allocating %lu bytes for fb %d\n", size, ofbi->id);
 
 	token = dma_alloc_attrs(fbdev->dev, size, &dma_handle,
-			GFP_KERNEL, &attrs);
+			GFP_KERNEL, attrs);
 
 	if (token == NULL) {
 		dev_err(fbdev->dev, "failed to allocate framebuffer\n");
@@ -1408,7 +1408,7 @@ static int omapfb_alloc_fbmem(struct fb_info *fbi, unsigned long size,
 		r = omap_vrfb_request_ctx(&rg->vrfb);
 		if (r) {
 			dma_free_attrs(fbdev->dev, size, token, dma_handle,
-					&attrs);
+					attrs);
 			dev_err(fbdev->dev, "vrfb create ctx failed\n");
 			return r;
 		}
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb.h b/drivers/video/fbdev/omap2/omapfb/omapfb.h
index 623cd872a367..8aaa2f643820 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb.h
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb.h
@@ -28,7 +28,6 @@
 #endif
 
 #include <linux/rwsem.h>
-#include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
 #include <video/omapdss.h>
@@ -51,7 +50,7 @@ extern bool omapfb_debug;
 
 struct omapfb2_mem_region {
 	int             id;
-	struct dma_attrs attrs;
+	unsigned long	attrs;
 	void		*token;
 	dma_addr_t	dma_handle;
 	u32		paddr;
-- 
1.9.1
