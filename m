Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755163E49F0
	for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653821; cv=none; b=dDwMkpgTUZmMWXfNxajPbr82rOmCwnJbQZ+VR19zOy+G4dXLiHzGqFxdtHaPZGjd2re6gdeH70C++Z/Y+3IUfrH6zZgHtikSZr/+NgbambDvDOurOZT+XMVQ3zU6YM2iuql9JMCpwXM/MXEj5ez1SQ27RxlYIVM+JF87mS9M8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653821; c=relaxed/simple;
	bh=2JTgTd9toINIPryUJzZ4cjvrunjhL4Ann5jB8FnbsS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsEUkyfgFxm3+ZXpYBBVVcb/poqB18HGJdsq/ziDCu0wJJkHZkoKjlIyCFK9DL3oQDX1UcReO+38byPCp2NUhHkzoRBRMHXoOgEApEzzTYxU19M34oKdP1FL7ERqKFK0oELgPvyeP0tetUM/2MDxyUc6yDAOYMt9zc4P99/Qnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSENKXmp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSENKXmp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccf2360620so76435885ad.3
        for <iommu@lists.linux.dev>; Tue, 21 Jul 2026 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784653820; x=1785258620; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fkn3JmTHyZHrmeo+sPGbWVcJWg9Sa/ZKVruguzBjPig=;
        b=YSENKXmpKBPdF85cuVZQboc6OuiUQs2WrfmJmBzb+5AHwx+JneBSJw+cA81k7WgVIr
         +r7pS4QD0chkTfLCGMMceYQqYnFLc40nFPEtYW5euY39vvDRgLlpzYlrNzyxlUfq0bGW
         FQyzCu2laGt7cVeWBLK0JYlVk6pn3vA37nRIObuJeNGMxPYbRRkz2ose27NN6FvhWKWU
         C3wbkQ8epb1/vTKGzVN5NgtHC/dJMEzORz9MDCUNzNQNnATazdAgE7mVcqmF2dFuKHOf
         vwx5yCjavZoJtu0c2FihKwq51PBD/qwl1VHfhHbBzRKDxT2GmXURpWk2cKXWhBxckHvx
         sYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784653820; x=1785258620;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fkn3JmTHyZHrmeo+sPGbWVcJWg9Sa/ZKVruguzBjPig=;
        b=Bij+vmUR7/mu+1BkrNJGdFoUY8MgXlCq+gLCQ7suGP69E1V9XnXVqr7485ZssfIfFJ
         QA47suXaigNm6bb7pF4ly8B245fub2XWBfHhl1PuhPDDWwhaK+iCTeEqe/o1VSJVJok5
         reVpEouisGsI1Zik57vtIIYGuaNFSt6DB6kO2vTJCC11hPrZgZ89BjLzrAXmSxOTizsr
         OMawj9LIYKlp1P+1yrn2hK1n4TgPXZTXSeUTw+yv+aaxH9WZM4T0EBkY7gniu5+8dZ9x
         mHCJQrY8dijvfn7c96ULY28g8JhRUtUVIO23EukQ8BDx3f9xba1UHsBesgjlowsBEzDJ
         OEgw==
X-Forwarded-Encrypted: i=1; AHgh+RqPR8CNsKJiZsVG9qGwfdcxt90u2SUV5MTgyqugMOVfYrHvr5EafMcDXA2bALq3vm7BCLmzrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6Q8LUQ0LGkfqMjc2km548aG3oJvI22RHKBvvi/dB9jCSQUv67
	Sz9NAcNu1b6t2DRJJRnvZZ27fql8iN1KJtolRu0o3aKxn0wg+e17w0sB
X-Gm-Gg: AR+sD12kAPwRf8n5hUqudLmChsdoFeo0wXfk6ndMd9qVI/6uWeGz1NPuHZMuRAPs0kg
	+/40hLVZ3ZLalZB5DqVluDf5VZ0LmLsgxYMeZl3Jw2SN1O55sYWUhbcosMAoGk1+3w0hv9VraIv
	Mpjw26KtsjZkd2rTRScpVvmTKSPrxnXaacPavYCI6Z6nMZglbMTFGCWq3Sh9GbHdZMpjMz9Hg7p
	JbnQbHEjf/8/ogzTFkBsQeuVxbPcpiSV3K+ftg4WMbV8oQEBtX5llVujYTYw3csYGyzMpiWttAg
	MCF8pKtwF16KfSaBAy73Iu48svYqs9oPD1FcpoDo41P7u+T8CsBloMtSItpb078gwFr21FyyDRK
	TbBOSrXtaXJZXV2yYhYoHgb6yY4288cDGHZp+U1UELppF8CZIJBFx7b6KkErqTp9tS2palNm8kl
	0exgjj628oxkAUQmr7SZagVorqUaTu75AY0A==
X-Received: by 2002:a17:902:e541:b0:2ca:b4b9:4586 with SMTP id d9443c01a7336-2cf348b0a43mr211904095ad.19.1784653819673;
        Tue, 21 Jul 2026 10:10:19 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm585939eec.26.2026.07.21.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:10:18 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:10:16 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
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
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2] x86/mm/pat: allocate split page tables as kernel page
 tables
Message-ID: <al-n-Eos9mc_7lvd@fedora>
References: <20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-fix-cpa-kernel-pagetables-v2-1-2b255deed710@kernel.org>

On Tue, Jul 21, 2026 at 01:14:52PM +0100, Lorenzo Stoakes (ARM) wrote:
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

Acked-by: Vishal Moola <vishal.moola@gmail.com>
