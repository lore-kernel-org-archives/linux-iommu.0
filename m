From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] of/platform: initialise AMBA default DMA masks
Date: Fri, 31 Aug 2018 10:26:14 +0200
Message-ID: <20180831082614.27455-1-linus.walleij@linaro.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This addresses a v4.19-rc1 regression in the PL111 DRM driver
in drivers/gpu/pl111/*

The driver uses the CMA KMS helpers and will thus at some
point call down to dma_alloc_attrs() to allocate a chunk
of contigous DMA memory for the framebuffer.

It appears that in v4.18, it was OK that this (and other
DMA mastering AMBA devices) left dev->coherent_dma_mask
blank (zero).

In v4.19-rc1 the WARN_ON_ONCE(dev && !dev->coherent_dma_mask)
in dma_alloc_attrs() in include/linux/dma-mapping.h is
triggered. The allocation later fails when get_coherent_dma_mask()
is called from __dma_alloc() and __dma_alloc() returns
NULL:

drm-clcd-pl111 dev:20: coherent DMA mask is unset
drm-clcd-pl111 dev:20: [drm:drm_fb_helper_fbdev_setup] *ERROR*
 	       	        Failed to set fbdev configuration

I have not been able to properly bisect down to the actual
committ causing it beacuse the kernel simply fails to build
at to many bisection points, pushing the bisect back to places
like the merge of entire subsystem trees, where things have
likely been resolved while merging them.

I found that Robin Murphy solved a similar problem in
a5516219b102 ("of/platform: Initialise default DMA masks")
by simply assigning dev.coherent_dma_mask and the
dev.dma_mask to point to the same when creating devices
from the device tree, and introducing the same code into
the code path creating AMBA/PrimeCell devices solved my
problem, graphics now come up.

The code simply assumes that the device can access all
of the system memory by setting the coherent DMA mask
to 0xffffffff when creating a device from the device
tree, which is crude, but seems to be what kernel v4.18
assumed.

Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
Russell, Christoph: this is probably not the last patch.
But it has a more accurate description of the problem.
I still do not know what change to the kernel made
it start triggering this, whether in the DMA API or
in DRM :(

I am looking into Russell's suggestion to use the DMA
ranges, and thusly patch all device trees with DMA
mastering devices adding DMA ranges to them and parsing
that in the device tree AMBA/PrimeCell population code.
Possibly that is the right path forward.
---
 drivers/of/platform.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 7ba90c290a42..6c59673933e9 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -241,6 +241,10 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	if (!dev)
 		goto err_clear_flag;
 
+	/* AMBA devices only support a single DMA mask */
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+
 	/* setup generic device info */
 	dev->dev.of_node = of_node_get(node);
 	dev->dev.fwnode = &node->fwnode;
-- 
2.17.1
