From: Tomasz Nowicki <tnowicki@caviumnetworks.com>
Subject: Re: [PATCH v4 5/6] iommu/iova: Extend rbtree node caching
Date: Wed, 20 Sep 2017 14:59:09 +0200
Message-ID: <ee693561-67c4-ed2a-9462-e783dfc013c2@caviumnetworks.com>
References: <cover.1505829018.git.robin.murphy@arm.com>
 <223f0fddac0dcefc43ad81594979875967745c58.1505829018.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <223f0fddac0dcefc43ad81594979875967745c58.1505829018.git.robin.murphy@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, thunder.leizhen@huawei.com, nwatters@codeaurora.org, tomasz.nowicki@caviumnetworks.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 19.09.2017 18:31, Robin Murphy wrote:
> The cached node mechanism provides a significant performance benefit for
> allocations using a 32-bit DMA mask, but in the case of non-PCI devices
> or where the 32-bit space is full, the loss of this benefit can be
> significant - on large systems there can be many thousands of entries in
> the tree, such that walking all the way down to find free space every
> time becomes increasingly awful.
> 
> Maintain a similar cached node for the whole IOVA space as a superset of
> the 32-bit space so that performance can remain much more consistent.
> 
> Inspired by work by Zhen Lei <thunder.leizhen@huawei.com>.
> 
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: Nate Watterson <nwatters@codeaurora.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v4:
>   - Adjust to simplified __get_cached_rbnode() behaviour
>   - Cosmetic tweaks
> 
>   drivers/iommu/iova.c | 43 +++++++++++++++++++++----------------------
>   include/linux/iova.h |  3 ++-
>   2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index c93a6c46bcb1..a125a5786dbf 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -51,6 +51,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   
>   	spin_lock_init(&iovad->iova_rbtree_lock);
>   	iovad->rbroot = RB_ROOT;
> +	iovad->cached_node = NULL;
>   	iovad->cached32_node = NULL;
>   	iovad->granule = granule;
>   	iovad->start_pfn = start_pfn;
> @@ -119,39 +120,38 @@ __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
>   	if (limit_pfn <= iovad->dma_32bit_pfn && iovad->cached32_node)
>   		return iovad->cached32_node;
>   
> +	if (iovad->cached_node)
> +		return iovad->cached_node;
> +
>   	return &iovad->anchor.node;
>   }
>   
>   static void
> -__cached_rbnode_insert_update(struct iova_domain *iovad,
> -	unsigned long limit_pfn, struct iova *new)
> +__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
>   {
> -	if (limit_pfn != iovad->dma_32bit_pfn)
> -		return;
> -	iovad->cached32_node = &new->node;
> +	if (new->pfn_hi < iovad->dma_32bit_pfn)
> +		iovad->cached32_node = &new->node;
> +	else
> +		iovad->cached_node = &new->node;
>   }
>   
>   static void
>   __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>   {
>   	struct iova *cached_iova;
> -	struct rb_node *curr;
> +	struct rb_node **curr;
>   
> -	if (!iovad->cached32_node)
> +	if (free->pfn_hi < iovad->dma_32bit_pfn)
> +		curr = &iovad->cached32_node;
> +	else
> +		curr = &iovad->cached_node;
> +
> +	if (!*curr)
>   		return;
> -	curr = iovad->cached32_node;
> -	cached_iova = rb_entry(curr, struct iova, node);
>   
> -	if (free->pfn_lo >= cached_iova->pfn_lo) {
> -		struct rb_node *node = rb_next(&free->node);
> -		struct iova *iova = rb_entry(node, struct iova, node);
> -
> -		/* only cache if it's below 32bit pfn */
> -		if (node && iova->pfn_lo < iovad->dma_32bit_pfn)
> -			iovad->cached32_node = node;
> -		else
> -			iovad->cached32_node = NULL;
> -	}
> +	cached_iova = rb_entry(*curr, struct iova, node);
> +	if (free->pfn_lo >= cached_iova->pfn_lo)
> +		*curr = rb_next(&free->node);

IMO, we may incorrectly update iovad->cached32_node here.

                               32-bit boundary
      --------       --------        |          --------       --------
     |        |     |        |       |         |        |     |        |
----  IOVA0   -----  IOVA1   -----------------  IOVA3   -----  anchor |
     |        |     |        |       |         |        |     |        |
      --------       --------        |          --------       --------

If we free last IOVA from 32-bit space (IOVA1) we will update 
iovad->cached32_node to IOVA3.

Thanks,
Tomasz
