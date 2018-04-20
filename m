From: Jean-Philippe Brucker <Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 05/22] iommu: introduce iommu invalidate API function
Date: Fri, 20 Apr 2018 19:19:54 +0100
Message-ID: <20180420181951.GA50099@ostrya.localdomain>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-6-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1523915351-54415-6-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Liu-U/l+663ovUtSq9BJjBFyUp/QNRX+jHPU@public.gmane.org, "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On Mon, Apr 16, 2018 at 10:48:54PM +0100, Jacob Pan wrote:
[...]
> +/**
> + * enum iommu_inv_granularity - Generic invalidation granularity
> + *
> + * When an invalidation request is sent to IOMMU to flush translation caches,
> + * it may carry different granularity. These granularity levels are not specific
> + * to a type of translation cache. For an example, PASID selective granularity
> + * is only applicable to PASID cache invalidation.

I'm still confused by this, I think we should add more definitions
because architectures tend to use different names. What you call
"Translations caches" encompasses all caches that can be invalidated
with this request, right? So all of:

* "TLB" and "DTLB" that cache IOVA->GPA and GPA->PA (TLB is in the
  IOMMU, DTLB is an ATC in an endpoint),
* "PASID cache" that cache PASID->Translation Table,
* "Context cache" that cache RID->PASID table

Does this match the model you're using?

The last name is a bit unfortunate. Since the Arm architecture uses the
name "context" for what a PASID points to, "Device cache" would suit us
better but it's not important.

I don't understand what you mean by "PASID selective granularity is only
applicable to PASID cache invalidation", it seems to contradict the
preceding sentence. What if user sends an invalidation with
IOMMU_INV_TYPE_TLB and IOMMU_INV_GRANU_ALL_PASID? Doesn't this remove
from the TLBs all entries with the given PASID?

> + * This enum is a collection of granularities for all types of translation
> + * caches. The idea is to make it easy for IOMMU model specific driver do
> + * conversion from generic to model specific value.
> + */
> +enum iommu_inv_granularity {

In patch 9, inv_type_granu_map has some valid fields with granularity ==
0. Does it mean "invalidate all caches"?

I don't think user should ever be allowed to invalidate caches entries
of devices and domains it doesn't own.

> +	IOMMU_INV_GRANU_DOMAIN = 1,	/* all TLBs associated with a domain */
> +	IOMMU_INV_GRANU_DEVICE,		/* caching structure associated with a
> +					 * device ID
> +					 */
> +	IOMMU_INV_GRANU_DOMAIN_PAGE,	/* address range with a domain */

> +	IOMMU_INV_GRANU_ALL_PASID,	/* cache of a given PASID */

If this corresponds to QI_GRAN_ALL_ALL in patch 9, the comment should be
"Cache of all PASIDs"? Or maybe "all entries for all PASIDs"? Is it
different from GRANU_DOMAIN then?

> +	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate specified PASID */
> +
> +	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within all PASIDs */
> +	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a PASIDs */

Are the "NG" variant needed since there is a IOMMU_INVALIDATE_GLOBAL_PAGE
below? We should drop either flag or granule.

FWIW I'm starting to think more granule options is actually better than
flags, because it flattens the combinations and keeps them to two
dimensions, that we can understand and explain with a table.

> +	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective within a PASID */

Maybe this should be called "NG_PAGE_PASID", and "DOMAIN_PAGE" should
instead be "PAGE_PASID". If I understood their meaning correctly, it
would be more consistent with the rest.

> +	IOMMU_INV_NR_GRANU,
> +};
> +
> +/** enum iommu_inv_type - Generic translation cache types for invalidation
> + *
> + * Invalidation requests sent to IOMMU may indicate which translation cache
> + * to be operated on.
> + * Combined with enum iommu_inv_granularity, model specific driver can do a
> + * simple lookup to convert generic type to model specific value.
> + */
> +enum iommu_inv_type {

These should be flags (1 << 0), (1 << 1) etc, since IOMMUs will want to
invalidate multiple caches at once (at least DTLB and TLB). You could
then do for_each_set_bit in the driver

> +	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
> +	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure cache */
> +	IOMMU_INV_TYPE_PASID,	/* PASID cache */
> +	IOMMU_INV_TYPE_CONTEXT,	/* device context entry cache */
> +	IOMMU_INV_NR_TYPE
> +};

We need to summarize and explain valid combinations, because reading
inv_type_granu_map and inv_type_granu_table is a bit tedious. I tried to
reproduce inv_type_granu_map here (Cell format is PASID_TAGGED /
!PASID_TAGGED). Could you check if this matches your model?

            type |   DTLB    |    TLB    |   PASID   |  CONTEXT
 granule         |           |           |           |
-----------------+-----------+-----------+-----------+-----------
   -             |     / Y   |     / Y   |           |     / Y
 DOMAIN          |           |     / Y   |           |     / Y
 DEVICE          |           |           |           |     / Y
 DOMAIN_PAGE     |           |     / Y   |           |
 ALL_PASID       |   Y       |   Y       |           |
 PASID_SEL       |   Y       |           |   Y       |
 NG_ALL_PASID    |           |   Y       |   Y       |
 NG_PASID        |           |   Y       |           |
 PAGE_PASID      |           |   Y       |           |

There is no intersection between PASID_TAGGED and !PASID_TAGGED (Y/Y),
so the flag might not be needed.

I think the API can be more relaxed. Each IOMMU driver can add more
restrictions, but I think the SMMU can support these combinations:

              |   DTLB    |    TLB    |   PASID   |  CONTEXT
--------------+-----------+-----------+-----------+-----------
 DOMAIN       |    Y      |     Y     |     Y     |     Y
 DEVICE       |    Y      |     Y     |     Y     |     Y
 DOMAIN_PAGE  |    Y      |     Y     |           |
 ALL_PASID    |    Y      |     Y     |     Y     |
 PASID_SEL    |    Y      |     Y     |     Y     |
 NG_ALL_PASID |    Y      |     Y     |     Y     |
 NG_PASID     |    Y      |     Y     |     Y     |
 PAGE_PASID   |    Y      |     Y     |           |

Two are missing in the PASID column because it doesn't make any sense to
target the PASID cache with a page-selective invalidation. And for the
context cache, we can only invalidate per device or per domain. So I
think this is the biggest set of allowed combinations.


> +
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

Maybe start the size at 1 byte, we don't know what sort of granularity
future architectures will offer.

> + * @pasid:		processor address space ID value per PCI spec.
> + * @addr:		page address to be invalidated
> + * @flags	IOMMU_INVALIDATE_PASID_TAGGED: DMA with PASID tagged,
> + *						@pasid validity can be
> + *						deduced from @granularity

This is really hurting my brain... Two dimensions was already difficult,
but I can't follow anymore. What does PASID_TAGGED say if not "@pasid is
valid"? I thought VT-d mandated PASID for nested translation?

> + *		IOMMU_INVALIDATE_ADDR_LEAF: leaf paging entries
> + *		IOMMU_INVALIDATE_GLOBAL_PAGE: global pages
> + *
> + */
> +struct tlb_invalidate_info {
> +	struct tlb_invalidate_hdr	hdr;
> +	enum iommu_inv_granularity	granularity;
> +	__u32		flags;
> +#define IOMMU_INVALIDATE_NO_PASID	(1 << 0)

I suggested NO_PASID because Arm can have pasid-tagged and one no-pasid
address spaces within the same domain in DSS0 mode. AMD would also need
this for their GIoV mode, if I understood it correctly.

When specifying NO_PASID, the user invalidates mappings for the address
space that doesn't have a PASID, but the same granularities as PASID
contexts apply. I now think we can remove the NO_PASID flag and avoid a
lot of confusion.

The GIoV and DSS0 modes are implemented by reserving entry 0 of the
PASID table for NO_PASID translations. Given that the guest specifies
this mode at BIND_TABLE time, the host understands that when the guest
invalidates PASID 0, if GIoV or DSS0 was enabled, then the invalidation
applies to the NO_PASID context. So you can drop this flag in my
opinion.

Thanks,
Jean
