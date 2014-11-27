From: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 4/4] iommu: make IOVA domain page size explicit
Date: Thu, 27 Nov 2014 15:10:50 +0800
Message-ID: <5476CE7A.3020302@huawei.com>
References: <cover.1416931258.git.robin.murphy@arm.com>
	<3774c76c45b21820b6a6acf582b8f441b639ffe9.1416931258.git.robin.murphy@arm.com>
	<54757E98.9010006@huawei.com> <5475D63D.1050405@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5475D63D.1050405-5wv7dgnIgG8@public.gmane.org>
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
Cc: Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2014/11/26 21:31, Robin Murphy wrote:
> Hi,
> 
> On 26/11/14 07:17, leizhen wrote:
> [...]
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index a3dbba8..9e50625 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -55,12 +55,16 @@ void free_iova_mem(struct iova *iova)
>>>   }
>>>
>>>   void
>>> -init_iova_domain(struct iova_domain *iovad, unsigned long start_pfn,
>>> -    unsigned long pfn_32bit)
>>> +init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>> +    unsigned long start_pfn, unsigned long pfn_32bit)
>>>   {
>>> +    /* IOMMUs must support at least the CPU page size */
>>> +    BUG_ON(granule > PAGE_SIZE);
>>
>> ??? BUG_ON(granule < PAGE_SIZE);
>>
> 
> Granule represents the smallest page size that the IOMMU can map - we'd never allocate less IOVA space than a single page, so we don't need a unit smaller than that, and a bigger unit would make it
> problematic to allocate IOVA space for individual pages.
> 
> If, for instance, the CPU has 64k pages, and the IOMMU supports 1k tiny pages, granule would be less than PAGE_SIZE, but the IOMMU could happily that 64k as 64 contiguous tiny pages, even if it's a
> waste of TLB space.
> 
> However, say the IOMMU only supports 16k pages and we try to map two noncontiguous 4k CPU pages as a contiguous 8k buffer in IOVA space - this can't work, hence why the _minimum_ IOMMU page size, and
> thus granule, may never be _bigger_ than a CPU page.
> 

Oh, I just confused with the comment: /* IOMMUs must support at least the CPU page size */
But the code means at most the CPU page size. Now, I got it.

>>> +
>>>       spin_lock_init(&iovad->iova_rbtree_lock);
>>>       iovad->rbroot = RB_ROOT;
>>>       iovad->cached32_node = NULL;
>>> +    iovad->granule = granule;
>>
>> Do you need to check granule is 2^n ?
>>
> 
> Yes, that would make a lot of sense.
> 
>>>       iovad->start_pfn = start_pfn;
>>>       iovad->dma_32bit_pfn = pfn_32bit;
>>>   }
>>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>>> index 591b196..3920a19 100644
>>> --- a/include/linux/iova.h
>>> +++ b/include/linux/iova.h
>>> @@ -28,6 +28,7 @@ struct iova_domain {
>>>       spinlock_t    iova_rbtree_lock; /* Lock to protect update of rbtree */
>>>       struct rb_root    rbroot;        /* iova domain rbtree root */
>>>       struct rb_node    *cached32_node; /* Save last alloced node */
>>> +    unsigned long    granule;    /* pfn granularity for this domain */
>>>       unsigned long    start_pfn;    /* Lower limit for this domain */
>>>       unsigned long    dma_32bit_pfn;
>>>   };
>>> @@ -37,6 +38,36 @@ static inline unsigned long iova_size(struct iova *iova)
>>>       return iova->pfn_hi - iova->pfn_lo + 1;
>>>   }
>>>
>>> +static inline unsigned long iova_shift(struct iova_domain *iovad)
>>> +{
>>> +    return __ffs(iovad->granule);
>>
>> I think it's good to save the result to a struct member. If we caculate it ervertime, it's too slow.
>>
> 
> I did give some consideration at the time to which of size, shift and mask to store - given the redundancy between them storing more than one seems excessively wasteful - and this made for the
> nicest-looking code IMO. These IOVA operations are going to be mostly used in map/unmap situations leading to an IOMMU TLB flush anyway, so I'm not sure how performance-critical they really are.
> 
> Are we likely to see this code used on architectures where __ffs takes more than a few cycles and has more impact than the general memory bloat of making structures bigger?
> 
> 
> Thanks for the review,
> Robin.
> 
>>> +}
>>> +
>>> +static inline unsigned long iova_mask(struct iova_domain *iovad)
>>> +{
>>> +    return iovad->granule - 1;
>>> +}
>>> +
>>> +static inline size_t iova_offset(struct iova_domain *iovad, dma_addr_t iova)
>>> +{
>>> +    return iova & iova_mask(iovad);
>>> +}
>>> +
>>> +static inline size_t iova_align(struct iova_domain *iovad, size_t size)
>>> +{
>>> +    return ALIGN(size, iovad->granule);
>>> +}
>>> +
>>> +static inline dma_addr_t iova_dma_addr(struct iova_domain *iovad, struct iova *iova)
>>> +{
>>> +    return (dma_addr_t)iova->pfn_lo << iova_shift(iovad);
>>> +}
>>> +
>>> +static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
>>> +{
>>> +    return iova >> iova_shift(iovad);
>>> +}
>>> +
>>>   int iommu_iova_cache_init(void);
>>>   void iommu_iova_cache_destroy(void);
>>>
>>> @@ -50,8 +81,8 @@ struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
>>>   struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>>>       unsigned long pfn_hi);
>>>   void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
>>> -void init_iova_domain(struct iova_domain *iovad, unsigned long start_pfn,
>>> -    unsigned long pfn_32bit);
>>> +void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>>> +    unsigned long start_pfn, unsigned long pfn_32bit);
>>>   struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>>>   void put_iova_domain(struct iova_domain *iovad);
>>>   struct iova *split_and_remove_iova(struct iova_domain *iovad,
>>>
>>
>>
>>
> 
> 
> 
> .
> 
