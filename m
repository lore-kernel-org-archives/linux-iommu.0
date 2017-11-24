From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 03/16] iommu: introduce iommu invalidate API function
Date: Fri, 24 Nov 2017 12:04:31 +0000
Message-ID: <9fe883f7-8650-20f2-4db1-1539b3e927ae@arm.com>
References: <1510944914-54430-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1510944914-54430-4-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510944914-54430-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, "Liu@mail.linuxfoundation.org" <Liu@mail.linuxfoundation.org>, Jean Delvare <khali@linux-fr.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 17/11/17 18:55, Jacob Pan wrote:
> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> When an SVM capable device is assigned to a guest, the first level page
> tables are owned by the guest and the guest PASID table pointer is
> linked to the device context entry of the physical IOMMU.
> 
> Host IOMMU driver has no knowledge of caching structure updates unless
> the guest invalidation activities are passed down to the host. The
> primary usage is derived from emulated IOMMU in the guest, where QEMU
> can trap invalidation activities before passing them down to the
> host/physical IOMMU.
> Since the invalidation data are obtained from user space and will be
> written into physical IOMMU, we must allow security check at various
> layers. Therefore, generic invalidation data format are proposed here,
> model specific IOMMU drivers need to convert them into their own format.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
[...]
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 651ad5d..039ba36 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -36,4 +36,66 @@ struct pasid_table_config {
>  	};
>  };
>  
> +enum iommu_inv_granularity {
> +	IOMMU_INV_GRANU_GLOBAL,		/* all TLBs invalidated */
> +	IOMMU_INV_GRANU_DOMAIN,		/* all TLBs associated with a domain */
> +	IOMMU_INV_GRANU_DEVICE,		/* caching structure associated with a
> +					 * device ID
> +					 */

I thought you were planning on removing these? If we do need global
invalidation, for example the guest clears the whole PASID table and
doesn't want to send individual GRANU_ALL_PASID invalidations, maybe keep
only GRANU_DOMAIN?

> +	IOMMU_INV_GRANU_DOMAIN_PAGE,	/* address range with a domain */
> +	IOMMU_INV_GRANU_ALL_PASID,	/* cache of a given PASID */
> +	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate specified PASID */

GRANU_PASID_SEL seems redundant, don't you already get it by default with
GRANU_ALL_PASID and GRANU_DOMAIN_PAGE (with IOMMU_INVALIDATE_PASID_TAGGED
flag)?

> +
> +	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within all PASIDs */
> +	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a PASIDs */

Don't you get the "NG" behavior by not passing the
IOMMU_INVALIDATE_GLOBAL_PAGE flag defined below?

> +	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective within a PASID */

And don't you get this with GRANU_DOMAIN_PAGE+IOMMU_INVALIDATE_PASID_TAGGED?

> +	IOMMU_INV_NR_GRANU,
> +};
> +
> +enum iommu_inv_type {
> +	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
> +	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure cache */
> +	IOMMU_INV_TYPE_PASID,	/* PASID cache */
> +	IOMMU_INV_TYPE_CONTEXT,	/* device context entry cache */
> +	IOMMU_INV_NR_TYPE
> +};

When the guest removes a PASID entry, it would have to send DTLB, TLB and
PASID invalidations separately? Could we define this inv_type as
cumulative, to avoid redundant invalidation requests:

* TYPE_DTLB only invalidates ATC entries.
* TYPE_TLB invalidates both ATC and IOTLB entries.
* TYPE_PASID invalidates all ATC and IOTLB entries for a PASID, and also
the PASID cache entry.
* TYPE_CONTEXT invalidates all. Although is it needed by userspace or just
here fore completeness? "CONTEXT" is specific to VT-d (doesn't exist on
AMD and has a different meaning on SMMU), how about "DEVICE" instead?

This is important because invalidation will probably become the
bottleneck. The guest shouldn't have to send DTLB and TLB invalidation
separately after each unmapping.

> +/**
> + * Translation cache invalidation header that contains mandatory meta data.
> + * @version:	info format version, expecting future extesions
> + * @type:	type of translation cache to be invalidated
> + */
> +struct tlb_invalidate_hdr {
> +	__u32 version;
> +#define TLB_INV_HDR_VERSION_1 1
> +	enum iommu_inv_type type;
> +};
> +
> +/**
> + * Translation cache invalidation information, contains generic IOMMU
> + * data which can be parsed based on model ID by model specific drivers.
> + *
> + * @granularity:	requested invalidation granularity, type dependent
> + * @size:		2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.

Having only power of two invalidation seems too restrictive for a software
interface. You might have the same problem as above, where the guest or
userspace needs to send lots of invalidation requests, They could be
multiplexed by passing an arbitrary range instead. How about making @size
a __u64?

> + * @pasid:		processor address space ID value per PCI spec.
> + * @addr:		page address to be invalidated
> + * @flags	IOMMU_INVALIDATE_PASID_TAGGED: DMA with PASID tagged,
> + *						@pasid validity can be
> + *						deduced from @granularity

What's the use for this PASID_TAGGED flag if it doesn't define the @pasid
validity?

> + *		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries

LEAF could be reused for multi-level PASID tables, when your first-level
table is already in place and you install a leaf entry, so maybe this
could be:

"IOMMU_INVALIDATE_LEAF: only invalidate leaf table entry"

Thanks,
Jean

> + *		IOMMU_INVALIDATE_GLOBAL_PAGE: global pages> + *
> + */
> +struct tlb_invalidate_info {
> +	struct tlb_invalidate_hdr	hdr;
> +	enum iommu_inv_granularity	granularity;
> +	__u32		flags;
> +#define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
> +#define IOMMU_INVALIDATE_ADDR_LEAF	(1 << 1)
> +#define IOMMU_INVALIDATE_GLOBAL_PAGE	(1 << 2)
> +#define IOMMU_INVALIDATE_PASID_TAGGED	(1 << 3)
> +	__u8		size;
> +	__u32		pasid;
> +	__u64		addr;
> +};
>  #endif /* _UAPI_IOMMU_H */
> 
