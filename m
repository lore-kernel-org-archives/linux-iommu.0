From: Khalid Aziz <khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v9 04/13] xpfo, x86: Add support for XPFO for x86-64
Date: Thu, 4 Apr 2019 09:40:01 -0600
Message-ID: <d526e3bb-ba83-afe5-5db9-bd0112e26fea@oracle.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<c15e7d09dfe3dfdb9947d39ed0ddd6573ff86dbf.1554248002.git.khalid.aziz@oracle.com>
	<20190404075206.GP4038@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190404075206.GP4038-Nxj+rRp3nVydTX5a5knrm8zTDFooKrT+cvkQGrU6aU0@public.gmane.org>
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
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, mhocko-IBi9RG/b67k@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, amir73il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, deepa.srinivasan-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, steven.sistare-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, joao.m.martins-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tycho-E0fblnxP3wo@public.gmane.org, ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, aneesh.kumar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org, willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, yaojun8558363-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khlebnikov-XoJtRXgx1JseBXzfvpsJ4g@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kanth.ghatraju-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, rientjes-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, anthony.yznaga-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org, labbott-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, pradeep.vincent-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, pave
List-Id: iommu@lists.linux-foundation.org

[trimmed To: and Cc: It was too large]

On 4/4/19 1:52 AM, Peter Zijlstra wrote:
> On Wed, Apr 03, 2019 at 11:34:05AM -0600, Khalid Aziz wrote:
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index 2779ace16d23..5c0e1581fa56 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1437,6 +1437,32 @@ static inline bool arch_has_pfn_modify_check(void)
>>  	return boot_cpu_has_bug(X86_BUG_L1TF);
>>  }
>>  
>> +/*
>> + * The current flushing context - we pass it instead of 5 arguments:
>> + */
>> +struct cpa_data {
>> +	unsigned long	*vaddr;
>> +	pgd_t		*pgd;
>> +	pgprot_t	mask_set;
>> +	pgprot_t	mask_clr;
>> +	unsigned long	numpages;
>> +	unsigned long	curpage;
>> +	unsigned long	pfn;
>> +	unsigned int	flags;
>> +	unsigned int	force_split		: 1,
>> +			force_static_prot	: 1;
>> +	struct page	**pages;
>> +};
>> +
>> +
>> +int
>> +should_split_large_page(pte_t *kpte, unsigned long address,
>> +			struct cpa_data *cpa);
>> +extern spinlock_t cpa_lock;
>> +int
>> +__split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
>> +		   struct page *base);
>> +
> 
> I really hate exposing all that.

I believe this was done so set_kpte() could split large pages if needed.
I will look into creating a helper function instead so this does not
have to be exposed.

> 
>>  #include <asm-generic/pgtable.h>
>>  #endif	/* __ASSEMBLY__ */
>>  
> 
>> diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
>> new file mode 100644
>> index 000000000000..3045bb7e4659
>> --- /dev/null
>> +++ b/arch/x86/mm/xpfo.c
>> @@ -0,0 +1,123 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2017 Hewlett Packard Enterprise Development, L.P.
>> + * Copyright (C) 2016 Brown University. All rights reserved.
>> + *
>> + * Authors:
>> + *   Juerg Haefliger <juerg.haefliger-ZPxbGqLxI0U@public.gmane.org>
>> + *   Vasileios P. Kemerlis <vpk-9N4TdPD67tT2fBVCVOL8/A@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/mm.h>
>> +
>> +#include <asm/tlbflush.h>
>> +
>> +extern spinlock_t cpa_lock;
>> +
>> +/* Update a single kernel page table entry */
>> +inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
>> +{
>> +	unsigned int level;
>> +	pgprot_t msk_clr;
>> +	pte_t *pte = lookup_address((unsigned long)kaddr, &level);
>> +
>> +	if (unlikely(!pte)) {
>> +		WARN(1, "xpfo: invalid address %p\n", kaddr);
>> +		return;
>> +	}
>> +
>> +	switch (level) {
>> +	case PG_LEVEL_4K:
>> +		set_pte_atomic(pte, pfn_pte(page_to_pfn(page),
>> +			       canon_pgprot(prot)));
> 
> (sorry, do we also need a nikon_pgprot() ? :-)

Are we trying to encourage nikon as well to sponsor this patch :)

> 
>> +		break;
>> +	case PG_LEVEL_2M:
>> +	case PG_LEVEL_1G: {
>> +		struct cpa_data cpa = { };
>> +		int do_split;
>> +
>> +		if (level == PG_LEVEL_2M)
>> +			msk_clr = pmd_pgprot(*(pmd_t *)pte);
>> +		else
>> +			msk_clr = pud_pgprot(*(pud_t *)pte);
>> +
>> +		cpa.vaddr = kaddr;
>> +		cpa.pages = &page;
>> +		cpa.mask_set = prot;
>> +		cpa.mask_clr = msk_clr;
>> +		cpa.numpages = 1;
>> +		cpa.flags = 0;
>> +		cpa.curpage = 0;
>> +		cpa.force_split = 0;
>> +
>> +
>> +		do_split = should_split_large_page(pte, (unsigned long)kaddr,
>> +						   &cpa);
>> +		if (do_split) {
>> +			struct page *base;
>> +
>> +			base = alloc_pages(GFP_ATOMIC, 0);
>> +			if (!base) {
>> +				WARN(1, "xpfo: failed to split large page\n");
> 
> You have to be fcking kidding right? A WARN when a GFP_ATOMIC allocation
> fails?!
> 

Not sure what the reasoning was for this WARN in original patch, but I
think this is trying to warn about failure to split the large page in
order to unmap this single page as opposed to warning about allocation
failure. Nevertheless this could be done better.

>> +				break;
>> +			}
>> +
>> +			if (!debug_pagealloc_enabled())
>> +				spin_lock(&cpa_lock);
>> +			if  (__split_large_page(&cpa, pte, (unsigned long)kaddr,
>> +						base) < 0) {
>> +				__free_page(base);
>> +				WARN(1, "xpfo: failed to split large page\n");
>> +			}
>> +			if (!debug_pagealloc_enabled())
>> +				spin_unlock(&cpa_lock);
>> +		}
>> +
>> +		break;
> 
> Ever heard of helper functions?

Good idea. I will see if this all can be done in a helper function instead.

> 
>> +	}
>> +	case PG_LEVEL_512G:
>> +		/* fallthrough, splitting infrastructure doesn't
>> +		 * support 512G pages.
>> +		 */
> 
> Broken coment style.

Slipped by me. Thanks, I will fix that.

> 
>> +	default:
>> +		WARN(1, "xpfo: unsupported page level %x\n", level);
>> +	}
>> +
>> +}
>> +EXPORT_SYMBOL_GPL(set_kpte);
>> +
>> +inline void xpfo_flush_kernel_tlb(struct page *page, int order)
>> +{
>> +	int level;
>> +	unsigned long size, kaddr;
>> +
>> +	kaddr = (unsigned long)page_address(page);
>> +
>> +	if (unlikely(!lookup_address(kaddr, &level))) {
>> +		WARN(1, "xpfo: invalid address to flush %lx %d\n", kaddr,
>> +		     level);
>> +		return;
>> +	}
>> +
>> +	switch (level) {
>> +	case PG_LEVEL_4K:
>> +		size = PAGE_SIZE;
>> +		break;
>> +	case PG_LEVEL_2M:
>> +		size = PMD_SIZE;
>> +		break;
>> +	case PG_LEVEL_1G:
>> +		size = PUD_SIZE;
>> +		break;
>> +	default:
>> +		WARN(1, "xpfo: unsupported page level %x\n", level);
>> +		return;
>> +	}
>> +
>> +	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
>> +}
> 
> You call this from IRQ/IRQ-disabled context... that _CANNOT_ be right.
> 

Another reason why current implementation of xpfo_kmap/xpfo_kunmap does
not look right. I am leaning more and more towards rewriting this to be
similar to kmap_high while taking into account your input on fixmap
kmap_atomic.

Side note: jsteckli-ebkRAfMGSJGzQB+pC5nmwQ@public.gmane.org is bouncing. Julian wrote quite a bit of
code in these patches. If anyone has Julian's current email, it would be
appreciated. Getting his feedback on these discussions will be useful.

Thanks,
Khalid
