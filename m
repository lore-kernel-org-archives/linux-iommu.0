Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452215;
	b=jXqwJ/5ZvQS2oazyiRo3EF5uZrt+a0W5SLTLlUjQoQuwa3jYwYqQvy7rYynkYyJBHsyr
	 Yt4JeifTYMybRJbRTPe9rdyR6VA1P35iU47sp4qhkqWFGp5mu6wOIogwdSXKXy7ioEHLX
	 gldB32JKaOmljtw1yqg27jC6WR4aJlDUppmumf4dRCQ+cg6OaGz4/Ty7co2NaLY263ALs
	 opjOgCo40hXuG2Gg4TEWYNTKLfa50/WQ/NNwAHjW3zaaK5GEyklXGI5R7FkRr6K38I9TL
	 LQo4gII4KPfwPpgkOjUFkPtaUNg1io8JNgX7bY6Dvr31zNklNZRS36UJas8k2M+xI7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452215;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=vOF+RGK9UnUHcVcejSq7M96a8eoJuO60vsZupJJEXRU=;
	b=aXRqH/QnPdL4vBLefivxQaql8Ar8wlQMbXBW45cfhwCYhN8MegCQX2npU4OVjJFk6UcT
	 0XUghKTzNhPUYQDlnYiEhXumWxMd0KIVjaE+add+TpHMbCQb0dJ4wLJ3dkmMMYzt2Q6h4
	 V55WfvT4k47/tsIXeoQcJwsK/FAMhaoANN+i1AQAJhucGBqM94GwIkW10Q0OCB5Gh9HDc
	 aTwlfi1tDGP6dOj0xcHoROLLadhFDym1eXtcwJd6ZTyv2sxQDr7L7aR/rBgEGvl8PH/pf
	 ucOp8tG3XKy/18/0SbA85lBMadzdBIK5wl7FB1/E2urAR7aI/gmw8iriMMddgcsHf4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPtuLY91;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC2D606A31C;
	Thu, 12 Nov 2026 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPtuLY91
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18831F00A05;
	Thu, 12 Nov 2026 02:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452215;
	bh=vOF+RGK9UnUHcVcejSq7M96a8eoJuO60vsZupJJEXRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lPtuLY91/lHi/9p1s/6yaltKtqqBQf/oS0B5bAxdsul7kIVXUg8c3c4R/zldKHFSZ
	 4X2gE0O66/XKBN0ohfV1lVVCPnWrFxe3vBNAcjRK/+ylOv3hj/gapimFUQfHa+gju9
	 sbSptR0QLQ3CmHIDGXT5yb5ULXEPO6mI4OeJYy+wYDvQqTGhe3eU6fAKFhc4IudBuS
	 6kAqY3weeLJzoulZ4m4aNYVw/INEROGBX/5LRS2KIhW4rYIHxMbfUrsCmshrSExfq8
	 4qxLTnYORQ9MzOYZK3phsoISxMHjgAO42TxTq1TXMoc083omMBUuRQTGqnGXaM6cPI
	 gXYAVJYt7RYCw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2] dma-pool: decrypt pages before creating the shared
 remap
In-Reply-To: <20261109230830.1707975-1-m.szyprowski@samsung.com>
References: <CGME20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7@eucas1p1.samsung.com>
 <20261109230830.1707975-1-m.szyprowski@samsung.com>
Date: Thu, 12 Nov 2026 08:26:49 +0530
Message-ID: <yq5abj7urc3y.fsf@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> atomic_pool_expand() creates the pgprot_decrypted() remap of the pool
> pages before calling set_memory_decrypted() on them. The error path
> when gen_pool_add_virt() fails does the reverse: it re-encrypts the
> pages and only then tears down the decrypted remap. In both cases there
> is a window where a decrypted (shared) kernel mapping points at a page
> that is still private, i.e. encrypted, to the guest.
>
> dma_direct_alloc() gets this right: it converts the pages first, then
> creates the remap, and on error removes the remap before re-encrypting.
> Do the same in atomic_pool_expand(). The pages are now converted before
> arch_dma_prep_coherent() and the remap, and the error path unwinds in
> reverse order.
>
> If set_memory_decrypted() fails, the encryption state of the pages is
> unknown (the conversion may have partially succeeded), so they must not
> be returned to the page allocator or CMA and are intentionally leaked,
> as before. No remap exists at that point any more, so nothing else needs
> to be undone. Add a comment explaining this.
>

Reviewed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

> Closes: https://sashiko.dev/#/bug/linux-9212d9b5-4a56-43e2-bc00-6e69b724078b
> Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> The patch was prepared with LLM assistance.
>
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> ---
> Changelog:
>
> v2:
> - addressed more sashiko.dev pointed issues:
>   https://sashiko.dev/#/patchset/20261109154403.384434-1-m.szyprowski%40samsung.com
>
> v1: https://lore.kernel.org/all/20261109154403.384434-1-m.szyprowski@samsung.com/
> ---
>  kernel/dma/pool.c | 48 +++++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 381b3cb28368..5e8cf12e8222 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -106,6 +106,22 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>  	if (!page)
>  		goto out;
>  
> +	/*
> +	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
> +	 * shrink so no re-encryption occurs in dma_direct_free().
> +	 */
> +	if (dma_pool->cc_shared) {
> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> +					   1 << order);
> +		/*
> +		 * On failure the encryption state of the pages is unknown,
> +		 * so they must not be returned to the page allocator or CMA.
> +		 * Leak them intentionally.
> +		 */
> +		if (ret)
> +			goto out;
> +	}
> +
>  	arch_dma_prep_coherent(page, pool_size);
>  
>  #ifdef CONFIG_DMA_DIRECT_REMAP
> @@ -116,42 +132,30 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>  
>  	addr = dma_common_contiguous_remap(page, pool_size, prot,
>  			__builtin_return_address(0));
> -	if (!addr)
> -		goto free_page;
> +	if (!addr) {
> +		ret = -ENOMEM;
> +		goto encrypt_pages;
> +	}
>  #else
>  	addr = page_to_virt(page);
>  #endif
> -	/*
> -	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
> -	 * shrink so no re-encryption occurs in dma_direct_free().
> -	 */
> -	if (dma_pool->cc_shared) {
> -		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> -					   1 << order);
> -		if (ret) {
> -			leak_pages = true;
> -			goto remove_mapping;
> -		}
> -	}
> -
>  	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
>  				page_to_phys(page), pool_size, NUMA_NO_NODE);
>  	if (ret)
> -		goto encrypt_mapping;
> +		goto remove_mapping;
>  
>  	dma_atomic_pool_size_add(gfp, pool_size);
>  	return 0;
>  
> -encrypt_mapping:
> -	if (dma_pool->cc_shared &&
> -	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
> -		leak_pages = true;
> -
>  remove_mapping:
>  #ifdef CONFIG_DMA_DIRECT_REMAP
>  	dma_common_free_remap(addr, pool_size);
> -free_page:
> +encrypt_pages:
>  #endif
> +	if (dma_pool->cc_shared &&
> +	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
> +		leak_pages = true;
> +
>  	if (!leak_pages &&
>  	    !dma_release_from_contiguous(NULL, page, 1 << order))
>  		__free_pages(page, order);
> -- 
> 2.43.0
