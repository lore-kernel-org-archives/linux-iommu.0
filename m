From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 03/16] iommu: introduce iommu invalidate API function
Date: Tue, 10 Oct 2017 15:35:42 +0200
Message-ID: <20171010133542.juag7cwbivlb56sl@8bytes.org>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-4-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1507244624-39189-4-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liu-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 05, 2017 at 04:03:31PM -0700, Jacob Pan wrote:
> +int iommu_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info)

This name is way too generic, it should at least be called
iommu_svm_invalidate() or something like that. With the name above it is
easily confused with the other TLB invalidation functions of the
IOMMU-API.

> +enum iommu_inv_granularity {
> +	IOMMU_INV_GRANU_GLOBAL,		/* all TLBs invalidated */

Is that needed? We certainly don't want to give userspace/guests that
fine-grained control about IOMMU cache invalidations.

In the end a guest issues flush-global command does not translate to a
flush-global on the host, but to separate flushes for the domains the
guest uses.

> +	IOMMU_INV_GRANU_DOMAIN,		/* all TLBs associated with a domain */
> +	IOMMU_INV_GRANU_DEVICE,		/* caching structure associated with a
> +					 * device ID

What is the difference between a DOMAIN and a DEVICE flush?

> +	IOMMU_INV_GRANU_DOMAN_PAGE,	/* address range with a domain */
> +	IOMMU_INV_GRANU_ALL_PASID,	/* cache of a given PASID */
> +	IOMMU_INV_GRANU_PASID_SEL,	/* only invalidate specified PASID */
> +
> +	IOMMU_INV_GRANU_NG_ALL_PASID,	/* non-global within all PASIDs */
> +	IOMMU_INV_GRANU_NG_PASID,	/* non-global within a PASIDs */
> +	IOMMU_INV_GRANU_PAGE_PASID,	/* page-selective within a PASID */
> +	IOMMU_INV_NR_GRANU,
> +};
> +
> +enum iommu_inv_type {
> +	IOMMU_INV_TYPE_DTLB,	/* device IOTLB */
> +	IOMMU_INV_TYPE_TLB,	/* IOMMU paging structure cache */
> +	IOMMU_INV_TYPE_PASID,	/* PASID cache */
> +	IOMMU_INV_TYPE_CONTEXT,	/* device context entry cache */

Is that really needed? When the guest updates it context-entry
equivalent it translates to bind_pasid_table/unbind_pasid_table calls,
no?
