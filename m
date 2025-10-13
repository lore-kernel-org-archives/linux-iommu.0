Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32ED1B4F09;
	Mon, 13 Oct 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760339888; cv=none; b=USItf5F7/ePmJBeIBA3pqpSxD8xcQQPYj8RY+Mfl91P5ut7oBPCD5f+50VHC2aAfM9GPSEcWPMRQ7wA3dlJXCUsripruXfdNYJAHTAoovG60NcCKg0C3imQra66ZGXzQmIlRs7OFPKwAVlxy3/iGdXKe035bzQ8p9y0ZrpgADxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760339888; c=relaxed/simple;
	bh=YLv5InJLlW0GnvCcW21BMvEaiqUu0JrGPOOfzqOIL7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe6NVzm3+fGJtEEwYvHBIDPUA+F1WBs4T2H8oaYlbchAlH4cH2nlRTgcAiv4hUpRpWpDf3ZLpQzxqQsXjg1aEXkEER9ADJ4lo93o87a/PfTPmyJ5lBhd5PqZdVbF16Zm2d0SIOY17l8Yb6XdGijl1XMyV0t/XatEXQ1YdXRmrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4R3k1LZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4R3k1LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43EAC4CEE7;
	Mon, 13 Oct 2025 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760339887;
	bh=YLv5InJLlW0GnvCcW21BMvEaiqUu0JrGPOOfzqOIL7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4R3k1LZHzpGoa3CGNOP1VANnxZgqbYFTh3O1uI0UOUZI6egZH7DS9iXzCNanfPj6
	 5l4hRVdl8kug78iGi503BMwTf4nOfB4vvPqzfQblO8bANCTR0IepYFAi8pg4PmXcJl
	 v5mRsMXje08tODxTmyA5OIz0MV0Bp+hR52IAzNGX/P+svL+EdB5DLwEoWOUND+O6Kf
	 YuSG4fNpL6qP9OxqgNyTvU+dffpgHu93yEHMZLAsR25uNDeEeJ6nise1nSkPELIGCx
	 VGgNLmvwA2eaX+H2UuCy8fUgkQfgvKdAEN9XvtoacZlIyOarhWxcIvseAbwa+xrPpj
	 rWlSnFWp2aHtA==
Date: Mon, 13 Oct 2025 10:17:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/8] mm: Actually mark kernel page table pages
Message-ID: <aOynozGF70jD3bo_@kernel.org>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919054007.472493-3-baolu.lu@linux.intel.com>

On Fri, Sep 19, 2025 at 01:40:00PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Now that the API is in place, mark kernel page table pages just
> after they are allocated. Unmark them just before they are freed.
> 
> Note: Unconditionally clearing the 'kernel' marking (via
> ptdesc_clear_kernel()) would be functionally identical to what
> is here. But having the if() makes it logically clear that this
> function can be used for kernel and non-kernel page tables.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/asm-generic/pgalloc.h | 18 ++++++++++++++++++
>  include/linux/mm.h            |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 3c8ec3bfea44..b9d2a7c79b93 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -28,6 +28,8 @@ static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>  		return NULL;
>  	}
>  
> +	ptdesc_set_kernel(ptdesc);
> +
>  	return ptdesc_address(ptdesc);
>  }
>  #define __pte_alloc_one_kernel(...)	alloc_hooks(__pte_alloc_one_kernel_noprof(__VA_ARGS__))
> @@ -146,6 +148,10 @@ static inline pmd_t *pmd_alloc_one_noprof(struct mm_struct *mm, unsigned long ad
>  		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> +
> +	if (mm == &init_mm)
> +		ptdesc_set_kernel(ptdesc);
> +
>  	return ptdesc_address(ptdesc);
>  }
>  #define pmd_alloc_one(...)	alloc_hooks(pmd_alloc_one_noprof(__VA_ARGS__))
> @@ -179,6 +185,10 @@ static inline pud_t *__pud_alloc_one_noprof(struct mm_struct *mm, unsigned long
>  		return NULL;
>  
>  	pagetable_pud_ctor(ptdesc);
> +
> +	if (mm == &init_mm)
> +		ptdesc_set_kernel(ptdesc);
> +
>  	return ptdesc_address(ptdesc);
>  }
>  #define __pud_alloc_one(...)	alloc_hooks(__pud_alloc_one_noprof(__VA_ARGS__))
> @@ -233,6 +243,10 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
>  		return NULL;
>  
>  	pagetable_p4d_ctor(ptdesc);
> +
> +	if (mm == &init_mm)
> +		ptdesc_set_kernel(ptdesc);
> +
>  	return ptdesc_address(ptdesc);
>  }
>  #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
> @@ -277,6 +291,10 @@ static inline pgd_t *__pgd_alloc_noprof(struct mm_struct *mm, unsigned int order
>  		return NULL;
>  
>  	pagetable_pgd_ctor(ptdesc);
> +
> +	if (mm == &init_mm)
> +		ptdesc_set_kernel(ptdesc);
> +
>  	return ptdesc_address(ptdesc);
>  }
>  #define __pgd_alloc(...)	alloc_hooks(__pgd_alloc_noprof(__VA_ARGS__))
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..f3db3a5ebefe 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2895,6 +2895,9 @@ static inline void pagetable_free(struct ptdesc *pt)
>  {
>  	struct page *page = ptdesc_page(pt);
>  
> +	if (ptdesc_test_kernel(pt))
> +		ptdesc_clear_kernel(pt);
> +
>  	__free_pages(page, compound_order(page));
>  }
>  
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
