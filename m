From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Subject: Re: [PATCH] iommu/iova: Optimise attempts to allocate iova from 32bit
 address range
Date: Thu, 9 Aug 2018 23:19:54 +0530
Message-ID: <CAKTKpr6HfLtkeertCyfA_vJt2rXi5qFOKKXohLfX1Z9QiK=Uvw@mail.gmail.com>
References: <20180807085437.15965-1-ganapatrao.kulkarni@cavium.com> <318f9118-df78-e78f-1ae2-72a33cbee28e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <318f9118-df78-e78f-1ae2-72a33cbee28e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com, jnair@caviumnetworks.com, Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Thu, Aug 9, 2018 at 9:54 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 07/08/18 09:54, Ganapatrao Kulkarni wrote:
>>
>> As an optimisation for PCI devices, there is always first attempt
>> been made to allocate iova from SAC address range. This will lead
>> to unnecessary attempts/function calls, when there are no free ranges
>> available.
>>
>> This patch optimises by adding flag to track previous failed attempts
>> and avoids further attempts until replenish happens.
>
>
> Agh, what I overlooked is that this still suffers from the original problem,
> wherein a large allocation which fails due to fragmentation then blocks all
> subsequent smaller allocations, even if they may have succeeded.
>
> For a minimal change, though, what I think we could do is instead of just
> having a flag, track the size of the last 32-bit allocation which failed. If
> we're happy to assume that nobody's likely to mix aligned and unaligned
> allocations within the same domain, then that should be sufficiently robust
> whilst being no more complicated than this version, i.e. (modulo thinking up
> a better name for it):

I agree, it would be better to track size and attempt to allocate for
smaller chunks, if not for bigger one.

>
>>
>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> ---
>> This patch is based on comments from Robin Murphy <robin.murphy@arm.com>
>> for patch [1]
>>
>> [1] https://lkml.org/lkml/2018/4/19/780
>>
>>   drivers/iommu/iova.c | 11 ++++++++++-
>>   include/linux/iova.h |  1 +
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 83fe262..d97bb5a 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
>> long granule,
>>         iovad->granule = granule;
>>         iovad->start_pfn = start_pfn;
>>         iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
>> +       iovad->free_32bit_pfns = true;
>
>
>         iovad->max_32bit_free = iovad->dma_32bit_pfn;
>
>>         iovad->flush_cb = NULL;
>>         iovad->fq = NULL;
>>         iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
>> @@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain
>> *iovad, struct iova *free)
>>         cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
>>         if (free->pfn_hi < iovad->dma_32bit_pfn &&
>> -           free->pfn_lo >= cached_iova->pfn_lo)
>> +           free->pfn_lo >= cached_iova->pfn_lo) {
>>                 iovad->cached32_node = rb_next(&free->node);
>> +               iovad->free_32bit_pfns = true;
>
>
>                 iovad->max_32bit_free = iovad->dma_32bit_pfn;

i think, you intended to say,
  iovad->max_32bit_free += (free->pfn_hi - free->pfn_lo);

>
>> +       }
>>         cached_iova = rb_entry(iovad->cached_node, struct iova, node);
>>         if (free->pfn_lo >= cached_iova->pfn_lo)
>> @@ -290,6 +293,10 @@ alloc_iova(struct iova_domain *iovad, unsigned long
>> size,
>>         struct iova *new_iova;
>>         int ret;
>>   +     if (limit_pfn <= iovad->dma_32bit_pfn &&
>> +                       !iovad->free_32bit_pfns)
>
>
>                         size >= iovad->max_32bit_free)
>
>> +               return NULL;
>> +
>>         new_iova = alloc_iova_mem();
>>         if (!new_iova)
>>                 return NULL;
>> @@ -299,6 +306,8 @@ alloc_iova(struct iova_domain *iovad, unsigned long
>> size,
>>         if (ret) {
>>                 free_iova_mem(new_iova);
>> +               if (limit_pfn <= iovad->dma_32bit_pfn)
>> +                       iovad->free_32bit_pfns = false;
>
>
>                         iovad->max_32bit_free = size;

same here, we should decrease available free range after successful allocation.
iovad->max_32bit_free -= size;

>
> What do you think?

most likely this should work, i will try this and confirm at the earliest,

>
> Robin.
>
>
>>                 return NULL;
>>         }
>>   diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index 928442d..3810ba9 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -96,6 +96,7 @@ struct iova_domain {
>>                                                    flush-queues */
>>         atomic_t fq_timer_on;                   /* 1 when timer is active,
>> 0
>>                                                    when not */
>> +       bool    free_32bit_pfns;
>>   };
>>     static inline unsigned long iova_size(struct iova *iova)
>>
>

thanks,
Ganapat
