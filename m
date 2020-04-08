Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40854C2BA80
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:38:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F8A20747
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 12:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F8A20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D0B6382507;
	Wed,  8 Apr 2020 12:38:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nQ1PPG-uBL0Q; Wed,  8 Apr 2020 12:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B9ABB82125;
	Wed,  8 Apr 2020 12:38:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2A65C1D7E;
	Wed,  8 Apr 2020 12:38:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 324BAC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2682187AAE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DWfOdXipS8WW for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 12:38:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0CF67879CF
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 12:38:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87C1331B;
 Wed,  8 Apr 2020 05:38:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ADA83F73D;
 Wed,  8 Apr 2020 05:38:37 -0700 (PDT)
Date: Wed, 8 Apr 2020 13:38:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 18/28] mm: enforce that vmap can't map pages executable
Message-ID: <20200408123835.GB36478@lakrids.cambridge.arm.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-19-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-19-hch@lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Catalin marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org,
 linux-mm@kvack.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Will Deacon <will@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>,
 linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 08, 2020 at 01:59:16PM +0200, Christoph Hellwig wrote:
> To help enforcing the W^X protection don't allow remapping existing
> pages as executable.
> 
> Based on patch from Peter Zijlstra <peterz@infradead.org>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/pgtable_types.h | 6 ++++++
>  include/asm-generic/pgtable.h        | 4 ++++
>  mm/vmalloc.c                         | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 947867f112ea..2e7c442cc618 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -282,6 +282,12 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
>  
>  typedef struct { pgdval_t pgd; } pgd_t;
>  
> +static inline pgprot_t pgprot_nx(pgprot_t prot)
> +{
> +	return __pgprot(pgprot_val(prot) | _PAGE_NX);
> +}
> +#define pgprot_nx pgprot_nx
> +
>  #ifdef CONFIG_X86_PAE

I reckon for arm64 we can do similar in our <asm/pgtable.h>:

#define pgprot_nx(pgprot_t prot) \
	__pgprot_modify(prot, 0, PTE_PXN)

... matching the style of our existing pgprot_*() modifier helpers.

Mark.

>  
>  /*
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 329b8c8ca703..8c5f9c29698b 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -491,6 +491,10 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>  #define flush_tlb_fix_spurious_fault(vma, address) flush_tlb_page(vma, address)
>  #endif
>  
> +#ifndef pgprot_nx
> +#define pgprot_nx(prot)	(prot)
> +#endif
> +
>  #ifndef pgprot_noncached
>  #define pgprot_noncached(prot)	(prot)
>  #endif
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7356b3f07bd8..334c75251ddb 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2390,7 +2390,7 @@ void *vmap(struct page **pages, unsigned int count,
>  	if (!area)
>  		return NULL;
>  
> -	if (map_kernel_range((unsigned long)area->addr, size, prot,
> +	if (map_kernel_range((unsigned long)area->addr, size, pgprot_nx(prot),
>  			pages) < 0) {
>  		vunmap(area->addr);
>  		return NULL;
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
