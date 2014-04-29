From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Tue, 29 Apr 2014 22:46:18 +0200
Message-ID: <6607258.MzzLbm2Afe@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<5242619.ZKgCdLW1L4@wuerfel>
	<20140429181601.GE3582@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140429181601.GE3582-M5GwZQ6tE7x5pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
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
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>ra
List-Id: iommu@lists.linux-foundation.org

On Tuesday 29 April 2014 19:16:02 Dave Martin wrote:
> On Mon, Apr 28, 2014 at 09:55:00PM +0200, Arnd Bergmann wrote:
> > On Monday 28 April 2014 20:30:56 Will Deacon wrote:
> >
> > > > 	device@4 {
> > > > 		compatible = "some,ethernet";
> > > > 		iommus = <&/iommu@1>;
> > > > 	};
> > > > 
> > > > 	device@5 {
> > > > 		compatible = "some,dmaengine";
> > > > 		iommus = <&/iommu@2 0x40000000 0x1000000>,
> > > > 			 <&/iommu@3 0x101>;
> > > > 	};
> > > > 
> > > > The device at address 4 has a one-one relationship with iommu@1, so there
> > > > is no need for any data. device@5 has two master ports. One is connected to
> > > > an IOMMU that has a per-device aperture, device@5 can only issue transfers
> > > > to the 256MB area at 0x40000000, and the IOMMU will have to put entries for
> > > > this device into that address. The second master port is connected to
> > > > iommu@3, which uses a master ID that gets passed along with each transfer,
> > > > so that needs to be put into the IOTLBs.
> > > 
> > > I think this is definitely going in the right direction, but it's not clear
> > > to me how the driver for device@5 knows how to configure the two ports.
> > > We're still lacking topology information (unless that's implicit in the
> > > ordering of the properties) to say how the mastering capabilities of the
> > > device are actually routed and configured.
> > 
> > It would be helpful to have a concrete example of a device that has multiple
> > masters. I have heard people mention this multiple times, and I can understand
> 
> You mean "a device that contains multiple independent bus masters",
> right?  In particular, a device composed of multiple bus masters that
> do different things or should be handled differently by the interconnect.

Right.

> There has definitely been talk on the list about real devices that
> use multiple stream IDs.
> 
> 
> I'll ask around for "device-like" examples, but the most obvious
> example is the IOMMU itself.
> 
> Transactions generated by the IOMMU clearly need to be handled
> differently by the interconnect, compared with transactions
> translated and forwarded by IOMMU on behalf of its clients.
> 
> For example, suppose devices can post MSIs to an interrupt controller
> via a mailbox accessed through the IOMMU.  Suppose also that the IOMMU
> generates MSIs itself in order to signal management events or faults
> to a host OS.  Linux (as host) will need to configure the interrupt
> controller separately for the IOMMU and for the IOMMU clients.  This
> means that Linux needs to know which IDs may travel to the interrupt
> controller for which purpose, and they must be distinct.

I don't understand. An MSI controller is just an address that acts
as a DMA slave for a 4-byte inbound data packet. It has no way of
knowing who is sending data, other than by the address or the data
sent to it. Are you talking of something else?

> I'm not sure whether there is actually a SoC today that is MSI-capable
> and contains an IOMMU, but all the components to build one are out
> there today.  GICv3 is also explicitly designed to support such
> systems.

A lot of SoCs have MSI integrated into the PCI root complex, which
of course is pointless from MSI perspective, as well as implying that
the MSI won't go through the IOMMU.

We have briefly mentioned MSI in the review of the Samsung GH7 PCI
support. It's possible that this one can either use the built-in
MSI or the one in the GICv2m.

> In the future, it is likely that "HSA"-style GPUs and other high-
> throughput virtualisable bus mastering devices will have capabilities
> of this sort, but I don't think there's anything concrete yet.

Wouldn't they just have IOMMUs with multiple contexts?

> > how it might be wired up in hardware, but I don't know what it's good for,
> > or who would actually do it.
> > 
> > > > A variation would be to not use #iommu-cells at all, but provide a
> > > > #address-cells / #size-cells pair in the IOMMU, and have a translation
> > > > as we do for dma-ranges. This is probably most flexible.
> > > 
> > > That would also allow us to describe ranges of master IDs, which we need for
> > > things like PCI RCs on the ARM SMMU. Furthermore, basic transformations of
> > > these ranges could also be described like this, although I think Dave (CC'd)
> > > has some similar ideas in this area.
> 
> Ideally, we would reuse the ePAPR "ranges" concept and describe the way
> sideband ID signals propagate down the bus hierarchy in a similar way.

It would be 'dma-ranges'. Unfortunately that would imply that each DMA
master is connected to only one IOMMU, which you say is not necessarily
the case. The simpler case of a device is only a master on a single IOMMU
but can use multiple contexts would however work fine with dma-ranges.

	Arnd
