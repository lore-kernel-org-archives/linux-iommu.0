From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2 2/4] iommu/arm-smmu-v3: Add tlbi_on_map option
Date: Fri, 18 Aug 2017 05:49:42 +0300
Message-ID: <20170818053639-mutt-send-email-mst@kernel.org>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
	<1502459130-6234-3-git-send-email-eric.auger@redhat.com>
	<20170817163424.GC30719@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170817163424.GC30719-5wv7dgnIgG8@public.gmane.org>
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
Cc: tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 17, 2017 at 05:34:25PM +0100, Will Deacon wrote:
> On Fri, Aug 11, 2017 at 03:45:28PM +0200, Eric Auger wrote:
> > When running a virtual SMMU on a guest we sometimes need to trap
> > all changes to the translation structures. This is especially useful
> > to integrate with VFIO. This patch adds a new option that forces
> > the IO_PGTABLE_QUIRK_TLBI_ON_MAP to be applied on LPAE page tables.
> > 
> > TLBI commands then can be trapped.
> > 
> > Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > 
> > ---
> > v1 -> v2:
> > - rebase on v4.13-rc2
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 4 ++++
> >  drivers/iommu/arm-smmu-v3.c                             | 5 +++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > index c9abbf3..ebb85e9 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> > @@ -52,6 +52,10 @@ the PCIe specification.
> >                          devicetree/bindings/interrupt-controller/msi.txt
> >                        for a description of the msi-parent property.
> >  
> > +- tlbi-on-map       : invalidate caches whenever there is an update of
> > +                      any remapping structure (updates to not-present or
> > +                      present entries).
> > +
> 
> My position on this hasn't changed, so NAK for this patch. If you want to
> emulate something outside of the SMMUv3 architecture, please do so, but
> don't pretend that it's an SMMUv3.
> 
> Will

What if the emulated device does not list arm,smmu-v3, listing
qemu,ssmu-v3 as compatible? Would that address the concern?

Way I see it down the road most people will want to use nested
mmu support in hardware. So things will work fine without
this hack.

For those that can't for some reason, reusing most of the code
in a real smmu driver allows better coverage than a completely
separate device.

Consider hypervisor as hardware - yes it's
not exactly an smmu-v3 but it's very similar so imho it's better to
reuse existing code than duplicate all of it.



-- 
MST
