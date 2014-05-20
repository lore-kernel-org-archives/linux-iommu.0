From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Tue, 20 May 2014 14:41:18 +0200
Message-ID: <8663464.40PHEumOar@wuerfel>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<10711669.TTjp9L4tTG@wuerfel> <20140520120242.GA20995@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140520120242.GA20995@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
> On Tue, May 20, 2014 at 01:15:48PM +0200, Arnd Bergmann wrote:
> > On Tuesday 20 May 2014 13:05:37 Thierry Reding wrote:
> > > On Tue, May 20, 2014 at 12:04:54PM +0200, Arnd Bergmann wrote:
> > > > On Monday 19 May 2014 22:59:46 Thierry Reding wrote:
> > > > > On Mon, May 19, 2014 at 08:34:07PM +0200, Arnd Bergmann wrote:
> [...]
> > > > > > You should never need #size-cells > #address-cells
> > > > > 
> > > > > That was always my impression as well. But how then do you represent the
> > > > > full 4 GiB address space in a 32-bit system? It starts at 0 and ends at
> > > > > 4 GiB - 1, which makes it 4 GiB large. That's:
> > > > > 
> > > > > 	<0 1 0>
> > > > > 
> > > > > With #address-cells = <1> and #size-cells = <1> the best you can do is:
> > > > > 
> > > > > 	<0 0xffffffff>
> > > > > 
> > > > > but that's not accurate.
> > > > 
> > > > I think we've done both in the past, either extended #size-cells or
> > > > taken 0xffffffff as a special token. Note that in your example,
> > > > the iommu actually needs #address-cells = <2> anyway.
> > > 
> > > But it needs #address-cells = <2> only to encode an ID in addition to
> > > the address. If this was a single-master IOMMU then there'd be no need
> > > for the ID.
> > 
> > Right. But for a single-master IOMMU, there is no need to specify
> > any additional data, it could have #address-cells=<0> if we take the
> > optimization you suggested.
> 
> Couldn't a single-master IOMMU be windowed?

Ah, yes. That would actually be like an IBM pSeries, which has a windowed
IOMMU but uses one window per virtual machine. In that case, the window could
be a property of the iommu node though, rather than part of the address
in the link.

> > > > The main advantage I think would be for IOMMUs that use the PCI b/d/f
> > > > numbers as IDs. These can have #address-cells=<3>, #size-cells=<2>
> > > > and have an empty dma-ranges property in the PCI host bridge node,
> > > > and interpret this as using the same encoding as the PCI BARs in
> > > > the ranges property.
> > > 
> > > I'm somewhat confused here, since you said earlier:
> > > 
> > > > After giving the ranges stuff some more thought, I have come to the
> > > > conclusion that using #iommu-cells should work fine for almost
> > > > all cases, including windowed iommus, because the window is not
> > > > actually needed in the device, but only in the iommu, wihch is of course
> > > > free to interpret the arguments as addresses.
> > > 
> > > But now you seem to be saying that we should still be using the
> > > #address-cells and #size-cells properties in the IOMMU node to determine
> > > the length of the specifier.
> > 
> > I probably wasn't clear. I think we can make it work either way, but
> > my feeling is that using #address-cells/#size-cells gives us a nicer
> > syntax for the more complex cases.
> 
> Okay, so in summary we'd have something like this for simple cases:
> 
> Required properties:
> --------------------
> - #address-cells: The number of cells in an IOMMU specifier needed to encode
>   an address.
> - #size-cells: The number of cells in an IOMMU specifier needed to represent
>   the length of an address range.
> 
> Typical values for the above include:
> - #address-cells = <0>, size-cells = <0>: Single master IOMMU devices are not
>   configurable and therefore no additional information needs to be encoded in
>   the specifier. This may also apply to multiple master IOMMU devices that do
>   not allow the association of masters to be configured.
> - #address-cells = <1>, size-cells = <0>: Multiple master IOMMU devices may
>   need to be configured in order to enable translation for a given master. In
>   such cases the single address cell corresponds to the master device's ID.
> - #address-cells = <2>, size-cells = <2>: Some IOMMU devices allow the DMA
>   window for masters to be configured. The first cell of the address in this
>   may contain the master device's ID for example, while the second cell could
>   contain the start of the DMA window for the given device. The length of the
>   DMA window is specified by two additional cells.
> 
> Examples:
> =========
> 
> Single-master IOMMU:
> --------------------
> 
> 	iommu {
> 		#address-cells = <0>;
> 		#size-cells = <0>;
> 	};
> 
> 	master {
> 		iommus = <&/iommu>;
> 	};
> 
> Multiple-master IOMMU with fixed associations:
> ----------------------------------------------
> 
> 	/* multiple-master IOMMU */
> 	iommu {
> 		/*
> 		 * Masters are statically associated with this IOMMU and
> 		 * address translation is always enabled.
> 		 */
> 		#iommu-cells = <0>;
> 	};

copied wrong? I guess you mean #address-cells=<0>/#size-cells=<0> here.

> 	/* static association with IOMMU */
> 	master@1 {
> 		reg = <1>;
> 		iommus = <&/iommu>;
> 	};
> 
> 	/* static association with IOMMU */
> 	master@2 {
> 		reg = <2>;
> 		iommus = <&/iommu>;
> 	};
> 
> Multiple-master IOMMU:
> ----------------------
> 
> 	iommu {
> 		/* the specifier represents the ID of the master */
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 	};
> 
> 	master {
> 		/* device has master ID 42 in the IOMMU */
> 		iommus = <&/iommu 42>;
> 	};
> 
> Multiple-master device:
> -----------------------
> 
> 	/* single-master IOMMU */
> 	iommu@1 {
> 		reg = <1>;
> 		#address-cells = <0>;
> 		#size-cells = <0>;
> 	};
> 
> 	/* multiple-master IOMMU */
> 	iommu@2 {
> 		reg = <2>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 	};
> 
> 	/* device with two master interfaces */
> 	master {
> 		iommus = <&/iommu@1>,    /* master of the single-master IOMMU */
> 			 <&/iommu@2 42>; /* ID 42 in multiple-master IOMMU */
> 	};
> 
> Multiple-master IOMMU with configurable DMA window:
> ---------------------------------------------------
> 
> 	/ {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 
> 		iommu {
> 			/* master ID, address of DMA window */
> 			#address-cells = <2>;
> 			#size-cells = <2>;
> 		};
> 
> 		master {
> 			/* master ID 42, 4 GiB DMA window starting at 0 */
> 			iommus = <&/iommu  42 0  0x1 0x0>;
> 		};
> 	};
> 
> Does that sound about right?

Yes, sounds great. I would probably leave out the Multiple-master device
from the examples, since that seems to be a rather obscure case.

I would like to add an explanation about dma-ranges to the binding:

8<--------
The parent bus of the iommu must have a valid "dma-ranges" property
describing how the physical address space of the IOMMU maps into
memory.
A device with an "iommus" property will ignore the "dma-ranges" property
of the parent node and rely on the IOMMU for translation instead.
Using an "iommus" property in bus device nodes with "dma-ranges"
specifying how child devices relate to the IOMMU is a possible extension
but is not recommended until this binding gets extended.
----------->8

Does that make sense to you? We can change what we say about
dma-ranges, I mainly want to be clear with what is or is not
allowed at this point.

	Arnd
