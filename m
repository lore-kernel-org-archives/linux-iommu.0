From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3] of/platform: initialise AMBA default DMA masks
Date: Thu, 6 Sep 2018 13:31:07 +0100
Message-ID: <2000a4f8-f842-b4db-5c1c-d68ec67ebd93@arm.com>
References: <20180831141307.9053-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180831141307.9053-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 31/08/18 15:13, Linus Walleij wrote:
> This addresses a v4.19-rc1 regression in the PL111 DRM driver
> in drivers/gpu/pl111/*
> 
> The driver uses the CMA KMS helpers and will thus at some
> point call down to dma_alloc_attrs() to allocate a chunk
> of contigous DMA memory for the framebuffer.
> 
> It appears that in v4.18, it was OK that this (and other
> DMA mastering AMBA devices) left dev->coherent_dma_mask
> blank (zero).
> 
> In v4.19-rc1 the WARN_ON_ONCE(dev && !dev->coherent_dma_mask)
> in dma_alloc_attrs() in include/linux/dma-mapping.h is
> triggered. The allocation later fails when get_coherent_dma_mask()
> is called from __dma_alloc() and __dma_alloc() returns
> NULL:
> 
> drm-clcd-pl111 dev:20: coherent DMA mask is unset
> drm-clcd-pl111 dev:20: [drm:drm_fb_helper_fbdev_setup] *ERROR*
>   	       	        Failed to set fbdev configuration
> 
> It turns out that in commit 4d8bde883bfb
> ("OF: Don't set default coherent DMA mask")
> the OF core stops setting the default DMA mask on new devices,
> especially those lines of the patch:
> 
> - if (!dev->coherent_dma_mask)
> -               dev->coherent_dma_mask = DMA_BIT_MASK(32);
> 
> Robin Murphy solved a similar problem in
> a5516219b102 ("of/platform: Initialise default DMA masks")
> by simply assigning dev.coherent_dma_mask and the
> dev.dma_mask to point to the same when creating devices
> from the device tree, and introducing the same code into
> the code path creating AMBA/PrimeCell devices solved my
> problem, graphics now come up.

Ugh, sorry - that commit really should have updated 
of_amba_device_create() at the same time, but thanks to the tangled 
history I managed to overlook it. And of course, the one PrimeCell 
device in my usual test system (PL330) gets an explicit coherent mask 
set by its driver so I didn't get the WARN() to remind me...

I see this is merged already, but after-the-fact Ack anyway. Apologies 
for the breakage, and thanks for fixing my mess :)

Robin.

> The code simply assumes that the device can access all
> of the system memory by setting the coherent DMA mask
> to 0xffffffff when creating a device from the device
> tree, which is crude, but seems to be what kernel v4.18
> assumed.
> 
> The AMBA PrimeCells do not differ between coherent and
> streaming DMA so we can just assign the same to any
> DMA mask.
> 
> Possibly drivers should augment their coherent DMA mask
> in accordance with "dma-ranges" from the device tree
> if more finegranular masking is needed.
> 
> Reported-by: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> Fixes: 4d8bde883bfb ("OF: Don't set default coherent DMA mask")
> Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> ChangeLog v2->v3:
> - Provide proper root cause analysis, point to the right
>    offending commit with Fixes:
> - Make even more elaborate description of what is causing
>    this.
> ChangeLog v1->v2:
> - Provide a better description for the change.
> ---
>   drivers/of/platform.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 7ba90c290a42..6c59673933e9 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -241,6 +241,10 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>   	if (!dev)
>   		goto err_clear_flag;
>   
> +	/* AMBA devices only support a single DMA mask */
> +	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> +
>   	/* setup generic device info */
>   	dev->dev.of_node = of_node_get(node);
>   	dev->dev.fwnode = &node->fwnode;
> 
