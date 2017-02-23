From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu: iova: Consolidate code for adding new node to
	iovad domain rbtree
Date: Thu, 23 Feb 2017 11:59:11 +0000
Message-ID: <54ade5ee-a7e7-e048-8eed-7ebace656ea0@arm.com>
References: <CGME20170223081743eucas1p2c4cec04758bd5fd950d5990eea6b84ae@eucas1p2.samsung.com>
	<1487837853-3195-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1487837853-3195-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 23/02/17 08:17, Marek Szyprowski wrote:
> This patch consolidates almost the same code used in iova_insert_rbtree()
> and __alloc_and_insert_iova_range() functions. There is no functional change.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/iova.c | 85 +++++++++++++++++++---------------------------------
>  1 file changed, 31 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b7268a14184f..32b9c2fb37b6 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -100,6 +100,32 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>  	}
>  }
>  
> +/* Insert the iova into domain rbtree by holding writer lock */
> +static void
> +iova_insert_rbtree(struct rb_root *root, struct iova *iova,
> +		   struct rb_node *start)
> +{
> +	struct rb_node **new, *parent = NULL;
> +
> +	new = (start) ? &start : &(root->rb_node);
> +	/* Figure out where to put new node */
> +	while (*new) {
> +		struct iova *this = rb_entry(*new, struct iova, node);
> +
> +		parent = *new;
> +
> +		if (iova->pfn_lo < this->pfn_lo)
> +			new = &((*new)->rb_left);
> +		else if (iova->pfn_lo > this->pfn_lo)
> +			new = &((*new)->rb_right);
> +		else
> +			BUG(); /* this should not happen */

Ooh, if we're touching this, can we downgrade it to a WARN()? Granted,
allocating an IOVA region of size 0 is not a reasonable thing to do
intentionally, but the fact that it's guaranteed to take down the kernel
is perhaps a bit much (I hit it soooo many times back when debugging the
iommu_dma_map_sg() stuff).

Nice tidyup otherwise, though.

Robin.

> +	}
> +	/* Add new node and rebalance tree. */
> +	rb_link_node(&iova->node, parent, new);
> +	rb_insert_color(&iova->node, root);
> +}
> +
>  /*
>   * Computes the padding size required, to make the start address
>   * naturally aligned on the power-of-two order of its size
> @@ -157,35 +183,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	new->pfn_lo = limit_pfn - (size + pad_size) + 1;
>  	new->pfn_hi = new->pfn_lo + size - 1;
>  
> -	/* Insert the new_iova into domain rbtree by holding writer lock */
> -	/* Add new node and rebalance tree. */
> -	{
> -		struct rb_node **entry, *parent = NULL;
> -
> -		/* If we have 'prev', it's a valid place to start the
> -		   insertion. Otherwise, start from the root. */
> -		if (prev)
> -			entry = &prev;
> -		else
> -			entry = &iovad->rbroot.rb_node;
> -
> -		/* Figure out where to put new node */
> -		while (*entry) {
> -			struct iova *this = rb_entry(*entry, struct iova, node);
> -			parent = *entry;
> -
> -			if (new->pfn_lo < this->pfn_lo)
> -				entry = &((*entry)->rb_left);
> -			else if (new->pfn_lo > this->pfn_lo)
> -				entry = &((*entry)->rb_right);
> -			else
> -				BUG(); /* this should not happen */
> -		}
> -
> -		/* Add new node and rebalance tree. */
> -		rb_link_node(&new->node, parent, entry);
> -		rb_insert_color(&new->node, &iovad->rbroot);
> -	}
> +	/* If we have 'prev', it's a valid place to start the insertion. */
> +	iova_insert_rbtree(&iovad->rbroot, new, prev);
>  	__cached_rbnode_insert_update(iovad, saved_pfn, new);
>  
>  	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> @@ -194,28 +193,6 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	return 0;
>  }
>  
> -static void
> -iova_insert_rbtree(struct rb_root *root, struct iova *iova)
> -{
> -	struct rb_node **new = &(root->rb_node), *parent = NULL;
> -	/* Figure out where to put new node */
> -	while (*new) {
> -		struct iova *this = rb_entry(*new, struct iova, node);
> -
> -		parent = *new;
> -
> -		if (iova->pfn_lo < this->pfn_lo)
> -			new = &((*new)->rb_left);
> -		else if (iova->pfn_lo > this->pfn_lo)
> -			new = &((*new)->rb_right);
> -		else
> -			BUG(); /* this should not happen */
> -	}
> -	/* Add new node and rebalance tree. */
> -	rb_link_node(&iova->node, parent, new);
> -	rb_insert_color(&iova->node, root);
> -}
> -
>  static struct kmem_cache *iova_cache;
>  static unsigned int iova_cache_users;
>  static DEFINE_MUTEX(iova_cache_mutex);
> @@ -505,7 +482,7 @@ void put_iova_domain(struct iova_domain *iovad)
>  
>  	iova = alloc_and_init_iova(pfn_lo, pfn_hi);
>  	if (iova)
> -		iova_insert_rbtree(&iovad->rbroot, iova);
> +		iova_insert_rbtree(&iovad->rbroot, iova, NULL);
>  
>  	return iova;
>  }
> @@ -612,11 +589,11 @@ struct iova *
>  	rb_erase(&iova->node, &iovad->rbroot);
>  
>  	if (prev) {
> -		iova_insert_rbtree(&iovad->rbroot, prev);
> +		iova_insert_rbtree(&iovad->rbroot, prev, NULL);
>  		iova->pfn_lo = pfn_lo;
>  	}
>  	if (next) {
> -		iova_insert_rbtree(&iovad->rbroot, next);
> +		iova_insert_rbtree(&iovad->rbroot, next, NULL);
>  		iova->pfn_hi = pfn_hi;
>  	}
>  	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> 
