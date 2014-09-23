From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH v3 6/7] arm: call iommu_init before
	of_platform_populate
Date: Tue, 23 Sep 2014 09:44:25 +0200
Message-ID: <3765297.6j3Rv68iqn@wuerfel>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<3261451.zpO6MVx5yo@wuerfel> <20140923070238.GH30514@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140923070238.GH30514@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tuesday 23 September 2014 09:02:39 Thierry Reding wrote:

> > I see two problems with using deferred probing here: 
> > 
> > - we don't actually need to defer the probing but the binding to the driver
> >   when no dma ops are set, but it seems silly to even create the device
> >   before we can find out which ops it should use.
> 
> What does device creation have to do with anything? Surely a device
> won't need IOMMU services before the device is bound to a driver.

The problem is that the driver will start using the IOMMU as soon
as it calls dma_map_*, but that happens at runtime, not necessarily
during the probe function.

So we can get into the weird situation that probe() returns success,
but then you can't use the device yet because you don't know whether
it is supposed to use an IOMMU or not.

> >   The reason is that a driver does not actively ask for an IOMMU as it would
> >   for other subsystems (gpio, led, dmaengine, ...).
> 
> Actually it does. At least in some cases. If you want to use the IOMMU
> API directly you'd call something like iommu_present() on the bus type
> and then allocate an IOMMU domain and attach to it. Unfortunately the
> API seems to have been designed under the assumption that IOMMU will
> have been registered before any users, so the API doesn't propagate any
> meaningful errors.

That's just a special case that does not even work as it should yet,
please don't confuse the matter more by talking about drivers that
use the IOMMU API explicitly, this series has very little to do with
that.

> Also, even if in other cases the drivers don't actively ask for an IOMMU
> that doesn't mean that they couldn't be made to. For drivers that use
> the DMA/IOMMU integration layer this is probably not practicable, but
> there is no reason the core couldn't do it.

We intentionally have an abstraction that is meant to let you write drivers
without knowing about iommu, swiotlb or coherency, these are all hidden
behind the dma_map_ops implementation.


	Arnd
