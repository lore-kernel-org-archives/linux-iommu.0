Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1BB2F90C5;
	Tue, 14 Apr 2026 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159437; cv=none; b=Jx1WKk02JBpZ7N5fwFqLSEAyEU3BGO1twVaod7/EEHRXvNhaktDs4cMHKjfMqG2k1EuyUurBIYiVtFjnQQb+KLKKMaqMcYrSkVDJ1b2ei//ht1ijVfIdvF+EYtHyro908fDloGHD8SNEex6y7mkBGEvzlKpB3qeE+yS+NflgqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159437; c=relaxed/simple;
	bh=Xl5MxfAYIlpxGIXhbFgrR3GTAuRhIwsFpnrTFr+MVNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q2jv2UJpxact41O9DpOhDkvOWBms7iMt6gTOPzrcfVZ1R7fRTzusVTz2BfeveS/mjljcMaFvj6qb7u5O0icAuOS9Vu4U6eE3i/xj98hnKvXIQzRXfl8xEdroPQs25gU9JHouL5Nl4Tf1POWNB/uAHg3Nf9Gh1v0YIwpXel+X+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M895UTOC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M895UTOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE43C19425;
	Tue, 14 Apr 2026 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159437;
	bh=Xl5MxfAYIlpxGIXhbFgrR3GTAuRhIwsFpnrTFr+MVNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M895UTOCiCmvMaJCIIs8EntiQZUjrpR1aMtkvhY5/gU0axG3d0c/XwW8LFveuMopx
	 zHdh7rXWmlyGa1WPODHYHyQvQqLy6/dxyfVt8hiEi8J/DTPr/cdWC6zuC9jjg29lpZ
	 edCuVJgb1mvQQPLUXLRokK2SNmOaVgg8i+cM/5TwNwZM21awZ0YddHl6GEbZ1gMabm
	 gnFk0VD+NWDwbTIPoM/K9KyHZZaFwKwOG+ubnF9SvsqLdmYVV9eYMaOKLKARv+xLNG
	 MAHjLGcoJ7+evdEnROoyqQapBUFzAHg4FqMhYilegsCHc/+ko/n9BG+YLHk6eg5dbA
	 1SPEZvFf9qOCA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH v3 5/5] dma-mapping: Fix memory decryption issues
In-Reply-To: <20260408194750.2280873-6-smostafa@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-6-smostafa@google.com>
Date: Tue, 14 Apr 2026 15:07:08 +0530
Message-ID: <yq5aqzohannf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Mostafa Saleh <smostafa@google.com> writes:

> Fix 2 existing issues:
> 1) In case a device have a restricted DMA pool, memory will be
> decrypted (which is now returned in the state from swiotlb_alloc().
>
> Later the main function  will attempt to decrypt the memory if
> force_dma_unencrypted() is true.
>
> Which results in the memory being decrypted twice.
> Change that to only encrypt/decrypt memory that is not already
> decrypted as indicated in the new dma_page struct.
>
> 2) Using phys_to_dma_unencrypted() is not enlighted about already
> decrypted memory and will use the wrong functions for that.
>
> Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 204bc566480c..26611d5e5757 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -43,6 +43,11 @@ static inline struct page *dma_page_to_page(struct dma_page dma_page)
>  	return (struct page *)(dma_page.val & ~DMA_PAGE_DECRYPTED_FLAG);
>  }
>  
> +static inline bool is_dma_page_decrypted(struct dma_page dma_page)
> +{
> +	return dma_page.val & DMA_PAGE_DECRYPTED_FLAG;
> +}
> +
>  /*
>   * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use
>   * it for entirely different regions. In that case the arch code needs to
> @@ -51,9 +56,9 @@ static inline struct page *dma_page_to_page(struct dma_page dma_page)
>  u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>  
>  static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> -		phys_addr_t phys)
> +					    phys_addr_t phys, bool already_decrypted)
>  {
> -	if (force_dma_unencrypted(dev))
> +	if (already_decrypted || force_dma_unencrypted(dev))
>  		return phys_to_dma_unencrypted(dev, phys);
>  	return phys_to_dma(dev, phys);
>

Can you explain what is covered by the if () above? Do we expect to
return an unencrypted DMA address even for devices for which
force_dma_unencrypted(dev) does not return true?


>  }
> @@ -67,7 +72,7 @@ static inline struct page *dma_direct_to_page(struct device *dev,
>  u64 dma_direct_get_required_mask(struct device *dev)
>  {
>  	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
> -	u64 max_dma = phys_to_dma_direct(dev, phys);
> +	u64 max_dma = phys_to_dma_direct(dev, phys, false);
>  
>  	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
>  }
> @@ -96,7 +101,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
>  
>  bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  {
> -	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
> +	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, false);
>  
>  	if (dma_addr == DMA_MAPPING_ERROR)
>  		return false;
> @@ -122,11 +127,14 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
>  static void __dma_direct_free_pages(struct device *dev, struct page *page,
>  				    size_t size, bool encrypt)
>  {
> -	if (encrypt && dma_set_encrypted(dev, page_address(page), size))
> +	bool keep_encrypted = swiotlb_is_decrypted(dev, page, size);
> +
> +	if (!keep_encrypted && encrypt && dma_set_encrypted(dev, page_address(page), size))
>  		return;
>  
>  	if (swiotlb_free(dev, page, size))
>  		return;
> +
>  	dma_free_contiguous(dev, page, size);
>  }
>  
> @@ -205,7 +213,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>  	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
>  	if (!page)
>  		return NULL;
> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), false);
>  	return ret;
>  }
>  
> @@ -225,7 +233,8 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
>  		arch_dma_prep_coherent(page, size);
>  
>  	/* return the page pointer as the opaque cookie */
> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
> +					 is_dma_page_decrypted(dma_page));
>  	return page;
>  }
>  
> @@ -234,6 +243,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  {
>  	bool remap = false, set_uncached = false, decrypt = force_dma_unencrypted(dev);
>  	struct dma_page dma_page;
> +	bool already_decrypted;
>  	struct page *page;
>  	void *ret;
>

I am wondering wether we can avoid the already_decrypted logic if you
pull dma_direct_alloc_swiotlb() out to the caller. 
https://lore.kernel.org/all/20260309102625.2315725-2-aneesh.kumar@kernel.org


>  
> @@ -289,6 +299,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	if (!page)
>  		return NULL;
>  
> +	already_decrypted = is_dma_page_decrypted(dma_page);
>  	/*
>  	 * dma_alloc_contiguous can return highmem pages depending on a
>  	 * combination the cma= arguments and per-arch setup.  These need to be
> @@ -299,12 +310,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		set_uncached = false;
>  	}
>  
> -	if (decrypt && dma_set_decrypted(dev, page_address(page), size))
> +	if (!already_decrypted && decrypt &&
> +	    dma_set_decrypted(dev, page_address(page), size))
>  		goto out_leak_pages;
>  	if (remap) {
>  		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>  
> -		if (decrypt)
> +		if (decrypt || already_decrypted)
>  			prot = pgprot_decrypted(prot);
>  
>  		/* remove any dirty cache lines on the kernel alias */
> @@ -328,11 +340,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  			goto out_encrypt_pages;
>  	}
>  
> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), already_decrypted);
>  	return ret;
>  
>  out_encrypt_pages:
> -	__dma_direct_free_pages(dev, page, size, decrypt);
> +	__dma_direct_free_pages(dev, page, size, decrypt && !already_decrypted);
>  	return NULL;
>  out_leak_pages:
>  	return NULL;
> @@ -385,6 +397,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>  {
>  	struct dma_page dma_page;
> +	bool already_decrypted;
>  	struct page *page;
>  	void *ret;
>  
> @@ -396,11 +409,13 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (!page)
>  		return NULL;
>  
> +	already_decrypted = is_dma_page_decrypted(dma_page);
>  	ret = page_address(page);
> -	if (force_dma_unencrypted(dev) && dma_set_decrypted(dev, ret, size))
> +	if (!already_decrypted && force_dma_unencrypted(dev) &&
> +	    dma_set_decrypted(dev, ret, size))
>  		goto out_leak_pages;
>  	memset(ret, 0, size);
> -	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> +	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), already_decrypted);
>  	return page;
>  out_leak_pages:
>  	return NULL;
> -- 
> 2.53.0.1213.gd9a14994de-goog
