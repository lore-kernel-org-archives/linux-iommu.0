Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A430148B
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577666; cv=none; b=Kyk2DDzkIXidlkUlW0WkPGgZsPjFfWFXLts/yjHlD4r95bzmaewhkne2amkZAz803atWDRPxZI+KFQtWPF+tEj6vj0H76FfzjFBx82rbCZhyo1fB6ef/eDjF0Zwe+QFonBWceWp/XLum6Fl3P8LOjBacTxlkdLwxaNkzsMjlSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577666; c=relaxed/simple;
	bh=fh9vsor5ESw9tLp2QbVw66m9no3crF0ZgJPINwiuibM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ellQJmyFtTLNKWylETLzVNxDZakphlVBixPz9DJg3UK5f3ZclGkqaRFeFxCIrMwnMLZIINxkNCTPjt7lfhwasG5OJ+z/sIMSM44sJp4BX0dFj/vSpxOYNN3nVYLIXtH2p5Hpd3Yax4tzaDFk8EamUWg6pSvheE4aZh/+sLmXA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdMkONyu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdMkONyu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ceb096e675so104437025ad.0
        for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 13:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577664; x=1785182464; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nHyzRN69SIvrGhU2BxqAEaCwqvk6nXUkdLyvQIyO8KI=;
        b=mdMkONyuQUSL66JzKYkyaAMj75G/VrGHm9c1xPiUy043y7OpzDWi5mq34Ome5Z+iBg
         fhENMWh82KJ/sbQ5K22GMe8YydcEXxirCJNh3QcuvPBZBuWottP8KJRhYNgxiWInJtwH
         SXMyjOnyF7uCotFWxA6RYALyN+QrRmC1RmmCllPEWC7qXdBQZbvRfi/5KG1bKakbGOkj
         M5P8129JcDbB8TWPolVIimuizb9JiUgSMxUxN/69fCafnIxbiUWDhW3U79nsP39X5Ch9
         hiyYGsjqpBC8rS9U1PaypjyvNrAkslimM9QtxuCcxqvVO+W+JzjFL/+siRWbSV8eJ0Uz
         t9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577664; x=1785182464;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nHyzRN69SIvrGhU2BxqAEaCwqvk6nXUkdLyvQIyO8KI=;
        b=Y5kVQvLybml0fKnvxpAYefTjZ4KQ7yTdgfovJ2IjSkx+RZKulH3AjnnFuRFdUBCa+y
         WpjGpu1OArmsH1Gw26DlGruxBYxDat9NZeKv7I2MvZWwL9nmQVMj2pyVjqbj1vuk8feo
         19aeKxSVowD7+aAZFuvu5jrcXRPE4oM4rZcV/saZ66KwTgGuJlwSfqvPiFA8Scy2RH5k
         5NDCsmfdef9xYQCyL6DmQaSlWe8+5XwT7NDnsm4AA7nFn+LXZd6aEWa0yL9W54DYJ5LX
         YuL9MFFgTkM4Q92m00/0kyYnJBr0n0YB6K36TTLkW3fDBYg9Q2pJl3bs14l9/9yRIGDF
         SNkg==
X-Forwarded-Encrypted: i=1; AHgh+RqVBKpxroamumxwacEy993VsTie5RB1oIOZg37TpTT/Eky+uzeKi20xVO5L6qYqlwhnAJqxKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaKBsedhtlKOLUoEitEjoFHEKHS4HJNlypUNgmiQTJb0dX1rLL
	T9VYAHPTij+cUQZaMi/b9JgJpalBT4bn/4STOaO4Rl6ex+ly3DiH3L4O
X-Gm-Gg: AR+sD10KyWWAb4gEuAuHRDNgYZjxwaDbf1A6QHO1ioRsIR5ui2hW+hPU/TTzzXbvbBF
	0c6W71rAmhIm0+dE/Gm7dca1xS7rT/gVOTx8syptRW3y9amDgyydmFG8IGXe5T4P3FxzY5ydXBq
	DqPp5s5TBOQXgxM8AaHg6hTnACTE++xFCKQYl5vhPMoQVALk1F6X5Z2jKYO78pWncrkNI/MqLZ7
	uvpapVEBzOUOygYFJ5leU0iCInKfwmH2x2ICojhbDlohH1xx+oEbkzfnqMaiouK+el6HNbFd6+u
	ZyNnI6cs8ZrqZOQT7qh2LQOboX2/PGuG5dTuRsxEQMQlk8DPeZhzKKfmtxCywD0UeNhvlk91hQP
	g0aAyA3cKCSHM3pUC6mZAQsOCJN/qJMbc4Z9vg8jNb5rzoWJ849feAXx7VMk9fW+6sV7lCLuZiO
	+XkP3Evy97NxXErvu28JXCwX9W4ZBcrqeHIg==
X-Received: by 2002:a17:902:eccb:b0:2c9:ff83:41fa with SMTP id d9443c01a7336-2cf3496204fmr169889025ad.24.1784577664139;
        Mon, 20 Jul 2026 13:01:04 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476f70esm61611825ad.77.2026.07.20.13.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:01:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:01:00 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Lu Baolu <baolu.lu@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Kiryl Shutsemau <kas@kernel.org>,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al5-fDRStgU6gjk6@fedora>
References: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-fix-cpa-kernel-pagetables-v1-1-0766e782cefe@kernel.org>

On Mon, Jul 20, 2026 at 10:27:29AM +0100, Lorenzo Stoakes (ARM) wrote:
> When splitting a large page in CPA in __split_large_page() we allocate a
> PTE directly without going through the standard page table allocation
> routines such as pte_alloc_one_kernel().
> 
> This means the page table constructor is never called nor is the page table
> marked as a kernel page table.
> 
> The former results in the folio associated with the page table not being
> marked as a page table (__pagetable_ctor() is never called thus neither is
> __folio_set_pgtable()) nor are statistics updated to reflect
> it (lruvec_stat_add_folio() is never called).
> 
> The latter issue of failing to mark the page table as a kernel page
> table (ptdesc_set_kernel() is never called) is far more problematic.
> 
> Since commit 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page
> tables") kernel page table freeing has been batched and since the
> subsequent commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries
> for kernel address space") IOTLB cache entries for kernel page tables have
> been invalidated upon being freed.
> 
> Since split page tables are freed without this invalidation, the IOTLB can
> contain stale entries for them.
> 
> Resolve the issue by using the ordinary PTE allocation API at split time.
> 
> This results in these kernel page tables invoking a page table constructor,
> and thus requires a page table destructor.
> 
> Since we cannot assume one is always present (early allocated direct map
> page tables are not marked as such), we conditionally call
> pagetable_dtor_free() if the PG_table folio flag for the ptdesc is set,
> otherwise we free the page table via pagetable_free().
> 
> Regardless of which path is taken page tables marked as kernel page tables,
> which now includes split page tables, take the correct route through
> pagetable_free_kernel().
> 
> There is a user-visible side effect in that split page tables will appear
> in nr_page_table_pages in /proc/vmstat (as do other kernel page tables
> allocated after early boot), however this is a positive change.
> 
> This issue started being markedly problematic after commit
> 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables") so
> choose this as the Fixes target.
> 
> Fixes: 5ba2f0a15564 ("mm: introduce deferred freeing for kernel page tables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/x86/mm/pat/set_memory.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 301fb9e77d91..a67ca33b9dd1 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -439,7 +439,11 @@ static void __cpa_collapse_large_pages(struct cpa_data *cpa)
>  
>  	list_for_each_entry_safe(ptdesc, tmp, &pgtables, pt_list) {
>  		list_del(&ptdesc->pt_list);
> -		pagetable_free(ptdesc);
> +
> +		if (folio_test_pgtable(ptdesc_folio(ptdesc)))
> +			pagetable_dtor_free(ptdesc);
> +		else
> +			pagetable_free(ptdesc);

Lets not introduce more folio-ptdesc crossovers, we're trying to get
rid of them :)

I believe pagetable_dtor_free() should do what you're looking for on its
own anyway.
