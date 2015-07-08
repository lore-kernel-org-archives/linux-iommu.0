From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Master-aware devices and sideband ID data
Date: Wed, 8 Jul 2015 14:30:50 +0100
Message-ID: <20150708133049.GD7025@leverpostej>
References: <20150324155007.GC23005@leverpostej>
	<26BE36EF-2C5B-4DA6-8950-8FEBB031ED1B@caviumnetworks.com>
	<20150527173953.GC23176@leverpostej>
	<E342D737-5DD5-48C7-BB01-B83C29CB6E31@caviumnetworks.com>
	<20150601102208.GD22406@leverpostej>
	<158EFC9F-FCAF-44D3-AD40-804EDFE0CE25@caviumnetworks.com>
	<20150605090534.GC1198@arm.com>
	<20150609101515.GA28474@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150609101515.GA28474@leverpostej>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 09, 2015 at 11:17:54AM +0100, Mark Rutland wrote:
> On Fri, Jun 05, 2015 at 10:05:34AM +0100, Will Deacon wrote:
> > On Thu, Jun 04, 2015 at 11:19:30PM +0100, Chalamarla, Tirumalesh wrote:
> > > > On Jun 1, 2015, at 3:22 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> > > > It's possible to specify that the paths exist. I expect that software
> > > > would select which to use at runtime.
> > > > 
> > > My worry is how to define any priorities/preferences between masters. 
> > > in general the proposal looks reasonable.
> > 
> > I agree that the proposal looks reasonable (in terms of the ability to
> > describe the sort of topologies that we will face) but I still don't
> > understand what I need to do in e.g. my IOMMU driver to support this
> > binding whilst continuing to support the existing iommus binding, which
> > is relied upon to configure dma-mapping.
> > 
> > Mark: how do you see this co-existing/merging with the current bindings?
> 
> As I mentioned in my initial mail, it's not clear to me how this can be
> reconciled with the current bindings. Everything I've been able to come
> up with so far at best ends up describing the same thing repeatedly.
> 
> I'll see what I can come up with. Any sugestions are welcome!

I can't see a way of keeping the ID transformations explicit with the
existing bindings, but I think we can simply fold these down into
properties in the master nodes, given we expect each ID to be derived
from some initial master ID anyway.

So, to cater for the ITS we would need to pass master IDs along with the
MSI parent information, which we could do by extending msi-parent or by
introducing a new msis property which behaves similarly to the iommus
property, describing the MSI controllers the device can address (via any
IOMMUs), along with any controller-specific identification data.

Which means we'd have DT fragments like the following for an arbitrary
platform device:

its0: its {
	...
	msi-controller;
	#msi-cells = <1>; // DeviceId
};

its1: its {
	...
	msi-controller;
	#msi-cells = <1>; // DeviceId
};

smmu: smmu {
	...
	iommu-cells = <1>; // StreamId
};

device {
	...
	iommus = <&its 0>;
	/* Can use either ITS, but has a different ID at each */
	msis = <&its0 0x0>, <&its1 0x400>;
};

That doesn't allow you to describe a device with multiple mater ports
where each master port might want to generate MSIs, but I'm not sure if
that's a real case.

For PCIe root complexes, we'd need to describe the BDF -> iommu-cells
and BDF -> msi-cells translations separately with new properties on the
node for the root complex itself.

Is there anything obviously broken with the above approach?

Thanks,
Mark.
