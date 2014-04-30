From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v12 11/31] documentation: iommu: add binding document of
 Exynos System MMU
Date: Wed, 30 Apr 2014 16:14:15 +0100
Message-ID: <20140430151415.GC3986@e103592.cambridge.arm.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <20140429181601.GE3582@e103592.cambridge.arm.com>
 <CANEJEGs6TXNzE8cWYgEKfFSsD2w5XiYvwSbhQ_+gtfzfs+6udA@mail.gmail.com>
 <7044616.kdaKNu3Qet@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <7044616.kdaKNu3Qet@wuerfel>
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
Cc: "t.figa@samsung.com" <t.figa@samsung.com>, Will Deacon <will.deacon@arm.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "joshi@samsung.com" <joshi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "s.nawrocki@samsung.com" <s.nawrocki@samsung.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "prathyush.k@samsung.com" <prathyush.k@samsung.com>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>, "joro@8bytes.org" <joro@8bytes.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Grant Grundler <grundler@chromium.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "a.motakis@virtualopensystems.com" <a.motakis@virtualopensystems.com>, "pullip.cho@samsung.com" <pullip.cho@samsung.com>, linux-arm-kernel@lists.infradead.o
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 29, 2014 at 11:00:29PM +0200, Arnd Bergmann wrote: > On Tuesday 29 April 2014 13:07:54 Grant Grundler wrote: > > On Tue, Apr 29, 2014 at 11:16 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> > ...
> > > An IOMMU is really a specialised bridge
> > 
> > Is a GART a bridge?

Depends what you mean by "bridge".

I would say that it can be logically viewed as a bridge through which
graphics cards master onto the bus.

In this context it's integrated into the bus, but I think the function
it performs is still in series with, and logically distinct from, the
routing done by the bus proper.

> > IOMMUs can provide three basic functions:
> > 1) remap address space to reach phys mem ranges that the device is
> > otherwise not capable of accessing (classic 32-bit DMA to reach 64-bit
> > Phys address)
> > 
> > 2) implement scatter-gather (page level granularity) so the device
> > doesn't have to
> > 
> > 3) provide some level of system protection against "rogue" DMA by
> > forcing everything through a DMA mapping interface and faulting when
> > encountering unmapped DMA transactions.
> 
> [ 4) provide isolation between multiple contexts, typically for purposes
>      of virtualization]

All of which are classic functionalities of an MMU.  What is different
is that the CPU MMU is built into the CPU and standardised, and either
symmetrically shared or private to the CPU so that there is rarely if
ever any need to describe anything in DT ... whereas an IOMMU is not
tightly coupled to the CPU, and wired up to external hardware in
sometimes arbitrary ways that may require description (especially for
SoC systems).

> > I summarize IOMMUs as: "participate in the routing of MMIO
> > transactions in the system fabric."
> > In this sense, IOMMUs are sort of a bridge. Defining what kind of
> > routing they can do (coalesce transactions? remapping MMIO domains?)
> > and which address ranges they route would describe most of that
> > functionality.

agreed

> > This "remapping" of MMIO transaction is also usually asymmetric.
> > Meaning routing of "downstream" transactions *might* be completely
> > different than the routing + remapping of transactions heading
> > upstream. DMA mappings services are designed to handle only the
> > transactions generated (aka "mastered") by a downstream device.

Also agreed.  In the SoC world, the upstream and downstream paths
may be completely separate in the topology, not following the same
path at all, so then it becomes more natural for them to have
independent characteristics.  "dma-ranges" doesn't work for these
situations.

> For the purposes of the DT binding, we have a 'ranges' property
> that defines the downstream translation (CPU-to-MMIO) and a
> 'dma-ranges' property for the opposite address translation
> (device-to-memory).
> 
> > >, so it may be cleaner to describe
> > > an IOMMU using a real bus node in the DT, if we also define a way to make
> > > master/slave linkages explicit where it matters.
> > 
> > "where it matters" is a bit vague.  Is the goal to just enable DMA
> > mapping services to "do the right thing" for a device that can
> > generate DMA?
> 
> Yes. It's very complicated unfortunately, because we have to be
> able to deal with arbitrary combinations of a lot of oddball cases
> that can show up in random SoCs:
> 
> - device can only do DMA to a limited address range
> - DMA is noncoherent and needs manual cache management
> - DMA address is at an offset from physical address
> - some devices have an IOMMU
> - some IOMMUs are shared between devices
> - some devices with IOMMU can have multiple simultaneous contexts
> - a device may access some memory directly and some other memory through IOMMU
> - a device may have DMA access to a bus that is invisible to the CPU
> - DMA on some device is only coherent if the IOMMU is enabled
> - DMA on some device is only coherent if the IOMMU is disabled
> - the IOVA range to an IOMMU is device dependent

This sounds bad on the surface, but really these are permutations of a
few key concepts:

 1) Topologies that can't be reduced to a tree, resulting from
   unidirectional buses (common in SoC architectures).

 2) Many-to-many connectivity of devices, unlike the familiar
   many-to-one parent/child relationship from PCI and similar.

 3) Interconnects made up of independently configured and
   connected components, such that they can't be described as optional
   features of some standard bus.

 4) Bridge components and devices that process, route or transform
   transactions based on more than just the destination address.
   Instead, the handling of a transaction can involve some kind of
   device ID, memory type and cacheability attributes and coherency
   domain information in addition to the address.


To address these, we need a few things:

 a) A way to describe the cross-links where the topology is not
    reducible to a tree.  This would involve a phandle to describe
    a "A masters on B" relationship analogous to what the parent/
    child relationship in DT already means.

 b) For devices with multiple distinct master roles with different
    routing or behaviour in the interconnect, a way to describe those
    roles.

 c) A way to describe mappings across bridges that builds on
    "ranges" to cover a wider range of situations.


> > > I've been hacking around some proposals on these areas which are a bit
> > > different from the approach suggested here -- I'll try to summarise some
> > > of it intelligibly and post something tomorrow so that we can discuss.
> > 
> > Are you planning on consolidating Documentation/devicetree/bindings/iommu/ ?

Not initially.  Ripping out old bindings that work perfectly well today
will just cause churn.  But if we can lay a good foundation for future
bindings that should help us in the future.

> > Do you care about Documentation/Intel-IOMMU.txt?

Probably answered by my above point.

If it ain't broke, there's no reason to fix it.

Defining DT bindings and refactoring kernel frameworks are pretty
orthogonal: we could retain compatibility with existing IOMMU bindings
within a modified framework that can also handle more diverse SoC
scenarios which may use a more uniform and sophisticated description in
the DT.

> I think we can ignore the Intel-IOMMU because that is specialized on PCI
> devices, which we don't normally represent in DT. It is also a special
> case because the Intel IOMMU is a single-instance device. If it's present
> and enabled, it will be used by every device. The case we do need to describe
> is when we don't know which IOMMU is used for which master, or how to
> configure it.

Agreed.  Because of the single-instance nature of the Intel IOMMU, and
the fact that is integrated into the interconnect in a pretty standard
way, we can get away with much less description.


I'll follow up with some more concrete details on my thinking --
hopefully that will make it a bit clearer what I mean.

Cheers
---Dave
