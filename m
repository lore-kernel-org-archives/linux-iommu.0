From: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
Date: Thu, 4 Apr 2019 09:15:46 -0600
Message-ID: <b414bacc-2883-1914-38ec-3d8f4a032e10@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190404074323.GO4038@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190404074323.GO4038-Nxj+rRp3nVydTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
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
To: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, tycho-E0fblnxP3wo@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, npiggin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rppt-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jrdr.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, chris.hyser-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Khalid Aziz <khalid@gonehiking>
List-Id: iommu@lists.linux-foundation.org

On 4/4/19 1:43 AM, Peter Zijlstra wrote:
> 
> You must be so glad I no longer use kmap_atomic from NMI context :-)
> 
> On Wed, Apr 03, 2019 at 11:34:04AM -0600, Khalid Aziz wrote:
>> +static inline void xpfo_kmap(void *kaddr, struct page *page)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (!static_branch_unlikely(&xpfo_inited))
>> +		return;
>> +
>> +	if (!PageXpfoUser(page))
>> +		return;
>> +
>> +	/*
>> +	 * The page was previously allocated to user space, so
>> +	 * map it back into the kernel if needed. No TLB flush required.
>> +	 */
>> +	spin_lock_irqsave(&page->xpfo_lock, flags);
>> +
>> +	if ((atomic_inc_return(&page->xpfo_mapcount) == 1) &&
>> +		TestClearPageXpfoUnmapped(page))
>> +		set_kpte(kaddr, page, PAGE_KERNEL);
>> +
>> +	spin_unlock_irqrestore(&page->xpfo_lock, flags);
> 
> That's a really sad sequence, not wrong, but sad. _3_ atomic operations,
> 2 on likely the same cacheline. And mostly all pointless.
> 
> This patch makes xpfo_mapcount an atomic, but then all modifications are
> under the spinlock, what gives?
> 
> Anyway, a possibly saner sequence might be:
> 
> 	if (atomic_inc_not_zero(&page->xpfo_mapcount))
> 		return;
> 
> 	spin_lock_irqsave(&page->xpfo_lock, flag);
> 	if ((atomic_inc_return(&page->xpfo_mapcount) == 1) &&
> 	    TestClearPageXpfoUnmapped(page))
> 		set_kpte(kaddr, page, PAGE_KERNEL);
> 	spin_unlock_irqrestore(&page->xpfo_lock, flags);
> 
>> +}
>> +
>> +static inline void xpfo_kunmap(void *kaddr, struct page *page)
>> +{
>> +	unsigned long flags;
>> +
>> +	if (!static_branch_unlikely(&xpfo_inited))
>> +		return;
>> +
>> +	if (!PageXpfoUser(page))
>> +		return;
>> +
>> +	/*
>> +	 * The page is to be allocated back to user space, so unmap it from
>> +	 * the kernel, flush the TLB and tag it as a user page.
>> +	 */
>> +	spin_lock_irqsave(&page->xpfo_lock, flags);
>> +
>> +	if (atomic_dec_return(&page->xpfo_mapcount) == 0) {
>> +#ifdef CONFIG_XPFO_DEBUG
>> +		WARN_ON(PageXpfoUnmapped(page));
>> +#endif
>> +		SetPageXpfoUnmapped(page);
>> +		set_kpte(kaddr, page, __pgprot(0));
>> +		xpfo_flush_kernel_tlb(page, 0);
> 
> You didn't speak about the TLB invalidation anywhere. But basically this
> is one that x86 cannot do.
> 
>> +	}
>> +
>> +	spin_unlock_irqrestore(&page->xpfo_lock, flags);
> 
> Idem:
> 
> 	if (atomic_add_unless(&page->xpfo_mapcount, -1, 1))
> 		return;
> 
> 	....
> 
> 
>> +}
> 
> Also I'm failing to see the point of PG_xpfo_unmapped, afaict it
> is identical to !atomic_read(&page->xpfo_mapcount).
> 

Thanks Peter. I really appreciate your review. Your feedback helps make
this code better and closer to where I can feel comfortable not calling
it RFC any more.

The more I look at xpfo_kmap()/xpfo_kunmap() code, the more I get
uncomfortable with it. As you pointed out about calling kmap_atomic from
NMI context, that just makes the kmap_atomic code look even worse. I
pointed out one problem with this code in cover letter and suggested a
rewrite. I see these problems with this code:

1. When xpfo_kmap maps a page back in physmap, it opens up the ret2dir
attack security hole again even if just for the duration of kmap. A kmap
can stay around for some time if the page is being used for I/O.

2. This code uses spinlock which leads to problems. If it does not
disable IRQ, it is exposed to deadlock around xpfo_lock. If it disables
IRQ, I think it can still deadlock around pgd_lock.

I think a better implementation of xpfo_kmap()/xpfo_kunmap() would map
the page at a new virtual address similar to what kmap_high for i386
does. This avoids re-opening the ret2dir security hole. We can also
possibly do away with xpfo_lock saving bytes in page-frame and the not
so sane code sequence can go away.

Good point about PG_xpfo_unmapped flag. You are right that it can be
replaced with !atomic_read(&page->xpfo_mapcount).

Thanks,
Khalid
