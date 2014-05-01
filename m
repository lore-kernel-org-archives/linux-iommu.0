From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Thu, 1 May 2014 12:15:35 +0100
Message-ID: <20140501111527.GA3732@e103592.cambridge.arm.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<5242619.ZKgCdLW1L4@wuerfel>
	<20140429181601.GE3582@e103592.cambridge.arm.com>
	<6607258.MzzLbm2Afe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6607258.MzzLbm2Afe@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rahul.sharma-Sze3O3UU22KIwRZHo2/mJg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 29, 2014 at 10:46:18PM +0200, Arnd Bergmann wrote:
> On Tuesday 29 April 2014 19:16:02 Dave Martin wrote:

[...]

> > For example, suppose devices can post MSIs to an interrupt controller
> > via a mailbox accessed through the IOMMU.  Suppose also that the IOMMU
> > generates MSIs itself in order to signal management events or faults
> > to a host OS.  Linux (as host) will need to configure the interrupt
> > controller separately for the IOMMU and for the IOMMU clients.  This
> > means that Linux needs to know which IDs may travel to the interrupt
> > controller for which purpose, and they must be distinct.
> 
> I don't understand. An MSI controller is just an address that acts
> as a DMA slave for a 4-byte inbound data packet. It has no way of
> knowing who is sending data, other than by the address or the data
> sent to it. Are you talking of something else?

Oops, looks like there are a few points I failed to respond to here...


I'm not an expert on PCI -- I'm prepared to believe it works that way.

GICv3 can descriminate between different MSI senders based on ID
signals on the bus.

> 
> > I'm not sure whether there is actually a SoC today that is MSI-capable
> > and contains an IOMMU, but all the components to build one are out
> > there today.  GICv3 is also explicitly designed to support such
> > systems.
> 
> A lot of SoCs have MSI integrated into the PCI root complex, which
> of course is pointless from MSI perspective, as well as implying that
> the MSI won't go through the IOMMU.
> 
> We have briefly mentioned MSI in the review of the Samsung GH7 PCI
> support. It's possible that this one can either use the built-in
> MSI or the one in the GICv2m.

We are likely to get non-PCI MSIs in future SoC systems too, and there
are no standards governing how such systems should look.


> > In the future, it is likely that "HSA"-style GPUs and other high-
> > throughput virtualisable bus mastering devices will have capabilities
> > of this sort, but I don't think there's anything concrete yet.
> 
> Wouldn't they just have IOMMUs with multiple contexts?

Who knows?  A management component of the GPU that is under exclusive
control of the host or hypervisor might be wired up to bypass the IOMMU
completely.

I'm not saying this kind of thing definitely will happen, but I can't
say confidently that it won't.


> > > how it might be wired up in hardware, but I don't know what it's good for,
> > > or who would actually do it.
> > > 
> > > > > A variation would be to not use #iommu-cells at all, but provide a
> > > > > #address-cells / #size-cells pair in the IOMMU, and have a translation
> > > > > as we do for dma-ranges. This is probably most flexible.
> > > > 
> > > > That would also allow us to describe ranges of master IDs, which we need for
> > > > things like PCI RCs on the ARM SMMU. Furthermore, basic transformations of
> > > > these ranges could also be described like this, although I think Dave (CC'd)
> > > > has some similar ideas in this area.
> > 
> > Ideally, we would reuse the ePAPR "ranges" concept and describe the way
> > sideband ID signals propagate down the bus hierarchy in a similar way.
> 
> It would be 'dma-ranges'. Unfortunately that would imply that each DMA
> master is connected to only one IOMMU, which you say is not necessarily
> the case. The simpler case of a device is only a master on a single IOMMU
> but can use multiple contexts would however work fine with dma-ranges.

Partly, yes.  The concept embodied by "dma-ranges" is correct, but the
topological relationship is not: the assumption that a master device
always masters onto its parent node doesn't work for non-tree-like
topologies.

Cheers
---Dave
