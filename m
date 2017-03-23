From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/7] iommu/iova: fix incorrect variable types
Date: Thu, 23 Mar 2017 11:42:56 +0000
Message-ID: <5fd3cc4b-44c1-e300-6254-892a6dfa435c@arm.com>
References: <1490164067-12552-1-git-send-email-thunder.leizhen@huawei.com>
 <1490164067-12552-2-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490164067-12552-2-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Joerg Roedel <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 22/03/17 06:27, Zhen Lei wrote:
> Keep these four variables type consistent with the paramters of function
> __alloc_and_insert_iova_range and the members of struct iova:
> 
> 1. static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
> 		unsigned long size, unsigned long limit_pfn,
> 
> 2. struct iova {
> 	unsigned long	pfn_hi;
> 	unsigned long	pfn_lo;
> 
> In fact, limit_pfn is most likely larger than 32 bits on DMA64.

FWIW if pad_size manages to overflow an int something's probably gone
horribly wrong, but there's no harm in making it consistent with
everything else here. However, given that patch #6 makes this irrelevant
anyway, do we really need to bother?

Robin.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/iommu/iova.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b7268a1..8ba8b496 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -104,8 +104,8 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>   * Computes the padding size required, to make the start address
>   * naturally aligned on the power-of-two order of its size
>   */
> -static unsigned int
> -iova_get_pad_size(unsigned int size, unsigned int limit_pfn)
> +static unsigned long
> +iova_get_pad_size(unsigned long size, unsigned long limit_pfn)
>  {
>  	return (limit_pfn + 1 - size) & (__roundup_pow_of_two(size) - 1);
>  }
> @@ -117,7 +117,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	struct rb_node *prev, *curr = NULL;
>  	unsigned long flags;
>  	unsigned long saved_pfn;
> -	unsigned int pad_size = 0;
> +	unsigned long pad_size = 0;
>  
>  	/* Walk the tree backwards */
>  	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> 
