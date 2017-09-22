From: tn <Tomasz.Nowicki@caviumnetworks.com>
Subject: Re: [PATCH v5 3/6] iommu/iova: Extend rbtree node caching
Date: Fri, 22 Sep 2017 19:08:09 +0200
Message-ID: <CY4PR0701MB36529313A0083DD6B5A15536F3670@CY4PR0701MB3652.namprd07.prod.outlook.com>
References: <cover.1506007392.git.robin.murphy@arm.com>
 <2c352944fb1d20ad4ef6778475006af81a270945.1506007392.git.robin.murphy@arm.com>
 <692b36cc-9bb0-51f9-a6f9-7d891f6ff78b@semihalf.com>
 <SN4PR0701MB3661578EC74E17C82AECB335F3670@SN4PR0701MB3661.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SN4PR0701MB3661578EC74E17C82AECB335F3670@SN4PR0701MB3661.namprd07.prod.outlook.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: tn <Tomasz.Nowicki@caviumnetworks.com>, Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: dwoods@mellanox.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On 22.09.2017 18:50, tn wrote:
> On 22.09.2017 18:21, Tomasz Nowicki wrote:
>> Hi Robin,
>>
>> On 21.09.2017 17:52, Robin Murphy wrote:
>>> The cached node mechanism provides a significant performance benefit for
>>> allocations using a 32-bit DMA mask, but in the case of non-PCI devices
>>> or where the 32-bit space is full, the loss of this benefit can be
>>> significant - on large systems there can be many thousands of entries in
>>> the tree, such that walking all the way down to find free space every
>>> time becomes increasingly awful.
>>>
>>> Maintain a similar cached node for the whole IOVA space as a superset of
>>> the 32-bit space so that performance can remain much more consistent.
>>>
>>> Inspired by work by Zhen Lei <thunder.leizhen@huawei.com>.
>>>
>>> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> Tested-by: Nate Watterson <nwatters@codeaurora.org>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>
>>> v5: Fixed __cached_rbnode_delete_update() logic to update both nodes
>>>      when necessary
>>>
>>>   drivers/iommu/iova.c | 60 
>>> ++++++++++++++++++++++++----------------------------
>>>   include/linux/iova.h |  3 ++-
>>>   2 files changed, 30 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 20be9a8b3188..c6f5a22f8d20 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -48,6 +48,7 @@ init_iova_domain(struct iova_domain *iovad, 
>>> unsigned long granule,
>>>       spin_lock_init(&iovad->iova_rbtree_lock);
>>>       iovad->rbroot = RB_ROOT;
>>> +    iovad->cached_node = NULL;
>>>       iovad->cached32_node = NULL;
>>>       iovad->granule = granule;
>>>       iovad->start_pfn = start_pfn;
>>> @@ -110,48 +111,44 @@ EXPORT_SYMBOL_GPL(init_iova_flush_queue);
>>>   static struct rb_node *
>>>   __get_cached_rbnode(struct iova_domain *iovad, unsigned long 
>>> *limit_pfn)
>>>   {
>>> -    if ((*limit_pfn > iovad->dma_32bit_pfn) ||
>>> -        (iovad->cached32_node == NULL))
>>> +    struct rb_node *cached_node = NULL;
>>> +    struct iova *curr_iova;
>>> +
>>> +    if (*limit_pfn <= iovad->dma_32bit_pfn)
>>> +        cached_node = iovad->cached32_node;
>>> +    if (!cached_node)
>>> +        cached_node = iovad->cached_node;
>>> +    if (!cached_node)
>>>           return rb_last(&iovad->rbroot);
>>> -    else {
>>> -        struct rb_node *prev_node = rb_prev(iovad->cached32_node);
>>> -        struct iova *curr_iova =
>>> -            rb_entry(iovad->cached32_node, struct iova, node);
>>> -        *limit_pfn = curr_iova->pfn_lo;
>>> -        return prev_node;
>>> -    }
>>> +
>>> +    curr_iova = rb_entry(cached_node, struct iova, node);
>>> +    *limit_pfn = min(*limit_pfn, curr_iova->pfn_lo);
>>
>> I guess this it the fix for stale pointer in iovad->cached32_node from 
>> previous series but I think this is something more.
>>
>> With this min() here we have real control over the limit_pfn we would 
>> like to allocate at most. In other works, without your series two 
>> subsequent calls can give us:
>> iova (ffff) = alloc_iova_fast(iovad, 1, DMA_BIT_MASK(32) >> shift);
>>
>> iova (fffe)= alloc_iova_fast(iovad, 1, DMA_BIT_MASK(16) >> shift);
>>
>> We do not see this since nobody uses limit_pfn below DMA_BIT_MASK(32) 
>> now. That might be done intentionally so I ask for your opinion.
>>
>> Also, with your patch and two the same alloc_iova_fast() calls in 
>> iteration may get 32-bit space full much faster. Please correct me if 
>> I messed things up.
> 
> After few more thoughts, I think this is unrealistic case.
> 
> In any case, please consider below fix:
>   static void
> -__cached_rbnode_insert_update(struct iova_domain *iovad,
> -    unsigned long limit_pfn, struct iova *new)
> +__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
>   {
> -    if (limit_pfn != iovad->dma_32bit_pfn)
> -        return;
> -    iovad->cached32_node = &new->node;
> +    if (new->pfn_hi == iovad->dma_32bit_pfn)
> +        iovad->cached32_node = &new->node;
> +    else
> +        iovad->cached_node = &new->node;
>   }

Sorry :(, this is still wrong.

It should look like this:
  static void
  __cached_rbnode_insert_update(struct iova_domain *iovad,
  	unsigned long limit_pfn, struct iova *new)
  {
-	if (limit_pfn != iovad->dma_32bit_pfn)
-		return;
-	iovad->cached32_node = &new->node;
+	if (limit_pfn == iovad->dma_32bit_pfn)
+		iovad->cached32_node = &new->node;
+	else if (new->pfn_hi > iovad->dma_32bit_pfn)
+		iovad->cached_node = &new->node;
  }

but then we still need to save initial limit_pfn in 
__alloc_and_insert_iova_range() for this decision.

Tomasz
