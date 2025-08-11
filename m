Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61523B613;
	Mon, 11 Aug 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902118; cv=none; b=gJMP11DrkUQ7XuUBpm7lm2yW7a2t0yXMqBwEmKfvWU1Ohz8dAtTFy3hnyolN7GVbM+ZGqnoF1hj5PXAi0RORrszeVIEOoj63cCUzR5T+0ivarsxSBthhMBN2qbEXloFzYjF3qn3XzYxnFPKJXGwMDhaE+KhYB+w5buYvS+j9Lp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902118; c=relaxed/simple;
	bh=J/tvAeenWY6r2kQMuQLExQzNUGVbJ5Td0cTgbLYekrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRIlTP6hEy0ymg7m5CFeHDO9SseIIp/aumYWiv7TERg12qWzIj0GzWlMKaF5RY1LoQayibLqbXpGbZw1470CT6toKWKFXL+5OrdTuaP2nKhk2VqVfqjH5SH2oLsUJ9MMlvfDzKeJMfYaFmB5eUP7y3cLO3OYVWWocK1KIBUdMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWN7MfRp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWN7MfRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8DDC4CEF1;
	Mon, 11 Aug 2025 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754902118;
	bh=J/tvAeenWY6r2kQMuQLExQzNUGVbJ5Td0cTgbLYekrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWN7MfRpqyxbN8Qra7VPZbbaSlsQ5woOMzZZKkCN+c2embl/N2yGINIJ/tjsuHibB
	 o5AFcHHdGCIID4ndaZXMZtE+1kr9TfRnJZ8iA7pefXJ1RiMZhVMhpvYFpicsbuwNoM
	 KuM+qQDyN0NbAfqBmZ5KRtD8+rztH7pWTrZ5tFIPMU3JNlNxAVZI57YlKh2F6p6mS1
	 QctExT95vObBAiYQYHjH2bwZJyWQDZ/WM7yUFGxTaKxeREO9ckyvaGMO/LBHQvuup9
	 6nNH/U4yMxynYS+SWF9nMjXZ6CquUI/luxp/WVl/OEGBpilK4aZcBTJpXb7qLysrFQ
	 WX0JG96IP4G9A==
Date: Mon, 11 Aug 2025 11:48:29 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Shanker Donthineni <sdonthineni@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>,
	Vikram Sethi <vsethi@nvidia.com>,
	Jason Sequeira <jsequeira@nvidia.com>, Dev Jain <dev.jain@arm.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [RESEND PATCH 1/2] dma/pool: Use vmap() address for memory
 encryption helpers on ARM64
Message-ID: <aJmuXTNUzsq1jKEK@kernel.org>
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
 <20250811005036.714274-2-sdonthineni@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811005036.714274-2-sdonthineni@nvidia.com>

On Sun, Aug 10, 2025 at 07:50:34PM -0500, Shanker Donthineni wrote:
> In atomic_pool_expand(), set_memory_encrypted()/set_memory_decrypted()
> are currently called with page_to_virt(page). On ARM64 with
> CONFIG_DMA_DIRECT_REMAP=y, the atomic pool is mapped via vmap(), so
> page_to_virt(page) does not reference the actual mapped region.
> 
> Using this incorrect address can cause encryption attribute updates to
> be applied to the wrong memory region. On ARM64 systems with memory
> encryption enabled (e.g. CCA), this can lead to data corruption or
> crashes.
> 
> Fix this by using the vmap() address ('addr') on ARM64 when invoking
> the memory encryption helpers, while retaining the existing
> page_to_virt(page) usage for other architectures.
> 
> Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
> ---
>  kernel/dma/pool.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 7b04f7575796b..ba08a301590fd 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  {
>  	unsigned int order;
>  	struct page *page = NULL;
> +	void *vaddr;
>  	void *addr;
>  	int ret = -ENOMEM;
>  
> @@ -113,8 +114,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>  	 * shrink so no re-encryption occurs in dma_direct_free().
>  	 */
> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> +	vaddr = IS_ENABLED(CONFIG_ARM64) ? addr : page_to_virt(page);

There's address calculation just before this code:

#ifdef CONFIG_DMA_DIRECT_REMAP
	addr = dma_common_contiguous_remap(page, pool_size,
					   pgprot_dmacoherent(PAGE_KERNEL),
					   __builtin_return_address(0));
	if (!addr)
		goto free_page;
#else
	addr = page_to_virt(page);
#endif

It should be enough to s/page_to_virt(page)/addr in the call to
set_memory_decrypted().

> +	ret = set_memory_decrypted((unsigned long)vaddr, 1 << order);
>  	if (ret)
>  		goto remove_mapping;
>  	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> @@ -126,8 +127,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	return 0;
>  
>  encrypt_mapping:
> -	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> +	ret = set_memory_encrypted((unsigned long)vaddr, 1 << order);
>  	if (WARN_ON_ONCE(ret)) {
>  		/* Decrypt succeeded but encrypt failed, purposely leak */
>  		goto out;
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
