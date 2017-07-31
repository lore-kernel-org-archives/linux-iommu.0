From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 3/4] iommu/iova: Extend rbtree node caching
Date: Mon, 31 Jul 2017 12:42:30 +0100
Message-ID: <e5d4524e-bfe9-acf1-66c1-ea1d9d319855@arm.com>
References: <cover.1500636791.git.robin.murphy@arm.com>
	<b5b7e5541e47cba1112ef5bfb036d8ad44df8893.1500636791.git.robin.murphy@arm.com>
	<23972edc-e59e-3a43-59a9-d776e64af4d7@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <23972edc-e59e-3a43-59a9-d776e64af4d7-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Nate,

On 29/07/17 04:57, Nate Watterson wrote:
> Hi Robin,
> I am seeing a crash when performing very basic testing on this series
> with a Mellanox CX4 NIC. I dug into the crash a bit, and think this
> patch is the culprit, but this rcache business is still mostly
> witchcraft to me.
> 
> # ifconfig eth5 up
> # ifconfig eth5 down
>     Unable to handle kernel NULL pointer dereference at virtual address
> 00000020
>     user pgtable: 64k pages, 48-bit VAs, pgd = ffff8007dbf47c00
>     [0000000000000020] *pgd=00000006efab0003, *pud=00000006efab0003,
> *pmd=00000007d8720003, *pte=0000000000000000
>     Internal error: Oops: 96000007 [#1] SMP
>     Modules linked in:
>     CPU: 47 PID: 5082 Comm: ifconfig Not tainted 4.13.0-rtp-enablement+ #3
>     task: ffff8007da1e5780 task.stack: ffff8007ddcb8000
>     PC is at __cached_rbnode_delete_update+0x2c/0x58
>     LR is at private_free_iova+0x2c/0x60
>     pc : [<ffff00000852c6e4>] lr : [<ffff00000852cdac>] pstate: 204001c5
>     sp : ffff8007ddcbba00
>     x29: ffff8007ddcbba00 x28: ffff8007c8350210
>     x27: ffff8007d1a80000 x26: ffff8007dcc20800
>     x25: 0000000000000140 x24: ffff8007c98f0008
>     x23: 00000000fffffe4e x22: 0000000000000140
>     x21: ffff8007c98f0008 x20: ffff8007c9adb240
>     x19: ffff8007c98f0018 x18: 0000000000000010
>     x17: 0000000000000000 x16: 0000000000000000
>     x15: 4000000000000000 x14: 0000000000000000
>     x13: 00000000ffffffff x12: 0000000000000001
>     x11: dead000000000200 x10: 00000000ffffffff
>     x9 : 0000000000000000 x8 : ffff8007c9adb1c0
>     x7 : 0000000040002000 x6 : 0000000000210d00
>     x5 : 0000000000000000 x4 : 000000000000c57e
>     x3 : 00000000ffffffcf x2 : 00000000ffffffcf
>     x1 : ffff8007c9adb240 x0 : 0000000000000000
>     [...]
>     [<ffff00000852c6e4>] __cached_rbnode_delete_update+0x2c/0x58
>     [<ffff00000852cdac>] private_free_iova+0x2c/0x60
>     [<ffff00000852cea4>] iova_magazine_free_pfns+0x4c/0xa0
>     [<ffff00000852d0a8>] free_iova_fast+0x1b0/0x230
>     [<ffff000008529d34>] iommu_dma_free_iova+0x5c/0x80
>     [<ffff000008529db4>] __iommu_dma_unmap+0x5c/0x98
>     [<ffff00000852aebc>] iommu_dma_unmap_resource+0x24/0x30
>     [<ffff00000852aed4>] iommu_dma_unmap_page+0xc/0x18
>     [<ffff000008093030>] __iommu_unmap_page+0x40/0x60
>     [<ffff0000087401bc>] mlx5e_page_release+0xbc/0x128
>     [<ffff000008740498>] mlx5e_dealloc_rx_wqe+0x30/0x40
>     [<ffff000008735ef0>] mlx5e_close_channel+0x70/0x1f8
>     [<ffff0000087370f4>] mlx5e_close_channels+0x2c/0x50
>     [<ffff0000087385dc>] mlx5e_close_locked+0x54/0x68
>     [<ffff000008738620>] mlx5e_close+0x30/0x58
>     [...]
> 
> ** Disassembly for __cached_rbnode_delete_update() near the fault **
>               92|if (free->pfn_hi < iovad->dma_32bit_pfn)
> FFFF00000852C6C4|            ldr     x3,[x1,#0x18]    ; x3,[free,#24]
> FFFF00000852C6C8|            ldr     x2,[x0,#0x30]    ; x2,[iovad,#48]
> FFFF00000852C6CC|            cmp     x3,x2
> FFFF00000852C6D0|            b.cs    0xFFFF00000852C708
>                 |        curr = &iovad->cached32_node;
>               94|if (!curr)
> FFFF00000852C6D4|            adds    x19,x0,#0x18     ; x19,iovad,#24
> FFFF00000852C6D8|            b.eq    0xFFFF00000852C708
>                 |
>                 |cached_iova = rb_entry(*curr, struct iova, node);
>                 |
>               99|if (free->pfn_lo >= cached_iova->pfn_lo)
> FFFF00000852C6DC|            ldr     x0,[x19]         ; xiovad,[curr]
> FFFF00000852C6E0|            ldr     x2,[x1,#0x20]    ; x2,[free,#32]
> FFFF00000852C6E4|            ldr     x0,[x0,#0x20]    ; x0,[x0,#32]
> Apparently cached_iova was NULL so the pfn_lo access faulted.
> 
> FFFF00000852C6E8|            cmp     x2,x0
> FFFF00000852C6EC|            b.cc    0xFFFF00000852C6FC
> FFFF00000852C6F0|            mov     x0,x1            ; x0,free
>              100|        *curr = rb_next(&free->node);
> After instrumenting the code a bit, this seems to be the culprit. In the
> previous call, free->pfn_lo was 0xFFFF_FFFF which is actually the
> dma_limit for the domain so rb_next() returns NULL.
> 
> Let me know if you have any questions or would like additional tests
> run. I also applied your "DMA domain debug info" patches and dumped the
> contents of the domain at each of the steps above in case that would be
> useful. If nothing else, they reinforce how thirsty the CX4 NIC is
> especially when using 64k pages and many CPUs.

Thanks for the report - I somehow managed to reason myself out of
keeping the "no cached node" check in __cached_rbnode_delete_update() on
the assumption that it must always be set by a previous allocation.
However, there is indeed just one case case for which that fails: when
you free any IOVA immediately after freeing the very topmost one. Which
is something that freeing an entire magazine's worth of IOVAs back to
the tree all at once has a very real chance of doing...

The obvious straightforward fix is inline below, but I'm now starting to
understand the appeal of reserving a sentinel node to ensure the tree
can never be empty, so I might have a quick go at that to see if it
results in nicer code overall.

Robin.

>
> -Nate
> 
> On 7/21/2017 7:42 AM, Robin Murphy wrote:
>> The cached node mechanism provides a significant performance benefit for
>> allocations using a 32-bit DMA mask, but in the case of non-PCI devices
>> or where the 32-bit space is full, the loss of this benefit can be
>> significant - on large systems there can be many thousands of entries in
>> the tree, such that traversing to the end then walking all the way down
>> to find free space every time becomes increasingly awful.
>>
>> Maintain a similar cached node for the whole IOVA space as a superset of
>> the 32-bit space so that performance can remain much more consistent.
>>
>> Inspired by work by Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>.
>>
>> Tested-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Tested-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> v2: No change
>>
>>   drivers/iommu/iova.c | 59
>> +++++++++++++++++++++++++---------------------------
>>   include/linux/iova.h |  3 ++-
>>   2 files changed, 30 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index d094d1ca8f23..f5809a2ee6c2 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -46,6 +46,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned
>> long granule,
>>         spin_lock_init(&iovad->iova_rbtree_lock);
>>       iovad->rbroot = RB_ROOT;
>> +    iovad->cached_node = NULL;
>>       iovad->cached32_node = NULL;
>>       iovad->granule = granule;
>>       iovad->start_pfn = start_pfn;
>> @@ -57,48 +58,46 @@ EXPORT_SYMBOL_GPL(init_iova_domain);
>>   static struct rb_node *
>>   __get_cached_rbnode(struct iova_domain *iovad, unsigned long
>> *limit_pfn)
>>   {
>> -    if ((*limit_pfn > iovad->dma_32bit_pfn) ||
>> -        (iovad->cached32_node == NULL))
>> +    struct rb_node *cached_node = NULL;
>> +    struct iova *curr_iova;
>> +
>> +    if (*limit_pfn <= iovad->dma_32bit_pfn)
>> +        cached_node = iovad->cached32_node;
>> +    if (!cached_node)
>> +        cached_node = iovad->cached_node;
>> +    if (!cached_node)
>>           return rb_last(&iovad->rbroot);
>> -    else {
>> -        struct rb_node *prev_node = rb_prev(iovad->cached32_node);
>> -        struct iova *curr_iova =
>> -            rb_entry(iovad->cached32_node, struct iova, node);
>> -        *limit_pfn = curr_iova->pfn_lo;
>> -        return prev_node;
>> -    }
>> +
>> +    curr_iova = rb_entry(cached_node, struct iova, node);
>> +    *limit_pfn = curr_iova->pfn_lo;
>> +
>> +    return rb_prev(cached_node);
>>   }
>>     static void
>> -__cached_rbnode_insert_update(struct iova_domain *iovad,
>> -    unsigned long limit_pfn, struct iova *new)
>> +__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova
>> *new)
>>   {
>> -    if (limit_pfn != iovad->dma_32bit_pfn)
>> -        return;
>> -    iovad->cached32_node = &new->node;
>> +    if (new->pfn_lo > iovad->dma_32bit_pfn)
>> +        iovad->cached_node = &new->node;
>> +    else
>> +        iovad->cached32_node = &new->node;
>>   }
>>     static void
>>   __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova
>> *free)
>>   {
>>       struct iova *cached_iova;
>> -    struct rb_node *curr;
>> +    struct rb_node **curr = NULL;
>>   -    if (!iovad->cached32_node)
>> -        return;
>> -    curr = iovad->cached32_node;
>> -    cached_iova = rb_entry(curr, struct iova, node);
>> +    if (free->pfn_hi < iovad->dma_32bit_pfn)
>> +        curr = &iovad->cached32_node;
>> +    if (!curr)
>> +        curr = &iovad->cached_node;

+	if (!*curr)
+		return;

>>   -    if (free->pfn_lo >= cached_iova->pfn_lo) {
>> -        struct rb_node *node = rb_next(&free->node);
>> -        struct iova *iova = rb_entry(node, struct iova, node);
>> +    cached_iova = rb_entry(*curr, struct iova, node);
>>   -        /* only cache if it's below 32bit pfn */
>> -        if (node && iova->pfn_lo < iovad->dma_32bit_pfn)
>> -            iovad->cached32_node = node;
>> -        else
>> -            iovad->cached32_node = NULL;
>> -    }
>> +    if (free->pfn_lo >= cached_iova->pfn_lo)
>> +        *curr = rb_next(&free->node);
>>   }
>>     /* Insert the iova into domain rbtree by holding writer lock */
>> @@ -135,7 +134,6 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>   {
>>       struct rb_node *prev, *curr = NULL;
>>       unsigned long flags;
>> -    unsigned long saved_pfn;
>>       unsigned long align_mask = ~0UL;
>>         if (size_aligned)
>> @@ -143,7 +141,6 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>         /* Walk the tree backwards */
>>       spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
>> -    saved_pfn = limit_pfn;
>>       curr = __get_cached_rbnode(iovad, &limit_pfn);
>>       prev = curr;
>>       while (curr) {
>> @@ -173,7 +170,7 @@ static int __alloc_and_insert_iova_range(struct
>> iova_domain *iovad,
>>         /* If we have 'prev', it's a valid place to start the
>> insertion. */
>>       iova_insert_rbtree(&iovad->rbroot, new, prev);
>> -    __cached_rbnode_insert_update(iovad, saved_pfn, new);
>> +    __cached_rbnode_insert_update(iovad, new);
>>         spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>>   diff --git a/include/linux/iova.h b/include/linux/iova.h
>> index e0a892ae45c0..0bb8df43b393 100644
>> --- a/include/linux/iova.h
>> +++ b/include/linux/iova.h
>> @@ -40,7 +40,8 @@ struct iova_rcache {
>>   struct iova_domain {
>>       spinlock_t    iova_rbtree_lock; /* Lock to protect update of
>> rbtree */
>>       struct rb_root    rbroot;        /* iova domain rbtree root */
>> -    struct rb_node    *cached32_node; /* Save last alloced node */
>> +    struct rb_node    *cached_node;    /* Save last alloced node */
>> +    struct rb_node    *cached32_node; /* Save last 32-bit alloced
>> node */
>>       unsigned long    granule;    /* pfn granularity for this domain */
>>       unsigned long    start_pfn;    /* Lower limit for this domain */
>>       unsigned long    dma_32bit_pfn;
>>
> 
