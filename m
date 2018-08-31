From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH v2] of/platform: initialise AMBA default DMA masks
Date: Fri, 31 Aug 2018 11:09:03 +0100
Message-ID: <20180831100903.GL30658@n2100.armlinux.org.uk>
References: <20180831082614.27455-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180831082614.27455-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 31, 2018 at 10:26:14AM +0200, Linus Walleij wrote:
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
>  	       	        Failed to set fbdev configuration
> 
> I have not been able to properly bisect down to the actual
> committ causing it beacuse the kernel simply fails to build
> at to many bisection points, pushing the bisect back to places
> like the merge of entire subsystem trees, where things have
> likely been resolved while merging them.
> 
> I found that Robin Murphy solved a similar problem in
> a5516219b102 ("of/platform: Initialise default DMA masks")
> by simply assigning dev.coherent_dma_mask and the
> dev.dma_mask to point to the same when creating devices
> from the device tree, and introducing the same code into
> the code path creating AMBA/PrimeCell devices solved my
> problem, graphics now come up.
> 
> The code simply assumes that the device can access all
> of the system memory by setting the coherent DMA mask
> to 0xffffffff when creating a device from the device
> tree, which is crude, but seems to be what kernel v4.18
> assumed.
> 
> Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
> Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Russell, Christoph: this is probably not the last patch.
> But it has a more accurate description of the problem.
> I still do not know what change to the kernel made
> it start triggering this, whether in the DMA API or
> in DRM :(

Doing some research, it seems the warning was added in v4.16-rc1, and
it is only a warning - it doesn't otherwise change the behaviour, so
it's not the actual warning that's the problem.

I can't see anything in the DMA API nor DRM which would cause this
either, but there are changes in the DT code.

However, there are changes to of_dma_configure() which will be called
just before the driver's probe function is called - and I guess the
culpret is 4d8bde883bfb ("OF: Don't set default coherent DMA mask").
So I guess that's the root cause of the problem, and indeed this
change was made in 4.19-rc1.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
