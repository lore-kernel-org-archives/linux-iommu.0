From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB invalidate
	propagation
Date: Sun, 14 May 2017 18:12:58 +0800
Message-ID: <20170514101258.GA22110@gmail.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cc330a8f-e087-9b6f-2a40-38b58688d300-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 12, 2017 at 01:11:02PM +0100, Jean-Philippe Brucker wrote:
> Hi Yi,
> 
> On 26/04/17 11:12, Liu, Yi L wrote:
> > From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > This patch adds VFIO_IOMMU_TLB_INVALIDATE to propagate IOMMU TLB
> > invalidate request from guest to host.
> > 
> > In the case of SVM virtualization on VT-d, host IOMMU driver has
> > no knowledge of caching structure updates unless the guest
> > invalidation activities are passed down to the host. So a new
> > IOCTL is needed to propagate the guest cache invalidation through
> > VFIO.
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  include/uapi/linux/vfio.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 6b97987..50c51f8 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -564,6 +564,15 @@ struct vfio_device_svm {
> >  
> >  #define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
> >  
> > +/* For IOMMU TLB Invalidation Propagation */
> > +struct vfio_iommu_tlb_invalidate {
> > +	__u32	argsz;
> > +	__u32	length;
> > +	__u8	data[];
> > +};
> 
> We initially discussed something a little more generic than this, with
> most info explicitly described and only pIOMMU-specific quirks and hints
> in an opaque structure. Out of curiosity, why the change? I'm not against
> a fully opaque structure, but there seem to be a large overlap between TLB
> invalidations across architectures.

Hi Jean,

As my cover letter mentioned, it is an open on the iommu tlb invalidate
propagation. Paste it here since it's in the cover letter for Qemu part
changes. Pls refer to the [Open] session in the following link.

http://www.spinics.net/lists/kvm/msg148798.html

I want to see if community wants to have opaque structure or not
on iommu tlb invalidate propagation. Personally, I incline to use
opaque structure. But it's better to gather the comments before
deciding it. To assist the discussion, I put the full opaque structure
here. Once community gets consensus on using opaque structure for
iommu tlb invalidate propagation, I'm glad to work with you on a
structure with partial opaque since there seems to be overlap across
arch.

> 
> For what it's worth, when prototyping the paravirtualized IOMMU I came up
> with the following.
> 
> (From the paravirtualized POV, the SMMU also has to swizzle endianess
> after unpacking an opaque structure, since userspace doesn't know what's
> in it and guest might use a different endianess. So we need to force all
> opaque data to be e.g. little-endian.)
> 
> struct vfio_iommu_tlb_invalidate {
> 	__u32	argsz;
> 	__u32	scope;
> 	__u32	flags;
> 	__u32	pasid;
> 	__u64	vaddr;
> 	__u64	size;
> 	__u8	data[];
> };
>
> Scope is a bitfields restricting the invalidation scope. By default
> invalidate the whole container (all PASIDs and all VAs). @pasid, @vaddr
> and @size are unused.
> 
> Adding VFIO_IOMMU_INVALIDATE_PASID (1 << 0) restricts the invalidation
> scope to the pasid described by @pasid.
> Adding VFIO_IOMMU_INVALIDATE_VADDR (1 << 1) restricts the invalidation
> scope to the address range described by (@vaddr, @size).
> 
> So setting scope = VFIO_IOMMU_INVALIDATE_VADDR would invalidate the VA
> range for *all* pasids (as well as no_pasid). Setting scope =
> (VFIO_IOMMU_INVALIDATE_VADDR|VFIO_IOMMU_INVALIDATE_PASID) would invalidate
> the VA range only for @pasid.
> 

Besides VA range flusing, there is PASID Cache flushing on VT-d. How about
SMMU? So I think besides the two scope you defined, may need one more to
indicate if it's PASID Cache flushing.

> Flags depend on the selected scope:
> 
> VFIO_IOMMU_INVALIDATE_NO_PASID, indicating that invalidation (either
> without scope or with INVALIDATE_VADDR) targets non-pasid mappings
> exclusively (some architectures, e.g. SMMU, allow this)
> 
> VFIO_IOMMU_INVALIDATE_VADDR_LEAF, indicating that the pIOMMU doesn't need
> to invalidate all intermediate tables cached as part of the PTW for vaddr,
> only the last-level entry (pte). This is a hint.
> 
> I guess what's missing for Intel IOMMU and would go in @data is the
> "global" hint (which we don't have in SMMU invalidations). Do you see
> anything else, that the pIOMMU cannot deduce from this structure?
> 

For Intel platform, Drain read/write would be needed in the opaque.

Thanks,
Yi L
