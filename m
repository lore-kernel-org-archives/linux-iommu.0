From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 17 Jun 2014 11:21:43 +0000
Message-ID: <32165315f0b84be9948f489fd87bf6a9@BL2PR03MB468.namprd03.prod.outlook.com>
References: <5288123.eXagyPAxNq@wuerfel>
	<20140602104104.GD3855@e103592.cambridge.arm.com>
	<20140604143509.GF28484@ulmo> <20140604164132.GF6644@arm.com>
	<07321368d15d4ad9928ebb83af87e401@DM2PR03MB479.namprd03.prod.outlook.com>
	<20140616152739.GS16758@arm.com>
	<8b0492b4697943a0b1f276ef42cc8223@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140616170416.GA16758@arm.com>
	<419e67f783524d208ab3be16bcd94bd9@DM2PR03MB352.namprd03.prod.outlook.com>
	<0587e1f4894546398be0798d2bc2c84f@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140617104304.GD13808@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140617104304.GD13808-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Will Deacon
> Sent: Tuesday, June 17, 2014 4:13 PM
> To: Sethi Varun-B16395
> Cc: Mark Rutland; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-samsung-
> soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Arnd Bergmann; Pawel Moll; Ian Campbell; Grant
> Grundler; Stephen Warren; Yoder Stuart-B08248; Rob Herring; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Marc Zyngier; Linux IOMMU; Thierry Reding; Kumar
> Gala; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Cho KyongHo; Dave P Martin; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree
> bindings
> 
> On Tue, Jun 17, 2014 at 11:26:48AM +0100, Varun Sethi wrote:
> > > The way we generally thought it would work was something like
> > > this:
> > >    -u-boot/bootloader makes any static streamID allocation if needed,
> > >     sets a default streamID  (e.g. 0x0) in device and expresses
> > >     that in the device tree
> > >    -device tree would express relationship between devices
> > >     (including bus controllers) and the SMMU through mmu-masters
> > >     property
> > >    -u-boot would express the range of unused (or used) streamIDs via
> > > a new
> > >     device tree property so the kernel SMMU driver knows what
> > > streamIDs are
> > >     free
> > >    -in the SMMU driver a different vendor specific 'add_device'
> callback
> > >     could be used to handle our special cases where we need to
> set/change
> > >     the stream ID for devices added to a domain
> >
> > Another possibility, could be to program the stream Id in the device
> > registers (reference for the stream ID register can be obtained from
> > the device tree) during device attach. This could be relevant in case
> > of VFIO, when we are assigning multiple devices to a single VM. All
> > the devices can share the same stream ID.
> 
> I think for simple masters (i.e. those that have all their StreamIDs
> under control of one driver), then setting something during attach (or
> add?) based on the DT could work pretty well. The other case is when we
> have masters behind a bridge (such as a PCI RC). In this case, it might
> actually be better to ask the bridge for the IDs and let it sort out the
> allocation itself. That would also move the RequesterID -> StreamID
> mapping out of the SMMU code.
> 
> What do you think?
The PCI bus iommu group creation code would be part of the SMMU driver (it is handled by other IOMMU drivers as well). My understanding is that there would be one is to one correspondence between the requestor ID and the iommu group. May be, we can have an API provided by the PCI bridge (architecture specific) for setting the stream ID.

-Varun
