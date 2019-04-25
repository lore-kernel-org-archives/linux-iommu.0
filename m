From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 1/3] xen/swiotlb: fix condition for calling
 xen_destroy_contiguous_region()
Date: Thu, 25 Apr 2019 10:55:33 +0200
Message-ID: <38c2907c-2749-e66c-1279-7d74bc20bc35@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
References: =?UTF-8?B?PDIwMTkwNDIzMTA1NDU3LjE3NTAy77+9Me+/vWpncm9zc0BzdXNl?=
 =?UTF-8?Q?=2ecom=3e_=3c20190423105457=2e17502-2-jgross=40suse=2ecom=3e_=3c5?=
 =?UTF-8?Q?CC175950200007800228E80=40suse=2ecom=3e?=
Content-Language: de-DE
Sender: stable-owner@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, iommu@lists.linux-foundation.org, xen-devel <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 25/04/2019 10:53, Jan Beulich wrote:
>>>> On 23.04.19 at 12:54, <jgross@suse.com> wrote:
>> --- a/drivers/xen/swiotlb-xen.c
>> +++ b/drivers/xen/swiotlb-xen.c
>> @@ -360,8 +360,8 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
>>  	/* Convert the size to actually allocated. */
>>  	size = 1UL << (order + XEN_PAGE_SHIFT);
>>  
>> -	if (((dev_addr + size - 1 <= dma_mask)) ||
>> -	    range_straddles_page_boundary(phys, size))
>> +	if ((dev_addr + size - 1 <= dma_mask) &&
>> +	    !WARN_ON(range_straddles_page_boundary(phys, size)))
>>  		xen_destroy_contiguous_region(phys, order);
> 
> On the allocation side we have
> 
> 	if (((dev_addr + size - 1 <= dma_mask)) &&
> 	    !range_straddles_page_boundary(phys, size))
> 		*dma_handle = dev_addr;
> 	else {
> 		if (xen_create_contiguous_region(phys, order,
> 						 fls64(dma_mask), dma_handle) != 0) {
> 			xen_free_coherent_pages(hwdev, size, ret, (dma_addr_t)phys, attrs);
> 			return NULL;
> 		}
> 	}
> 
> which is (as far as the function call is concerned)
> 
> 	if ((dev_addr + size - 1 > dma_mask) ||
> 	    range_straddles_page_boundary(phys, size))
> 		xen_create_contiguous_region(...);
> 
> So I don't think your transformation is correct. Even worse, both
> parts of the condition in xen_swiotlb_free_coherent() act on an
> address that is the _result_ of the prior
> xen_create_contiguous_region(), i.e. the address should always
> match _both_ criteria anyway. Whereas what you really want is
> undo the xen_create_contiguous_region() only when it actually
> was called. Otherwise you also shatter contiguous allocations
> that were contiguous already for other reasons (perhaps just
> luck).

Yes, that is what patch 3 does.


Juergen
