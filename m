From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Mon, 28 Apr 2014 21:55 +0200
Message-ID: <5242619.ZKgCdLW1L4@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<4780885.JaktFvJeC7@wuerfel> <20140428193056.GD22135@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140428193056.GD22135-5wv7dgnIgG8@public.gmane.org>
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
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, msung.com-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, dave.martin-5wv7dgnIgG8@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel
List-Id: iommu@lists.linux-foundation.org

On Monday 28 April 2014 20:30:56 Will Deacon wrote:
> Hi Arnd,
> 
> [and thanks Thierry for CCing me -- I have been tangled up with this before
> :)]
> 
> On Mon, Apr 28, 2014 at 01:05:30PM +0100, Arnd Bergmann wrote:
> > On Monday 28 April 2014 13:18:03 Thierry Reding wrote:
> > > There still has to be one cell to specify which master. Unless perhaps
> > > if they can be arbitrarily assigned. I guess even if there's a fixed
> > > mapping that applies to one SoC generation, it might be good to still
> > > employ a specifier and have the mapping in DT for flexibility.
> > 
> > let me clarify by example:
> > 
> > 	iommu@1 {
> > 		compatible = "some,simple-iommu";
> > 		reg = <1>;
> > 		#iommu-cells = <0>; /* supports only one master */
> > 	};
> > 
> > 	iommu@2 {
> > 		compatible = "some,other-iommu";
> > 		reg = <3>;
> > 		#iommu-cells = <1>; /* contains master ID */
> > 	};
> > 
> > 	iommu@3 {
> > 		compatible = "some,windowed-iommu";
> > 		reg = <2>;
> > 		#iommu-cells = <2>; /* contains dma-window */
> > 	};
> > 
> > 	device@4 {
> > 		compatible = "some,ethernet";
> > 		iommus = <&/iommu@1>;
> > 	};
> > 
> > 	device@5 {
> > 		compatible = "some,dmaengine";
> > 		iommus = <&/iommu@2 0x40000000 0x1000000>,
> > 			 <&/iommu@3 0x101>;
> > 	};
> > 
> > The device at address 4 has a one-one relationship with iommu@1, so there
> > is no need for any data. device@5 has two master ports. One is connected to
> > an IOMMU that has a per-device aperture, device@5 can only issue transfers
> > to the 256MB area at 0x40000000, and the IOMMU will have to put entries for
> > this device into that address. The second master port is connected to
> > iommu@3, which uses a master ID that gets passed along with each transfer,
> > so that needs to be put into the IOTLBs.
> 
> I think this is definitely going in the right direction, but it's not clear
> to me how the driver for device@5 knows how to configure the two ports.
> We're still lacking topology information (unless that's implicit in the
> ordering of the properties) to say how the mastering capabilities of the
> device are actually routed and configured.

It would be helpful to have a concrete example of a device that has multiple
masters. I have heard people mention this multiple times, and I can understand
how it might be wired up in hardware, but I don't know what it's good for,
or who would actually do it.

> > A variation would be to not use #iommu-cells at all, but provide a
> > #address-cells / #size-cells pair in the IOMMU, and have a translation
> > as we do for dma-ranges. This is probably most flexible.
> 
> That would also allow us to describe ranges of master IDs, which we need for
> things like PCI RCs on the ARM SMMU. Furthermore, basic transformations of
> these ranges could also be described like this, although I think Dave (CC'd)
> has some similar ideas in this area.

Good point.

	ARnd
