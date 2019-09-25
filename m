Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF20C432C1
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 05:22:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA34217F4
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 05:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA34217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2273FAC8;
	Wed, 25 Sep 2019 05:22:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C5C3A7F6
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 05:22:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E301C8A
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 05:22:11 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
	[209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3283F356CE
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 05:22:11 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id y13so1268013plr.17
	for <iommu@lists.linux-foundation.org>;
	Tue, 24 Sep 2019 22:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=qpstl2yJkkpj95636PfTSAxVYaG/GkSVcL8Wuku3BZk=;
	b=J2f9liIPrfJ6dX7n8P7brWrpxVakTKdNg9s8Fxz/Mb4aT3G6KWjC2hUgb1YmZ743xv
	vnH6WFKxm7LUwQ87qEsZuORHhp8gz1lx6LLs5asA0TUbsePOzlneI8hG4pdkN4eEa7vL
	Asi9ESOK6JdSBrf8l4Np+A6xDgaI/LoHeeW7vWLWtyPqWnWXO9ZgbCt9WUQl1bFVRZ59
	tkWhKen0V+uxI3uF0EeFA06mLG59ulPj+Gp/gVVqaAYeQm2EDSvg74xma6KnGYquzERB
	S52So2i4KlhttF/0LY0HRHeMqvB+OZ0xFVzKRrajSArI5t28o5bIXSX9UpWe6nUPcX26
	2b/w==
X-Gm-Message-State: APjAAAVlYyjLhmHPzpQGBZi6auhZYvf8nLRkiJDVUaILlp7kl5jABzXs
	3XkFOqCC2E1wM+p6Uyqb3g8sq6LjoOQ0CT4D1ykax3U4BwK4GTYj9+hsC3l1MuNA0V7NECF8lhK
	pIhJIMWXhQnHY8EIRK6kyV4NUxzVUcw==
X-Received: by 2002:a65:5c0b:: with SMTP id u11mr6974914pgr.294.1569388930460; 
	Tue, 24 Sep 2019 22:22:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVH44sOKA0TrcGiF/TYwgX91lTxmEKuAa+c51LptqDzNivQ0XTKrbkH4QTN7/cD8hPJHAv9Q==
X-Received: by 2002:a65:5c0b:: with SMTP id u11mr6974881pgr.294.1569388930048; 
	Tue, 24 Sep 2019 22:22:10 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80]) by smtp.gmail.com with ESMTPSA id
	y2sm5821568pfe.126.2019.09.24.22.22.05
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 24 Sep 2019 22:22:09 -0700 (PDT)
Date: Wed, 25 Sep 2019 13:21:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190925052157.GL28074@xz-x1>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190923122454.9888-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
	ashok.raj@intel.com, kvm@vger.kernel.org,
	sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, yi.y.sun@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Sep 23, 2019 at 08:24:52PM +0800, Lu Baolu wrote:
> This adds functions to manipulate first level page tables
> which could be used by a scalale mode capable IOMMU unit.
> 
> intel_mmmap_range(domain, addr, end, phys_addr, prot)
>  - Map an iova range of [addr, end) to the physical memory
>    started at @phys_addr with the @prot permissions.
> 
> intel_mmunmap_range(domain, addr, end)
>  - Tear down the map of an iova range [addr, end). A page
>    list will be returned which will be freed after iotlb
>    flushing.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/Makefile             |   2 +-
>  drivers/iommu/intel-pgtable.c      | 342 +++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h        |  24 +-
>  include/trace/events/intel_iommu.h |  60 +++++
>  4 files changed, 426 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/intel-pgtable.c
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 4f405f926e73..dc550e14cc58 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -17,7 +17,7 @@ obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o
>  obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
>  obj-$(CONFIG_DMAR_TABLE) += dmar.o
>  obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
> -obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o
> +obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o intel-pgtable.o
>  obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
>  obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
>  obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
> diff --git a/drivers/iommu/intel-pgtable.c b/drivers/iommu/intel-pgtable.c
> new file mode 100644
> index 000000000000..8e95978cd381
> --- /dev/null
> +++ b/drivers/iommu/intel-pgtable.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * intel-pgtable.c - Intel IOMMU page table manipulation library

Could this be a bit misleading?  Normally I'll use "IOMMU page table"
to refer to the 2nd level page table only, and I'm always
understanding it as "the new IOMMU will understand MMU page table as
the 1st level".  At least mention "IOMMU 1st level page table"?

> + *
> + * Copyright (C) 2019 Intel Corporation
> + *
> + * Author: Lu Baolu <baolu.lu@linux.intel.com>
> + */
> +
> +#define pr_fmt(fmt)     "DMAR: " fmt
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/sched.h>
> +#include <linux/io.h>
> +#include <linux/export.h>
> +#include <linux/intel-iommu.h>
> +#include <asm/cacheflush.h>
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>
> +#include <trace/events/intel_iommu.h>
> +
> +#ifdef CONFIG_X86
> +/*
> + * mmmap: Map a range of IO virtual address to physical addresses.

"... to physical addresses using MMU page table"?

Might be clearer?

> + */
> +#define pgtable_populate(domain, nm)					\
> +do {									\
> +	void *__new = alloc_pgtable_page(domain->nid);			\
> +	if (!__new)							\
> +		return -ENOMEM;						\
> +	smp_wmb();							\

Could I ask what's this wmb used for?

> +	spin_lock(&(domain)->page_table_lock);				\

Is this intended to lock here instead of taking the lock during the
whole page table walk?  Is it safe?

Taking the example where nm==PTE: when we reach here how do we
guarantee that the PMD page that has this PTE is still valid?

> +	if (nm ## _present(*nm)) {					\
> +		free_pgtable_page(__new);				\
> +	} else {							\
> +		set_##nm(nm, __##nm(__pa(__new) | _PAGE_TABLE));	\

It seems to me that PV could trap calls to set_pte().  Then these
could also be trapped by e.g. Xen?  Are these traps needed?  Is there
side effect?  I'm totally not familiar with this, but just ask aloud...

> +		domain_flush_cache(domain, nm, sizeof(nm##_t));		\
> +	}								\
> +	spin_unlock(&(domain)->page_table_lock);			\
> +} while(0);
> +
> +static int
> +mmmap_pte_range(struct dmar_domain *domain, pmd_t *pmd, unsigned long addr,
> +		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
> +{
> +	pte_t *pte, *first_pte;
> +	u64 pfn;
> +
> +	pfn = phys_addr >> PAGE_SHIFT;
> +	if (unlikely(pmd_none(*pmd)))
> +		pgtable_populate(domain, pmd);
> +
> +	first_pte = pte = pte_offset_kernel(pmd, addr);
> +
> +	do {
> +		set_pte(pte, pfn_pte(pfn, prot));
> +		pfn++;
> +	} while (pte++, addr += PAGE_SIZE, addr != end);
> +
> +	domain_flush_cache(domain, first_pte, (void *)pte - (void *)first_pte);
> +
> +	return 0;
> +}
> +
> +static int
> +mmmap_pmd_range(struct dmar_domain *domain, pud_t *pud, unsigned long addr,
> +		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
> +{
> +	unsigned long next;
> +	pmd_t *pmd;
> +
> +	if (unlikely(pud_none(*pud)))
> +		pgtable_populate(domain, pud);
> +	pmd = pmd_offset(pud, addr);
> +
> +	phys_addr -= addr;
> +	do {
> +		next = pmd_addr_end(addr, end);
> +		if (mmmap_pte_range(domain, pmd, addr, next,
> +				    phys_addr + addr, prot))
> +			return -ENOMEM;

How about return the errcode of mmmap_pte_range() directly?

> +	} while (pmd++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static int
> +mmmap_pud_range(struct dmar_domain *domain, p4d_t *p4d, unsigned long addr,
> +		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
> +{
> +	unsigned long next;
> +	pud_t *pud;
> +
> +	if (unlikely(p4d_none(*p4d)))
> +		pgtable_populate(domain, p4d);
> +
> +	pud = pud_offset(p4d, addr);
> +
> +	phys_addr -= addr;
> +	do {
> +		next = pud_addr_end(addr, end);
> +		if (mmmap_pmd_range(domain, pud, addr, next,
> +				    phys_addr + addr, prot))
> +			return -ENOMEM;

Same.

> +	} while (pud++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +static int
> +mmmap_p4d_range(struct dmar_domain *domain, pgd_t *pgd, unsigned long addr,
> +		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
> +{
> +	unsigned long next;
> +	p4d_t *p4d;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_LA57) && unlikely(pgd_none(*pgd)))
> +		pgtable_populate(domain, pgd);
> +
> +	p4d = p4d_offset(pgd, addr);
> +
> +	phys_addr -= addr;
> +	do {
> +		next = p4d_addr_end(addr, end);
> +		if (mmmap_pud_range(domain, p4d, addr, next,
> +				    phys_addr + addr, prot))
> +			return -ENOMEM;

Same.

> +	} while (p4d++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +int intel_mmmap_range(struct dmar_domain *domain, unsigned long addr,
> +		      unsigned long end, phys_addr_t phys_addr, int dma_prot)
> +{
> +	unsigned long next;
> +	pgprot_t prot;
> +	pgd_t *pgd;
> +
> +	trace_domain_mm_map(domain, addr, end, phys_addr);
> +
> +	/*
> +	 * There is no PAGE_KERNEL_WO for a pte entry, so let's use RW
> +	 * for a pte that requires write operation.
> +	 */
> +	prot = dma_prot & DMA_PTE_WRITE ? PAGE_KERNEL : PAGE_KERNEL_RO;
> +	BUG_ON(addr >= end);
> +
> +	phys_addr -= addr;
> +	pgd = pgd_offset_pgd(domain->pgd, addr);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (mmmap_p4d_range(domain, pgd, addr, next,
> +				    phys_addr + addr, prot))
> +			return -ENOMEM;

Same.

> +	} while (pgd++, addr = next, addr != end);
> +
> +	return 0;
> +}
> +
> +/*
> + * mmunmap: Unmap an existing mapping between a range of IO vitual address
> + *          and physical addresses.
> + */
> +static struct page *
> +mmunmap_pte_range(struct dmar_domain *domain, pmd_t *pmd,
> +		  unsigned long addr, unsigned long end,
> +		  struct page *freelist, bool reclaim)
> +{
> +	int i;
> +	unsigned long start;
> +	pte_t *pte, *first_pte;
> +
> +	start = addr;
> +	pte = pte_offset_kernel(pmd, addr);
> +	first_pte = pte;
> +	do {
> +		set_pte(pte, __pte(0));
> +	} while (pte++, addr += PAGE_SIZE, addr != end);
> +
> +	domain_flush_cache(domain, first_pte, (void *)pte - (void *)first_pte);
> +
> +	/* Add page to free list if all entries are empty. */
> +	if (reclaim) {

Shouldn't we know whether to reclaim if with (addr, end) specified as
long as they cover the whole range of this PMD?

Also I noticed that this value right now is passed in from the very
top of the unmap() call.  I didn't really catch the point of that...

I'll have similar question to below a few places but I'll skip to
comment after I understand this one.

> +		struct page *pte_page;
> +
> +		pte = (pte_t *)pmd_page_vaddr(*pmd);
> +		for (i = 0; i < PTRS_PER_PTE; i++)
> +			if (!pte || !pte_none(pte[i]))
> +				goto pte_out;
> +
> +		pte_page = pmd_page(*pmd);
> +		pte_page->freelist = freelist;
> +		freelist = pte_page;
> +		pmd_clear(pmd);
> +		domain_flush_cache(domain, pmd, sizeof(pmd_t));
> +	}
> +
> +pte_out:
> +	return freelist;
> +}

Regards,

-- 
Peter Xu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
