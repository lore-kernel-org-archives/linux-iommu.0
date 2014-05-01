From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
	Exynos System MMU
Date: Thu, 01 May 2014 17:46:03 +0200
Message-ID: <8052890.tELEFf8xoX@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<36874558.Vf2LgdL3qf@wuerfel>
	<20140501143654.GB3732@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140501143654.GB3732-M5GwZQ6tE7x5pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: "t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel@lists.i
List-Id: iommu@lists.linux-foundation.org

On Thursday 01 May 2014 15:36:54 Dave Martin wrote:
> On Thu, May 01, 2014 at 02:29:50PM +0100, Arnd Bergmann wrote:
> > On Thursday 01 May 2014 12:15:35 Dave Martin wrote:
> > > > > I'm not sure whether there is actually a SoC today that is MSI-capable
> > > > > and contains an IOMMU, but all the components to build one are out
> > > > > there today.  GICv3 is also explicitly designed to support such
> > > > > systems.
> > > > 
> > > > A lot of SoCs have MSI integrated into the PCI root complex, which
> > > > of course is pointless from MSI perspective, as well as implying that
> > > > the MSI won't go through the IOMMU.
> > > > 
> > > > We have briefly mentioned MSI in the review of the Samsung GH7 PCI
> > > > support. It's possible that this one can either use the built-in
> > > > MSI or the one in the GICv2m.
> > > 
> > > We are likely to get non-PCI MSIs in future SoC systems too, and there
> > > are no standards governing how such systems should look.
> > 
> > I wouldn't call that MSI though -- using the same term in the code
> > can be rather confusing. There are existing SoCs that use message
> > based interrupt notification. We are probably better off modeling
> > those are regular irqchips in Linux and DT, given that they may
> > not be bound by the same constraints as PCI MSI.
> 
> We can call it what we like and maybe bury the distinction in irqchip
> drivers for some fixed-configuration cases, but it's logically the same
> concept.  Naming and subsystem factoring are implementation decisions
> for Linux.
> 
> For full dynamic assignment of pluggable devices or buses to VMs, I'm
> less sure that we can model that as plain irqchips.

I definitely hope we won't have to deal with plugging non-PCI devices
into VMs. Nothing good can come out of that.

> > Supporting this case in DT straight away is going to add a major burden.
> > If nobody can say for sure that they are actually going to do it, I'd
> > lean towards assuming that we won't need it and not putting the extra
> > complexity in.
> > 
> > If someone actually needs it later, let's make it their problem for
> > not participating in the design.
> 
> This is a fair point, but there is a difference between the bindings and
> what kind of wacky configurations a particular version of Linux actually
> supports.
> 
> DT is supposed to be a description of the hardware, not a description
> of how Linux subsystems are structured, though if the two are not
> reasonably well aligned that will lead to pain...
> 
> The key thing is to make sure the DT bindings are extensible to
> things that we can reasonably foresee.

Yes, defining them in an extensible way is always a good idea, but I
think it would be better not to define the fine details until we
actually need them in this case.

> > > > It would be 'dma-ranges'. Unfortunately that would imply that each DMA
> > > > master is connected to only one IOMMU, which you say is not necessarily
> > > > the case. The simpler case of a device is only a master on a single IOMMU
> > > > but can use multiple contexts would however work fine with dma-ranges.
> > > 
> > > Partly, yes.  The concept embodied by "dma-ranges" is correct, but the
> > > topological relationship is not: the assumption that a master device
> > > always masters onto its parent node doesn't work for non-tree-like
> > > topologies.
> > 
> > In almost all cases it will fit. When it doesn't, we can work around it by
> > defining virtual address spaces the way that the PCI binding does. The only
> > major exception that we know we have to handle is IOMMUs.
> 
> My concern here is that as new exceptions and oddball or complex systems
> crop up, we will end up repeatedly inventing different bodges to solve
> essentially the same problem.
> 
> Unlike some of the other situations we have to deal with, these are valid
> hardware configurations rather than quirks or broken systems.

Can you give an example where this would be done for a good reason?
I can't come up with an example that doesn't involve the hardware
design being seriously screwed.

	Arnd
