From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC v2 2/4] iommu/arm-smmu-v3: Add tlbi_on_map option
Date: Wed, 23 Aug 2017 17:05:04 +0300
Message-ID: <20170823164320-mutt-send-email-mst@kernel.org>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
 <1502459130-6234-3-git-send-email-eric.auger@redhat.com>
 <20170817163424.GC30719@arm.com>
 <20170818053639-mutt-send-email-mst@kernel.org>
 <20170822220457-mutt-send-email-mst@kernel.org>
 <20170823102517.GE27301@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823102517.GE27301@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, Jean-Philippe.Brucker@arm.com, christoffer.dall@linaro.org, Marc.Zyngier@arm.com, alex.williamson@redhat.com, peterx@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 23, 2017 at 11:25:17AM +0100, Will Deacon wrote:
> On Tue, Aug 22, 2017 at 10:09:15PM +0300, Michael S. Tsirkin wrote:
> > On Fri, Aug 18, 2017 at 05:49:42AM +0300, Michael S. Tsirkin wrote:
> > > On Thu, Aug 17, 2017 at 05:34:25PM +0100, Will Deacon wrote:
> > > > On Fri, Aug 11, 2017 at 03:45:28PM +0200, Eric Auger wrote:
> > > > > When running a virtual SMMU on a guest we sometimes need to trap
> > > > > all changes to the translation structures. This is especially useful
> > > > > to integrate with VFIO. This patch adds a new option that forces
> > > > > the IO_PGTABLE_QUIRK_TLBI_ON_MAP to be applied on LPAE page tables.
> > > > > 
> > > > > TLBI commands then can be trapped.
> > > > > 
> > > > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > > > 
> > > > > ---
> > > > > v1 -> v2:
> > > > > - rebase on v4.13-rc2
> > > > > ---
> > > > >  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 4 ++++
> > > > >  drivers/iommu/arm-smmu-v3.c                             | 5 +++++
> > > > >  2 files changed, 9 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > > > index c9abbf3..ebb85e9 100644
> > > > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > > > @@ -52,6 +52,10 @@ the PCIe specification.
> > > > >                          devicetree/bindings/interrupt-controller/msi.txt
> > > > >                        for a description of the msi-parent property.
> > > > >  
> > > > > +- tlbi-on-map       : invalidate caches whenever there is an update of
> > > > > +                      any remapping structure (updates to not-present or
> > > > > +                      present entries).
> > > > > +
> > > > 
> > > > My position on this hasn't changed, so NAK for this patch. If you want to
> > > > emulate something outside of the SMMUv3 architecture, please do so, but
> > > > don't pretend that it's an SMMUv3.
> > > > 
> > > > Will
> > > 
> > > What if the emulated device does not list arm,smmu-v3, listing
> > > qemu,ssmu-v3 as compatible? Would that address the concern?
> > 
> > Will, can you comment on this please? Are you open to reusing the code
> > in drivers/iommu/arm-smmu-v3.c to support a paravirtual device that does
> > not claim to be compatible with smmuv3 but does try to behave very close to
> > it except it can cache non-present structures? Or would you rather
> > the code to support this is forked to qemu-smmu-v3.c?
> 
> I still don't understand why this is preferable to a PV IOMMU
> implementation.

It has advantages and disadvantages as everything. To list some
advantages:

- Because this reuses all of the code we need for emulating SMMU anyway.
Just look at size of the patches and compare to virtio iommu patches.

- I think this is a reasonable stepping stone for using nested support in
host SMMU which is obviously faster as you don't need to send mappings
to host. We can get guest and QEMU working, then work on support
using guest page tables directly.

- With virtio IOMMU you will never be able to switch to using
guest page tables directly without upheaving to host/guest
interfaces.

> Not only is this proposing to issue TLB maintenance on
> map, but the maintenance command itself is entirely made up. Why not just
> have a map command? Anyway, I'm reluctant to add this hack to the driver until:
> 
>   1. There is a compelling reason to pursue this approach instead of a
>      PV approach (including performance measurements).

In fact the question does not make a lot of sense.  This interface is PV
right there. But this PV is waaay less code since we need the emulation
anyway. I don't even need to look at performance to see a compelling
reason on the QEMU side.  So it's a question of reduced maintainance
host side.

>   2. There is a specification for the QEMU fork of the ARM SMMUv3
>      architecture, including the semantics of the new command being proposed
>      and what exactly the TLB maintenance requirements are on map (for
>      example, what if I change an STE or a CD -- are they cached too?).

Makes sense.

>   3. The ACPI IORT spec is updated to recognise this implementation

I don't think we have to gate on this. IORT is ARM spec for ARM
hardware.  This should be a device specific quirk only triggering for
the QEMU (non-ARM) implementation (which in this patchset it isn't, and
this is something to fix IMO).

>   4. There is an implementation that can use the guest page tables directly,
>      because that may well make all of this moot.

That will depend on the specific host capability. So this is actually
another part of the motivation here. Guest / host interface will be very
similar with this and with using guest page tables directly. So most of
the same code gets to run with and without, good for testing, coverage etc.

But I agree this item should at least be on the roadmap,
I'm somewhat concerned it isn't. In fact the same applies to PV IOMMU.


> Forking the driver doesn't sound very sensible to me.
> 
> Will

There's still time as patches on qemu side are RFC

-- 
MST
