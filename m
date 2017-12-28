From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 03/16] iommu: introduce iommu invalidate API function
Date: Thu, 28 Dec 2017 11:25:18 -0800
Message-ID: <20171228112518.76f9194b@jacob-builder>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1510944914-54430-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<9fe883f7-8650-20f2-4db1-1539b3e927ae@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9fe883f7-8650-20f2-4db1-1539b3e927ae-5wv7dgnIgG8@public.gmane.org>
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
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org" <Liu-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 24 Nov 2017 12:04:31 +0000
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> Hi,
> 
> On 17/11/17 18:55, Jacob Pan wrote:
> > From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > When an SVM capable device is assigned to a guest, the first level
> > page tables are owned by the guest and the guest PASID table
> > pointer is linked to the device context entry of the physical IOMMU.
> > 
> > Host IOMMU driver has no knowledge of caching structure updates
> > unless the guest invalidation activities are passed down to the
> > host. The primary usage is derived from emulated IOMMU in the
> > guest, where QEMU can trap invalidation activities before passing
> > them down to the host/physical IOMMU.
> > Since the invalidation data are obtained from user space and will be
> > written into physical IOMMU, we must allow security check at various
> > layers. Therefore, generic invalidation data format are proposed
> > here, model specific IOMMU drivers need to convert them into their
> > own format.
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>  
> [...]
> >  #endif /* __LINUX_IOMMU_H */
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 651ad5d..039ba36 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -36,4 +36,66 @@ struct pasid_table_config {
> >  	};
> >  };
> >  
> > +enum iommu_inv_granularity {
> > +	IOMMU_INV_GRANU_GLOBAL,		/* all TLBs
> > invalidated */
> > +	IOMMU_INV_GRANU_DOMAIN,		/* all TLBs
> > associated with a domain */
> > +	IOMMU_INV_GRANU_DEVICE,		/* caching
> > structure associated with a
> > +					 * device ID
> > +					 */  
> 
> I thought you were planning on removing these? If we do need global
> invalidation, for example the guest clears the whole PASID table and
> doesn't want to send individual GRANU_ALL_PASID invalidations, maybe
> keep only GRANU_DOMAIN?
> 
yes, we can remove global and keep domain & pasid.
> > +	IOMMU_INV_GRANU_DOMAIN_PAGE,	/* address range with
> > a domain */
> > +	IOMMU_INV_GRANU_ALL_PASID,	/* cache of a given
> > PASID */
> > +	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate
> > specified PASID */  
> 
> GRANU_PASID_SEL seems redundant, don't you already get it by default
> with GRANU_ALL_PASID and GRANU_DOMAIN_PAGE (with
> IOMMU_INVALIDATE_PASID_TAGGED flag)?
> 
yes, you can deduce from certain combinations of flags. My thinking
was for an easy look up from generic flags to model specific
fields. Same as the one below. I will try to consolidate based on your
input in the next version.
> > +
> > +	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within
> > all PASIDs */
> > +	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a
> > PASIDs */  
> 
> Don't you get the "NG" behavior by not passing the
> IOMMU_INVALIDATE_GLOBAL_PAGE flag defined below?
> 
> > +	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective
> > within a PASID */  
> 
> And don't you get this with
> GRANU_DOMAIN_PAGE+IOMMU_INVALIDATE_PASID_TAGGED?
> 
> > +	IOMMU_INV_NR_GRANU,
> > +};
> > +
> > +enum iommu_inv_type {
> > +	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
> > +	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure cache
> > */
> > +	IOMMU_INV_TYPE_PASID,	/* PASID cache */
> > +	IOMMU_INV_TYPE_CONTEXT,	/* device context entry
> > cache */
> > +	IOMMU_INV_NR_TYPE
> > +};  
> 
> When the guest removes a PASID entry, it would have to send DTLB, TLB
> and PASID invalidations separately? Could we define this inv_type as
> cumulative, to avoid redundant invalidation requests:
> 
That is a good idea, but it will require some change to VT-d driver.
For emulated IOMMU and current VT-d driver, we do send separate
requests for PASID cache, followed by IOTLB/DTLB invalidation. But we do
have a caching mode capability bit to tell the driver whether it is
running on a real IOMMU or not. So we can combine and reduce
invalidation overhead as you said below. Not sure about AMD though?

> * TYPE_DTLB only invalidates ATC entries.
> * TYPE_TLB invalidates both ATC and IOTLB entries.
> * TYPE_PASID invalidates all ATC and IOTLB entries for a PASID, and
> also the PASID cache entry.
Sounds good to me.

> * TYPE_CONTEXT invalidates all. Although is it needed by userspace or
> just here fore completeness? "CONTEXT" is specific to VT-d (doesn't
> exist on AMD and has a different meaning on SMMU), how about "DEVICE"
> instead?
It is here for completeness. context entry is set during bind/unbind
pasid table call. I can remove it for now.
> 
> This is important because invalidation will probably become the
> bottleneck. The guest shouldn't have to send DTLB and TLB invalidation
> separately after each unmapping.
> 
Agreed, i will change the VT-d driver to accommodate that. i.e. For
emulated IOMMU (Caching Mode == 1), no need to send redundant
invalidation request.
> > +/**
> > + * Translation cache invalidation header that contains mandatory
> > meta data.
> > + * @version:	info format version, expecting future extesions
> > + * @type:	type of translation cache to be invalidated
> > + */
> > +struct tlb_invalidate_hdr {
> > +	__u32 version;
> > +#define TLB_INV_HDR_VERSION_1 1
> > +	enum iommu_inv_type type;
> > +};
> > +
> > +/**
> > + * Translation cache invalidation information, contains generic
> > IOMMU
> > + * data which can be parsed based on model ID by model specific
> > drivers.
> > + *
> > + * @granularity:	requested invalidation granularity, type
> > dependent
> > + * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB,
> > etc.  
> 
> Having only power of two invalidation seems too restrictive for a
> software interface. You might have the same problem as above, where
> the guest or userspace needs to send lots of invalidation requests,
> They could be multiplexed by passing an arbitrary range instead. How
> about making @size a __u64?
> 
Sure if you have such need for non power of two. So it will be __u64 of
4k pages?

> > + * @pasid:		processor address space ID value per PCI
> > spec.
> > + * @addr:		page address to be invalidated
> > + * @flags	IOMMU_INVALIDATE_PASID_TAGGED: DMA with PASID
> > tagged,
> > + *						@pasid validity
> > can be
> > + *						deduced from
> > @granularity  
> 
> What's the use for this PASID_TAGGED flag if it doesn't define the
> @pasid validity?
> 
VT-d uses different table format based on this PASID_TAGGED flag. With
PASID_TAGGED set, @pasid could still be invalid if the granularity is
not at PASID selective level.
> > + *		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries  
> 
> LEAF could be reused for multi-level PASID tables, when your
> first-level table is already in place and you install a leaf entry,
> so maybe this could be:
> 
> "IOMMU_INVALIDATE_LEAF: only invalidate leaf table entry"
> 
Sounds good. Assume we will only have 2 levels for the foreseeable
future.
> Thanks,
> Jean
> 
> > + *		IOMMU_INVALIDATE_GLOBAL_PAGE: global pages> + *
> > + */
> > +struct tlb_invalidate_info {
> > +	struct tlb_invalidate_hdr	hdr;
> > +	enum iommu_inv_granularity	granularity;
> > +	__u32		flags;
> > +#define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
> > +#define IOMMU_INVALIDATE_ADDR_LEAF	(1 << 1)
> > +#define IOMMU_INVALIDATE_GLOBAL_PAGE	(1 << 2)
> > +#define IOMMU_INVALIDATE_PASID_TAGGED	(1 << 3)
> > +	__u8		size;
> > +	__u32		pasid;
> > +	__u64		addr;
> > +};
> >  #endif /* _UAPI_IOMMU_H */
> >   
> 

[Jacob Pan]
