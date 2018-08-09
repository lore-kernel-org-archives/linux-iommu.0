From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 2/5] iommu/dma: add support for non-strict mode
Date: Thu, 9 Aug 2018 19:01:09 +0800
Message-ID: <5B6C1EF5.2050602@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
	<1533558424-16748-3-git-send-email-thunder.leizhen@huawei.com>
	<e57298b0-66ec-b97c-1b36-b35bb3e1f20a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e57298b0-66ec-b97c-1b36-b35bb3e1f20a-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: LinuxArm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2018/8/9 18:46, Robin Murphy wrote:
> On 06/08/18 13:27, Zhen Lei wrote:
>> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>>     capable call domain->ops->flush_iotlb_all to flush TLB.
>> 2. During the iommu domain initialization phase, base on domain->non_strict
>>     field to check whether non-strict mode is supported or not. If so, call
>>     init_iova_flush_queue to register iovad->flush_cb callback.
>> 3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>>     -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>>     put off iova freeing.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 23 +++++++++++++++++++++++
>>   drivers/iommu/iommu.c     |  1 +
>>   include/linux/iommu.h     |  1 +
>>   3 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index ddcbbdb..213e62a 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -55,6 +55,7 @@ struct iommu_dma_cookie {
>>       };
>>       struct list_head        msi_page_list;
>>       spinlock_t            msi_lock;
>> +    struct iommu_domain        *domain;
>>   };
>>
>>   static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>> @@ -257,6 +258,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>       return ret;
>>   }
>>
>> +static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
>> +{
>> +    struct iommu_dma_cookie *cookie;
>> +    struct iommu_domain *domain;
>> +
>> +    cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
>> +    domain = cookie->domain;
>> +
>> +    domain->ops->flush_iotlb_all(domain);
>> +}
>> +
>>   /**
>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> @@ -308,6 +320,14 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>       }
>>
>>       init_iova_domain(iovad, 1UL << order, base_pfn);
>> +
>> +    if (domain->non_strict) {
>> +        BUG_ON(!domain->ops->flush_iotlb_all);
>> +
>> +        cookie->domain = domain;
> 
> cookie->domain will only be non-NULL if domain->non_strict is true...
> 
>> +        init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
>> +    }
>> +
>>       if (!dev)
>>           return 0;
>>
>> @@ -390,6 +410,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>>       /* The MSI case is only ever cleaning up its most recent allocation */
>>       if (cookie->type == IOMMU_DMA_MSI_COOKIE)
>>           cookie->msi_iova -= size;
>> +    else if (cookie->domain && cookie->domain->non_strict)
> 
> ...so we don't need to re-check non_strict every time here.

OK, I will change it to a comment.

> 
>> +        queue_iova(iovad, iova_pfn(iovad, iova),
>> +                size >> iova_shift(iovad), 0);
>>       else
>>           free_iova_fast(iovad, iova_pfn(iovad, iova),
>>                   size >> iova_shift(iovad));
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 63b3756..7811fde 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1263,6 +1263,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>
>>       domain->ops  = bus->iommu_ops;
>>       domain->type = type;
>> +    domain->non_strict = 0;
>>       /* Assume all sizes by default; the driver may override this later */
>>       domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 19938ee..0a0fb48 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -88,6 +88,7 @@ struct iommu_domain_geometry {
>>
>>   struct iommu_domain {
>>       unsigned type;
>> +    int non_strict;
> 
> bool?

OK

> 
> Robin.
> 
>>       const struct iommu_ops *ops;
>>       unsigned long pgsize_bitmap;    /* Bitmap of page sizes in use */
>>       iommu_fault_handler_t handler;
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

-- 
Thanks!
BestRegards
