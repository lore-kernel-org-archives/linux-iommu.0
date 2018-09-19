From: Ganapatrao Kulkarni <gklkml16@gmail.com>
Subject: Re: [PATCH v4] iommu/iova: Optimise attempts to allocate iova from
 32bit address range
Date: Wed, 19 Sep 2018 09:08:25 +0530
Message-ID: <CAKTKpr7SokNx304PbVzhn6Xj05m962tmsCzmBec1R0Q9Pon3Zw@mail.gmail.com>
References: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905042736.11904-1-ganapatrao.kulkarni@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, tomasz.nowicki@cavium.com, jnair@caviumnetworks.com, Robert Richter <Robert.Richter@cavium.com>, Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

can you please pull this patch?

On Wed, Sep 5, 2018 at 9:58 AM Ganapatrao Kulkarni
<ganapatrao.kulkarni@cavium.com> wrote:
>
> As an optimisation for PCI devices, there is always first attempt
> been made to allocate iova from SAC address range. This will lead
> to unnecessary attempts, when there are no free ranges
> available. Adding fix to track recently failed iova address size and
> allow further attempts, only if requested size is lesser than a failed
> size. The size is updated when any replenish happens.
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
> v4:
>     Rebsaed to 4.19-rc2
> v3:
>     Update with comments [3] from Robin Murphy <robin.murphy@arm.com>
>
> [3] https://lkml.org/lkml/2018/8/13/116
>
> v2: update with comments [2] from Robin Murphy <robin.murphy@arm.com>
>
> [2] https://lkml.org/lkml/2018/8/7/166
>
> v1: Based on comments from Robin Murphy <robin.murphy@arm.com>
> for patch [1]
>
> [1] https://lkml.org/lkml/2018/4/19/780
>
>  drivers/iommu/iova.c | 22 +++++++++++++++-------
>  include/linux/iova.h |  1 +
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 83fe2621effe..f8d3ba247523 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -56,6 +56,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>         iovad->granule = granule;
>         iovad->start_pfn = start_pfn;
>         iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
> +       iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>         iovad->flush_cb = NULL;
>         iovad->fq = NULL;
>         iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
> @@ -139,8 +140,10 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>
>         cached_iova = rb_entry(iovad->cached32_node, struct iova, node);
>         if (free->pfn_hi < iovad->dma_32bit_pfn &&
> -           free->pfn_lo >= cached_iova->pfn_lo)
> +           free->pfn_lo >= cached_iova->pfn_lo) {
>                 iovad->cached32_node = rb_next(&free->node);
> +               iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> +       }
>
>         cached_iova = rb_entry(iovad->cached_node, struct iova, node);
>         if (free->pfn_lo >= cached_iova->pfn_lo)
> @@ -190,6 +193,10 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>
>         /* Walk the tree backwards */
>         spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +       if (limit_pfn <= iovad->dma_32bit_pfn &&
> +                       size >= iovad->max32_alloc_size)
> +               goto iova32_full;
> +
>         curr = __get_cached_rbnode(iovad, limit_pfn);
>         curr_iova = rb_entry(curr, struct iova, node);
>         do {
> @@ -200,10 +207,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>                 curr_iova = rb_entry(curr, struct iova, node);
>         } while (curr && new_pfn <= curr_iova->pfn_hi);
>
> -       if (limit_pfn < size || new_pfn < iovad->start_pfn) {
> -               spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -               return -ENOMEM;
> -       }
> +       if (limit_pfn < size || new_pfn < iovad->start_pfn)
> +               goto iova32_full;
>
>         /* pfn_lo will point to size aligned address if size_aligned is set */
>         new->pfn_lo = new_pfn;
> @@ -214,9 +219,12 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>         __cached_rbnode_insert_update(iovad, new);
>
>         spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -
> -
>         return 0;
> +
> +iova32_full:
> +       iovad->max32_alloc_size = size;
> +       spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +       return -ENOMEM;
>  }
>
>  static struct kmem_cache *iova_cache;
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 928442dda565..0b93bf96693e 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -75,6 +75,7 @@ struct iova_domain {
>         unsigned long   granule;        /* pfn granularity for this domain */
>         unsigned long   start_pfn;      /* Lower limit for this domain */
>         unsigned long   dma_32bit_pfn;
> +       unsigned long   max32_alloc_size; /* Size of last failed allocation */
>         struct iova     anchor;         /* rbtree lookup anchor */
>         struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];  /* IOVA range caches */
>
> --
> 2.18.0
>
thanks,
Ganapat
