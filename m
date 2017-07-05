From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
	invalidate propagation
Date: Wed, 5 Jul 2017 06:45:38 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
	<20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170703103115.GB22053-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org" <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Pan, Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Liu, Yi L
> Sent: Monday, July 3, 2017 6:31 PM
> 
> Hi Jean,
> 
> 
> >
> > > 2. Define a structure in include/uapi/linux/iommu.h(newly added header
> file)
> > >
> > > struct iommu_tlb_invalidate {
> > > 	__u32	scope;
> > > /* pasid-selective invalidation described by @pasid */
> > > #define IOMMU_INVALIDATE_PASID	(1 << 0)
> > > /* address-selevtive invalidation described by (@vaddr, @size) */
> > > #define IOMMU_INVALIDATE_VADDR	(1 << 1)

For VT-d above two flags are related. There is no method of flushing
(@vaddr, @size) for all pasids, which doesn't make sense. address-
selective invalidation is valid only for a given pasid. So it's not appropriate
to put them in same level of scope definition at least for VT-d.

> > > 	__u32	flags;
> > > /*  targets non-pasid mappings, @pasid is not valid */
> > > #define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
> >
> > Although it was my proposal, I don't like this flag. In ARM SMMU, we're
> > using a special mode where PASID 0 is reserved and any traffic without
> > PASID uses entry 0 of the PASID table. So I proposed the "NO_PASID" flag
> > to invalidate that special context explicitly. But this means that
> > invalidation packet targeted at that context will have "scope = PASID" and
> > "flags = NO_PASID", which is utterly confusing.
> >
> > I now think that we should get rid of the IOMMU_INVALIDATE_NO_PASID
> flag
> > and just use PASID 0 to invalidate this context on ARM. I don't think
> > other architectures would use the NO_PASID flag anyway, but might be
> mistaken.
> 
> I may suggest to keep it so far. On VT-d, we may pass some data in opaque,
> so
> we may work without it. But if other vendor want to issue non-PASID tagged
> cache, then may encounter problem.

I'm worried about what's the criteria which attribute should be abstracted
in common structure and which can be left to opaque. It doesn't make
much sense to do such abstraction purely because different vendor formats
have some common fields. Usually we do such abstraction because 
vendor-agnostic code need to do some common handling before going to
vendor specific code. However in this case VFIO is not expected to do anything
with those IOMMU specific attributes. Then the structure is directly forwarded
to IOMMU driver, which simply translates the structure into vendor specific
opaque data again. Then why bothering to do double translations in Qemu
and IOMMU driver side?

Take VT-d for example. Below is a summary of all possible selections around
invalidation of 1st level structure for svm:

Scope: All PASIDs, single PASID
for each PASID:
	all mappings, or page-selective mappings (addr, size)
invalidation target:
	IOTLB entries (leaf)
	paging structure cache (non-leaf)
	PASID cache (pasid->cr3)
invalidation hint:
	whether global pages are included
	drain reads/writes

Above are pretty architectural attributes if just looking at functional
purpose. Then if we really consider defining a common structure, it
might be more natural to define a superset of all vendors' capabilities
and remove the opaque field at all. But as said earlier the purpose of
doing such abstraction is not clear if there is no vendor-agnostic
user actually digesting those fields. Then should we reconsider the
full opaque approach?

Welcome comments since I may overlook something here. :-)

Thanks
Kevin
