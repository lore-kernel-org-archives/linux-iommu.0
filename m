From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 17 Jun 2014 10:26:48 +0000
Message-ID: <0587e1f4894546398be0798d2bc2c84f@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1400877218-4113-1-git-send-email-thierry.reding@gmail.com>
	<4545972.cM7IP1qTXQ@wuerfel>
	<CAL_Jsq+tkFNpjSEZboT+o69B_Z3a8e-ZVKaYDmLwtkyYoPy6VQ@mail.gmail.com>
	<5288123.eXagyPAxNq@wuerfel>
	<20140602104104.GD3855@e103592.cambridge.arm.com>
	<20140604143509.GF28484@ulmo> <20140604164132.GF6644@arm.com>
	<07321368d15d4ad9928ebb83af87e401@DM2PR03MB479.namprd03.prod.outlook.com>
	<20140616152739.GS16758@arm.com>
	<8b0492b4697943a0b1f276ef42cc8223@DM2PR03MB352.namprd03.prod.outlook.com>
	<20140616170416.GA16758@arm.com>
	<419e67f783524d208ab3be16bcd94bd9@DM2PR03MB352.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <419e67f783524d208ab3be16bcd94bd9-ufbTtyGzTTT8GZusEWM6WuO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
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
To: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Tuesday, June 17, 2014 12:24 AM
> To: Will Deacon
> Cc: Sethi Varun-B16395; Thierry Reding; Mark Rutland;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Pawel
> Moll; Arnd Bergmann; Ian Campbell; Grant Grundler; Stephen Warren; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Marc Zyngier; Linux IOMMU; Rob Herring; Kumar
> Gala; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Cho KyongHo; Dave P Martin; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Subject: RE: [PATCH v2] devicetree: Add generic IOMMU device tree
> bindings
> 
> 
> 
> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org]
> > Sent: Monday, June 16, 2014 12:04 PM
> > To: Yoder Stuart-B08248
> > Cc: Sethi Varun-B16395; Thierry Reding; Mark Rutland;
> > devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Pawel
> > Moll; Arnd Bergmann; Ian Campbell; Grant Grundler; Stephen Warren;
> > linux- kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Marc Zyngier; Linux IOMMU; Rob Herring;
> > Kumar Gala; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Cho KyongHo; Dave P Martin;
> > linux-arm- kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree
> > bindings
> >
> > Hi Stuart,
> >
> > On Mon, Jun 16, 2014 at 05:56:32PM +0100, Stuart Yoder wrote:
> > > > Do you have use-cases where you really need to change these
> > > > mappings dynamically?
> > >
> > > Yes.  In the case of a PCI bus-- you may not know in advance how many
> > > PCI devices there are until you probe the bus.   We have another FSL
> > > proprietary bus we call the "fsl-mc" bus that is similar.
> >
> > For that case, though, you could still describe an algorithmic
> > transformation from RequesterID to StreamID which corresponds to a
> > fixed mapping.
> >
> > > Another thing to consider-- starting with SMMUv2, as you know, there
> > > is a new distributed architecture with multiple TBUs and a
> > > centralized TCU that walks the SMMU page tables.  So instead of
> > > sprinkling multiple SMMUs all over an SoC you now have the option a
> > > 1 central TCU and
> > sprinkling
> > > multiple TBUs around.   However, this means that the stream ID
> > namespace
> > > is now global and can be pretty limited.  In the SMMU implementation
> > > we have there are only 64 stream ID total for our Soc.  But we have
> > > many
> > more
> > > masters than that.
> > >
> > > So we look at stream IDs as really corresponding to an 'isolation
> > context'
> > > and not to a bus master.  An isolation context is the domain you are
> > > trying to isolate with the SMMU.  Devices that all belong to the
> > > same 'isolation context' can share the same stream ID, since they
> > > share the same domain and page tables.
> >
> > Ok, this is more compelling.
> >
> > > So, perhaps by default some/most SMMU masters may have a default
> > > stream
> > ID
> > > of 0x0 that is used by the host...and that could be represented
> > > statically in the device tree.
> > >
> > > But, we absolutely will need to dynamically set new stream IDs into
> > > masters when a new IOMMU 'domain' is created and devices
> > > are added to it.   All the devices in a domain will share
> > > the same stream ID.
> > >
> > > So whatever we do, let's please have an architecture flexible enough
> > > to allow for this.
> >
> > What is the software interface to the logic that assigns the StreamIDs?
> > Is
> > it part of the SMMU, or a separate device (or set of devices)?
> 
> For us at the hardware level there are a few different ways that the
> streamIDs can be set.  It is not part of the SMMU.  In the cases where
> there is simply
> 1 device to 1 streamID (e.g. USB controller) there is an SoC register
> where
> you just program the stream ID.   In the case of PCI, our PCI controller
> has a RequesterID-to-streamID table that you set via some PCI controller
> registers.
> 
> The way we generally thought it would work was something like
> this:
>    -u-boot/bootloader makes any static streamID allocation if needed,
>     sets a default streamID  (e.g. 0x0) in device and expresses
>     that in the device tree
>    -device tree would express relationship between devices
>     (including bus controllers) and the SMMU through mmu-masters
>     property
>    -u-boot would express the range of unused (or used) streamIDs via a
> new
>     device tree property so the kernel SMMU driver knows what streamIDs
> are
>     free
>    -in the SMMU driver a different vendor specific 'add_device' callback
>     could be used to handle our special cases where we need to set/change
>     the stream ID for devices added to a domain

Another possibility, could be to program the stream Id in the device registers (reference for the stream ID register can be obtained from the device tree) during device attach. This could be relevant in case of VFIO, when we are assigning multiple devices to a single VM. All the devices can share the same stream ID.

-Varun
