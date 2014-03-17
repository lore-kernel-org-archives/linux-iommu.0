From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fixing kvm_iommu_put_pages()
Date: Mon, 17 Mar 2014 09:44:21 -0600
Message-ID: <1395071061.8201.14.camel@ul30vt.home>
References: <1394585481.2270.179.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394585481.2270.179.camel-Fexsq3y4057IgHVZqg5X0TlWvGAXklZc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2014-03-11 at 17:51 -0700, David Woodhouse wrote:
> In kvm_iommu_put_pages() we use this bizarre and horrid API for
> iommu_unmap() where we call it to unmap PAGE_SIZE at a time, but if it
> actually finds a larger page than that in its page tables then it's
> allowed to unmap and return the larger size.
> 
> For some IOMMUs including the Intel one, breaking unmaps into tiny
> chunks like this is *really* pessimal.
> 
> It looks like the actual reason it's done this way is because we need to
> unpin the underlying physical pages when we're done with them, and the
> only way we can do that is by doing it a page at a time calling
> iommu_iova_to_phys() on each page. 
> 
> I wonder if this could be better handled by passing a callback function
> in to the iommu_unmap() function, which can be called for each physical
> address range that's unmapped.
> 
> That way, we wouldn't need all the cache and IOTLB flushing between the
> individual page unmaps; we could still just do it the quick way.
> 
> It would look something like this...
> 
> diff --git a/virt/kvm/iommu.c b/virt/kvm/iommu.c
> index 0df7d4b..bf3f4f9 100644
> --- a/virt/kvm/iommu.c
> +++ b/virt/kvm/iommu.c
> @@ -278,41 +278,14 @@ static void kvm_iommu_put_pages(struct kvm *kvm,
>  				gfn_t base_gfn, unsigned long npages)
>  {
>  	struct iommu_domain *domain;
> -	gfn_t end_gfn, gfn;
> -	pfn_t pfn;
> -	u64 phys;
>  
>  	domain  = kvm->arch.iommu_domain;
> -	end_gfn = base_gfn + npages;
> -	gfn     = base_gfn;
>  
>  	/* check if iommu exists and in use */
>  	if (!domain)
>  		return;
>  
> -	while (gfn < end_gfn) {
> -		unsigned long unmap_pages;
> -		size_t size;
> -
> -		/* Get physical address */
> -		phys = iommu_iova_to_phys(domain, gfn_to_gpa(gfn));
> -
> -		if (!phys) {
> -			gfn++;
> -			continue;
> -		}
> -
> -		pfn  = phys >> PAGE_SHIFT;
> -
> -		/* Unmap address from IO address space */
> -		size       = iommu_unmap(domain, gfn_to_gpa(gfn), PAGE_SIZE);
> -		unmap_pages = 1ULL << get_order(size);
> -
> -		/* Unpin all pages we just unmapped to not leak any memory */
> -		kvm_unpin_pages(kvm, pfn, unmap_pages);
> -
> -		gfn += unmap_pages;
> -	}
> +	iommu_unmap(domain, gfn_to_gpa(base_gfn), npages << PAGE_SHIFT, kvm_unpin_pages, kvm);
>  }
>  
>  void kvm_iommu_unmap_pages(struct kvm *kvm, struct kvm_memory_slot *slot)
> 

As mentioned on irc, I think this could probably be made to work and
doing a callback would likely give the IOMMU driver the most flexibility
versus some sort of interface for iommu_iova_to_phys() to return the
mapping size.  Also note that KVM device assignment is being phased out
in favor of VFIO-based device assignment.  vfio_unmap_unpin() has a
similar loop where we attempt to unmap a PAGE_SIZE chunk and unpin based
on the actual size unmapped.  Thanks,

Alex
