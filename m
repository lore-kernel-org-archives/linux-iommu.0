From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 2/6] iommu/dma: Add support for non-strict mode
Date: Tue, 18 Sep 2018 19:52:04 +0100
Message-ID: <60410578-64f3-9bb3-0b88-27cde93335d0@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
	<0a891cec4bb164f8cf2f57c753791a7d1f5f1d81.1536935328.git.robin.murphy@arm.com>
	<20180918171007.GJ16498@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180918171007.GJ16498-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-09-18 6:10 PM, Will Deacon wrote:
> Hi Robin,
> 
> On Fri, Sep 14, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
>> From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>
>> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>>     capable call domain->ops->flush_iotlb_all to flush TLB.
>> 2. During the iommu domain initialization phase, base on domain->non_strict
>>     field to check whether non-strict mode is supported or not. If so, call
>>     init_iova_flush_queue to register iovad->flush_cb callback.
>> 3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>>     -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>>     put off iova freeing, and omit iommu_tlb_sync operation.
> 
> Hmm, this is basically just a commentary on the code. Please could you write
> it more in terms of the problem that's being solved?

Sure - I intentionally kept a light touch when it came to the 
documentation and commit messages in this rework (other than patch #1 
where I eventually remembered the original reasoning and that it wasn't 
a bug). If we're more-or-less happy with the shape of the technical side 
I'll make sure to take a final pass through v8 to tidy up all the prose.

>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> [rm: convert raw boolean to domain attribute]
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++++++++-
>>   include/linux/iommu.h     |  1 +
>>   2 files changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 511ff9a1d6d9..092e6926dc3c 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -55,6 +55,9 @@ struct iommu_dma_cookie {
>>   	};
>>   	struct list_head		msi_page_list;
>>   	spinlock_t			msi_lock;
>> +
>> +	/* Only be assigned in non-strict mode, otherwise it's NULL */
>> +	struct iommu_domain		*domain;
>>   };
>>   
>>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>> @@ -257,6 +260,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>   	return ret;
>>   }
>>   
>> +static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
>> +{
>> +	struct iommu_dma_cookie *cookie;
>> +	struct iommu_domain *domain;
>> +
>> +	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
>> +	domain = cookie->domain;
>> +
>> +	domain->ops->flush_iotlb_all(domain);
> 
> Can we rely on this function pointer being non-NULL? I think it would
> be better to call iommu_flush_tlb_all(cookie->domain) instead.

Yeah, that's deliberate - in fact got as far as writing that change, 
then undid it as I realised that although the attribute conversion got 
rid of the explicit ops->flush_iotlb_all check, it still makes zero 
sense for an IOMMU driver to claim to support the flush queue attribute 
without also providing the relevant callback, so I do actually want this 
to blow up rather than silently do nothing if that assumption isn't met.

>> +}
>> +
>>   /**
>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> @@ -275,6 +289,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>   	struct iova_domain *iovad = &cookie->iovad;
>>   	unsigned long order, base_pfn, end_pfn;
>> +	int attr = 1;
> 
> Do we actually need to initialise this?

Oops, no, that's a left-over from the turned-out-messier-that-I-thought 
v6 implementation.

Thanks,
Robin.
