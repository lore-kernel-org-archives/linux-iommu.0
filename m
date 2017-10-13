From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 4/4] vfio/type1: Gather TLB-syncs and pages to unpin
Date: Fri, 13 Oct 2017 11:02:43 -0600
Message-ID: <20171013110243.1ed895f7@t450s.home>
References: <1507905613-30695-1-git-send-email-joro@8bytes.org>
        <1507905613-30695-5-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507905613-30695-5-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On Fri, 13 Oct 2017 16:40:13 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> From: Joerg Roedel <jroedel@suse.de>
> 
> After every unmap VFIO unpins the pages that where mapped by
> the IOMMU. This requires an IOTLB flush after every unmap
> and puts a high load on the IOMMU hardware and the device
> TLBs.
> 
> Gather up to 32 ranges to flush and unpin and do the IOTLB
> flush once for all these ranges. This significantly reduces
> the number of IOTLB flushes in the unmapping path.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 106 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 2b1e81f..86fc1da 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -107,6 +107,92 @@ struct vfio_pfn {
>  
>  static int put_pfn(unsigned long pfn, int prot);
>  
> +static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
> +				    unsigned long pfn, long npage,
> +				    bool do_accounting);
> +
> +#define GATHER_ENTRIES	32

What heuristics make us arrive at this number and how would we evaluate
changing it in the future?  Ideally we'd only want to do a single
flush, but we can't unpin pages until after the iommu sync and we need
the iommu to track iova-phys mappings, so it's a matter of how much do
we want to allocate to buffer those translations.  I wonder if a cache
pool would help here, but this is probably fine for a first pass with
some comment about this trade-off and why 32 was chosen.

> +
> +/*
> + * Gather TLB flushes before unpinning pages
> + */
> +struct vfio_gather_entry {
> +	dma_addr_t iova;
> +	phys_addr_t phys;
> +	size_t size;
> +};
> +
> +struct vfio_gather {
> +	unsigned fill;
> +	struct vfio_gather_entry entries[GATHER_ENTRIES];
> +};
> +
> +/*
> + * The vfio_gather* functions below keep track of flushing the IOMMU TLB
> + * and unpinning the pages. It is safe to call them gather == NULL, in
> + * which case they will fall-back to flushing the TLB and unpinning the
> + * pages at every call.
> + */
> +static long vfio_gather_flush(struct iommu_domain *domain,
> +			      struct vfio_dma *dma,
> +			      struct vfio_gather *gather)
> +{
> +	long unlocked = 0;
> +	unsigned i;
> +
> +	if (!gather)

|| !gather->fill

We might have gotten lucky that our last add triggered a flush.

> +		goto out;
> +
> +	/* First flush unmapped TLB entries */
> +	iommu_tlb_sync(domain);
> +
> +	for (i = 0; i < gather->fill; i++) {
> +		dma_addr_t iova = gather->entries[i].iova;
> +		phys_addr_t phys = gather->entries[i].phys;
> +		size_t size = gather->entries[i].size;
> +
> +		unlocked += vfio_unpin_pages_remote(dma, iova,
> +						    phys >> PAGE_SHIFT,
> +						    size >> PAGE_SHIFT,
> +						    false);
> +	}
> +
> +	gather->fill = 0;


A struct vfio_gather_entry* would clean this up and eliminate some
variables, including i.

> +
> +out:
> +	return unlocked;
> +}
> +
> +static long vfio_gather_add(struct iommu_domain *domain,
> +			    struct vfio_dma *dma,
> +			    struct vfio_gather *gather,
> +			    dma_addr_t iova, phys_addr_t phys, size_t size)
> +{
> +	long unlocked = 0;
> +
> +	if (gather) {
> +		unsigned index;
> +
> +		if (gather->fill == GATHER_ENTRIES)
> +			unlocked = vfio_gather_flush(domain, dma, gather);

                        unlocked += vfio_unpin_pages_remote(...);
                } else {

IOW, vfio_gather_flush() has already done the iommu_tlb_sync() for the
mapping that called us, there's no point in adding these to our list,
unpin them immediate.

> +
> +		index = gather->fill++;
> +
> +		gather->entries[index].iova = iova;
> +		gather->entries[index].phys = phys;
> +		gather->entries[index].size = size;

Alternatively, do the test and flush here instead.

Thanks,
Alex

> +	} else {
> +		iommu_tlb_sync(domain);
> +
> +		unlocked = vfio_unpin_pages_remote(dma, iova,
> +						   phys >> PAGE_SHIFT,
> +						   size >> PAGE_SHIFT,
> +						   false);
> +	}
> +
> +	return unlocked;
> +}
> +
>  /*
>   * This code handles mapping and unmapping of user data buffers
>   * into DMA'ble space using the IOMMU
> @@ -653,6 +739,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  {
>  	dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
>  	struct vfio_domain *domain, *d;
> +	struct vfio_gather *gather;
>  	long unlocked = 0;
>  
>  	if (!dma->size)
> @@ -662,6 +749,12 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  		return 0;
>  
>  	/*
> +	 * No need to check return value - It is safe to continue with a
> +	 * NULL pointer.
> +	 */
> +	gather = kzalloc(sizeof(*gather), GFP_KERNEL);
> +
> +	/*
>  	 * We use the IOMMU to track the physical addresses, otherwise we'd
>  	 * need a much more complicated tracking system.  Unfortunately that
>  	 * means we need to use one of the iommu domains to figure out the
> @@ -706,17 +799,20 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  			break;
>  
>  		iommu_tlb_range_add(domain->domain, iova, unmapped);
> -		iommu_tlb_sync(domain->domain);
>  
> -		unlocked += vfio_unpin_pages_remote(dma, iova,
> -						    phys >> PAGE_SHIFT,
> -						    unmapped >> PAGE_SHIFT,
> -						    false);
> +		unlocked += vfio_gather_add(domain->domain, dma, gather,
> +					    iova, phys, unmapped);
> +
>  		iova += unmapped;
>  
>  		cond_resched();
>  	}
>  
> +	unlocked += vfio_gather_flush(domain->domain, dma, gather);
> +
> +	kfree(gather);
> +	gather = NULL;
> +
>  	dma->iommu_mapped = false;
>  	if (do_accounting) {
>  		vfio_lock_acct(dma->task, -unlocked, NULL);
