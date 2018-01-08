From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/2] vfio/type1: Adopt fast IOTLB flush interface
	when unmap IOVAs
Date: Mon, 8 Jan 2018 14:07:18 -0700
Message-ID: <20180108140718.5ce48492@t450s.home>
References: <1514366435-12723-1-git-send-email-suravee.suthikulpanit@amd.com>
	<1514366435-12723-2-git-send-email-suravee.suthikulpanit@amd.com>
	<20180108135329.3c1e2c88@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180108135329.3c1e2c88-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 8 Jan 2018 13:53:29 -0700
Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Wed, 27 Dec 2017 04:20:34 -0500
> Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org> wrote:
> 
> > VFIO IOMMU type1 currently upmaps IOVA pages synchronously, which requires
> > IOTLB flushing for every unmapping. This results in large IOTLB flushing
> > overhead when handling pass-through devices has a large number of mapped
> > IOVAs.
> > 
> > This can be avoided by using the new IOTLB flushing interface.  
> 
> Hi Suravee,
> 
> I've been playing with other ways we might do this, but I can't come up
> with anything better.  A few comments below...
> 
> > 
> > Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 89 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 77 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index e30e29a..f000844 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -102,6 +102,13 @@ struct vfio_pfn {
> >  	atomic_t		ref_count;
> >  };
> >  
> > +struct vfio_regions{
> > +	struct list_head list;
> > +	dma_addr_t iova;
> > +	phys_addr_t phys;
> > +	size_t len;
> > +};
> > +
> >  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
> >  					(!list_empty(&iommu->domain_list))
> >  
> > @@ -479,6 +486,40 @@ static long vfio_unpin_pages_remote(struct vfio_dma *dma, dma_addr_t iova,
> >  	return unlocked;
> >  }
> >  
> > +/*
> > + * Generally, VFIO needs to unpin remote pages after each IOTLB flush.
> > + * Therefore, when using IOTLB flush sync interface, VFIO need to keep track
> > + * of these regions (currently using a list).
> > + *
> > + * This value specifies maximum number of regions for each IOTLB flush sync.
> > + */
> > +#define VFIO_IOMMU_TLB_SYNC_MAX		512  
> 
> Is this an arbitrary value or are there non-obvious considerations for
> this value should we want to further tune it in the future?
> 
> > +
> > +static long vfio_sync_and_unpin(struct vfio_dma *dma, struct vfio_domain *domain,
> > +				struct list_head *regions, bool do_accounting)
> > +{
> > +	long unlocked = 0;
> > +	struct vfio_regions *entry, *next;
> > +
> > +	iommu_tlb_sync(domain->domain);
> > +
> > +	list_for_each_entry_safe(entry, next, regions, list) {
> > +		unlocked += vfio_unpin_pages_remote(dma,
> > +						    entry->iova,
> > +						    entry->phys >> PAGE_SHIFT,
> > +						    entry->len >> PAGE_SHIFT,
> > +						    false);
> > +		list_del(&entry->list);
> > +		kfree(entry);
> > +	}
> > +
> > +	if (do_accounting) {
> > +		vfio_lock_acct(dma->task, -unlocked, NULL);
> > +		return 0;
> > +	}
> > +	return unlocked;
> > +}
> > +
> >  static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
> >  				  unsigned long *pfn_base, bool do_accounting)
> >  {
> > @@ -653,7 +694,10 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >  {
> >  	dma_addr_t iova = dma->iova, end = dma->iova + dma->size;
> >  	struct vfio_domain *domain, *d;
> > +	struct list_head unmapped_regions;
> > +	struct vfio_regions *entry;
> >  	long unlocked = 0;
> > +	int cnt = 0;
> >  
> >  	if (!dma->size)
> >  		return 0;
> > @@ -661,6 +705,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >  	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
> >  		return 0;
> >  
> > +	INIT_LIST_HEAD(&unmapped_regions);
> > +
> >  	/*
> >  	 * We use the IOMMU to track the physical addresses, otherwise we'd
> >  	 * need a much more complicated tracking system.  Unfortunately that
> > @@ -698,24 +744,36 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >  				break;
> >  		}
> >  
> > -		unmapped = iommu_unmap(domain->domain, iova, len);
> > -		if (WARN_ON(!unmapped))
> > +		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > +		if (!entry)
> >  			break;


Turns out this nagged at me a bit too, this function only gets called
once to dump the vfio_dma, so bailing out here leaves pages pinned and
IOMMU mappings in place, for a performance optimization that we could
just skip.  We could sync&unpin anything collected up to this point and
continue this step with a synchronous unmap/unpin.  Thanks,

Alex

> >  
> > -		unlocked += vfio_unpin_pages_remote(dma, iova,
> > -						    phys >> PAGE_SHIFT,
> > -						    unmapped >> PAGE_SHIFT,
> > -						    false);
> > +		unmapped = iommu_unmap_fast(domain->domain, iova, len);
> > +		if (WARN_ON(!unmapped)) {
> > +			kfree(entry);
> > +			break;
> > +		}
> > +
> > +		iommu_tlb_range_add(domain->domain, iova, unmapped);
> > +		entry->iova = iova;
> > +		entry->phys = phys;
> > +		entry->len  = unmapped;
> > +		list_add_tail(&entry->list, &unmapped_regions);
> > +		cnt++;
> >  		iova += unmapped;
> >  
> > +		if (cnt >= VFIO_IOMMU_TLB_SYNC_MAX) {
> > +			unlocked += vfio_sync_and_unpin(dma, domain, &unmapped_regions,
> > +							do_accounting);  
> 
> Exceeds 80 columns here.
> 
> > +			cnt = 0;
> > +		}
> >  		cond_resched();
> >  	}
> >  
> > +	if (cnt)
> > +		unlocked += vfio_sync_and_unpin(dma, domain, &unmapped_regions,
> > +						do_accounting);
> >  	dma->iommu_mapped = false;
> > -	if (do_accounting) {
> > -		vfio_lock_acct(dma->task, -unlocked, NULL);
> > -		return 0;
> > -	}
> >  	return unlocked;
> >  }
> >  
> > @@ -878,6 +936,7 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
> >  {
> >  	long i;
> >  	int ret = 0;
> > +	size_t unmapped = 0;
> >  
> >  	for (i = 0; i < npage; i++, pfn++, iova += PAGE_SIZE) {
> >  		ret = iommu_map(domain->domain, iova,
> > @@ -887,8 +946,14 @@ static int map_try_harder(struct vfio_domain *domain, dma_addr_t iova,
> >  			break;
> >  	}
> >  
> > -	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE)
> > -		iommu_unmap(domain->domain, iova, PAGE_SIZE);
> > +	for (; i < npage && i > 0; i--, iova -= PAGE_SIZE) {
> > +		unmapped = iommu_unmap_fast(domain->domain, iova, PAGE_SIZE);
> > +		if (WARN_ON(!unmapped))
> > +			break;
> > +		iommu_tlb_range_add(domain->domain, iova, unmapped);
> > +	}
> > +	if (unmapped)
> > +		iommu_tlb_sync(domain->domain);  
> 
> Using unmapped here seems a little sketchy, for instance if we got back
> zero on the last call to iommu_unmap_fast() but had other ranges queued
> for flush.  Do we even need a WARN_ON and break here, are we just
> trying to skip adding a zero range?  The intent is that we either leave
> this function with everything mapped or nothing mapped, so perhaps we
> should warn and continue.  Assuming a spurious sync is ok, we could
> check (i < npage) for the sync condition, the only risk being we had no
> mappings at all and therefore no unmaps.
> 
> TBH, I wonder if this function is even needed anymore or if the mapping
> problem in amd_iommu has since ben fixed.
> 
> Also, I'm not sure why you're gating adding fast flushing to amd_iommu
> on vfio making use of it.  These can be done independently.  Thanks,
> 
> Alex
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
