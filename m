From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH] of/platform: Initialise AMBA default DMA masks
Date: Thu, 30 Aug 2018 18:01:36 +0100
Message-ID: <20180830170136.GK30658@n2100.armlinux.org.uk>
References: <20180828084442.30176-1-linus.walleij@linaro.org>
	<20180828092338.GA12488@lst.de>
	<CACRpkdbLOGE2TiNxnV+L9Y=9QJ9jt-tv4GjDB3iTpJFj_w-5SQ@mail.gmail.com>
	<20180828141413.GH30658@n2100.armlinux.org.uk>
	<20180829055521.GA28958@lst.de>
	<20180830084014.GJ30658@n2100.armlinux.org.uk>
	<CACRpkdYbaZj4z_RYST2+HuA9A1YQZ3-xM0J0xBdFLWzZ_0=u4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYbaZj4z_RYST2+HuA9A1YQZ3-xM0J0xBdFLWzZ_0=u4w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:DRM PANEL DRIVERS" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 30, 2018 at 10:45:11AM +0200, Linus Walleij wrote:
> On Thu, Aug 30, 2018 at 10:40 AM Russell King - ARM Linux
> <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org> wrote:
> 
> > Well, as I've no idea what the issue is here, I can't do anything or
> > make any suggestions.  I wasn't copied on the initial part of the
> > thread.
> 
> Sorry about that, it was because the original patch only hit in
> drivers/of/*.
> 
> I will send you a copy of the thread.

Thanks.

>From the original patch description:
> commit a5516219b102 ("of/platform: Initialise default DMA masks")
> sets up the coherent_dma_mask of platform devices created
> from the device tree, but fails to do the same for AMBA
> (PrimeCell) devices.
> 
> This leads to a regression in kernel v4.19-rc1 triggering the
> WARN_ONCE() in kernel/dma/coherent.c, dma_alloc_attrs()
> WARN_ON_ONCE(dev && !dev->coherent_dma_mask):

This description is very misleading.  It makes it sound like commit
a5516219b102 caused the problem.  Maybe someone would like to explain
how that can be the case - this commit just touches the DT platform
device code, and thus can not itself cause this regression.

Second reason it is misleading is that it claims that there is a
regression in 4.19-rc1 with a WARN in kernel/dma/coherent.c.
Looking at Linus' tip, kernel/dma/coherent.c does not contain any
WARNings except for one to do with dma_reserved_default_memory.
Looking at the history of that file in Linus' tree, there is only
one commit which touches this file, and that is Christoph's commit
which creates it.

So, this patch description needs much improvement, and AFAICS there
is no regression in Linus' kernel.  There may be a regression in
-next, but that is not as urgent as if it were in Linus' tree - iow,
we have time to fix this properly.


Now, from the AMBA perspective, we do not want every AMBA device to
appear to be DMA capable - we only want the ones which are to be so.

>From the backtrace, it seems to be a PL111 causing the issue - this
device has an AXI bus interface as well as an APB bus interface, so
is one of the few that are capable of DMA.  It's only restriction
is that it is limited to 32 bits of DMA address, and it doesn't care
about Linux's distinction between coherent and streaming DMA.

So, I'd suggest that we arrange for the DT code to setup the DMA mask
for the device only if it has an appropriate property (dma-ranges?),
and we don't need to re-introduce the separate mask for coherent DMA.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
