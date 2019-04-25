From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 1/3] xen/swiotlb: fix condition for
 calling xen_destroy_contiguous_region()
Date: Thu, 25 Apr 2019 02:53:41 -0600
Message-ID: <5CC175950200007800228E80@prv1-mh.provo.novell.com>
References: <20190423105457.17502-1-jgross@suse.com>
 <20190423105457.17502-2-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423105457.17502-2-jgross@suse.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, iommu@lists.linux-foundation.org, xen-devel <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

>>> On 23.04.19 at 12:54, <jgross@suse.com> wrote:
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -360,8 +360,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>  	/* Convert the size to actually allocated. */
>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>  
> -	if (((dev_addr + size - 1 <= dma_mask)) ||
> -	    range_straddles_page_boundary(phys, size))
> +	if ((dev_addr + size - 1 <= dma_mask) &&
> +	    !WARN_ON(range_straddles_page_boundary(phys, size)))
>  		xen_destroy_contiguous_region(phys, order);

On the allocation side we have

	if (((dev_addr + size - 1 <= dma_mask)) &&
	    !range_straddles_page_boundary(phys, size))
		*dma_handle = dev_addr;
	else {
		if (xen_create_contiguous_region(phys, order,
						 fls64(dma_mask), dma_handle) != 0) {
			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
			return NULL;
		}
	}

which is (as far as the function call is concerned)

	if ((dev_addr + size - 1 > dma_mask) ||
	    range_straddles_page_boundary(phys, size))
		xen_create_contiguous_region(...);

So I don't think your transformation is correct. Even worse, both
parts of the condition in xen_swiotlb_free_coherent() act on an
address that is the _result_ of the prior
xen_create_contiguous_region(), i.e. the address should always
match _both_ criteria anyway. Whereas what you really want is
undo the xen_create_contiguous_region() only when it actually
was called. Otherwise you also shatter contiguous allocations
that were contiguous already for other reasons (perhaps just
luck).

Jan
