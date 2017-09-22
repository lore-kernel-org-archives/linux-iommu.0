From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 3/6] iommu/iova: Extend rbtree node caching
Date: Fri, 22 Sep 2017 18:25:03 +0100
Message-ID: <cd2ce176-0e25-8a57-1f1e-fd2f26840c01@arm.com>
References: <cover.1506007392.git.robin.murphy@arm.com>
 <2c352944fb1d20ad4ef6778475006af81a270945.1506007392.git.robin.murphy@arm.com>
 <692b36cc-9bb0-51f9-a6f9-7d891f6ff78b@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <692b36cc-9bb0-51f9-a6f9-7d891f6ff78b@semihalf.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, joro@8bytes.org
Cc: dwoods@mellanox.com, tomasz.nowicki@caviumnetworks.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 22/09/17 17:21, Tomasz Nowicki wrote:
> Hi Robin,
> 
> On 21.09.2017 17:52, Robin Murphy wrote:
>> The cached node mechanism provides a significant performance benefit for
>> allocations using a 32-bit DMA mask, but in the case of non-PCI devices
>> or where the 32-bit space is full, the loss of this benefit can be
>> significant - on large systems there can be many thousands of entries in
>> the tree, such that walking all the way down to find free space every
>> time becomes increasingly awful.
>>
>> Maintain a similar cached node for the whole IOVA space as a superset of
>> the 32-bit space so that performance can remain much more consistent.
>>
>> Inspired by work by Zhen Lei <thunder.leizhen@huawei.com>.
>>
>> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Tested-by: Nate Watterson <nwatters@codeaurora.org>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v5: Fixed __cached_rbnode_delete_update() logic to update both nodes
>>      when necessary
>>
>>   drivers/iommu/iova.c | 60
>> ++++++++++++++++++++++++----------------------------
>>   include/linux/iova.h |  3 ++-
>>   2 files changed, 30 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 20be9a8b3188..c6f5a22f8d20 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -48,6 +48,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
>> long granule,
>>         spin_lock_init(&iovad->iova_rbtree_lock);
>>       iovad->rbroot = RB_ROOT;
>> +    iovad->cached_node = NULL;
>>       iovad->cached32_node = NULL;
>>       iovad->granule = granule;
>>       iovad->start_pfn = start_pfn;
>> @@ -110,48 +111,44 @@ EXPORT_SYMBOL_GPL(init_iova_flush_queue);
>>   static struct rb_node *
>>   __get_cached_rbnode(struct iova_domain *iovad, unsigned long
>> *limit_pfn)
>>   {
>> -    if ((*limit_pfn > iovad->dma_32bit_pfn) ||
>> -        (iovad->cached32_node == NULL))
>> +    struct rb_node *cached_node = NULL;
>> +    struct iova *curr_iova;
>> +
>> +    if (*limit_pfn <= iovad->dma_32bit_pfn)
>> +        cached_node = iovad->cached32_node;
>> +    if (!cached_node)
>> +        cached_node = iovad->cached_node;
>> +    if (!cached_node)
>>           return rb_last(&iovad->rbroot);
>> -    else {
>> -        struct rb_node *prev_node = rb_prev(iovad->cached32_node);
>> -        struct iova *curr_iova =
>> -            rb_entry(iovad->cached32_node, struct iova, node);
>> -        *limit_pfn = curr_iova->pfn_lo;
>> -        return prev_node;
>> -    }
>> +
>> +    curr_iova = rb_entry(cached_node, struct iova, node);
>> +    *limit_pfn = min(*limit_pfn, curr_iova->pfn_lo);
> 
> I guess this it the fix for stale pointer in iovad->cached32_node from
> previous series but I think this is something more.
> 
> With this min() here we have real control over the limit_pfn we would
> like to allocate at most. In other works, without your series two
> subsequent calls can give us:
> iova (ffff) = alloc_iova_fast(iovad, 1, DMA_BIT_MASK(32) >> shift);
> 
> iova (fffe)= alloc_iova_fast(iovad, 1, DMA_BIT_MASK(16) >> shift);
> 
> We do not see this since nobody uses limit_pfn below DMA_BIT_MASK(32)
> now. That might be done intentionally so I ask for your opinion.

I realise it's not called out in the commit message, but this patch does
make one small change to how the existing 32-bit caching behaves when
freeing the topmost 32-bit IOVA. With the previous behaviour,
__cached_rbnode_delete_update() set cached32_node to NULL when the
rb_next(free) node lies above dma_32bit_pfn, meaning the next 32-bit
allocation returns from here early with rb_last(). Therefore limit_pfn
is updated unconditionally when a cached node exists on the expectation
that it will only ever move downwards.

...and having worked through that, I now realise I failed to take it
into account in 62280cf2e8bb, so yes, the theoretical case of a 32-bit
allocation followed by a <32-bit allocation has in fact been broken (in
that it could adjust limit_pfn upwards and return an too-high IOVA for
the second call) for a while. Grrr...

With the new behaviour from this patch, freeing the topmost 32-bit IOVA
can let cached32_node point at the lowest >32-bit IOVA to avoid the
rb_last() overhead on the next allocation - that's how the stale pointer
bug could now happen (which is fixed by always checking both nodes in
__cached_rbnode_delete_update() below). Because cached32_node may now
occasionally point at something for which pfn_lo > dma_32bit_pfn, we add
the min() here to make sure we never move limit_pfn upwards (and thus
inadvertently fix the <32-bit case as well).

I admit that one of my motivations for rewriting so much here is just
because the existing code is so horrendously subtle and tricky. I'd like
to think that by patch #6 it's actually understandable without spending
several days picking through it...

Robin.

> Also, with your patch and two the same alloc_iova_fast() calls in
> iteration may get 32-bit space full much faster. Please correct me if I
> messed things up.
> 
> Thanks,
> Tomasz
> 
> 
>> +
>> +    return rb_prev(cached_node);
>>   }
>>     static void
>> -__cached_rbnode_insert_update(struct iova_domain *iovad,
>> -    unsigned long limit_pfn, struct iova *new)
>> +__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova
>> *new)
>>   {
>> -    if (limit_pfn != iovad->dma_32bit_pfn)
>> -        return;
>> -    iovad->cached32_node = &new->node;
>> +    if (new->pfn_hi < iovad->dma_32bit_pfn)
>> +        iovad->cached32_node = &new->node;
>> +    else
>> +        iovad->cached_node = &new->node;
>>   }
>>     static void
>>   __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova
>> *free)
>>   {
>>       struct iova *cached_iova;
>> -    struct rb_node *curr;
>>   -    if (!iovad->cached32_node)
>> -        return;
>> -    curr = iovad->cached32_node;
>> -    cached_iova = rb_entry(curr, struct iova, node);
>> +    cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
>> +    if (free->pfn_hi < iovad->dma_32bit_pfn &&
>> +        iovad->cached32_node && free->pfn_lo >= cached_iova->pfn_lo)
>> +        iovad->cached32_node = rb_next(&free->node);
>>   -    if (free->pfn_lo >= cached_iova->pfn_lo) {
>> -        struct rb_node *node = rb_next(&free->node);
>> -        struct iova *iova = rb_entry(node, struct iova, node);
>> -
>> -        /* only cache if it's below 32bit pfn */
>> -        if (node && iova->pfn_lo < iovad->dma_32bit_pfn)
>> -            iovad->cached32_node = node;
>> -        else
>> -            iovad->cached32_node = NULL;
>> -    }
>> +    cached_iova = rb_entry(iovad->cached_node, struct iova, node);
>> +    if (iovad->cached_node && free->pfn_lo >= cached_iova->pfn_lo)
>> +        iovad->cached_node = rb_next(&free->node);
>>   }
>>     /* Insert the iova into domain rbtree by holding writer lock */
>> @@ -188,7 +185,7 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>   {
>>       struct rb_node *prev, *curr = NULL;
>>       unsigned long flags;
>> -    unsigned long saved_pfn, new_pfn;
>> +    unsigned long new_pfn;
>>       unsigned long align_mask = ~0UL;
>>         if (size_aligned)
>> @@ -196,7 +193,6 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>         /* Walk the tree backwards */
>>       spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>> -    saved_pfn = limit_pfn;
>>       curr = __get_cached_rbnode(iovad, &limit_pfn);
>>       prev = curr;
>>       while (curr) {
>> @@ -226,7 +222,7 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>         /* If we have 'prev', it's a valid place to start the
>> insertion. */
>>       iova_insert_rbtree(&iovad->rbroot, new, prev);
>> -    __cached_rbnode_insert_update(iovad, saved_pfn, new);
>> +    __cached_rbnode_insert_update(iovad, new);
>>         spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>>   diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index d179b9bf7814..69ea3e258ff2 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -70,7 +70,8 @@ struct iova_fq {
>>   struct iova_domain {
>>       spinlock_t    iova_rbtree_lock; /* Lock to protect update of
>> rbtree */
>>       struct rb_root    rbroot;        /* iova domain rbtree root */
>> -    struct rb_node    *cached32_node; /* Save last alloced node */
>> +    struct rb_node    *cached_node;    /* Save last alloced node */
>> +    struct rb_node    *cached32_node; /* Save last 32-bit alloced
>> node */
>>       unsigned long    granule;    /* pfn granularity for this domain */
>>       unsigned long    start_pfn;    /* Lower limit for this domain */
>>       unsigned long    dma_32bit_pfn;
>>
> 
