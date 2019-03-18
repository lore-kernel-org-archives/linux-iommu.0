From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/iova: Fix tracking of recently failed iova address
 size
Date: Mon, 18 Mar 2019 15:19:23 +0000
Message-ID: <7515342b-f4b2-9406-5249-93ae7880835a@arm.com>
References: <20190315155553.11857-1-rrichter@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315155553.11857-1-rrichter@marvell.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Richter <rrichter@marvell.com>, Joerg Roedel <joro@8bytes.org>
Cc: Ganapatrao Kulkarni <gkulkarni@marvell.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 15/03/2019 15:56, Robert Richter wrote:
> We track the smallest size that failed for a 32 bit allocation. The
> Size decreases only and if we actually walked the tree and noticed an
> allocation failure. Current code is broken and wrongly updates the
> size value even if we did not try an allocation. This leads to
> increased size values and we might go the slow path again even if we
> have seen a failure before for the same or a smaller size.

That description wasn't too clear (since it rather contradicts itself by 
starting off with "XYZ happens" when the whole point is that XYZ doesn't 
actually happen properly), but having gone and looked at the code in 
context I think I understand it now - specifically, it's that the 
early-exit path for detecting that a 32-bit allocation request is too 
big to possibly succeed should never have gone via the route which 
assigns to max32_alloc_size.

In that respect, the diff looks correct, so modulo possibly tweaking the 
commit message,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Cc: <stable@vger.kernel.org> # 4.20+
> Fixes: bee60e94a1e2 ("iommu/iova: Optimise attempts to allocate iova from 32bit address range")
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>   drivers/iommu/iova.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index f8d3ba247523..2de8122e218f 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -207,8 +207,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   		curr_iova = rb_entry(curr, struct iova, node);
>   	} while (curr && new_pfn <= curr_iova->pfn_hi);
>   
> -	if (limit_pfn < size || new_pfn < iovad->start_pfn)
> +	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> +		iovad->max32_alloc_size = size;
>   		goto iova32_full;
> +	}
>   
>   	/* pfn_lo will point to size aligned address if size_aligned is set */
>   	new->pfn_lo = new_pfn;
> @@ -222,7 +224,6 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   	return 0;
>   
>   iova32_full:
> -	iovad->max32_alloc_size = size;
>   	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
>   	return -ENOMEM;
>   }
> 
