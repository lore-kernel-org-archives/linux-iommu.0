From: Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [RFC PATCH v9 04/13] xpfo, x86: Add support for XPFO for x86-64
Date: Thu, 4 Apr 2019 09:52:06 +0200
Message-ID: <20190404075206.GP4038@hirez.programming.kicks-ass.net>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<c15e7d09dfe3dfdb9947d39ed0ddd6573ff86dbf.1554248002.git.khalid.aziz@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c15e7d09dfe3dfdb9947d39ed0ddd6573ff86dbf.1554248002.git.khalid.aziz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
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

On Wed, Apr 03, 2019 at 11:34:05AM -0600, Khalid Aziz wrote:
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2779ace16d23..5c0e1581fa56 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1437,6 +1437,32 @@ static inline bool arch_has_pfn_modify_check(void)
>  	return boot_cpu_has_bug(X86_BUG_L1TF);
>  }
>  
> +/*
> + * The current flushing context - we pass it instead of 5 arguments:
> + */
> +struct cpa_data {
> +	unsigned long	*vaddr;
> +	pgd_t		*pgd;
> +	pgprot_t	mask_set;
> +	pgprot_t	mask_clr;
> +	unsigned long	numpages;
> +	unsigned long	curpage;
> +	unsigned long	pfn;
> +	unsigned int	flags;
> +	unsigned int	force_split		: 1,
> +			force_static_prot	: 1;
> +	struct page	**pages;
> +};
> +
> +
> +int
> +should_split_large_page(pte_t *kpte, unsigned long address,
> +			struct cpa_data *cpa);
> +extern spinlock_t cpa_lock;
> +int
> +__split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
> +		   struct page *base);
> +

I really hate exposing all that.

>  #include <asm-generic/pgtable.h>
>  #endif	/* __ASSEMBLY__ */
>  

> diff --git a/arch/x86/mm/xpfo.c b/arch/x86/mm/xpfo.c
> new file mode 100644
> index 000000000000..3045bb7e4659
> --- /dev/null
> +++ b/arch/x86/mm/xpfo.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017 Hewlett Packard Enterprise Development, L.P.
> + * Copyright (C) 2016 Brown University. All rights reserved.
> + *
> + * Authors:
> + *   Juerg Haefliger <juerg.haefliger-ZPxbGqLxI0U@public.gmane.org>
> + *   Vasileios P. Kemerlis <vpk-9N4TdPD67tT2fBVCVOL8/A@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/mm.h>
> +
> +#include <asm/tlbflush.h>
> +
> +extern spinlock_t cpa_lock;
> +
> +/* Update a single kernel page table entry */
> +inline void set_kpte(void *kaddr, struct page *page, pgprot_t prot)
> +{
> +	unsigned int level;
> +	pgprot_t msk_clr;
> +	pte_t *pte = lookup_address((unsigned long)kaddr, &level);
> +
> +	if (unlikely(!pte)) {
> +		WARN(1, "xpfo: invalid address %p\n", kaddr);
> +		return;
> +	}
> +
> +	switch (level) {
> +	case PG_LEVEL_4K:
> +		set_pte_atomic(pte, pfn_pte(page_to_pfn(page),
> +			       canon_pgprot(prot)));

(sorry, do we also need a nikon_pgprot() ? :-)

> +		break;
> +	case PG_LEVEL_2M:
> +	case PG_LEVEL_1G: {
> +		struct cpa_data cpa = { };
> +		int do_split;
> +
> +		if (level == PG_LEVEL_2M)
> +			msk_clr = pmd_pgprot(*(pmd_t *)pte);
> +		else
> +			msk_clr = pud_pgprot(*(pud_t *)pte);
> +
> +		cpa.vaddr = kaddr;
> +		cpa.pages = &page;
> +		cpa.mask_set = prot;
> +		cpa.mask_clr = msk_clr;
> +		cpa.numpages = 1;
> +		cpa.flags = 0;
> +		cpa.curpage = 0;
> +		cpa.force_split = 0;
> +
> +
> +		do_split = should_split_large_page(pte, (unsigned long)kaddr,
> +						   &cpa);
> +		if (do_split) {
> +			struct page *base;
> +
> +			base = alloc_pages(GFP_ATOMIC, 0);
> +			if (!base) {
> +				WARN(1, "xpfo: failed to split large page\n");

You have to be fcking kidding right? A WARN when a GFP_ATOMIC allocation
fails?!

> +				break;
> +			}
> +
> +			if (!debug_pagealloc_enabled())
> +				spin_lock(&cpa_lock);
> +			if  (__split_large_page(&cpa, pte, (unsigned long)kaddr,
> +						base) < 0) {
> +				__free_page(base);
> +				WARN(1, "xpfo: failed to split large page\n");
> +			}
> +			if (!debug_pagealloc_enabled())
> +				spin_unlock(&cpa_lock);
> +		}
> +
> +		break;

Ever heard of helper functions?

> +	}
> +	case PG_LEVEL_512G:
> +		/* fallthrough, splitting infrastructure doesn't
> +		 * support 512G pages.
> +		 */

Broken coment style.

> +	default:
> +		WARN(1, "xpfo: unsupported page level %x\n", level);
> +	}
> +
> +}
> +EXPORT_SYMBOL_GPL(set_kpte);
> +
> +inline void xpfo_flush_kernel_tlb(struct page *page, int order)
> +{
> +	int level;
> +	unsigned long size, kaddr;
> +
> +	kaddr = (unsigned long)page_address(page);
> +
> +	if (unlikely(!lookup_address(kaddr, &level))) {
> +		WARN(1, "xpfo: invalid address to flush %lx %d\n", kaddr,
> +		     level);
> +		return;
> +	}
> +
> +	switch (level) {
> +	case PG_LEVEL_4K:
> +		size = PAGE_SIZE;
> +		break;
> +	case PG_LEVEL_2M:
> +		size = PMD_SIZE;
> +		break;
> +	case PG_LEVEL_1G:
> +		size = PUD_SIZE;
> +		break;
> +	default:
> +		WARN(1, "xpfo: unsupported page level %x\n", level);
> +		return;
> +	}
> +
> +	flush_tlb_kernel_range(kaddr, kaddr + (1 << order) * size);
> +}

You call this from IRQ/IRQ-disabled context... that _CANNOT_ be right.
