From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 3/6] of: fix size when dma-range is not used
Date: Wed, 28 Jan 2015 17:30:48 +0000
Message-ID: <20150128173048.GE31752@e104818-lin.cambridge.arm.com>
References: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com>
	<1422052359-12384-4-git-send-email-m-karicheri2@ti.com>
	<54C77616.80301@arm.com> <54C7DF13.20402@ti.com>
	<20150128110523.GC6646@e104818-lin.cambridge.arm.com>
	<54C9068D.8050701@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54C9068D.8050701-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 28, 2015 at 03:55:57PM +0000, Robin Murphy wrote:
> On 28/01/15 11:05, Catalin Marinas wrote:
> > On Tue, Jan 27, 2015 at 06:55:15PM +0000, Murali Karicheri wrote:
> >> How about having the logic like this?
> >>
> >> 	ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> >> 	if (ret < 0) {
> >> 		dma_addr = offset = 0;
> >> 		size = dev->coherent_dma_mask + 1;
> >> 	} else {
> >> 		offset = PFN_DOWN(paddr - dma_addr);
> >> 		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
> >> 	}
> >>
> >> 	if (is_power_of_2(size + 1))
> >> 		size = size + 1;
> >> 	else if (!is_power_of_2(size))
> >> 	{
> >> 		dev_err(dev, "invalid size\n");
> >> 		return;
> >> 	}
> >
> > In of_dma_configure(), we currently assume that the default coherent
> > mask is 32-bit. In this thread:
> >
> > http://article.gmane.org/gmane.linux.kernel/1835096
> >
> > we talked about setting the coherent mask based on size automatically.
> > I'm not sure about the size but I think we can assume is 32-bit mask + 1
> > if it is not specified in the DT. Instead of just assuming a default
> > mask, let's assume a default size and create the mask based on this
> > (untested):
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 5b33c6a21807..9ff8d1286b44 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -170,10 +170,10 @@ static void of_dma_configure(struct device *dev)
> >   	struct iommu_ops *iommu;
> >
> >   	/*
> > -	 * Set default dma-mask to 32 bit. Drivers are expected to setup
> > -	 * the correct supported dma_mask.
> > +	 * Set default size to cover the 32-bit. Drivers are expected to setup
> > +	 * the correct size and dma_mask.
> >   	 */
> > -	dev->coherent_dma_mask = DMA_BIT_MASK(32);
> > +	size = 1ULL << 32;
> >
> >   	/*
> >   	 * Set it to coherent_dma_mask by default if the architecture
> > @@ -185,13 +185,24 @@ static void of_dma_configure(struct device *dev)
> >   	ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
> >   	if (ret < 0) {
> >   		dma_addr = offset = 0;
> > -		size = dev->coherent_dma_mask;
> >   	} else {
> >   		offset = PFN_DOWN(paddr - dma_addr);
> >   		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", dev->dma_pfn_offset);
> >   	}
> >   	dev->dma_pfn_offset = offset;
> >
> > +	/*
> > +	 * Workaround for DTs setting the size to a mask or 0.
> > +	 */
> > +	if (is_power_of_2(size + 1))
> > +		size += 1;
> 
> In fact, since the ilog2 below ends up effectively rounding down, we 
> might as well do away with this check as well and just add 1 
> unconditionally. The only time it makes any difference is when we want 
> it to anyway!

Well, we could simply ignore the is_power_of_2() check but without
incrementing size as we don't know what arch_setup_dma_ops() does with
it.

I think we can remove this check altogether (we leaved without it for a
while) but we need to add 1 when calculating the mask:

	dev->coherent_dma_mask = min(DMA_BIT_MASK(32),
				     DMA_BIT_MASK(ilog2(size + 1)));

-- 
Catalin
