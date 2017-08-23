From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC v2 2/4] iommu/arm-smmu-v3: Add tlbi_on_map option
Date: Wed, 23 Aug 2017 11:25:17 +0100
Message-ID: <20170823102517.GE27301@arm.com>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
	<1502459130-6234-3-git-send-email-eric.auger@redhat.com>
	<20170817163424.GC30719@arm.com>
	<20170818053639-mutt-send-email-mst@kernel.org>
	<20170822220457-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170822220457-mutt-send-email-mst-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 22, 2017 at 10:09:15PM +0300, Michael S. Tsirkin wrote:
> On Fri, Aug 18, 2017 at 05:49:42AM +0300, Michael S. Tsirkin wrote:
> > On Thu, Aug 17, 2017 at 05:34:25PM +0100, Will Deacon wrote:
> > > On Fri, Aug 11, 2017 at 03:45:28PM +0200, Eric Auger wrote:
> > > > When running a virtual SMMU on a guest we sometimes need to trap
> > > > all changes to the translation structures. This is especially useful
> > > > to integrate with VFIO. This patch adds a new option that forces
> > > > the IO_PGTABLE_QUIRK_TLBI_ON_MAP to be applied on LPAE page tables.
> > > > 
> > > > TLBI commands then can be trapped.
> > > > 
> > > > Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > > 
> > > > ---
> > > > v1 -> v2:
> > > > - rebase on v4.13-rc2
> > > > ---
> > > >  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 4 ++++
> > > >  drivers/iommu/arm-smmu-v3.c                             | 5 +++++
> > > >  2 files changed, 9 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > > index c9abbf3..ebb85e9 100644
> > > > --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > > > @@ -52,6 +52,10 @@ the PCIe specification.
> > > >                          devicetree/bindings/interrupt-controller/msi.txt
> > > >                        for a description of the msi-parent property.
> > > >  
> > > > +- tlbi-on-map       : invalidate caches whenever there is an update of
> > > > +                      any remapping structure (updates to not-present or
> > > > +                      present entries).
> > > > +
> > > 
> > > My position on this hasn't changed, so NAK for this patch. If you want to
> > > emulate something outside of the SMMUv3 architecture, please do so, but
> > > don't pretend that it's an SMMUv3.
> > > 
> > > Will
> > 
> > What if the emulated device does not list arm,smmu-v3, listing
> > qemu,ssmu-v3 as compatible? Would that address the concern?
> 
> Will, can you comment on this please? Are you open to reusing the code
> in drivers/iommu/arm-smmu-v3.c to support a paravirtual device that does
> not claim to be compatible with smmuv3 but does try to behave very close to
> it except it can cache non-present structures? Or would you rather
> the code to support this is forked to qemu-smmu-v3.c?

I still don't understand why this is preferable to a PV IOMMU
implementation. Not only is this proposing to issue TLB maintenance on
map, but the maintenance command itself is entirely made up. Why not just
have a map command? Anyway, I'm reluctant to add this hack to the driver until:

  1. There is a compelling reason to pursue this approach instead of a
     PV approach (including performance measurements).

  2. There is a specification for the QEMU fork of the ARM SMMUv3
     architecture, including the semantics of the new command being proposed
     and what exactly the TLB maintenance requirements are on map (for
     example, what if I change an STE or a CD -- are they cached too?).

  3. The ACPI IORT spec is updated to recognise this implementation

  4. There is an implementation that can use the guest page tables directly,
     because that may well make all of this moot.

Forking the driver doesn't sound very sensible to me.

Will
