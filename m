From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC v2 2/4] iommu/arm-smmu-v3: Add tlbi_on_map option
Date: Tue, 22 Aug 2017 22:09:15 +0300
Message-ID: <20170822220457-mutt-send-email-mst@kernel.org>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
 <1502459130-6234-3-git-send-email-eric.auger@redhat.com>
 <20170817163424.GC30719@arm.com>
 <20170818053639-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170818053639-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, robin.murphy@arm.com, Jean-Philippe.Brucker@arm.com, christoffer.dall@linaro.org, Marc.Zyngier@arm.com, alex.williamson@redhat.com, peterx@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 18, 2017 at 05:49:42AM +0300, Michael S. Tsirkin wrote:
> On Thu, Aug 17, 2017 at 05:34:25PM +0100, Will Deacon wrote:
> > On Fri, Aug 11, 2017 at 03:45:28PM +0200, Eric Auger wrote:
> > > When running a virtual SMMU on a guest we sometimes need to trap
> > > all changes to the translation structures. This is especially useful
> > > to integrate with VFIO. This patch adds a new option that forces
> > > the IO_PGTABLE_QUIRK_TLBI_ON_MAP to be applied on LPAE page tables.
> > > 
> > > TLBI commands then can be trapped.
> > > 
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > 
> > > ---
> > > v1 -> v2:
> > > - rebase on v4.13-rc2
> > > ---
> > >  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 4 ++++
> > >  drivers/iommu/arm-smmu-v3.c                             | 5 +++++
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > index c9abbf3..ebb85e9 100644
> > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > @@ -52,6 +52,10 @@ the PCIe specification.
> > >                          devicetree/bindings/interrupt-controller/msi.txt
> > >                        for a description of the msi-parent property.
> > >  
> > > +- tlbi-on-map       : invalidate caches whenever there is an update of
> > > +                      any remapping structure (updates to not-present or
> > > +                      present entries).
> > > +
> > 
> > My position on this hasn't changed, so NAK for this patch. If you want to
> > emulate something outside of the SMMUv3 architecture, please do so, but
> > don't pretend that it's an SMMUv3.
> > 
> > Will
> 
> What if the emulated device does not list arm,smmu-v3, listing
> qemu,ssmu-v3 as compatible? Would that address the concern?

Will, can you comment on this please? Are you open to reusing the code
in drivers/iommu/arm-smmu-v3.c to support a paravirtual device that does
not claim to be compatible with smmuv3 but does try to behave very close to
it except it can cache non-present structures? Or would you rather
the code to support this is forked to qemu-smmu-v3.c?


> Way I see it down the road most people will want to use nested
> mmu support in hardware. So things will work fine without
> this hack.
> 
> For those that can't for some reason, reusing most of the code
> in a real smmu driver allows better coverage than a completely
> separate device.
> 
> Consider hypervisor as hardware - yes it's
> not exactly an smmu-v3 but it's very similar so imho it's better to
> reuse existing code than duplicate all of it.
> 
> 
> 
> -- 
> MST
