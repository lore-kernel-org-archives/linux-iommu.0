From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 2/6] iommu/dma: add support for non-strict mode
Date: Thu, 26 Jul 2018 12:15:28 +0800
Message-ID: <5B594AE0.2090701@huawei.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
	<1531376312-2192-3-git-send-email-thunder.leizhen@huawei.com>
	<4a668c7c-bce6-eef0-e11d-319333c60fcb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4a668c7c-bce6-eef0-e11d-319333c60fcb-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg
	Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LinuxArm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2018/7/25 6:01, Robin Murphy wrote:
> On 2018-07-12 7:18 AM, Zhen Lei wrote:
>> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>>     capable call domain->ops->flush_iotlb_all to flush TLB.
>> 2. Add a new iommu capability: IOMMU_CAP_NON_STRICT, which used to indicate
>>     that the iommu domain support non-strict mode.
>> 3. During the iommu domain initialization phase, call capable() to check
>>     whether it support non-strcit mode. If so, call init_iova_flush_queue
>>     to register iovad->flush_cb callback.
>> 4. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>>     -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>>     put off iova freeing.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 25 +++++++++++++++++++++++++
>>   include/linux/iommu.h     |  7 +++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index ddcbbdb..9f0c77a 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -55,6 +55,7 @@ struct iommu_dma_cookie {
>>       };
>>       struct list_head        msi_page_list;
>>       spinlock_t            msi_lock;
>> +    struct iommu_domain        *domain_non_strict;
>>   };
>>     static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
>> @@ -257,6 +258,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>       return ret;
>>   }
>>   +static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
>> +{
>> +    struct iommu_dma_cookie *cookie;
>> +    struct iommu_domain *domain;
>> +
>> +    cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
>> +    domain = cookie->domain_non_strict;
>> +
>> +    domain->ops->flush_iotlb_all(domain);
>> +}
>> +
>>   /**
>>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
>> @@ -272,6 +284,7 @@ static int iova_reserve_iommu_regions(struct device *dev,
>>   int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>           u64 size, struct device *dev)
>>   {
>> +    const struct iommu_ops *ops = domain->ops;
>>       struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>       struct iova_domain *iovad = &cookie->iovad;
>>       unsigned long order, base_pfn, end_pfn;
>> @@ -308,6 +321,15 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>       }
>>         init_iova_domain(iovad, 1UL << order, base_pfn);
>> +
>> +    if ((ops->capable && ops->capable(IOMMU_CAP_NON_STRICT)) &&
>> +        (IOMMU_DOMAIN_STRICT_MODE(domain) == IOMMU_NON_STRICT)) {
>> +        BUG_ON(!ops->flush_iotlb_all);
>> +
>> +        cookie->domain_non_strict = domain;
>> +        init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
>> +    }
>> +
>>       if (!dev)
>>           return 0;
>>   @@ -390,6 +412,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
>>       /* The MSI case is only ever cleaning up its most recent allocation */
>>       if (cookie->type == IOMMU_DMA_MSI_COOKIE)
>>           cookie->msi_iova -= size;
>> +    else if (cookie->domain_non_strict)
>> +        queue_iova(iovad, iova_pfn(iovad, iova),
>> +                size >> iova_shift(iovad), 0);
>>       else
>>           free_iova_fast(iovad, iova_pfn(iovad, iova),
>>                   size >> iova_shift(iovad));
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 19938ee..82ed979 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -86,6 +86,12 @@ struct iommu_domain_geometry {
>>   #define IOMMU_DOMAIN_DMA    (__IOMMU_DOMAIN_PAGING |    \
>>                    __IOMMU_DOMAIN_DMA_API)
>>   +#define IOMMU_STRICT        0
>> +#define IOMMU_NON_STRICT    1
>> +#define IOMMU_STRICT_MODE_MASK    1UL
>> +#define IOMMU_DOMAIN_STRICT_MODE(domain)    \
>> +        (domain->type != IOMMU_DOMAIN_UNMANAGED)
>> +
>>   struct iommu_domain {
>>       unsigned type;
>>       const struct iommu_ops *ops;
>> @@ -101,6 +107,7 @@ enum iommu_cap {
>>                          transactions */
>>       IOMMU_CAP_INTR_REMAP,        /* IOMMU supports interrupt isolation */
>>       IOMMU_CAP_NOEXEC,        /* IOMMU_NOEXEC flag */
>> +    IOMMU_CAP_NON_STRICT,        /* IOMMU supports non-strict mode */
> 
> This still isn't a capability of the hardware. Non-strict mode is pure software policy; *every IOMMU ever* supports it.
> 
> If you want to have this kind of per-driver control, make it a domain attribute - that's not only more logical, but should also work out a lot cleaner overall.

OK, I will use quirk, so this capability will be removed in the next version.

> 
> Robin.
> 
>>   };
>>     /*
>>
> 
> .
> 

-- 
Thanks!
BestRegards
