Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452160;
	b=4JYeZDNHBoqLyoT+NyaN++/wfjHh/mwBUV8pwFociu6ce6KuFZiecHknikGRlsqyTDDz
	 WHdMMRyAiU7hMOkGFWedajY7ejjewtX7EcidvEfiyvAIqAzmtELqabkK6p2E5qlGh6BIe
	 CaGiL/ZjEwz2RQ8AGQmIK0uF+/fX6jTuIOmWd6/Zbob0iHWjxItvr2N/Li8h9W3JoB6br
	 y8sMt+ykIcwwjn+kjWMfvGsmHRhtUM3glusJMpCyaSU1tr8xYqKeQW840KhZ15GnYmcKs
	 jw3HcCAVepQlHikvs5VQhHU0Rxqspeh+7jjsAxddtEGH/fSX+8fj0Jhh0U4B4rttVMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452160;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=CqfImJvbBCfbJiBn9MZOtV5tMRMtqhnvXEPFcs5Onlg=;
	b=f7j4twJAQ/dcz8PQWSzi+jzHZEj6esUpqAvw7q/gAL91JxuVcAdjCaOSSVwT1+LTHP3K
	 tUiPTM+1Xwi2N9R7HmG8fR755FTn1IO3aj8o9Y5kWEPE9DwaRXNau+5HFle9+YIpjQmar
	 umROrtRr4FbElcTLtS1wPC7uOZh6ZLlp376XJbwVluxCfch+BjqSal6wn4bJC5up0yAxr
	 u2wJOCdovOP9DDfg9XoxVYR8uFGqc/O6WXIXXpEIdttkcdPABcAL4j/XISR2VLOXhFepW
	 VDv3klIz+Kl0zEgzpGEgNUGwSxOV7BS7xFzk7S9kKUHQzxVOEb5xevWj7UD9EAc05YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jThQQBPr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A225606A323;
	Thu, 12 Nov 2026 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jThQQBPr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A344C1F00A05;
	Thu, 12 Nov 2026 02:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452160;
	bh=CqfImJvbBCfbJiBn9MZOtV5tMRMtqhnvXEPFcs5Onlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jThQQBPrty1bexjnGQ1dBJ11758QFqPlYSyEvRWv45gtbQRD9FSkqx14/B9NcTIP3
	 T2o/x2+sTCiGmdWWuZEVt0ijuoQH/zSOicfdU43vUm1IgR5EzytZxg9U6lN8zCtSJK
	 Kn/LApuAmBzMkl2xHNzg2t5ESCLWMNO+jP2z5lZbMWPs7X3/yqudRoRwiV7wVEOd0c
	 w0G0g4yJR5xz1uT705gMLy9pJ+P0FqpTHz3mbeVsvYQNyA+L5AnAlWIJlHA1rZl5p2
	 LybqTR1Wl9UcVhFje1VncTk4c20u2xqos6cpGnBhxEaU373Y8C3ReIdG4lzwT5IHmG
	 D6Vp0ucLB7a5g==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	David Rientjes <rientjes@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] dma-pool: decrypt pages before creating the shared remap
In-Reply-To: <20261109154403.384434-1-m.szyprowski@samsung.com>
References: <CGME20261109154426eucas1p28dad751a60e6a8cd490b178bbf0400fb@eucas1p2.samsung.com>
 <20261109154403.384434-1-m.szyprowski@samsung.com>
Date: Thu, 12 Nov 2026 08:25:53 +0530
Message-ID: <yq5aeccqrc5i.fsf@kernel.org>
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
> If set_memory_decrypted() fails, the page state is unknown, so the
> pages are still leaked rather than freed. No remap exists at that point
> any more, so nothing else needs to be undone.
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
>  kernel/dma/pool.c | 39 ++++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 381b3cb28368..3c67728a2471 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -106,6 +106,17 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
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
> +		if (ret)
> +			goto out;
> +	}
> +
>  	arch_dma_prep_coherent(page, pool_size);
>  
>  #ifdef CONFIG_DMA_DIRECT_REMAP
> @@ -117,41 +128,27 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>  	addr = dma_common_contiguous_remap(page, pool_size, prot,
>  			__builtin_return_address(0));
>  	if (!addr)
> -		goto free_page;
> +		goto encrypt_pages;
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
