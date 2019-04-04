From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [RFC PATCH v9 11/13] xpfo, mm: optimize spinlock usage in
	xpfo_kunmap
Date: Thu, 4 Apr 2019 09:56:48 +0200
Message-ID: <20190404075648.GQ4038@hirez.programming.kicks-ass.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<5bab13e12d4215112ad2180106cc6bb9b513754a.1554248002.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5bab13e12d4215112ad2180106cc6bb9b513754a.1554248002.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: kernel-hardening-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, tycho-E0fblnxP3wo@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-l3A5Bk7waGM@public.gmane.org, keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser@oracl
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 11:34:12AM -0600, Khalid Aziz wrote:
> From: Julian Stecklina <jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
> 
> Only the xpfo_kunmap call that needs to actually unmap the page
> needs to be serialized. We need to be careful to handle the case,
> where after the atomic decrement of the mapcount, a xpfo_kmap
> increased the mapcount again. In this case, we can safely skip
> modifying the page table.
> 
> Model-checked with up to 4 concurrent callers with Spin.
> 
> Signed-off-by: Julian Stecklina <jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> Cc: Khalid Aziz <khalid-21RPF02GE+GXwddmVfQv5g@public.gmane.org>
> Cc: x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
> Cc: kernel-hardening-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org
> Cc: Vasileios P. Kemerlis <vpk-eQaUEPhvms7ENvBUuze7eA@public.gmane.org>
> Cc: Juerg Haefliger <juerg.haefliger-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
> Cc: Tycho Andersen <tycho-E0fblnxP3wo@public.gmane.org>
> Cc: Marco Benatto <marco.antonio.780-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> ---
>  include/linux/xpfo.h | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
> index 2318c7eb5fb7..37e7f52fa6ce 100644
> --- a/include/linux/xpfo.h
> +++ b/include/linux/xpfo.h
> @@ -61,6 +61,7 @@ static inline void xpfo_kmap(void *kaddr, struct page *page)
>  static inline void xpfo_kunmap(void *kaddr, struct page *page)
>  {
>  	unsigned long flags;
> +	bool flush_tlb = false;
>  
>  	if (!static_branch_unlikely(&xpfo_inited))
>  		return;
> @@ -72,18 +73,23 @@ static inline void xpfo_kunmap(void *kaddr, struct page *page)
>  	 * The page is to be allocated back to user space, so unmap it from
>  	 * the kernel, flush the TLB and tag it as a user page.
>  	 */
> -	spin_lock_irqsave(&page->xpfo_lock, flags);
> -
>  	if (atomic_dec_return(&page->xpfo_mapcount) == 0) {
> -#ifdef CONFIG_XPFO_DEBUG
> -		WARN_ON(PageXpfoUnmapped(page));
> -#endif
> -		SetPageXpfoUnmapped(page);
> -		set_kpte(kaddr, page, __pgprot(0));
> -		xpfo_flush_kernel_tlb(page, 0);
> +		spin_lock_irqsave(&page->xpfo_lock, flags);
> +
> +		/*
> +		 * In the case, where we raced with kmap after the
> +		 * atomic_dec_return, we must not nuke the mapping.
> +		 */
> +		if (atomic_read(&page->xpfo_mapcount) == 0) {
> +			SetPageXpfoUnmapped(page);
> +			set_kpte(kaddr, page, __pgprot(0));
> +			flush_tlb = true;
> +		}
> +		spin_unlock_irqrestore(&page->xpfo_lock, flags);
>  	}
>  
> -	spin_unlock_irqrestore(&page->xpfo_lock, flags);
> +	if (flush_tlb)
> +		xpfo_flush_kernel_tlb(page, 0);
>  }

This doesn't help with the TLB invalidation issue, AFAICT this is still
completely buggered. kunmap_atomic() can be called from IRQ context.
