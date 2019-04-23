From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH 3/3] xen/swiotlb: remember having called
 xen_create_contiguous_region()
Date: Tue, 23 Apr 2019 10:05:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1904230955190.24598@sstabellini-ThinkPad-X260>
References: <20190423105457.17502-1-jgross@suse.com> <20190423105457.17502-4-jgross@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423105457.17502-4-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 23 Apr 2019, Juergen Gross wrote:
> Instead of always calling xen_destroy_contiguous_region() in case the
> memory is DMA-able for the used device, do so only in case it has been
> made DMA-able via xen_create_contiguous_region() before.
> 
> This will avoid a lot of xen_destroy_contiguous_region() calls for
> 64-bit capable devices.
> 
> As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
> flag of the first allocated page can be used for remembering.

Although the patch looks OK, this sentence puzzles me. Why do you say
that the memory in question is owned by swiotlb-xen? Because it was
returned by xen_alloc_coherent_pages? Both the x86 and the Arm
implementation return fresh new memory, hence, it should be safe to set
the PageOwnerPriv1 flag?

My concern with this approach is with the semantics of PG_owner_priv_1.
Is a page marked with PG_owner_priv_1 only supposed to be used by the
owner?


> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  drivers/xen/swiotlb-xen.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 43b6e65ae256..a72f181d8e20 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -321,6 +321,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
>  			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
>  			return NULL;
>  		}
> +		SetPageOwnerPriv1(virt_to_page(ret));
>  	}
>  	memset(ret, 0, size);
>  	return ret;
> @@ -344,9 +345,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if ((dev_addr + size - 1 <= dma_mask) &&
> -	    !WARN_ON(range_straddles_page_boundary(phys, size)))
> -		xen_destroy_contiguous_region(phys, order);
> +	if (PageOwnerPriv1(virt_to_page(vaddr))) {
> +		if (!WARN_ON(range_straddles_page_boundary(phys, size)))
> +			xen_destroy_contiguous_region(phys, order);
> +		ClearPageOwnerPriv1(virt_to_page(vaddr));
> +	}
>  
>  	xen_free_coherent_pages(hwdev, size, vaddr, (dma_addr_t)phys, attrs);
>  }
