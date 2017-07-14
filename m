From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
	invalidate propagation
Date: Fri, 14 Jul 2017 08:58:02 +0000
Message-ID: <A2975661238FB949B60364EF0F2C2574390A7C4F@shsmsx102.ccr.corp.intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
	<20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
	<1d63c1ae-ca10-0f9d-91de-0d9c9823c104@arm.com>
	<20170705112816.56554f65@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170705112816.56554f65-DGNDKt5SQtizQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu,
	Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

Against to the opaque open, I'd like to propose the following definition
based on the existing comments. Pls note that I've merged the pasid
table binding and iommu tlb invalidation into a single IOCTL and make
different flags to indicate the iommu operations. Per Kevin's comments,
there may be iommu invalidation for guest IOVA tlb, so I renamed the
IOCTL and data structure to be non-svm specific. Pls kindly have a review,
so that we can make the opaque open closed and move forward. Surely,
comments and ideas are welcomed. And for the scope and flags definition
in struct iommu_tlb_invalidate, it's also welcomed to give your ideas on it.

1. Add a VFIO IOCTL for iommu operations from user-space

#define VFIO_IOMMU_OP_IOCTL _IO(VFIO_TYPE, VFIO_BASE + 24)

Corresponding data structure:
struct vfio_iommu_operation_info {
	__u32	argsz;
#define VFIO_IOMMU_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
#define VFIO_IOMMU_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver*/
#define VFIO_IOMMU_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
#define VFIO_IOMMU_INVAL_IOTLB	(1 << 3) /* Invalidate iommu tlb */
	__u32	flag;
	__u32	length; // length of the data[] part in byte
	__u8	data[]; // stores the data for iommu op indicated by flag field
};

For iommu tlb invalidation from userspace, the "__u8 data[]" stores
data which would be parsed by the "struct iommu_tlb_invalidate" defined
below.

2. Definitions in include/uapi/linux/iommu.h(newly added header file)

/* IOMMU model definition for iommu operations from userspace */
enum iommu_model {
	INTLE_IOMMU,
	ARM_SMMU,
	AMD_IOMMU,
	SPAPR_IOMMU,
	S390_IOMMU,
};

struct iommu_tlb_invalidate {
	__u32	scope;
/* pasid-selective invalidation described by @pasid */
#define IOMMU_INVALIDATE_PASID	(1 << 0)
/* address-selevtive invalidation described by (@vaddr, @size) */
#define IOMMU_INVALIDATE_VADDR	(1 << 1)
	__u32	flags;
/*  targets non-pasid mappings, @pasid is not valid */
#define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
/* indicating that the pIOMMU doesn't need to invalidate
	all intermediate tables cached as part of the PTE for
	vaddr, only the last-level entry (pte). This is a hint. */
#define IOMMU_INVALIDATE_VADDR_LEAF	(1 << 1)
	__u32	pasid;
	__u64	vaddr;
	__u64	size;
	enum iommu_model model;
	/*
	 Vendor may have different HW version and thus the
	 data part of this structure differs, use sub_version
	 to indicate such difference.
	 */
	__u322 sub_version;
	__u64 length; // length of the data[] part in byte
	__u8	data[];
};

For Intel, the data structue is:
struct intel_iommu_invalidate_data {
	__u64 low;
	__u64 high;
}

Thanks,
Yi L

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Thursday, July 6, 2017 1:28 AM
> To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> Cc: Tian, Kevin <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; Lan,
> Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Raj, Ashok
> <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Will Deacon
> <Will.Deacon-5wv7dgnIgG8@public.gmane.org>; peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Pan, Jacob jun <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
> invalidate propagation
> 
> On Wed, 5 Jul 2017 13:42:03 +0100
> Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:
> 
> > On 05/07/17 07:45, Tian, Kevin wrote:
> > >> From: Liu, Yi L
> > >> Sent: Monday, July 3, 2017 6:31 PM
> > >>
> > >> Hi Jean,
> > >>
> > >>
> > >>>
> > >>>> 2. Define a structure in include/uapi/linux/iommu.h(newly added
> > >>>> header
> > >> file)
> > >>>>
> > >>>> struct iommu_tlb_invalidate {
> > >>>> 	__u32	scope;
> > >>>> /* pasid-selective invalidation described by @pasid */
> > >>>> #define IOMMU_INVALIDATE_PASID	(1 << 0)
> > >>>> /* address-selevtive invalidation described by (@vaddr, @size) */
> > >>>> #define IOMMU_INVALIDATE_VADDR	(1 << 1)
> > >
> > > For VT-d above two flags are related. There is no method of flushing
> > > (@vaddr, @size) for all pasids, which doesn't make sense. address-
> > > selective invalidation is valid only for a given pasid. So it's not
> > > appropriate to put them in same level of scope definition at least for VT-d.
> >
> > For ARM SMMU the "flush all by VA" operation is valid. Although it's
> > unclear at this point if we will ever allow that, it should probably
> > stay in the common format, if there is one.
> >
> > >>>> 	__u32	flags;
> > >>>> /*  targets non-pasid mappings, @pasid is not valid */
> > >>>> #define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
> > >>>
> > >>> Although it was my proposal, I don't like this flag. In ARM SMMU,
> > >>> we're using a special mode where PASID 0 is reserved and any
> > >>> traffic without PASID uses entry 0 of the PASID table. So I
> > >>> proposed the "NO_PASID" flag to invalidate that special context
> > >>> explicitly. But this means that invalidation packet targeted at
> > >>> that context will have "scope = PASID" and "flags = NO_PASID", which is utterly
> confusing.
> > >>>
> > >>> I now think that we should get rid of the
> > >>> IOMMU_INVALIDATE_NO_PASID
> > >> flag
> > >>> and just use PASID 0 to invalidate this context on ARM. I don't
> > >>> think other architectures would use the NO_PASID flag anyway, but
> > >>> might be
> > >> mistaken.
> > >>
> > >> I may suggest to keep it so far. On VT-d, we may pass some data in
> > >> opaque, so we may work without it. But if other vendor want to
> > >> issue non-PASID tagged cache, then may encounter problem.
> > >
> > > I'm worried about what's the criteria which attribute should be
> > > abstracted in common structure and which can be left to opaque. It
> > > doesn't make much sense to do such abstraction purely because
> > > different vendor formats have some common fields. Usually we do such
> > > abstraction because vendor-agnostic code need to do some common
> > > handling before going to vendor specific code. However in this case
> > > VFIO is not expected to do anything with those IOMMU specific
> > > attributes. Then the structure is directly forwarded to IOMMU
> > > driver, which simply translates the structure into vendor specific
> > > opaque data again. Then why bothering to do double translations in
> > > Qemu and IOMMU driver side?> Take VT-d for example. Below is a
> > > summary of all possible selections around invalidation of 1st level structure for
> svm:
> > >
> > > Scope: All PASIDs, single PASID
> > > for each PASID:
> > > 	all mappings, or page-selective mappings (addr, size) invalidation
> > > target:
> > > 	IOTLB entries (leaf)
> > > 	paging structure cache (non-leaf)
> >
> > I'm curious, can you invalidate all intermediate paging structures for
> > a given PASID without invalidating the leaves?
> >
> > > 	PASID cache (pasid->cr3)
> > I guess any implementations that gives the whole PASID table to
> > userspace will need the PASID cache invalidation. This was missing
> > from my proposal since it was from virtio-iommu.
> >
> > > invalidation hint:
> > > 	whether global pages are included
> > > 	drain reads/writes>
> > > Above are pretty architectural attributes if just looking at
> > > functional purpose. Then if we really consider defining a common
> > > structure, it might be more natural to define a superset of all
> > > vendors' capabilities and remove the opaque field at all. But as
> > > said earlier the purpose of doing such abstraction is not clear if
> > > there is no vendor-agnostic user actually digesting those fields.
> > > Then should we reconsider the full opaque approach?
> > >
> > > Welcome comments since I may overlook something here. :-)
> >
> > I guess on x86 the invalidation packet formats are stable, but for ARM
> > I'm reluctant to deal with vendor-specific formats at the API level,
> > because they tend to be volatile. If a virtual IOMMU version is
> > different from the physical one, then the page table format will be
> > the same but invalidation format will not.
> >
> > So it would be good to define common fields that have the same effects
> > regardless on the underlying pIOMMU. And the fields that differ
> > between ARM and x86 seem to only be hints.
> >
> > In addition on ARM SMMU, the guest cannot build an invalidation
> > command that the host could simply copy into the hardware command
> > queue. The pIOMMU driver needs to craft an invalidation command with a
> > Virtual Machine ID, that the guest is never aware of, and a separate
> > ATS invalidation command. It might also need to retrieve an Address
> > Space ID associated with the given PASID if it chose to hide it from the guest.
> >
> > So for us the invalidation structure would always be different from
> > the hardware one. That's why I do not have any reason the prefer an
> > opaque structure in the first place, and defining generic fields looks
> > much neater :) Then again, I don't have any strong technical objection to it.
> 
> I have an objection to opaque data, it's not documented for users, can't be
> considered a stable ABI, introduces compatibility issues, and makes debugging
> difficult.  vfio should have the right to and the ability to validate anything coming
> from the user, whether it's vendor specific or generic.  Your concern about hardware
> changing is just as valid on VT-d.  Even if we're emulating VT-d in userspace on a VT-
> d host, how do we know that the two are strictly compatible?  It may be today, but
> we cannot predict the future.  A fully specified ABI means that we can properly
> version it, and if necessary provide compatibility handlers if the hardware changes.
> Thanks,
> 
> Alex
