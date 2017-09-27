From: David Woods <dwoods@mellanox.com>
Subject: Re: [PATCH] iommu/iova: Improve alloc_iova performance
Date: Wed, 27 Sep 2017 11:21:39 -0400
Message-ID: <37b805d0-4585-53b2-6ed2-3ff316540023@mellanox.com>
References: <1505921299-7837-1-git-send-email-dwoods@mellanox.com>
 <20170927141057.GP8398@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170927141057.GP8398@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, robin.murphy@arm.com
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, cmetcalf@mellanox.com
List-Id: iommu@lists.linux-foundation.org


I see now that this is redundant with Robin's patch series "Optimise 
64-bit IOVA allocations".  I tested those patches on our platform and 
find that they solve the performance problem we were having. So, I'd 
like to withdraw this patch.

On 9/27/2017 10:10 AM, Joerg Roedel wrote:
> Adding Robin.
>
> Robin, can you please have a look?
>
> On Wed, Sep 20, 2017 at 11:28:19AM -0400, David Woods wrote:
>> When allocating pages with alloc_iova() where limit_pfn > dma_32bit_pfn
>> __alloc_and_insert_iova_range does a linear traversal of the tree to
>> find a free block.  In the worst case it makes the alloc O(n) for each
>> page, where n is the number of pages allocated so far.  The worst case
>> turns out to be common for drivers that allocate lots of pages at start
>> up and never free them.
>>
>> There is an optimization for allocating 32-bit addresses where it
>> starts the search at the point where the previous allocated page was
>> inserted.  This is sensible, since otherwise it would have to always
>> search through all the 64-bit pages first.
>>
>> To improve this situation, extend the optimization to also keep track
>> of the point were the previous 64-bit page was inserted.  With this
>> change, the search for an available slot can normally be done in
>> constant time and the whole alloc_iova only costs O(log n) due to the
>> rb tree insert.
>>
>> Reviewed-by: Chris Metcalf <cmetcalf@mellanox.com>
>> Signed-off-by: David Woods <dwoods@mellanox.com>
>> ---
>>   drivers/iommu/iova.c | 82 +++++++++++++++++++++++++++++++++++-----------------
>>   include/linux/iova.h |  1 +
>>   2 files changed, 56 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 33edfa7..3c82694 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -108,15 +108,26 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>>   EXPORT_SYMBOL_GPL(init_iova_flush_queue);
>>   
>>   static struct rb_node *
>> -__get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
>> +__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
>>   {
>> -	if ((*limit_pfn > iovad->dma_32bit_pfn) ||
>> -		(iovad->cached32_node == NULL))
>> +	if (limit_pfn <= iovad->dma_32bit_pfn)
>> +		return iovad->cached32_node;
>> +	else
>> +		return iovad->cached64_node;
>> +}
>> +
>> +static struct rb_node *
>> +__get_cached_rbnode_and_limit(struct iova_domain *iovad,
>> +			      unsigned long *limit_pfn)
>> +{
>> +	struct rb_node *cached_node = __get_cached_rbnode(iovad, *limit_pfn);
>> +
>> +	if (cached_node == NULL) {
>>   		return rb_last(&iovad->rbroot);
>> -	else {
>> -		struct rb_node *prev_node = rb_prev(iovad->cached32_node);
>> +	} else {
>> +		struct rb_node *prev_node = rb_prev(cached_node);
>>   		struct iova *curr_iova =
>> -			rb_entry(iovad->cached32_node, struct iova, node);
>> +			rb_entry(cached_node, struct iova, node);
>>   		*limit_pfn = curr_iova->pfn_lo;
>>   		return prev_node;
>>   	}
>> @@ -124,33 +135,50 @@ __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
>>   
>>   static void
>>   __cached_rbnode_insert_update(struct iova_domain *iovad,
>> -	unsigned long limit_pfn, struct iova *new)
>> +	unsigned long limit_pfn, struct rb_node *node)
>>   {
>> -	if (limit_pfn != iovad->dma_32bit_pfn)
>> -		return;
>> -	iovad->cached32_node = &new->node;
>> +	if (limit_pfn == iovad->dma_32bit_pfn)
>> +		iovad->cached32_node = node;
>> +	else if (limit_pfn > iovad->dma_32bit_pfn)
>> +		iovad->cached64_node = node;
>>   }
>>   
>>   static void
>>   __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>>   {
>>   	struct iova *cached_iova;
>> -	struct rb_node *curr;
>> -
>> -	if (!iovad->cached32_node)
>> -		return;
>> -	curr = iovad->cached32_node;
>> -	cached_iova = rb_entry(curr, struct iova, node);
>> -
>> -	if (free->pfn_lo >= cached_iova->pfn_lo) {
>> -		struct rb_node *node = rb_next(&free->node);
>> -		struct iova *iova = rb_entry(node, struct iova, node);
>> +	struct rb_node *cached_node;
>>   
>> -		/* only cache if it's below 32bit pfn */
>> -		if (node && iova->pfn_lo < iovad->dma_32bit_pfn)
>> -			iovad->cached32_node = node;
>> -		else
>> -			iovad->cached32_node = NULL;
>> +	if (free->pfn_lo <= iovad->dma_32bit_pfn) {
>> +		if (unlikely(iovad->cached64_node == &free->node))
>> +			iovad->cached64_node = NULL;
>> +		cached_node = iovad->cached32_node;
>> +		if (!cached_node)
>> +			return;
>> +		cached_iova = rb_entry(cached_node, struct iova, node);
>> +		if (free->pfn_lo >= cached_iova->pfn_lo) {
>> +			struct rb_node *next_node = rb_next(&free->node);
>> +
>> +			if (next_node &&
>> +			    rb_entry(next_node, struct iova, node)->pfn_lo <=
>> +			    iovad->dma_32bit_pfn)
>> +				iovad->cached32_node = next_node;
>> +			else
>> +				iovad->cached32_node = NULL;
>> +		}
>> +	} else {
>> +		cached_node = iovad->cached64_node;
>> +		if (!cached_node)
>> +			return;
>> +		cached_iova = container_of(cached_node, struct iova, node);
>> +		if (free->pfn_lo >= cached_iova->pfn_lo) {
>> +			struct rb_node *next_node = rb_next(&free->node);
>> +
>> +			if (next_node)
>> +				iovad->cached64_node = next_node;
>> +			else
>> +				iovad->cached64_node = NULL;
>> +		}
>>   	}
>>   }
>>   
>> @@ -204,7 +232,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>>   	/* Walk the tree backwards */
>>   	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>>   	saved_pfn = limit_pfn;
>> -	curr = __get_cached_rbnode(iovad, &limit_pfn);
>> +	curr = __get_cached_rbnode_and_limit(iovad, &limit_pfn);
>>   	prev = curr;
>>   	while (curr) {
>>   		struct iova *curr_iova = rb_entry(curr, struct iova, node);
>> @@ -238,7 +266,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>>   
>>   	/* If we have 'prev', it's a valid place to start the insertion. */
>>   	iova_insert_rbtree(&iovad->rbroot, new, prev);
>> -	__cached_rbnode_insert_update(iovad, saved_pfn, new);
>> +	__cached_rbnode_insert_update(iovad, saved_pfn, &new->node);
>>   
>>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>>   
>> diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index d179b9b..ea89695 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -71,6 +71,7 @@ struct iova_domain {
>>   	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
>>   	struct rb_root	rbroot;		/* iova domain rbtree root */
>>   	struct rb_node	*cached32_node; /* Save last alloced node */
>> +	struct rb_node	*cached64_node; /* Save last alloced node */
>>   	unsigned long	granule;	/* pfn granularity for this domain */
>>   	unsigned long	start_pfn;	/* Lower limit for this domain */
>>   	unsigned long	dma_32bit_pfn;
>> -- 
>> 2.1.2
