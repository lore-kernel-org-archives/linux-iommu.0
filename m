From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops into
	arch_setup_dma_ops
Date: Tue, 20 Jan 2015 18:41:32 +0200
Message-ID: <1824276.v3FzABiMyQ@avalon>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<5043167.LEiljZnGai@avalon> <3782946.UYvzT31Xfc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3782946.UYvzT31Xfc@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Arnd,

On Monday 19 January 2015 17:13:14 Arnd Bergmann wrote:
> On Sunday 18 January 2015 13:18:51 Laurent Pinchart wrote:
> > On Sunday 18 January 2015 15:54:34 Alexandre Courbot wrote:
> >> On 01/16/2015 08:18 AM, Laurent Pinchart wrote:
> >>> On Thursday 15 January 2015 11:12:17 Will Deacon wrote:
> >>>> On Thu, Jan 15, 2015 at 08:28:44AM +0000, Thierry Reding wrote:
> >>>>> This has several advantages, such as that I can also use the regular
> >>>>> driver model for suspend/resume of the IOMMU, and I get to enjoy the
> >>>>> benefits of devres in the IOMMU driver. Probe ordering is still a
> >>>>> tiny issue, but we can easily solve that using explicit initcall
> >>>>> ordering (which really isn't any worse than IOMMU_OF_DECLARE()).
> >>>> 
> >>>> That's a pity. I'd much rather extend what we currently have to
> >>>> satisfy your use-case. Ho-hum.
> >>> 
> >>> Assuming we want the IOMMU to be handled transparently for the
> >>> majority of devices I only see two ways to fix this,
> >>> 
> >>> The first way is to create a default DMA mapping unconditionally and
> >>> let drivers that can't live with it tear it down. That's what is
> >>> implemented today.
> >> 
> >> I strongly support Thierry's point that drivers should not have to tear
> >> down things they don't need. The issue we are facing today is a very
> >> good illustration of why one should not have to do this.
> >> 
> >> Everybody hates to receive unsollicited email with a link that says "to
> >> unsubscribe, click here". Let's not import that unpleasant culture into
> >> the kernel.
> >> 
> >> I am arriving late in this discussion, but what is wrong with asking
> >> drivers to explicitly state that they want the DMA API to be backed by
> >> the IOMMU instead of forcibly making it work that way?
> > 
> > The vast majority of the drivers are not IOMMU-aware. We would thus need
> > to add a call at the beginning of the probe function of nearly every
> > driver that can perform DMA to state that the driver doesn't need to
> > handle any IOMMU that might be present in the system itself. I don't think
> > that's a better solution.
>
> Right, abstracting the presence of an IOMMU (along with things like
> cache management) is the whole point for having the dma-mapping API.
> 
> The iommu driver should instead be able to make the decision on whether
> the device uses the iommu for DMA or not. In some cases, it's not an
> option because the iommu is mandatory for all DMA and there is no working
> passthrough mode. In other cases, it depends on the dma mask: as long as
> the device's dma_mask covers all of RAM, we can avoid using the IOMMU
> and get better performance (and also avoid setting up tables that may
> need to be removed again), but when the dma mask is too small, we have
> to use the iommu or fall back to swiotlb (which is currently not implemeted
> on arm32).
> 
> >>> we can't signal this by calling a function in probe(). A new flag
> >>> field for struct device_driver is a possible solution. This would
> >>> however require delaying the creation of DMA mappings until right
> >>> before probe time. Attaching to the IOMMU could be pushed to right
> >>> before probe() as well, which would have the added benefit of making
> >>> IOMMU driver implementable as real platform drivers.
> >> 
> >> Keeping the ability to write IOMMU drivers as platform drivers would be
> >> nice indeed.
> >> 
> >> The problem with the opt-out flag though is that one will need to check
> >> every single driver out there to see whether it stills behave correctly
> >> if its hardware is suddently put behind a IOMMU.
> > 
> > That's actually my default assumption :-) On ARM platforms at least, for
> > many devices, whether an IOMMU is present or not is an integration
> > property, not a property of the device. The same way a device shouldn't
> > care about the exact bus topology that connects it to the CPU and memory,
> > it shouldn't care about whether an IOMMU is present on that bus, except
> > in special cases.
> 
> Agreed. This must work by default, or basically all arm64 machines are
> broken. At the moment, arm64 does not support IOMMUs properly and uses
> uses swiotlb instead, but it's a huge performance bottleneck. On arm32,
> very few systems need an IOMMU at the moment, but it's getting more common.
> 
> >> Doing it the other way (a flag that enables IOMMU if available) sounds
> >> safer to me.
> >> 
> >> What we have right now is a mechanism that basically makes it impossible
> >> to use the DMA API on many ARM platforms if ARM_DMA_USE_IOMMU is set
> >> (and I suspect it would also make the IOMMU unusable as well, without
> >> any way to fix things). This is quite concerning.
> >> 
> >> Even more concerning is that -rc5 is about to be released and we have
> >> in-tree drivers (Rockchip DRM) that are not working as they should
> >> because of this patch. Will, what is your plan to fix this? Do we have
> >> stuff that absolutely depends on this patch? If not, can we just revert
> >> it until all these issues are solved?
> 
> keystone, shmobile, mvebu and highbank all have PCI buses that are unable
> to access all of RAM, with different kinds of hacks to work around that.

But Will's series doesn't fix that, does it ? 

-- 
Regards,

Laurent Pinchart
