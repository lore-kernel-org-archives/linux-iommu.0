From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iova: allow allocation of lowest domain PFN
Date: Thu, 11 May 2017 18:39:01 +0100
Message-ID: <7c703cfd-e667-bdce-de49-ae31a696b5dd@arm.com>
References: <102275367.137137.1494509795293.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <102275367.137137.1494509795293.JavaMail.zimbra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Aaron,

On 11/05/17 14:36, Aaron Sierra wrote:
> I found it was impossible to allocate all of the address space
> defined by an IOVA domain. For example, a trivial domain with 2 pages
> would cover PFNs 0 (start) and 1 (limit), but attempting to allocate
> more than one total PFN would fail because the start PFN could never be
> allocated.

Does this only happen when start_pfn is 0? The recent fix in
5016bdb796b3 implies that allocating the entire address space works
fine, albeit with a non-zero start_pfn. I was about to say that for all
current callers, start_pfn is always at least 1 anyway, but I see the
Nvidia DRM stuff in next is making that no longer true, oh well.

> This adds a function to prevent PFN limit calculations from dipping
> "below" the start PFN in __alloc_and_insert_iova_range() and
> __get_cached_rbnode(). It also alters the PFN validity checks in
> __alloc_and_insert_iova_range() to anticipate possible PFN rollover.
> These combine to allow every PFN within the IOVA domain to be available
> for allocation.
> 
> Signed-off-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/iova.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 5c88ba7..9d92005b 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -32,6 +32,18 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>  static void init_iova_rcaches(struct iova_domain *iovad);
>  static void free_iova_rcaches(struct iova_domain *iovad);
>  
> +static inline unsigned long
> +bounded_next_pfn(struct iova_domain *iovad, struct iova *iova)
> +{
> +	unsigned long next_pfn = iova->pfn_lo - 1;
> +
> +	if (!iova->pfn_lo)
> +		return iovad->start_pfn;
> +
> +	/* make sure the PFN doesn't rollover */
> +	return (next_pfn > iova->pfn_lo) ? iovad->start_pfn : next_pfn;

Why this check? Substituting the definition of next_pfn:

	((iova->pfn_lo - 1) > iova->pfn_lo)

which is only true if iova->pfn_lo == 0, in which case we never get this
far anyway.

I'm also not sure about returning start_pfn instead of 0 in the
underflow case, since reserved entries may exist in the tree such that
pfn_lo < start_pfn, and I'm not convinced that returning a "next" PFN
which is actually "previous" to the lowest entry won't cause things to
go horrendously wrong.

> +}
> +
>  void
>  init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>  	unsigned long start_pfn, unsigned long pfn_32bit)
> @@ -63,7 +75,7 @@ __get_cached_rbnode(struct iova_domain *iovad, unsigned long *limit_pfn)
>  		struct rb_node *prev_node = rb_prev(iovad->cached32_node);
>  		struct iova *curr_iova =
>  			rb_entry(iovad->cached32_node, struct iova, node);
> -		*limit_pfn = curr_iova->pfn_lo - 1;
> +		*limit_pfn = bounded_next_pfn(iovad, curr_iova);
>  		return prev_node;
>  	}
>  }
> @@ -146,6 +158,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  	unsigned long flags;
>  	unsigned long saved_pfn;
>  	unsigned int pad_size = 0;
> +	unsigned long pfn_lo, pfn_hi;
>  
>  	/* Walk the tree backwards */
>  	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> @@ -166,24 +179,30 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  				break;	/* found a free slot */
>  		}
>  adjust_limit_pfn:
> -		limit_pfn = curr_iova->pfn_lo ? (curr_iova->pfn_lo - 1) : 0;
> +		limit_pfn = bounded_next_pfn(iovad, curr_iova);
>  move_left:
>  		prev = curr;
>  		curr = rb_prev(curr);
>  	}
>  
> -	if (!curr) {
> -		if (size_aligned)
> -			pad_size = iova_get_pad_size(size, limit_pfn);
> -		if ((iovad->start_pfn + size + pad_size) > limit_pfn) {

Wouldn't it be sufficient to just change this to

	if ((iovad->start_pfn + size + pad_size - 1) > limit_pfn)

?

Since a size of 0 is invalid, that would appear to be sufficiently
resistant to underflow.

Robin.

> -			spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> -			return -ENOMEM;
> -		}
> -	}
> +	if (size_aligned)
> +		pad_size = iova_get_pad_size(size, limit_pfn);
>  
>  	/* pfn_lo will point to size aligned address if size_aligned is set */
> -	new->pfn_lo = limit_pfn - (size + pad_size) + 1;
> -	new->pfn_hi = new->pfn_lo + size - 1;
> +	pfn_lo = limit_pfn - (size + pad_size) + 1;
> +	pfn_hi = pfn_lo + size - 1;
> +
> +	/*
> +	 * We're working with unsigned values, so we have to be careful about
> +	 * how we detect a PFN "below" the lowest PFN possible; zero.
> +	 */
> +	if (pfn_lo < iovad->start_pfn || pfn_lo > limit_pfn) {
> +		spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +	new->pfn_lo = pfn_lo;
> +	new->pfn_hi = pfn_hi;
>  
>  	/* If we have 'prev', it's a valid place to start the insertion. */
>  	iova_insert_rbtree(&iovad->rbroot, new, prev);
> 
