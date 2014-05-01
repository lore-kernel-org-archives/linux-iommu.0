From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Thu, 1 May 2014 15:36:54 +0100
Message-ID: <20140501143654.GB3732@e103592.cambridge.arm.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<6607258.MzzLbm2Afe@wuerfel>
	<20140501111527.GA3732@e103592.cambridge.arm.com>
	<36874558.Vf2LgdL3qf@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <36874558.Vf2LgdL3qf@wuerfel>
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
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel@lists.i
List-Id: iommu@lists.linux-foundation.org

On Thu, May 01, 2014 at 02:29:50PM +0100, Arnd Bergmann wrote:
> On Thursday 01 May 2014 12:15:35 Dave Martin wrote:
> > On Tue, Apr 29, 2014 at 10:46:18PM +0200, Arnd Bergmann wrote:
> > > On Tuesday 29 April 2014 19:16:02 Dave Martin wrote:
> > 
> > [...]
> > 
> > > > For example, suppose devices can post MSIs to an interrupt controller
> > > > via a mailbox accessed through the IOMMU.  Suppose also that the IOMMU
> > > > generates MSIs itself in order to signal management events or faults
> > > > to a host OS.  Linux (as host) will need to configure the interrupt
> > > > controller separately for the IOMMU and for the IOMMU clients.  This
> > > > means that Linux needs to know which IDs may travel to the interrupt
> > > > controller for which purpose, and they must be distinct.
> > > 
> > > I don't understand. An MSI controller is just an address that acts
> > > as a DMA slave for a 4-byte inbound data packet. It has no way of
> > > knowing who is sending data, other than by the address or the data
> > > sent to it. Are you talking of something else?
> > 
> > Oops, looks like there are a few points I failed to respond to here...
> > 
> > 
> > I'm not an expert on PCI -- I'm prepared to believe it works that way.
> > 
> > GICv3 can descriminate between different MSI senders based on ID
> > signals on the bus.
> 
> Any idea what this is good for? Do we have to use it? It probably doesn't
> fit very well into the way Linux handles MSIs today.

Marc may be better placed than me to comment on this in detail.

However, I believe it's correct to say that because the GIC is not part
of PCI, end-to-end MSI delivery inherently involves a non-PCI step from
the PCI RC to the GIC itself.

Thus this is likely to be a fundamental requirement for MSIs on ARM SoCs
using GIC, if we want to have a hope of mapping MSIs to VMs efficiently.

> > > > I'm not sure whether there is actually a SoC today that is MSI-capable
> > > > and contains an IOMMU, but all the components to build one are out
> > > > there today.  GICv3 is also explicitly designed to support such
> > > > systems.
> > > 
> > > A lot of SoCs have MSI integrated into the PCI root complex, which
> > > of course is pointless from MSI perspective, as well as implying that
> > > the MSI won't go through the IOMMU.
> > > 
> > > We have briefly mentioned MSI in the review of the Samsung GH7 PCI
> > > support. It's possible that this one can either use the built-in
> > > MSI or the one in the GICv2m.
> > 
> > We are likely to get non-PCI MSIs in future SoC systems too, and there
> > are no standards governing how such systems should look.
> 
> I wouldn't call that MSI though -- using the same term in the code
> can be rather confusing. There are existing SoCs that use message
> based interrupt notification. We are probably better off modeling
> those are regular irqchips in Linux and DT, given that they may
> not be bound by the same constraints as PCI MSI.

We can call it what we like and maybe bury the distinction in irqchip
drivers for some fixed-configuration cases, but it's logically the same
concept.  Naming and subsystem factoring are implementation decisions
for Linux.

For full dynamic assignment of pluggable devices or buses to VMs, I'm
less sure that we can model that as plain irqchips.

> > > > In the future, it is likely that "HSA"-style GPUs and other high-
> > > > throughput virtualisable bus mastering devices will have capabilities
> > > > of this sort, but I don't think there's anything concrete yet.
> > > 
> > > Wouldn't they just have IOMMUs with multiple contexts?
> > 
> > Who knows?  A management component of the GPU that is under exclusive
> > control of the host or hypervisor might be wired up to bypass the IOMMU
> > completely.
> > 
> > I'm not saying this kind of thing definitely will happen, but I can't
> > say confidently that it won't.
> 
> Supporting this case in DT straight away is going to add a major burden.
> If nobody can say for sure that they are actually going to do it, I'd
> lean towards assuming that we won't need it and not putting the extra
> complexity in.
> 
> If someone actually needs it later, let's make it their problem for
> not participating in the design.

This is a fair point, but there is a difference between the bindings and
what kind of wacky configurations a particular version of Linux actually
supports.

DT is supposed to be a description of the hardware, not a description
of how Linux subsystems are structured, though if the two are not
reasonably well aligned that will lead to pain...

The key thing is to make sure the DT bindings are extensible to
things that we can reasonably foresee.

> 
> > > > > how it might be wired up in hardware, but I don't know what it's good for,
> > > > > or who would actually do it.
> > > > > 
> > > > > > > A variation would be to not use #iommu-cells at all, but provide a
> > > > > > > #address-cells / #size-cells pair in the IOMMU, and have a translation
> > > > > > > as we do for dma-ranges. This is probably most flexible.
> > > > > > 
> > > > > > That would also allow us to describe ranges of master IDs, which we need for
> > > > > > things like PCI RCs on the ARM SMMU. Furthermore, basic transformations of
> > > > > > these ranges could also be described like this, although I think Dave (CC'd)
> > > > > > has some similar ideas in this area.
> > > > 
> > > > Ideally, we would reuse the ePAPR "ranges" concept and describe the way
> > > > sideband ID signals propagate down the bus hierarchy in a similar way.
> > > 
> > > It would be 'dma-ranges'. Unfortunately that would imply that each DMA
> > > master is connected to only one IOMMU, which you say is not necessarily
> > > the case. The simpler case of a device is only a master on a single IOMMU
> > > but can use multiple contexts would however work fine with dma-ranges.
> > 
> > Partly, yes.  The concept embodied by "dma-ranges" is correct, but the
> > topological relationship is not: the assumption that a master device
> > always masters onto its parent node doesn't work for non-tree-like
> > topologies.
> 
> In almost all cases it will fit. When it doesn't, we can work around it by
> defining virtual address spaces the way that the PCI binding does. The only
> major exception that we know we have to handle is IOMMUs.

My concern here is that as new exceptions and oddball or complex systems
crop up, we will end up repeatedly inventing different bodges to solve
essentially the same problem.

Unlike some of the other situations we have to deal with, these are valid
hardware configurations rather than quirks or broken systems.


A more uniform approach is not necessarily a win, but it is worth discussing.
That will be easier with a bit more concrete detail -- I'll follow up with
something that I hope will focus the discussion a bit on this point.

Cheers
---Dave
