Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC363A1E69;
	Wed, 17 Jun 2026 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726128; cv=none; b=Wx/Tr/MbHzTVnpEBUxEKGSruInsWb09kI4sQcqaP+QyuemNKrnf0EILanoHiJIFo+SuI7TTWg2cnxV0d2qKPtYSlwrbFp1e+qATpnr+1uQ9XEYn0yWw4gHRcryXnENpa8QJ855vnA3G5ERQ5IbpnOfKjx5/pzp5Q+wZSIXQGtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726128; c=relaxed/simple;
	bh=yI0s7mH6cma8sO62XSPzV8gvpSNCthAa7uZfha7qHYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2m8Fr+lOwuM2Bn1KCHyffRfRVYbDva75p7Oy9v5kLwBSXMjF4TPyNeSjMWi1BClL8bvkK77dwnxTWzmlqn30zCS9ogEmg3KtIldqS5fRRPjF7BoGUCzgQSNHf/6ey4bDWz5peR4tDrBH74DLUvAzyjbfm8Ltxo/d9ko07vGy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TlsujTHt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TlsujTHt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FaIXkx6bICCEeHVM1VfDvi+i38PauiO2syOky77jwjY=; b=TlsujTHtkdJqNImi3uQpzkD07N
	xosi6Y+tqbQMiQib9nUxl+SsTpqrR7HxLpxEETR1eF85La7GKaJuaK5wjGDV5Sk7uD/iiMA82X42z
	A2fhbVP/Z4WvVGjgfZSM4ht+paVXOLvEwX0LwmvQWLIX1Jg90GeQGODGE03obcl5Um/b5WH7LQrFP
	aOATMBiS49rqE7rflxttHAzYZtlvUCUkMunetTuH6v5VuboOH84EMwOM11xtwYWwWcHHJcOTw6IQa
	DVSqMo0ekF9ryRgSpjFn312HAy8xTXOtbsgTllXe0Kzuw6jPbiqrXjiPV6OalaGxm6mmousoBKMnk
	ykWfrVMw==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZwLx-00000000I5D-1Bv3;
	Wed, 17 Jun 2026 19:55:13 +0000
Date: Wed, 17 Jun 2026 15:55:11 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	jgg@ziepe.ca, kyle@mcmartin.ca, Rik van Riel <riel@meta.com>
Subject: Re: [PATCH v3 1/3] iova: convert from rbtree to maple tree
Message-ID: <3bdrfc244zzmutjfpfyw4nivb4w4mckfs3b3mqbxr4ffr27mkv@x3i4v335ozww>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-2-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603033653.4144138-2-riel@surriel.com>

On 26/06/02 11:35PM, Rik van Riel wrote:
> From: Rik van Riel <riel@meta.com>
> 
> Replace the hand-rolled rbtree in the IOVA allocator with a maple tree.
> The maple tree is a B-tree variant designed for range tracking with
> built-in gap searching, making it a natural fit for IOVA address space
> management -- the same data structure is used by the kernel VMA
> subsystem for the analogous problem.
> 
> Key changes:
> 
>   - struct iova shrinks from 40 bytes (rb_node 24 + pfn_hi 8 + pfn_lo 8)
>     to just pfn_hi + pfn_lo (16 bytes). SLAB_HWCACHE_ALIGN is dropped
>     from the iova slab cache since struct iova no longer contains an
>     embedded rb_node touched during tree rebalancing -- tree traversal
>     now touches maple nodes exclusively. This lets the slab allocator
>     pack 16-byte objects tightly instead of rounding to 64 bytes.
> 
>     The maple tree replaces the embedded rb_node with external B-tree
>     nodes: each maple_arange_64 node is 256 bytes and holds up to 10
>     entries, plus internal nodes add ~11% overhead. At typical
>     utilization (~70-90% full), this works out to ~28-41 bytes of maple
>     tree node memory per IOVA entry. The net per-entry cost is ~44-57
>     bytes (16 bytes slab + ~28-41 bytes maple), compared to ~64 bytes
>     with the old rbtree (64 bytes HWCACHE_ALIGN slab + 0 bytes
>     embedded rbtree). Combined with the maple tree's O(log_10 n)
>     search depth and better cache locality from B-tree fan-out,
>     this improves both memory efficiency and search performance.
> 
>   - struct iova_domain replaces rb_root + cached_node + cached32_node
>     + anchor with a single struct maple_tree. The iova_rbtree_lock
>     spinlock is renamed to iova_lock. The maple tree is initialized
>     with MT_FLAGS_ALLOC_RANGE (enables gap tracking for
>     mas_empty_area_rev) and MT_FLAGS_LOCK_EXTERN (uses the existing
>     iova_lock spinlock instead of the maple tree internal lock)there .

If the spinlock is only used to protect the tree, why are you using an
external lock?

> 
>   - Allocation via __alloc_and_insert_iova_range() uses
>     mas_empty_area_rev() to find the highest-addressed gap of
>     sufficient size below limit_pfn in O(log n) with B-tree fan-out.
>     Alignment is handled by over-requesting (size + alignment - 1)
>     to guarantee room after rounding, eliminating the need for a
>     retry loop. The result is stored with mas_store_gfp().
> 
>   - Lookup via private_find_iova() uses mas_walk() for O(log n)
>     point-in-range lookup.
> 
>   - Deletion via remove_iova() uses mas_erase(). No successor gap
>     fixup needed -- the maple tree handles it internally.
> 
>   - reserve_iova() walks the requested range for existing entries,
>     computes the merged range, collects old entries for freeing, then
>     stores a single merged entry. If the request is fully covered by
>     an existing entry, it returns that entry without allocating.
> 
>   - The IOVA_ANCHOR sentinel node is eliminated. The maple tree
>     tracks gaps implicitly, including the space above the highest
>     allocation.
> 
>   - The cached_node / cached32_node fields and all their helpers
>     are eliminated. The maple tree B-tree structure provides
>     equivalent or better cache behaviour.
> 
> The rcache (magazine cache) layer is unchanged -- it operates on raw
> pfn values and is orthogonal to the tree backing store.
> 
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iova.c | 338 ++++++++++++-------------------------------
>  include/linux/iova.h |  10 +-
>  2 files changed, 98 insertions(+), 250 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 021daf6528de..523d1e8315f9 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -13,9 +13,7 @@
>  #include <linux/bitops.h>
>  #include <linux/cpu.h>
>  #include <linux/workqueue.h>
> -
> -/* The anchor node sits above the top of the usable address space */
> -#define IOVA_ANCHOR	~0UL
> +#include <linux/maple_tree.h>
>  
>  #define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
>  
> @@ -29,11 +27,6 @@ static void free_iova_rcaches(struct iova_domain *iovad);
>  static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>  static void free_global_cached_iovas(struct iova_domain *iovad);
>  
> -static struct iova *to_iova(struct rb_node *node)
> -{
> -	return rb_entry(node, struct iova, node);
> -}
> -
>  void
>  init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>  	unsigned long start_pfn)
> @@ -45,180 +38,63 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>  	 */
>  	BUG_ON((granule > PAGE_SIZE) || !is_power_of_2(granule));
>  
> -	spin_lock_init(&iovad->iova_rbtree_lock);
> -	iovad->rbroot = RB_ROOT;
> -	iovad->cached_node = &iovad->anchor.node;
> -	iovad->cached32_node = &iovad->anchor.node;
> +	spin_lock_init(&iovad->iova_lock);
> +	mt_init_flags(&iovad->mtree,
> +		      MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
> +	mt_set_external_lock(&iovad->mtree, &iovad->iova_lock);
>  	iovad->granule = granule;
>  	iovad->start_pfn = start_pfn;
>  	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
>  	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> -	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
> -	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
> -	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
>  }
>  EXPORT_SYMBOL_GPL(init_iova_domain);
>  
> -static struct rb_node *
> -__get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
> -{
> -	if (limit_pfn <= iovad->dma_32bit_pfn)
> -		return iovad->cached32_node;
> -
> -	return iovad->cached_node;
> -}
> -
> -static void
> -__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
> -{
> -	if (new->pfn_hi < iovad->dma_32bit_pfn)
> -		iovad->cached32_node = &new->node;
> -	else
> -		iovad->cached_node = &new->node;
> -}
> -
> -static void
> -__cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
> -{
> -	struct iova *cached_iova;
> -
> -	cached_iova = to_iova(iovad->cached32_node);
> -	if (free == cached_iova ||
> -	    (free->pfn_hi < iovad->dma_32bit_pfn &&
> -	     free->pfn_lo >= cached_iova->pfn_lo))
> -		iovad->cached32_node = rb_next(&free->node);
> -
> -	if (free->pfn_lo < iovad->dma_32bit_pfn)
> -		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> -
> -	cached_iova = to_iova(iovad->cached_node);
> -	if (free->pfn_lo >= cached_iova->pfn_lo)
> -		iovad->cached_node = rb_next(&free->node);
> -}
> -
> -static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
> -{
> -	struct rb_node *node, *next;
> -	/*
> -	 * Ideally what we'd like to judge here is whether limit_pfn is close
> -	 * enough to the highest-allocated IOVA that starting the allocation
> -	 * walk from the anchor node will be quicker than this initial work to
> -	 * find an exact starting point (especially if that ends up being the
> -	 * anchor node anyway). This is an incredibly crude approximation which
> -	 * only really helps the most likely case, but is at least trivially easy.
> -	 */
> -	if (limit_pfn > iovad->dma_32bit_pfn)
> -		return &iovad->anchor.node;
> -
> -	node = iovad->rbroot.rb_node;
> -	while (to_iova(node)->pfn_hi < limit_pfn)
> -		node = node->rb_right;
> -
> -search_left:
> -	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
> -		node = node->rb_left;
> -
> -	if (!node->rb_left)
> -		return node;
> -
> -	next = node->rb_left;
> -	while (next->rb_right) {
> -		next = next->rb_right;
> -		if (to_iova(next)->pfn_lo >= limit_pfn) {
> -			node = next;
> -			goto search_left;
> -		}
> -	}
> -
> -	return node;
> -}
> -
> -/* Insert the iova into domain rbtree by holding writer lock */
> -static void
> -iova_insert_rbtree(struct rb_root *root, struct iova *iova,
> -		   struct rb_node *start)
> -{
> -	struct rb_node **new, *parent = NULL;
> -
> -	new = (start) ? &start : &(root->rb_node);
> -	/* Figure out where to put new node */
> -	while (*new) {
> -		struct iova *this = to_iova(*new);
> -
> -		parent = *new;
> -
> -		if (iova->pfn_lo < this->pfn_lo)
> -			new = &((*new)->rb_left);
> -		else if (iova->pfn_lo > this->pfn_lo)
> -			new = &((*new)->rb_right);
> -		else {
> -			WARN_ON(1); /* this should not happen */
> -			return;
> -		}
> -	}
> -	/* Add new node and rebalance tree. */
> -	rb_link_node(&iova->node, parent, new);
> -	rb_insert_color(&iova->node, root);
> -}
> -
>  static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  		unsigned long size, unsigned long limit_pfn,
>  			struct iova *new, bool size_aligned)
>  {
> -	struct rb_node *curr, *prev;
> -	struct iova *curr_iova;
>  	unsigned long flags;
> -	unsigned long new_pfn, retry_pfn;
> +	unsigned long new_pfn;
>  	unsigned long align_mask = ~0UL;
> -	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
> +	unsigned long search_size = size;
> +	MA_STATE(mas, &iovad->mtree, 0, 0);
> +
> +	if (size_aligned) {
> +		unsigned long align = 1UL << fls_long(size - 1);
>  
> -	if (size_aligned)
>  		align_mask <<= fls_long(size - 1);
> +		search_size = size + align - 1;
> +	}
>  
> -	/* Walk the tree backwards */
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	spin_lock_irqsave(&iovad->iova_lock, flags);
>  	if (limit_pfn <= iovad->dma_32bit_pfn &&
>  			size >= iovad->max32_alloc_size)
>  		goto iova32_full;

This check seems to ensure the request is either both 32bit safe or it's
fine to pass.  If a 64bit allocation uses a larger size and we fail
later, aren't we overwriting the 32bit size safety in your alloc_fail
label?  It seems wrong to be changing the max32_alloc_size in the error
recovery.

This also could happen outside the spinlock?  I'm not sure why it was
inside to begin with.

>  
> -	curr = __get_cached_rbnode(iovad, limit_pfn);
> -	curr_iova = to_iova(curr);
> -	retry_pfn = curr_iova->pfn_hi;
> +	if (mas_empty_area_rev(&mas, iovad->start_pfn,
> +				 limit_pfn - 1, search_size))
> +		goto alloc_fail;
>  
> -retry:
> -	do {
> -		high_pfn = min(high_pfn, curr_iova->pfn_lo);
> -		new_pfn = (high_pfn - size) & align_mask;
> -		prev = curr;
> -		curr = rb_prev(curr);
> -		curr_iova = to_iova(curr);
> -	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
> -
> -	if (high_pfn < size || new_pfn < low_pfn) {
> -		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
> -			high_pfn = limit_pfn;
> -			low_pfn = retry_pfn + 1;
> -			curr = iova_find_limit(iovad, limit_pfn);
> -			curr_iova = to_iova(curr);
> -			goto retry;
> -		}
> -		iovad->max32_alloc_size = size;
> -		goto iova32_full;
> -	}
> +	new_pfn = (mas.last - size + 1) & align_mask;
> +	if (new_pfn < mas.index || new_pfn < iovad->start_pfn)
> +		goto alloc_fail;

Neither of these can ever happen..?  You've searched for a gap that's
the worst case alignment and now you're ensuring the offset off the end
aligned isn't smaller than the start of the gap or the end of your
search.  I'm no LLM, I don't think this is possible.

>  
> -	/* pfn_lo will point to size aligned address if size_aligned is set */
>  	new->pfn_lo = new_pfn;
> -	new->pfn_hi = new->pfn_lo + size - 1;
> +	new->pfn_hi = new_pfn + size - 1;
>  
> -	/* If we have 'prev', it's a valid place to start the insertion. */
> -	iova_insert_rbtree(&iovad->rbroot, new, prev);
> -	__cached_rbnode_insert_update(iovad, new);
> +	mas.index = new->pfn_lo;
> +	mas.last = new->pfn_hi;
> +	if (mas_store_gfp(&mas, new, GFP_ATOMIC))
> +		goto alloc_fail;
>  
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>  	return 0;
>  
> +alloc_fail:
> +	if (limit_pfn <= iovad->dma_32bit_pfn)
> +		iovad->max32_alloc_size = size;
>  iova32_full:
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>  	return -ENOMEM;
>  }
>  
> @@ -233,8 +109,7 @@ static struct iova *alloc_iova_mem(void)
>  
>  static void free_iova_mem(struct iova *iova)
>  {
> -	if (iova->pfn_lo != IOVA_ANCHOR)
> -		kmem_cache_free(iova_cache, iova);
> +	kmem_cache_free(iova_cache, iova);
>  }
>  
>  /**
> @@ -275,29 +150,22 @@ EXPORT_SYMBOL_GPL(alloc_iova);
>  static struct iova *
>  private_find_iova(struct iova_domain *iovad, unsigned long pfn)
>  {
> -	struct rb_node *node = iovad->rbroot.rb_node;
> +	MA_STATE(mas, &iovad->mtree, pfn, pfn);
>  
> -	assert_spin_locked(&iovad->iova_rbtree_lock);
> -
> -	while (node) {
> -		struct iova *iova = to_iova(node);
> -
> -		if (pfn < iova->pfn_lo)
> -			node = node->rb_left;
> -		else if (pfn > iova->pfn_hi)
> -			node = node->rb_right;
> -		else
> -			return iova;	/* pfn falls within iova's range */
> -	}
> -
> -	return NULL;
> +	assert_spin_locked(&iovad->iova_lock);
> +	return mas_walk(&mas);
>  }
>  
>  static void remove_iova(struct iova_domain *iovad, struct iova *iova)
>  {
> -	assert_spin_locked(&iovad->iova_rbtree_lock);
> -	__cached_rbnode_delete_update(iovad, iova);
> -	rb_erase(&iova->node, &iovad->rbroot);
> +	MA_STATE(mas, &iovad->mtree, iova->pfn_lo, iova->pfn_hi);
> +
> +	assert_spin_locked(&iovad->iova_lock);
> +
> +	if (iova->pfn_lo < iovad->dma_32bit_pfn)
> +		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
> +
> +	mas_store_gfp(&mas, NULL, GFP_ATOMIC);
>  }
>  
>  /**
> @@ -312,10 +180,9 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
>  	unsigned long flags;
>  	struct iova *iova;
>  
> -	/* Take the lock so that no other thread is manipulating the rbtree */
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	spin_lock_irqsave(&iovad->iova_lock, flags);
>  	iova = private_find_iova(iovad, pfn);
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>  	return iova;
>  }
>  EXPORT_SYMBOL_GPL(find_iova);
> @@ -331,9 +198,9 @@ __free_iova(struct iova_domain *iovad, struct iova *iova)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	spin_lock_irqsave(&iovad->iova_lock, flags);
>  	remove_iova(iovad, iova);
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>  	free_iova_mem(iova);
>  }
>  EXPORT_SYMBOL_GPL(__free_iova);
> @@ -351,14 +218,14 @@ free_iova(struct iova_domain *iovad, unsigned long pfn)
>  	unsigned long flags;
>  	struct iova *iova;
>  
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	spin_lock_irqsave(&iovad->iova_lock, flags);
>  	iova = private_find_iova(iovad, pfn);
>  	if (!iova) {
> -		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +		spin_unlock_irqrestore(&iovad->iova_lock, flags);
>  		return;
>  	}
>  	remove_iova(iovad, iova);
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>  	free_iova_mem(iova);
>  }
>  EXPORT_SYMBOL_GPL(free_iova);
> @@ -445,27 +312,18 @@ static void iova_domain_free_rcaches(struct iova_domain *iovad)
>   */
>  void put_iova_domain(struct iova_domain *iovad)
>  {
> -	struct iova *iova, *tmp;
> +	struct iova *iova;
> +	MA_STATE(mas, &iovad->mtree, 0, 0);
>  
>  	if (iovad->rcaches)
>  		iova_domain_free_rcaches(iovad);
>  
> -	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
> +	mas_for_each(&mas, iova, ULONG_MAX)
>  		free_iova_mem(iova);
> +	__mt_destroy(&iovad->mtree);
>  }
>  EXPORT_SYMBOL_GPL(put_iova_domain);
>  
> -static int
> -__is_range_overlap(struct rb_node *node,
> -	unsigned long pfn_lo, unsigned long pfn_hi)
> -{
> -	struct iova *iova = to_iova(node);
> -
> -	if ((pfn_lo <= iova->pfn_hi) && (pfn_hi >= iova->pfn_lo))
> -		return 1;
> -	return 0;
> -}
> -
>  static inline struct iova *
>  alloc_and_init_iova(unsigned long pfn_lo, unsigned long pfn_hi)
>  {
> @@ -480,29 +338,6 @@ alloc_and_init_iova(unsigned long pfn_lo, unsigned long pfn_hi)
>  	return iova;
>  }
>  
> -static struct iova *
> -__insert_new_range(struct iova_domain *iovad,
> -	unsigned long pfn_lo, unsigned long pfn_hi)
> -{
> -	struct iova *iova;
> -
> -	iova = alloc_and_init_iova(pfn_lo, pfn_hi);
> -	if (iova)
> -		iova_insert_rbtree(&iovad->rbroot, iova, NULL);
> -
> -	return iova;
> -}
> -
> -static void
> -__adjust_overlap_range(struct iova *iova,
> -	unsigned long *pfn_lo, unsigned long *pfn_hi)
> -{
> -	if (*pfn_lo < iova->pfn_lo)
> -		iova->pfn_lo = *pfn_lo;
> -	if (*pfn_hi > iova->pfn_hi)
> -		*pfn_lo = iova->pfn_hi + 1;
> -}
> -
>  /**
>   * reserve_iova - reserves an iova in the given range
>   * @iovad: - iova domain pointer
> @@ -510,41 +345,58 @@ __adjust_overlap_range(struct iova *iova,
>   * @pfn_hi:- higher pfn address
>   * This function allocates reserves the address range from pfn_lo to pfn_hi so
>   * that this address is not dished out as part of alloc_iova.
> + *
> + * If the requested range overlaps existing reservations, ranges are merged.
> + * If the requested range is fully covered by an existing reservation, the
> + * existing entry is returned without allocating.
>   */
>  struct iova *
>  reserve_iova(struct iova_domain *iovad,
>  	unsigned long pfn_lo, unsigned long pfn_hi)
>  {
> -	struct rb_node *node;
>  	unsigned long flags;
> -	struct iova *iova;
> -	unsigned int overlap = 0;
> +	struct iova *iova, *overlap;
> +	unsigned long merged_lo = pfn_lo, merged_hi = pfn_hi;
>  
>  	/* Don't allow nonsensical pfns */
>  	if (WARN_ON((pfn_hi | pfn_lo) > (ULLONG_MAX >> iova_shift(iovad))))
>  		return NULL;
>  
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> -	for (node = rb_first(&iovad->rbroot); node; node = rb_next(node)) {
> -		if (__is_range_overlap(node, pfn_lo, pfn_hi)) {
> -			iova = to_iova(node);
> -			__adjust_overlap_range(iova, &pfn_lo, &pfn_hi);
> -			if ((pfn_lo >= iova->pfn_lo) &&
> -				(pfn_hi <= iova->pfn_hi))
> -				goto finish;
> -			overlap = 1;
> -
> -		} else if (overlap)
> -				break;
> +	spin_lock_irqsave(&iovad->iova_lock, flags);
> +	{
> +		MA_STATE(mas, &iovad->mtree, pfn_lo, pfn_hi);

You might want to look at mas_init() instead of the extra tab block.

> +
> +		mas_for_each(&mas, overlap, pfn_hi) {
> +			if (pfn_lo >= overlap->pfn_lo &&
> +			    pfn_hi <= overlap->pfn_hi) {
> +				spin_unlock_irqrestore(&iovad->iova_lock,
> +						       flags);
> +				return overlap;
> +			}
> +			if (overlap->pfn_lo < merged_lo)
> +				merged_lo = overlap->pfn_lo;
> +			if (overlap->pfn_hi > merged_hi)
> +				merged_hi = overlap->pfn_hi;
> +			free_iova_mem(overlap);
> +		}
>  	}
>  
> -	/* We are here either because this is the first reserver node
> -	 * or need to insert remaining non overlap addr range
> -	 */
> -	iova = __insert_new_range(iovad, pfn_lo, pfn_hi);
> -finish:
> +	iova = alloc_and_init_iova(merged_lo, merged_hi);
> +	if (!iova) {
> +		spin_unlock_irqrestore(&iovad->iova_lock, flags);
> +		return NULL;

                A goto the same repeated block below might be in order?

> +	}
> +
> +	{
> +		MA_STATE(mas, &iovad->mtree, merged_lo, merged_hi);
>  
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);

The maple state keeps track of where things are, so if you have a maple
state pointing at the correct slot, then you can avoid rewalking the
tree.  This is rather complicated, but it will save you a hand full of
dereferences if you need them.

> +		if (mas_store_gfp(&mas, iova, GFP_ATOMIC)) {
> +			spin_unlock_irqrestore(&iovad->iova_lock, flags);
> +			free_iova_mem(iova);
> +			return NULL;
> +		}
> +	}
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>  	return iova;
>  }
>  EXPORT_SYMBOL_GPL(reserve_iova);
> @@ -621,7 +473,7 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>  	unsigned long flags;
>  	int i;
>  
> -	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	spin_lock_irqsave(&iovad->iova_lock, flags);
>  
>  	for (i = 0 ; i < mag->size; ++i) {
>  		struct iova *iova = private_find_iova(iovad, mag->pfns[i]);
> @@ -633,7 +485,7 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
>  		free_iova_mem(iova);
>  	}
>  
> -	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	spin_unlock_irqrestore(&iovad->iova_lock, flags);
>  
>  	mag->size = 0;
>  }
> @@ -956,8 +808,8 @@ int iova_cache_get(void)
>  
>  	mutex_lock(&iova_cache_mutex);
>  	if (!iova_cache_users) {
> -		iova_cache = kmem_cache_create("iommu_iova", sizeof(struct iova), 0,
> -					       SLAB_HWCACHE_ALIGN, NULL);
> +		iova_cache = kmem_cache_create("iommu_iova", sizeof(struct iova),
> +					       0, 0, NULL);

Was this in the patch notes or expected to change?

>  		if (!iova_cache)
>  			goto out_err;
>  
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index d2c4fd923efa..eb4f9ead5451 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -11,12 +11,11 @@
>  
>  #include <linux/types.h>
>  #include <linux/kernel.h>
> -#include <linux/rbtree.h>
> +#include <linux/maple_tree.h>
>  #include <linux/dma-mapping.h>
>  
>  /* iova structure */
>  struct iova {
> -	struct rb_node	node;
>  	unsigned long	pfn_hi; /* Highest allocated pfn */
>  	unsigned long	pfn_lo; /* Lowest allocated pfn */
>  };
> @@ -26,15 +25,12 @@ struct iova_rcache;
>  
>  /* holds all the iova translations for a domain */
>  struct iova_domain {
> -	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
> -	struct rb_root	rbroot;		/* iova domain rbtree root */
> -	struct rb_node	*cached_node;	/* Save last alloced node */
> -	struct rb_node	*cached32_node; /* Save last 32-bit alloced node */
> +	spinlock_t	iova_lock;	/* Lock to protect update of maple tree */
> +	struct maple_tree	mtree;
>  	unsigned long	granule;	/* pfn granularity for this domain */
>  	unsigned long	start_pfn;	/* Lower limit for this domain */
>  	unsigned long	dma_32bit_pfn;
>  	unsigned long	max32_alloc_size; /* Size of last failed allocation */
> -	struct iova	anchor;		/* rbtree lookup anchor */
>  
>  	struct iova_rcache	*rcaches;
>  	struct hlist_node	cpuhp_dead;
> -- 
> 2.54.0
> 
> 
