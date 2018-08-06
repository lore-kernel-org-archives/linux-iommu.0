From: "Yang, Shunyong" <shunyong.yang-PT9Dzx9SjPiXmMXjJBpWqg@public.gmane.org>
Subject: Re: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
	mode
Date: Mon, 6 Aug 2018 01:32:44 +0000
Message-ID: <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
	<1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
	<89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
	<5B597628.2020103@huawei.com>
	<04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg
	Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi, Robin,

On 2018/7/26 22:37, Robin Murphy wrote:
> On 2018-07-26 8:20 AM, Leizhen (ThunderTown) wrote:
>> On 2018/7/25 6:25, Robin Murphy wrote:
>>> On 2018-07-12 7:18 AM, Zhen Lei wrote:
>>>> To support the non-strict mode, now we only tlbi and sync for the strict
>>>> mode. But for the non-leaf case, always follow strict mode.
>>>>
>>>> Use the lowest bit of the iova parameter to pass the strict mode:
>>>> 0, IOMMU_STRICT;
>>>> 1, IOMMU_NON_STRICT;
>>>> Treat 0 as IOMMU_STRICT, so that the unmap operation can compatible with
>>>> other IOMMUs which still use strict mode.
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>>    drivers/iommu/io-pgtable-arm.c | 23 ++++++++++++++---------
>>>>    1 file changed, 14 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>>>> index 010a254..9234db3 100644
>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>> @@ -292,7 +292,7 @@ static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
>>>>      static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>                       unsigned long iova, size_t size, int lvl,
>>>> -                   arm_lpae_iopte *ptep);
>>>> +                   arm_lpae_iopte *ptep, int strict);
>>>>      static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>>>                    phys_addr_t paddr, arm_lpae_iopte prot,
>>>> @@ -334,7 +334,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>>>>            size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
>>>>              tblp = ptep - ARM_LPAE_LVL_IDX(iova, lvl, data);
>>>> -        if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp) != sz))
>>>> +        if (WARN_ON(__arm_lpae_unmap(data, iova, sz, lvl, tblp, IOMMU_STRICT) != sz))
>>>>                return -EINVAL;
>>>>        }
>>>>    @@ -531,7 +531,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
>>>>    static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>>>                           unsigned long iova, size_t size,
>>>>                           arm_lpae_iopte blk_pte, int lvl,
>>>> -                       arm_lpae_iopte *ptep)
>>>> +                       arm_lpae_iopte *ptep, int strict)
>>>
>>> DMA code should never ever be splitting blocks anyway, and frankly the TLB maintenance here is dodgy enough (since we can't reasonably do break-before make as VMSA says we should) that I *really* don't want to introduce any possibility of making it more asynchronous. I'd much rather just hard-code the expectation of strict == true for this.
>>
>> OK, I will hard-code strict=true for it.
>>
>> But since it never ever be happened, why did not give a warning at the beginning?
> 
> Because DMA code is not the only caller of iommu_map/unmap. It's 
> perfectly legal in the IOMMU API to partially unmap a previous mapping 
> such that a block entry needs to be split. The DMA API, however, is a 
> lot more constrined, and thus by construction the iommu-dma layer will 
> never generate a block-splitting iommu_unmap() except as a result of 
> illegal DMA API usage, and we obviously do not need to optimise for that 
> (you will get a warning about mismatched unmaps under dma-debug, but 
> it's a bit too expensive to police in the general case).
> 

When I was reading the code around arm_lpae_split_blk_unmap(), I was
curious in which scenario a block will be split. Now with your comments
"Because DMA code is not the only caller of iommu_map/unmap", it seems
depending on the user.

Would you please explain this further? I mean besides DMA, which user
will use iommu_map/umap and how it split a block.

Thanks.
Shunyong.

> 
>>>>    {
>>>>        struct io_pgtable_cfg *cfg = &data->iop.cfg;
>>>>        arm_lpae_iopte pte, *tablep;
>>>> @@ -576,15 +576,18 @@ static size_t arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
>>>>        }
>>>>          if (unmap_idx < 0)
>>>> -        return __arm_lpae_unmap(data, iova, size, lvl, tablep);
>>>> +        return __arm_lpae_unmap(data, iova, size, lvl, tablep, strict);
>>>>          io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
>>>> +    if (!strict)
>>>> +        io_pgtable_tlb_sync(&data->iop);
>>>> +
>>>>        return size;
>>>>    }
>>>>      static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>                       unsigned long iova, size_t size, int lvl,
>>>> -                   arm_lpae_iopte *ptep)
>>>> +                   arm_lpae_iopte *ptep, int strict)
>>>>    {
>>>>        arm_lpae_iopte pte;
>>>>        struct io_pgtable *iop = &data->iop;
>>>> @@ -609,7 +612,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>                io_pgtable_tlb_sync(iop);
>>>>                ptep = iopte_deref(pte, data);
>>>>                __arm_lpae_free_pgtable(data, lvl + 1, ptep);
>>>> -        } else {
>>>> +        } else if (strict) {
>>>>                io_pgtable_tlb_add_flush(iop, iova, size, size, true);
>>>>            }
>>>>    @@ -620,25 +623,27 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>>             * minus the part we want to unmap
>>>>             */
>>>>            return arm_lpae_split_blk_unmap(data, iova, size, pte,
>>>> -                        lvl + 1, ptep);
>>>> +                        lvl + 1, ptep, strict);
>>>>        }
>>>>          /* Keep on walkin' */
>>>>        ptep = iopte_deref(pte, data);
>>>> -    return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep);
>>>> +    return __arm_lpae_unmap(data, iova, size, lvl + 1, ptep, strict);
>>>>    }
>>>>      static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
>>>>                     size_t size)
>>>>    {
>>>> +    int strict = ((iova & IOMMU_STRICT_MODE_MASK) == IOMMU_STRICT);
>>>>        struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
>>>>        arm_lpae_iopte *ptep = data->pgd;
>>>>        int lvl = ARM_LPAE_START_LVL(data);
>>>>    +    iova &= ~IOMMU_STRICT_MODE_MASK;
>>>>        if (WARN_ON(iova >= (1ULL << data->iop.cfg.ias)))
>>>>            return 0;
>>>>    -    return __arm_lpae_unmap(data, iova, size, lvl, ptep);
>>>> +    return __arm_lpae_unmap(data, iova, size, lvl, ptep, strict);
>>>>    }
>>>>      static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>>>>
>>>
>>> .
>>>
>>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
