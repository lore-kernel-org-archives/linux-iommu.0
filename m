From: Juergen Gross <jgross@suse.com>
Subject: Re: [Xen-devel] [PATCH 1/3] xen/swiotlb: fix condition for calling
 xen_destroy_contiguous_region()
Date: Thu, 25 Apr 2019 11:03:02 +0200
Message-ID: <32d173a2-4b8c-909e-89fc-68ed9fb2fa02@suse.com>
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
> So I don't think your transformation is correct.

I know that I modified the condition. Calling
xen_destroy_contiguous_region() for a non-contiguous region is
destructive, so we have to avoid it in any case.

I could be talked into moving both tests into the WARN_ON(), however.


Juergen
