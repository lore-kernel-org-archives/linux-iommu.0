From: Boris Ostrovsky <boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] xen/swiotlb: remember having called
	xen_create_contiguous_region()
Date: Tue, 23 Apr 2019 10:31:49 -0400
Message-ID: <b4917f80-a8ce-d38f-5c59-ef266669cea3@oracle.com>
References: <20190423105457.17502-1-jgross@suse.com>
	<20190423105457.17502-4-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190423105457.17502-4-jgross-IBi9RG/b67k@public.gmane.org>
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
To: Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 4/23/19 6:54 AM, Juergen Gross wrote:
> Instead of always calling xen_destroy_contiguous_region() in case the
> memory is DMA-able for the used device, do so only in case it has been
> made DMA-able via xen_create_contiguous_region() before.
>
> This will avoid a lot of xen_destroy_contiguous_region() calls for
> 64-bit capable devices.
>
> As the memory in question is owned by swiotlb-xen the PG_owner_priv_1
> flag of the first allocated page can be used for remembering.

I think a new enum in pageflags would be useful, and be consistent with
other flag uses.

-boris


>
> Signed-off-by: Juergen Gross <jgross-IBi9RG/b67k@public.gmane.org>
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
