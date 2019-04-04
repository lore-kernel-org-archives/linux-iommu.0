From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [RFC PATCH v9 12/13] xpfo, mm: Defer TLB flushes for non-current
	CPUs (x86 only)
Date: Thu, 4 Apr 2019 10:18:47 +0200
Message-ID: <20190404081847.GR4038@hirez.programming.kicks-ass.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
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
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, tycho-E0fblnxP3wo@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Khalid Aziz <khalid@gonehiking>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 11:34:13AM -0600, Khalid Aziz wrote:
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 999d6d8f0bef..cc806a01a0eb 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -37,6 +37,20 @@
>   */
>  #define LAST_USER_MM_IBPB	0x1UL
>  
> +/*
> + * A TLB flush may be needed to flush stale TLB entries
> + * for pages that have been mapped into userspace and unmapped
> + * from kernel space. This TLB flush needs to be propagated to
> + * all CPUs. Asynchronous flush requests to all CPUs can cause
> + * significant performance imapct. Queue a pending flush for
> + * a CPU instead. Multiple of these requests can then be handled
> + * by a CPU at a less disruptive time, like context switch, in
> + * one go and reduce performance impact significantly. Following
> + * data structure is used to keep track of CPUs with pending full
> + * TLB flush forced by xpfo.
> + */
> +static cpumask_t pending_xpfo_flush;
> +
>  /*
>   * We get here when we do something requiring a TLB invalidation
>   * but could not go invalidate all of the contexts.  We do the
> @@ -321,6 +335,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  		__flush_tlb_all();
>  	}
>  #endif
> +
> +	/*
> +	 * If there is a pending TLB flush for this CPU due to XPFO
> +	 * flush, do it now.
> +	 */
> +	if (cpumask_test_and_clear_cpu(cpu, &pending_xpfo_flush)) {
> +		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
> +		__flush_tlb_all();
> +	}

That really should be:

	if (cpumask_test_cpu(cpu, &pending_xpfo_flush)) {
		cpumask_clear_cpu(cpu, &pending_xpfo_flush);
		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
		__flush_tlb_all();
	}

test_and_clear is an unconditional RmW and can cause cacheline
contention between adjecent CPUs even if none of the bits are set.

> +
>  	this_cpu_write(cpu_tlbstate.is_lazy, false);
>  
>  	/*
> @@ -803,6 +827,34 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  	}
>  }
>  
> +void xpfo_flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +	struct cpumask tmp_mask;
> +
> +	/*
> +	 * Balance as user space task's flush, a bit conservative.
> +	 * Do a local flush immediately and post a pending flush on all
> +	 * other CPUs. Local flush can be a range flush or full flush
> +	 * depending upon the number of entries to be flushed. Remote
> +	 * flushes will be done by individual processors at the time of
> +	 * context switch and this allows multiple flush requests from
> +	 * other CPUs to be batched together.
> +	 */
> +	if (end == TLB_FLUSH_ALL ||
> +	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
> +		do_flush_tlb_all(NULL);
> +	} else {
> +		struct flush_tlb_info info;
> +
> +		info.start = start;
> +		info.end = end;
> +		do_kernel_range_flush(&info);
> +	}
> +	cpumask_setall(&tmp_mask);
> +	__cpumask_clear_cpu(smp_processor_id(), &tmp_mask);
> +	cpumask_or(&pending_xpfo_flush, &pending_xpfo_flush, &tmp_mask);
> +}
> +
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  {
>  	struct flush_tlb_info info = {
> diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
> index b42513347865..638eee5b1f09 100644
> --- a/arch/x86/mm/xpfo.c
> +++ b/arch/x86/mm/xpfo.c
> @@ -118,7 +118,7 @@ inline void xpfo_flush_kernel_tlb(struct page *page, int order)
>  		return;
>  	}
>  
> -	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
> +	xpfo_flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
>  }
>  EXPORT_SYMBOL_GPL(xpfo_flush_kernel_tlb);

So this patch is the one that makes it 'work', but I'm with Andy on
hating it something fierce.

Up until this point x86_64 is completely buggered in this series, after
this it sorta works but *urgh* what crap.

All in all your changelog is complete and utter garbage, this is _NOT_ a
performance issue. It is a very much a correctness issue.

Also; I distinctly dislike the inconsistent TLB states this generates.
It makes it very hard to argue for its correctness..
