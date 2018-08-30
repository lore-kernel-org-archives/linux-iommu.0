From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH] of/platform: Initialise AMBA default DMA masks
Date: Thu, 30 Aug 2018 09:40:15 +0100
Message-ID: <20180830084014.GJ30658@n2100.armlinux.org.uk>
References: <20180828084442.30176-1-linus.walleij@linaro.org>
	<20180828092338.GA12488@lst.de>
	<CACRpkdbLOGE2TiNxnV+L9Y=9QJ9jt-tv4GjDB3iTpJFj_w-5SQ@mail.gmail.com>
	<20180828141413.GH30658@n2100.armlinux.org.uk>
	<20180829055521.GA28958@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180829055521.GA28958-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:DRM PANEL DRIVERS" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 29, 2018 at 07:55:21AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 28, 2018 at 03:14:14PM +0100, Russell King - ARM Linux wrote:
> > But yes, the fundamental fact is that AMBA devices don't have any
> > care about the differences between coherent and streaming DMA.  The
> > distinction that we make in the kernel is purely a software one when
> > it comes to these devices.
> > 
> > Most AMBA devices themselves are not DMA capable, as they are only
> > connected to the APB (Amba peripheral bus) and they rely on a
> > separate DMA engine for their DMA.  APB devices should not have DMA
> > masks - their DMA capabilities are entirely down to the DMA controller.
> > So, the majority of AMBA devices should not have any DMA masks.
> > 
> > Only those connected to a bus that they can master on (eg AXI) should
> > have DMA masks - things like the PL08x DMA controllers, PL11x LCD
> > controllers, etc.  As I've said above, there is no difference between
> > streaming and coherent DMA for these devices.
> 
> So for now I plan to apply the patch from Linus to just set a dma
> mask, as that gets back the previous behavior where dma did just
> work (as it did without a mask).

NAK on that at the moment.

> But if Linus, you or someone else familiar with amba would like to
> add an explicit opt-in into dma support eventually that would be
> even better.

Well, as I've no idea what the issue is here, I can't do anything or
make any suggestions.  I wasn't copied on the initial part of the
thread.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
