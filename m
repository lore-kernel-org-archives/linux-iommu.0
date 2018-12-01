From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 6/9] dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING
Date: Sat, 1 Dec 2018 18:05:06 +0100
Message-ID: <20181201170506.GE20912@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
	<20181105121931.13481-7-hch@lst.de>
	<e993440c-53bf-8071-b1b6-06d022d39e4e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e993440c-53bf-8071-b1b6-06d022d39e4e-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>, Laura Abbott <labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Nov 30, 2018 at 07:05:40PM +0000, Robin Murphy wrote:
> On 05/11/2018 12:19, Christoph Hellwig wrote:
>> Do not waste vmalloc space on allocations that do not require a mapping
>> into the kernel address space.
>>
>> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
>> ---
>>   kernel/dma/remap.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
>> index 8f1fca34b894..10a545126b0b 100644
>> --- a/kernel/dma/remap.c
>> +++ b/kernel/dma/remap.c
>> @@ -200,7 +200,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>     	size = PAGE_ALIGN(size);
>>   -	if (!gfpflags_allow_blocking(flags)) {
>> +	if (!gfpflags_allow_blocking(flags) &&
>> +	    !(attrs & DMA_ATTR_NO_KERNEL_MAPPING)) {
>>   		ret = dma_alloc_from_pool(size, &page, flags);
>>   		if (!ret)
>>   			return NULL;
>> @@ -215,6 +216,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>   	/* remove any dirty cache lines on the kernel alias */
>>   	arch_dma_prep_coherent(page, size);
>>   +	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
>> +		return page; /* opaqueue cookie */
>
> Best to preempt the inevitable patch fixing that typo in 3 months' time. 
> Otherwise,

Thanks,

fixed.
