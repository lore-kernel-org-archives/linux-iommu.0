From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/7] add non-strict mode support for arm-smmu-v3
Date: Thu, 31 May 2018 12:24:21 +0100
Message-ID: <d65f87a4-db61-3cd2-1a6f-0322025840a8@arm.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1527752569-18020-1-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-mediatek <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Guozhu Li <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Libin <huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 31/05/18 08:42, Zhen Lei wrote:
> In common, a IOMMU unmap operation follow the below steps:
> 1. remove the mapping in page table of the specified iova range
> 2. execute tlbi command to invalid the mapping which is cached in TLB
> 3. wait for the above tlbi operation to be finished
> 4. free the IOVA resource
> 5. free the physical memory resource
> 
> This maybe a problem when unmap is very frequently, the combination of tlbi
> and wait operation will consume a lot of time. A feasible method is put off
> tlbi and iova-free operation, when accumulating to a certain number or
> reaching a specified time, execute only one tlbi_all command to clean up
> TLB, then free the backup IOVAs. Mark as non-strict mode.
> 
> But it must be noted that, although the mapping has already been removed in
> the page table, it maybe still exist in TLB. And the freed physical memory
> may also be reused for others. So a attacker can persistent access to memory
> based on the just freed IOVA, to obtain sensible data or corrupt memory. So
> the VFIO should always choose the strict mode.
> 
> Some may consider put off physical memory free also, that will still follow
> strict mode. But for the map_sg cases, the memory allocation is not controlled
> by IOMMU APIs, so it is not enforceable.
> 
> Fortunately, Intel and AMD have already applied the non-strict mode, and put
> queue_iova() operation into the common file dma-iommu.c., and my work is based
> on it. The difference is that arm-smmu-v3 driver will call IOMMU common APIs to
> unmap, but Intel and AMD IOMMU drivers are not.
> 
> Below is the performance data of strict vs non-strict for NVMe device:
> Randomly Read  IOPS: 146K(strict) vs 573K(non-strict)
> Randomly Write IOPS: 143K(strict) vs 513K(non-strict)

What hardware is this on? If it's SMMUv3 without MSIs (e.g. D05), then 
you'll still be using the rubbish globally-blocking sync implementation. 
If that is the case, I'd be very interested to see how much there is to 
gain from just improving that - I've had a patch kicking around for a 
while[1] (also on a rebased branch at [2]), but don't have the means for 
serious performance testing.

Robin.

[1] 
https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg20576.html
[2] git://linux-arm.org/linux-rm iommu/smmu

> 
> 
> Zhen Lei (7):
>    iommu/dma: fix trival coding style mistake
>    iommu/arm-smmu-v3: fix the implementation of flush_iotlb_all hook
>    iommu: prepare for the non-strict mode support
>    iommu/amd: make sure TLB to be flushed before IOVA freed
>    iommu/dma: add support for non-strict mode
>    iommu/io-pgtable-arm: add support for non-strict mode
>    iommu/arm-smmu-v3: add support for non-strict mode
> 
>   drivers/iommu/amd_iommu.c          |  2 +-
>   drivers/iommu/arm-smmu-v3.c        | 16 ++++++++++++---
>   drivers/iommu/arm-smmu.c           |  2 +-
>   drivers/iommu/dma-iommu.c          | 41 ++++++++++++++++++++++++++++++--------
>   drivers/iommu/io-pgtable-arm-v7s.c |  6 +++---
>   drivers/iommu/io-pgtable-arm.c     | 28 ++++++++++++++------------
>   drivers/iommu/io-pgtable.h         |  2 +-
>   drivers/iommu/ipmmu-vmsa.c         |  2 +-
>   drivers/iommu/msm_iommu.c          |  2 +-
>   drivers/iommu/mtk_iommu.c          |  2 +-
>   drivers/iommu/qcom_iommu.c         |  2 +-
>   include/linux/iommu.h              |  5 +++++
>   12 files changed, 76 insertions(+), 34 deletions(-)
> 
