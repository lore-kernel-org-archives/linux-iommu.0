From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/7] add non-strict mode support for arm-smmu-v3
Date: Fri, 1 Jun 2018 14:50:35 +0800
Message-ID: <5B10ECBB.209@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
	<d65f87a4-db61-3cd2-1a6f-0322025840a8@arm.com>
	<96cc25b9-b21f-6067-384d-f52e6b8b25e7@huawei.com>
	<92b240f5-596e-87a9-863a-b18475042cce@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <92b240f5-596e-87a9-863a-b18475042cce-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-mediatek <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Guozhu Li <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2018/5/31 22:25, Robin Murphy wrote:
> On 31/05/18 14:49, Hanjun Guo wrote:
>> Hi Robin,
>>
>> On 2018/5/31 19:24, Robin Murphy wrote:
>>> On 31/05/18 08:42, Zhen Lei wrote:
>>>> In common, a IOMMU unmap operation follow the below steps:
>>>> 1. remove the mapping in page table of the specified iova range
>>>> 2. execute tlbi command to invalid the mapping which is cached in TLB
>>>> 3. wait for the above tlbi operation to be finished
>>>> 4. free the IOVA resource
>>>> 5. free the physical memory resource
>>>>
>>>> This maybe a problem when unmap is very frequently, the combination of tlbi
>>>> and wait operation will consume a lot of time. A feasible method is put off
>>>> tlbi and iova-free operation, when accumulating to a certain number or
>>>> reaching a specified time, execute only one tlbi_all command to clean up
>>>> TLB, then free the backup IOVAs. Mark as non-strict mode.
>>>>
>>>> But it must be noted that, although the mapping has already been removed in
>>>> the page table, it maybe still exist in TLB. And the freed physical memory
>>>> may also be reused for others. So a attacker can persistent access to memory
>>>> based on the just freed IOVA, to obtain sensible data or corrupt memory. So
>>>> the VFIO should always choose the strict mode.
>>>>
>>>> Some may consider put off physical memory free also, that will still follow
>>>> strict mode. But for the map_sg cases, the memory allocation is not controlled
>>>> by IOMMU APIs, so it is not enforceable.
>>>>
>>>> Fortunately, Intel and AMD have already applied the non-strict mode, and put
>>>> queue_iova() operation into the common file dma-iommu.c., and my work is based
>>>> on it. The difference is that arm-smmu-v3 driver will call IOMMU common APIs to
>>>> unmap, but Intel and AMD IOMMU drivers are not.
>>>>
>>>> Below is the performance data of strict vs non-strict for NVMe device:
>>>> Randomly Read  IOPS: 146K(strict) vs 573K(non-strict)
>>>> Randomly Write IOPS: 143K(strict) vs 513K(non-strict)
>>>
>>> What hardware is this on? If it's SMMUv3 without MSIs (e.g. D05), then you'll still be using the rubbish globally-blocking sync implementation. If that is the case, I'd be very interested to see how much there is to gain from just improving that - I've had a patch kicking around for a while[1] (also on a rebased branch at [2]), but don't have the means for serious performance testing.
I will try your patch to see how much it can improve. I think the best way
to resovle the globally-blocking sync is that the hardware provide 64bits
CONS regitster, so that it can never be wrapped, and the spinlock can also
be removed.

>>
>> The hardware is the new D06 which the SMMU with MSIs,
> 
> Cool! Now that profiling is fairly useful since we got rid of most of the locks, are you able to get an idea of how the overhead in the normal case is distributed between arm_smmu_cmdq_insert_cmd() and __arm_smmu_sync_poll_msi()? We're always trying to improve our understanding of where command-queue-related overheads turn out to be in practice, and there's still potentially room to do nicer things than TLBI_NH_ALL ;)
Even if the software has no overhead, there may still be a problem, because
the smmu need to execute the commands in sequence, especially before
globally-blocking sync has been removed. Base on the actually execute time
of single tlbi and sync, we can get the upper limit in theory.

BTW, I will reply the reset of mail next week. I'm busy with other things now.

> 
> Robin.
> 
>> it's not D05 :)
>>
>> Thanks
>> Hanjun
>>
> 
> .
> 

-- 
Thanks!
BestRegards
