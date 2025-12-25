Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7AF227E83;
	Thu, 25 Dec 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666216; cv=none; b=aExmCFB9uTdlGVDxFK4r9UWleIgAVLMKDwZiK8wqKteXTVTDwzpecnzYw12SOBU+lD1M+7DEk4Tj3IX5Ioca8R2XOuBbTa3Sl6rZtgkxIJbA8JBpvRHwwIdm0vG8EnYghTpkbyIbM/5zJ9Bx0/qiPzPh0Vz59rEE8Nie1nWxJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666216; c=relaxed/simple;
	bh=WzoONx4GwRY0HIt+QGBq0NrV6ZYzdLYx41h6bExqSyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKA7q3jB5iwZjGPYtvpdv0LL5hNenMFjTWgU2Uwh5HypsLoQmh+RrDjt3UQfm30G0jYzKcAZwIWl2pIzYu3ZMyojD/zAPKjsCnbGgYDXXD0W6hk9cQicBcBu0l88PE+nF/35hqEIxo4Qu8I4HYVmbEyptUMT49HyNHc3x6gvvnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH64681e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH64681e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC11C4CEF1;
	Thu, 25 Dec 2025 12:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766666215;
	bh=WzoONx4GwRY0HIt+QGBq0NrV6ZYzdLYx41h6bExqSyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GH64681eyxF/5e2195mhPnPO3YGodiwCuyr6x+WjMJS2vhlRlwCZ0KBL5qyx0ZzZN
	 uMqLbqEY7wyKIKJ34IM/sKcD2GND2sPGJqtihi1U7olo/bB6RcVON7wqml+zGVjX+f
	 FMRgavhp0mrbhVKMf7UEdZxhcwWx5RkcaBa01Dgzdj+8Yb1IbV0q2ED/F3s5wSAWhx
	 la9VBLsEhLqKRATnzaYYi4QGqE+tIcoKnJzW/bXb0hAZR1/SRFYgy35lUZo/AK6sLi
	 SO3MQstr7qy5yT4mBaNueQTsVGINVdFwy92Vmkzk/tJO0dLya093ww8C3lErecBdMf
	 4twp/pZ1CFIug==
Date: Thu, 25 Dec 2025 14:36:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: ada.coupriediaz@arm.com, anshuman.khandual@arm.com, ardb@kernel.org,
	catalin.marinas@arm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com, maz@kernel.org, robin.murphy@arm.com,
	ryan.roberts@arm.com, surenb@google.com, v-songbaohua@oppo.com,
	will@kernel.org, zhengtangquan@oppo.com
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if
 supported by the arch
Message-ID: <20251225123650.GJ11869@unreal>
References: <20251224085145.GF11869@unreal>
 <20251225054509.39917-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225054509.39917-1-21cnbao@gmail.com>

On Thu, Dec 25, 2025 at 06:45:09PM +1300, Barry Song wrote:
> > > >
> > >
> > > OK. Could you take a look at [1] and see if any further
> > > improvements are needed before I send v2?
> >
> > Everything looks ok, except these renames:
> > -                       arch_sync_dma_for_cpu(paddr, sg->length, dir);
> > +                       arch_sync_dma_for_cpu_batch_add(paddr, sg->length, dir);
> 
> Thanks!
> I'm happy to drop the rename as outlined below-feedback welcome :-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index dd2c8586a725..487fb7c355ed 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -87,6 +87,12 @@ int cache_line_size(void);
>  
>  #define dma_get_cache_alignment	cache_line_size
>  
> +static inline void arch_sync_dma_flush(void)
> +{
> +	dsb(sy);
> +}
> +#define arch_sync_dma_flush arch_sync_dma_flush
> +
>  /* Compress a u64 MPIDR value into 32 bits. */
>  static inline u64 arch_compact_of_hwid(u64 id)
>  {
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index b2b5792b2caa..ae1ae0280eef 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -17,7 +17,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>  {
>  	unsigned long start = (unsigned long)phys_to_virt(paddr);
>  
> -	dcache_clean_poc(start, start + size);
> +	dcache_clean_poc_nosync(start, start + size);
>  }
>  
>  void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
> @@ -28,7 +28,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  	if (dir == DMA_TO_DEVICE)
>  		return;
>  
> -	dcache_inval_poc(start, start + size);
> +	dcache_inval_poc_nosync(start, start + size);
>  }
>  
>  void arch_dma_prep_coherent(struct page *page, size_t size)
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 4809204c674c..e7dd8a63b40e 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -361,6 +361,12 @@ static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  }
>  #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
>  
> +#ifndef arch_sync_dma_flush

You likely need to wrap this in "#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FLUSH"
as done in the surrounding code.

Thanks

> +static inline void arch_sync_dma_flush(void)
> +{
> +}
> +#endif
> +
>  #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
>  void arch_sync_dma_for_cpu_all(void);
>  #else
> 
