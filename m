From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
Date: Tue, 29 Apr 2014 19:16:02 +0100
Message-ID: <20140429181601.GE3582@e103592.cambridge.arm.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <4780885.JaktFvJeC7@wuerfel> <20140428193056.GD22135@arm.com>
 <5242619.ZKgCdLW1L4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <5242619.ZKgCdLW1L4@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "t.figa@samsung.com" <t.figa@samsung.com>, Will Deacon <will.deacon@arm.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "joshi@samsung.com" <joshi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "prathyush.k@samsung.com" <prathyush.k@samsung.com>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, "joro@8bytes.org" <joro@8bytes.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, "grundler@chromium.org" <grundler@chromium.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "a.motakis@virtualopensystems.com" <a.motakis@virtualopensystems.com>, "pullip.cho@samsung.com" <pullip.cho@samsung.com>, linux-arm-kernel@lists.i
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 28, 2014 at 09:55:00PM +0200, Arnd Bergmann wrote:
> On Monday 28 April 2014 20:30:56 Will Deacon wrote:
> > Hi Arnd,
> > 
> > [and thanks Thierry for CCing me -- I have been tangled up with this before
> > :)]
> > 
> > On Mon, Apr 28, 2014 at 01:05:30PM +0100, Arnd Bergmann wrote:
> > > On Monday 28 April 2014 13:18:03 Thierry Reding wrote:
> > > > There still has to be one cell to specify which master. Unless perhaps
> > > > if they can be arbitrarily assigned. I guess even if there's a fixed
> > > > mapping that applies to one SoC generation, it might be good to still
> > > > employ a specifier and have the mapping in DT for flexibility.
> > > 
> > > let me clarify by example:
> > > 
> > > 	iommu@1 {
> > > 		compatible = "some,simple-iommu";
> > > 		reg = <1>;
> > > 		#iommu-cells = <0>; /* supports only one master */
> > > 	};
> > > 
> > > 	iommu@2 {
> > > 		compatible = "some,other-iommu";
> > > 		reg = <3>;
> > > 		#iommu-cells = <1>; /* contains master ID */
> > > 	};
> > > 
> > > 	iommu@3 {
> > > 		compatible = "some,windowed-iommu";
> > > 		reg = <2>;
> > > 		#iommu-cells = <2>; /* contains dma-window */
> > > 	};

An IOMMU is really a specialised bridge, so it may be cleaner to describe
an IOMMU using a real bus node in the DT, if we also define a way to make
master/slave linkages explicit where it matters.


The problems of how to describe master/slave linkage, coherency between
masters, and how to describe sideband ID information present on the bus
are really interrelated.


If we can come up with a consistent description for these things, it
should help us to describe IOMMUs, bus mastering peripherals, MSI
controllers and complex bridges in a more uniform way, without having to
reinvent so much for each binding.  That's my hope anyway.

I've been hacking around some proposals on these areas which are a bit
different from the approach suggested here -- I'll try to summarise some
of it intelligibly and post something tomorrow so that we can discuss.


> > > 
> > > 	device@4 {
> > > 		compatible = "some,ethernet";
> > > 		iommus = <&/iommu@1>;
> > > 	};
> > > 
> > > 	device@5 {
> > > 		compatible = "some,dmaengine";
> > > 		iommus = <&/iommu@2 0x40000000 0x1000000>,
> > > 			 <&/iommu@3 0x101>;
> > > 	};
> > > 
> > > The device at address 4 has a one-one relationship with iommu@1, so there
> > > is no need for any data. device@5 has two master ports. One is connected to
> > > an IOMMU that has a per-device aperture, device@5 can only issue transfers
> > > to the 256MB area at 0x40000000, and the IOMMU will have to put entries for
> > > this device into that address. The second master port is connected to
> > > iommu@3, which uses a master ID that gets passed along with each transfer,
> > > so that needs to be put into the IOTLBs.
> > 
> > I think this is definitely going in the right direction, but it's not clear
> > to me how the driver for device@5 knows how to configure the two ports.
> > We're still lacking topology information (unless that's implicit in the
> > ordering of the properties) to say how the mastering capabilities of the
> > device are actually routed and configured.
> 
> It would be helpful to have a concrete example of a device that has multiple
> masters. I have heard people mention this multiple times, and I can understand

You mean "a device that contains multiple independent bus masters",
right?  In particular, a device composed of multiple bus masters that
do different things or should be handled differently by the interconnect.

There has definitely been talk on the list about real devices that
use multiple stream IDs.


I'll ask around for "device-like" examples, but the most obvious
example is the IOMMU itself.

Transactions generated by the IOMMU clearly need to be handled
differently by the interconnect, compared with transactions
translated and forwarded by IOMMU on behalf of its clients.

For example, suppose devices can post MSIs to an interrupt controller
via a mailbox accessed through the IOMMU.  Suppose also that the IOMMU
generates MSIs itself in order to signal management events or faults
to a host OS.  Linux (as host) will need to configure the interrupt
controller separately for the IOMMU and for the IOMMU clients.  This
means that Linux needs to know which IDs may travel to the interrupt
controller for which purpose, and they must be distinct.

I'm not sure whether there is actually a SoC today that is MSI-capable
and contains an IOMMU, but all the components to build one are out
there today.  GICv3 is also explicitly designed to support such
systems.


In the future, it is likely that "HSA"-style GPUs and other high-
throughput virtualisable bus mastering devices will have capabilities
of this sort, but I don't think there's anything concrete yet.


> how it might be wired up in hardware, but I don't know what it's good for,
> or who would actually do it.
> 
> > > A variation would be to not use #iommu-cells at all, but provide a
> > > #address-cells / #size-cells pair in the IOMMU, and have a translation
> > > as we do for dma-ranges. This is probably most flexible.
> > 
> > That would also allow us to describe ranges of master IDs, which we need for
> > things like PCI RCs on the ARM SMMU. Furthermore, basic transformations of
> > these ranges could also be described like this, although I think Dave (CC'd)
> > has some similar ideas in this area.

Ideally, we would reuse the ePAPR "ranges" concept and describe the way
sideband ID signals propagate down the bus hierarchy in a similar way.

Cheers
---Dave
