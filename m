From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC 01/10] iommu: Add IOMMU device registry
Date: Sun, 6 Jul 2014 20:17:22 +0200
Message-ID: <201407062017.23049.arnd@arndb.de>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<20140704134709.GA4203@ulmo> <20140704134928.GA25714@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140704134928.GA25714-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Friday 04 July 2014, Will Deacon wrote:
> On Fri, Jul 04, 2014 at 02:47:10PM +0100, Thierry Reding wrote:
> > On Fri, Jul 04, 2014 at 01:05:30PM +0200, Joerg Roedel wrote:
> > > On Thu, Jun 26, 2014 at 10:49:41PM +0200, Thierry Reding wrote:
> > > > Add an IOMMU device registry for drivers to register with and implement
> > > > a method for users of the IOMMU API to attach to an IOMMU device. This
> > > > allows to support deferred probing and gives the IOMMU API a convenient
> > > > hook to perform early initialization of a device if necessary.
> > > 
> > > Can you elaborate on why exactly you need this? The IOMMU-API is
> > > designed to hide any details from the user about the available IOMMUs in
> > > the system and which IOMMU handles which device. This looks like it is
> > > going in a completly different direction from that.
> > 
> > I need this primarily to properly serialize device probing order.
> > Without it the IOMMU may be probed later than its clients, in which case
> > the client drivers will assume that there is no IOMMU (iommu_present()
> > for the parent bus fails).
> 
> I can also vouch for needing a solution to this problem. The ARM SMMU (and
> I think others) rely on initcall ordering rather than the driver probing
> model to ensure the IOMMU is probed before any of its masters.

I think it would be best to attach platform devices to IOMMUs from the
of_dma_configure() we just introduced. That still requires handling
IOMMUs special though, and I don't know how we should best deal
with that. It would not be too hard to scan for IOMMUs in DT first
and register them all in a way that we can later look them up
by phandle, but that would break down if we ever get nested IOMMUs.

Another possibility might be to register all devices as we do today,
including IOMMU devices, but return -EPROBE_DEFER from
platform_drv_probe() before we call into the driver's probe function
if the IOMMU has not been set up at that point.

For PCI devices, we need a different way of dealing with the IOMMUs,
some generic PCI code needs to be added to attach the correct IOMMU
to a newly added PCI device based on how the host bridge is configured.

We can probably for now get away with not worrying about any bus type
other than platform, amba or PCI: we don't use any other DMA master
capable bus on ARM, and other architectures can probably rely on
having only a single IOMMU implementation in the system.

	Arnd
