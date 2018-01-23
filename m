From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3] vfio/type1: Adopt fast IOTLB flush interface when
 unmap IOVAs
Date: Tue, 23 Jan 2018 15:04:52 -0700
Message-ID: <20180123150452.03a42c53@w520.home>
References: <1516595377-4681-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516595377-4681-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, joro@8bytes.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

Hi Suravee,

On Sun, 21 Jan 2018 23:29:37 -0500
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which requires
> IOTLB flushing for every unmapping. This results in large IOTLB flushing
> overhead when handling pass-through devices has a large number of mapped
> IOVAs (e.g. GPUs). This could also cause IOTLB invalidate time-out issue
> on AMD IOMMU with certain dGPUs.

Nit, GPUs don't imply a larger number of mapped IOVAs than any
other type of device, QEMU statically maps the entire VM address space
regardless of the device type.  I am curious though which dGPUs and what
size guests experience this problem, I'd also like to have those
details in the commit log.  Is there any performance data to go along
with this?

> This can be avoided by using the new IOTLB flushing interface.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
> Changes from V2: (https://lkml.org/lkml/2017/12/27/43)
> 
>   * In vfio_unmap_unpin(), fallback to use slow IOTLB flush
>     when fast IOTLB flush fails (per Alex).
> 
>   * Do not adopt fast IOTLB flush in map_try_harder().
> 
>   * Submit VFIO and AMD IOMMU patches separately.
> 
>  drivers/vfio/vfio_iommu_type1.c | 98 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e30e29a..5c40b00 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -102,6 +102,13 @@ struct vfio_pfn {
>  	atomic_t		ref_count;
>  };
>  
> +struct vfio_regions {
> +	struct list_head list;
> +	dma_addr_t iova;
> +	phys_addr_t phys;
> +	size_t len;
> +};
> +
>  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
>  					(!list_empty(&iommu->domain_list))
>  
> @@ -479,6 +486,36 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
>  	return unlocked;
>  }
>  
> +/*
> + * Generally, VFIO needs to unpin remote pages after each IOTLB flush.
> + * Therefore, when using IOTLB flush sync interface, VFIO need to keep track
> + * of these regions (currently using a list).
> + *
> + * This value specifies maximum number of regions for each IOTLB flush sync.
> + */
> +#define VFIO_IOMMU_TLB_SYNC_MAX		512
> +
> +static long vfio_sync_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
> +				struct list_head *regions)
> +{
> +	long unlocked = 0;
> +	struct vfio_regions *entry, *next;
> +
> +	iommu_tlb_sync(domain->domain);
> +
> +	list_for_each_entry_safe(entry, next, regions, list) {
> +		unlocked += vfio_unpin_pages_remote(dma,
> +						    entry->iova,
> +						    entry->phys >> PAGE_SHIFT,
> +						    entry->len >> PAGE_SHIFT,
> +						    false);
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +	cond_resched();
> +	return unlocked;
> +}
> +
>  static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
>  				  unsigned long *pfn_base, bool do_accounting)
>  {
> @@ -648,12 +685,40 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
>  	return i > npage ? npage : (i > 0 ? i : -EINVAL);
>  }
>  
> +static size_t try_unmap_unpin_fast(struct vfio_domain *domain, dma_addr_t iova,
> +				   size_t len, phys_addr_t phys,
> +				   struct list_head *unmapped_regions)
> +{
> +	struct vfio_regions *entry;
> +	size_t unmapped;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;

size_t is unsigned, so pushing -ENOMEM out though this unsigned
function and the callee interpreting it as unsigned, means we're going
to see this as a very large unmap, not an error condition.  Looks like
the IOMMU API has problems in this space too, ex. iommu_unmap(), Joerg?

> +
> +	unmapped = iommu_unmap_fast(domain->domain, iova, len);
> +	if (WARN_ON(!unmapped)) {
> +		kfree(entry);
> +		return -EINVAL;
> +	}

Not sure about the handling of this, the zero check is just a
consistency validation.  If there's nothing mapped where we think there
should be something mapped, we warn and throw out the whole vfio_dma.
After this patch, such an error gets warned twice, which doesn't
really seem to be an improvement.

> +
> +	iommu_tlb_range_add(domain->domain, iova, unmapped);
> +	entry->iova = iova;
> +	entry->phys = phys;
> +	entry->len  = unmapped;
> +	list_add_tail(&entry->list, unmapped_regions);
> +	return unmapped;
> +}
> +
>  static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  			     bool do_accounting)
>  {
>  	dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
>  	struct vfio_domain *domain, *d;
> +	struct list_head unmapped_regions;
> +	bool use_fastpath = true;
>  	long unlocked = 0;
> +	int cnt = 0;
>  
>  	if (!dma->size)
>  		return 0;
> @@ -661,6 +726,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
>  		return 0;
>  
> +	INIT_LIST_HEAD(&unmapped_regions);
> +
>  	/*
>  	 * We use the IOMMU to track the physical addresses, otherwise we'd
>  	 * need a much more complicated tracking system.  Unfortunately that
> @@ -698,6 +765,33 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  				break;
>  		}
>  
> +		/*
> +		 * First, try to use fast unmap/unpin. In case of failure,
> +		 * sync upto the current point, and continue the slow
> +		 * unmap/unpin path.
> +		 */
> +		if (use_fastpath) {
> +			unmapped = try_unmap_unpin_fast(domain, iova,
> +							len, phys,
> +							&unmapped_regions);
> +			if (unmapped > 0) {
> +				iova += unmapped;
> +				cnt++;
> +			} else {
> +				use_fastpath = false;
> +			}
> +
> +			if (cnt >= VFIO_IOMMU_TLB_SYNC_MAX || !use_fastpath) {
> +				unlocked += vfio_sync_unpin(dma, domain,
> +							    &unmapped_regions);
> +				cnt = 0;
> +			}
> +
> +			if (use_fastpath)
> +				continue;
> +		}

It seems sufficient on a fast path failure to sync and unpin the list
and continue.  It would probably be wise to single (slow) step the
failing entry to guarantee forward progress, but I don't see an
advantage to switching to only slow mode for the full remainder of the
vfio_dma.  Thanks,

Alex

> +
> +		/* Slow unmap/unpin path */
>  		unmapped = iommu_unmap(domain->domain, iova, len);
>  		if (WARN_ON(!unmapped))
>  			break;
> @@ -712,6 +806,10 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  	}
>  
>  	dma->iommu_mapped = false;
> +
> +	if (cnt)
> +		unlocked += vfio_sync_unpin(dma, domain, &unmapped_regions);
> +
>  	if (do_accounting) {
>  		vfio_lock_acct(dma->task, -unlocked, NULL);
>  		return 0;
