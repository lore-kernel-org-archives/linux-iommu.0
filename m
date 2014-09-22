From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH v3 6/7] arm: call iommu_init before
	of_platform_populate
Date: Mon, 22 Sep 2014 18:03:47 +0200
Message-ID: <3261451.zpO6MVx5yo@wuerfel>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<11868654.D6MinQlF2p@wuerfel> <20140922114039.GT1470@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140922114039.GT1470@ulmo>
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

On Monday 22 September 2014 13:40:40 Thierry Reding wrote:
> On Mon, Sep 22, 2014 at 01:08:27PM +0200, Arnd Bergmann wrote:
> > On Monday 22 September 2014 11:36:15 Thierry Reding wrote:
> > > On Fri, Sep 12, 2014 at 05:34:54PM +0100, Will Deacon wrote:
> > > > We need to ensure that the IOMMUs in the system have a chance to perform
> > > > some basic initialisation before we start adding masters to them.
> > > > 
> > > > This patch adds a call to of_iommu_init before of_platform_populate.
> > > 
> > > Why can't you call it from of_platform_populate() directly? That way it
> > > would be usable for all architectures rather than just ARM. Eventually
> > > we're going to need the same thing for 64-bit ARM (and possibly others
> > > as well).
> > 
> > IIRC, of_platform_populate can be called multiple times, even recursively
> > be drivers that populate their own child devices.
> 
> Indeed. Perhaps it could be conditionally called when root == NULL. But
> perhaps that's not safe either. Anyway, I still think we shouldn't be
> making this some randomly placed early initcall anyway.

I disagree. IOMMUs are special in the same sense that irqchips, clocks and
timers are. This is not just a random call, it is being explicit about a
base functionality that is needed for all devices attached to it.

While we pretend that these are just device drivers in some sense, I think
it's perfectly reasonable to have an explicit entry point for each subsystem
here.

I see two problems with using deferred probing here: 

- we don't actually need to defer the probing but the binding to the driver
  when no dma ops are set, but it seems silly to even create the device
  before we can find out which ops it should use.
  The reason is that a driver does not actively ask for an IOMMU as it would
  for other subsystems (gpio, led, dmaengine, ...).

- As long as the dma_ops are not set, we can't actually call probe() for
  any device other than iommus, and even that would require adding special
  magic in the platform_device_probe(), so we'd just defer every device
  until we get to the iommu. This likely causes a lot of overhead at probe
  time.

	Arnd
