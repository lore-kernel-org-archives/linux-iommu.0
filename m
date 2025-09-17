Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8A2367C3;
	Wed, 17 Sep 2025 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105409; cv=none; b=ukYFl/s0d7JvR6a6fsHNHdMPW8yRtIum/5JnQh31wj64PiHES2Wa9UhaJU+6Bl+lQ5xLNEwwREeOmirLvB4qNQ4oINRgT1rh2qsEu6ytJCTBwyCSwQgP02pmoqPYnSOaNLiE8AGi7sWIfwu1SXqSpIUat0R3VlYchiCpKKZjpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105409; c=relaxed/simple;
	bh=9+CfYEPcX9RBMZk8bYI4Kxv/QQTIj2Zq3577UGdLueI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZUVcjxOrV1mDGGX6g+3iSemVBIEzvaiPdaFhfgRG2rqa1KlcOnq9gGG+nz0Z1R1wB7iaWVVLQeGPRuAhXPWBLCu6lvzErUANf5XdrEpGgUwi8T0AEF3n2XFDmdnyiKXqYuRcrW35NOXzapwW7qAqcR3MGiwbjdr5HyHZQwI6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCefrIWD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCefrIWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2481FC4CEFC;
	Wed, 17 Sep 2025 10:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758105408;
	bh=9+CfYEPcX9RBMZk8bYI4Kxv/QQTIj2Zq3577UGdLueI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCefrIWDpyeDN3tXCB94u2Q5MHcY4yejTjtLsnQVEmKCthEh6xZgfJLbg0LQHPSrA
	 nSRFKqERWoVpqSJRGh2DasAyTzco1FZJiQ6RV8TxkrkGc6jukqP6yo3IsgptEsd7b9
	 ZPjqCne7q7h0dMm/687O7OdUOK4Sx3X1cX5N7PnoEz1D4z93ewUSVpM6AJLAoz+qLQ
	 tB4jan9ZQqw8jp1Mp9F67+yZRi2ivSd+Xs5sHJOxM1s9jbSS2eGenOP4oD7vtFmg2P
	 7UnjEMEaBp8ZKfTszdcjLZOf2Ezycnw6joQfJW/BWvhcuIOSFMdO0eAw/bx6/+U2Of
	 FAOvNCNFqe7QQ==
Date: Wed, 17 Sep 2025 13:36:44 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address
 mapping callbacks
Message-ID: <20250917103644.GB6464@unreal>
References: <cover.1758006942.git.leon@kernel.org>
 <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
 <20250916184617.GW1086830@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916184617.GW1086830@nvidia.com>

On Tue, Sep 16, 2025 at 03:46:17PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 10:32:06AM +0300, Leon Romanovsky wrote:
> > +	if (!dev->dma_coherent &&
> > +	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
> > +		__dma_page_cpu_to_dev(phys_to_page(phys), offset, size, dir);
> 
> I'd keep going and get rid of the page here too, maybe as a second
> patch in this series:

Thanks, it is always unclear how far to go with cleanups.

> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 88c2d68a69c9ee..a84d12cd0ba4a9 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -624,16 +624,14 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
>  	kfree(buf);
>  }
>  
> -static void dma_cache_maint_page(struct page *page, unsigned long offset,
> +static void dma_cache_maint_page(phys_addr_t paddr,
>  	size_t size, enum dma_data_direction dir,
>  	void (*op)(const void *, size_t, int))
>  {
> -	unsigned long pfn;
> +	unsigned long pfn = paddr / PAGE_SIZE;
> +	unsigned int offset = paddr % PAGE_SIZE;
>  	size_t left = size;
>  
> -	pfn = page_to_pfn(page) + offset / PAGE_SIZE;
> -	offset %= PAGE_SIZE;
> -
>  	/*
>  	 * A single sg entry may refer to multiple physically contiguous
>  	 * pages.  But we still need to process highmem pages individually.
> @@ -644,17 +642,17 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
>  		size_t len = left;
>  		void *vaddr;
>  
> -		page = pfn_to_page(pfn);
> -
> -		if (PageHighMem(page)) {
> +		if (PhysHighMem(pfn << PAGE_SHIFT)) {
>  			if (len + offset > PAGE_SIZE)
>  				len = PAGE_SIZE - offset;
>  
>  			if (cache_is_vipt_nonaliasing()) {
> -				vaddr = kmap_atomic(page);
> +				vaddr = kmap_atomic_pfn(pfn);
>  				op(vaddr + offset, len, dir);
>  				kunmap_atomic(vaddr);
>  			} else {
> +				struct page *page = pfn_to_page(pfn);
> +
>  				vaddr = kmap_high_get(page);
>  				if (vaddr) {
>  					op(vaddr + offset, len, dir);
> @@ -662,7 +660,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
>  				}
>  			}
>  		} else {
> -			vaddr = page_address(page) + offset;
> +			vaddr = phys_to_virt(pfn) + offset;
>  			op(vaddr, len, dir);
>  		}
>  		offset = 0;
> @@ -676,14 +674,11 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
>   * Note: Drivers should NOT use this function directly.
>   * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
>   */
> -static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
> +static void __dma_page_cpu_to_dev(phys_addr_t paddr,
>  	size_t size, enum dma_data_direction dir)
>  {
> -	phys_addr_t paddr;
> +	dma_cache_maint_page(paddr, size, dir, dmac_map_area);
>  
> -	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
> -
> -	paddr = page_to_phys(page) + off;
>  	if (dir == DMA_FROM_DEVICE) {
>  		outer_inv_range(paddr, paddr + size);
>  	} else {
> 
> > +	if (!dev->dma_coherent &&
> > +	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
> >  		page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
> >  		__dma_page_dev_to_cpu(page, offset, size, dir);
> 
> Same treatment here..
> 
> Looks Ok though, I didn't notice any pitfalls
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
> 
