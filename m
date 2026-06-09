Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6910C413606
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007360; cv=none; b=bYeWAfmwxlfPcLo4Xj6B+aD/SAN8fG+oc0lxgjpXFPdfelK5p3jtWnqzbC+9AQa38UnDn7+5uVmaNSvTtSrUvOaXvebzYgpAfQD9kdWzqs5mSSAXX0x2j12ZqYxL4daWAplTMCrrb8GYJo7gEJb5wTkUOIntVTf26EnFcqDHRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007360; c=relaxed/simple;
	bh=brtgLaNnyjw2YXdYG21MgcS8I6CCPSHYKNmm+BOhNKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/f+PbOcD0KUtBd3WLtCqJNTVU1AMDO/30aW8EW76wg9Zf/HQd+ORhucEFfcsO7jvg+V9Qpadoe8VN7eB9358/rkhSdM15cUa0YzXfpqQui5aKrJbtiY79l9Oo/tjTnlhPVpm+ZssEKUxp/2rgFFaoQWZCnoX748/iwZNxMMxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aEO24Yv/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aEO24Yv/"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490a762c8d5so5672925e9.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781007357; x=1781612157; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7sN51CIvQwRuTJi3qMza06o4wJMznBiMEkiJVIlNBs=;
        b=aEO24Yv/+ICVYF8i7VSgo2y64nzVygobJX2R1G4m4L0/3pY5YkUpMQOLZzSVzoHauy
         YvXmZuvhz/H1FatM8xvz3QiehzD2ICb8WX2sAq9/HjZXGAQweWS0zZx4JltpBciWh0Mu
         Y8TYhF/wRmT4AFsU1MASII8rZL7EnEFdEmaCUaUFAB/AqV2GHowqtLfxjhTL2PxRLg6A
         Vyl6sl07CDfxbABh/QcCDC+Qhy0cWMY5mS0FZoHLMr1nZf1FsJ5BBHWnMewtGmKENZ9h
         57AISMIUAcHaBF12M/mRpier4vaZrcoXc0SblOLpj/OEUgk5vVv3dgnakAJgUbkjeFMI
         7bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007357; x=1781612157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7sN51CIvQwRuTJi3qMza06o4wJMznBiMEkiJVIlNBs=;
        b=Rwqf/OtS0Ceb624ldUaUU16H2fvWSAZVYVePBPYr2qinEkwRROAlfSlZTfDNHN/hjL
         Uf8hrQ4OR7DZfGu4Ca4asVYDZ90sO9QbAldd86W26smpr2W2WMeZjFErlroPHPJTAt5T
         a8OEnpK53NXY5zRiZ5Sy5IUpRH8M8uRk3B76koNjwKOpMj6kN9z/gP1VUd6G3Q6RRI57
         WvtDc5tT8nw0hfH3DgK0oXfd/ySQaHo5oaHXWGIMdtd2qphWLHl7xII1trGTqAzp/ZIJ
         BQ/LygWancZGJV5c3W+HPprd0fJbn0ljEJqPVzeSnkIOttSVgvj5tgM0ZEbJGdaM3ifM
         S5kw==
X-Gm-Message-State: AOJu0Yx428uqWSnwQJqmrDklTJsiPRthIqrGyClhhqg24v4SaqmmXGxB
	nCB7iyapZjm4ULp2PlCRcYHqluKYh60AI0Y13Y25cUvN3kpPElvOc5y4h/zO4HA9PhwUyhvj66M
	YviquHUk=
X-Gm-Gg: Acq92OFushsdwRv5gifFX2u/lgK+6uxFuncy6w6ac2mb6WNOw12tnLzThR41tZkZWNy
	uyyhDrkHiBaisI7nGqv4yleu+1fQHto8eKFfySkXAItNVg1IuimOdvCNhOtV3Q23zch2ED5rhgn
	5CBJTA1dKtlN5zF69AcRoRrxX4pIj/m4ogIEPY/o7MAWd7zLP8gMaTGorZIWA5IXz9OeMTKcEbH
	XuyfSH2T+i6UhFDLxpEib4PLd8mWiexUi4mu5ZXee0sMmA9jFk3cIwFOSRayOkyhg3+wtkg5RKV
	R8dhW7L51N74GEy7WSklRFylb8xGH2zoxlas5lfH75k36mDgFdj+mi1OPFCl/BCbeyiPcb7BMcG
	a7yWsCxWtjCgzvBa1zUBkcI5ETlrO1+h7XuHYrFqc8aW6LJuExhJWRGhXvdFqdHoBXMsCyQch0G
	ZEbp6C0+6qsxFbdhVfSRZYXhU=
X-Received: by 2002:a05:600c:620d:b0:48d:1021:e5d1 with SMTP id 5b1f17b1804b1-490c25f597emr139602585e9.3.1781007356518;
        Tue, 09 Jun 2026 05:15:56 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e5a00sm473055565e9.15.2026.06.09.05.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:15:55 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:15:48 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Jiri Pirko <jiri@nvidia.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 02/20] dma-direct: swiotlb: handle swiotlb alloc/free
 outside __dma_direct_alloc_pages
Message-ID: <20260609141548.70a5848d@mordecai>
In-Reply-To: <20260604083959.1265923-3-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-3-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:41 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Move swiotlb allocation out of __dma_direct_alloc_pages() and handle it in
> dma_direct_alloc() / dma_direct_alloc_pages().
> 
> This is needed for follow-up changes that simplify the handling of
> memory encryption/decryption based on the DMA attribute flags.
> 
> swiotlb backing pages are already mapped decrypted by
> swiotlb_update_mem_attributes() and rmem_swiotlb_device_init(), so
> dma-direct should not call dma_set_decrypted() on allocation nor
> dma_set_encrypted() on free for swiotlb-backed memory.
> 
> Update alloc/free paths to detect swiotlb-backed pages and skip
> encrypt/decrypt transitions for those paths. Keep the existing highmem
> rejection in dma_direct_alloc_pages() for swiotlb allocations.
> 
> Only for "restricted-dma-pool", we currently set `for_alloc = true`, while
> rmem_swiotlb_device_init() decrypts the whole pool up front. This pool is
> typically used together with "shared-dma-pool", where the shared region is
> accessed after remap/ioremap and the returned address is suitable for
> decrypted memory access. So existing code paths remain valid.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  include/linux/swiotlb.h |  6 ++++
>  kernel/dma/direct.c     | 71 ++++++++++++++++++++++++++++++-----------
>  kernel/dma/swiotlb.c    |  6 ++++
>  3 files changed, 65 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 3dae0f592063..133bb8ca9032 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -284,6 +284,8 @@ extern void swiotlb_print_info(void);
>  #ifdef CONFIG_DMA_RESTRICTED_POOL
>  struct page *swiotlb_alloc(struct device *dev, size_t size);
>  bool swiotlb_free(struct device *dev, struct page *page, size_t size);
> +void swiotlb_free_from_pool(struct device *dev, phys_addr_t tlb_addr,
> +		size_t size, struct io_tlb_pool *pool);
>  
>  static inline bool is_swiotlb_for_alloc(struct device *dev)
>  {
> @@ -299,6 +301,10 @@ static inline bool swiotlb_free(struct device *dev, struct page *page,
>  {
>  	return false;
>  }
> +static inline void swiotlb_free_from_pool(struct device *dev, phys_addr_t tlb_addr,
> +		size_t size, struct io_tlb_pool *pool)
> +{
> +}
>  static inline bool is_swiotlb_for_alloc(struct device *dev)
>  {
>  	return false;
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 583c5922bca2..a741c8a2ee66 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -96,14 +96,6 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
>  	return ret;
>  }
>  
> -static void __dma_direct_free_pages(struct device *dev, struct page *page,
> -				    size_t size)
> -{
> -	if (swiotlb_free(dev, page, size))
> -		return;
> -	dma_free_contiguous(dev, page, size);
> -}
> -
>  static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>  {
>  	struct page *page = swiotlb_alloc(dev, size);
> @@ -125,9 +117,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>  
>  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
>  
> -	if (is_swiotlb_for_alloc(dev))
> -		return dma_direct_alloc_swiotlb(dev, size);
> -
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
>  	page = dma_alloc_contiguous(dev, size, gfp);
>  	if (page) {
> @@ -204,6 +193,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> +	bool mark_mem_decrypt = true;
>  	struct page *page;
>  	void *ret;
>  
> @@ -250,11 +240,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> +	if (is_swiotlb_for_alloc(dev)) {
> +		page = dma_direct_alloc_swiotlb(dev, size);
> +		if (page) {
> +			mark_mem_decrypt = false;
> +			goto setup_page;
> +		}
> +		return NULL;
> +	}
> +
>  	/* we always manually zero the memory once we are done */
>  	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
>  	if (!page)
>  		return NULL;
>  
> +setup_page:
>  	/*
>  	 * dma_alloc_contiguous can return highmem pages depending on a
>  	 * combination the cma= arguments and per-arch setup.  These need to be
> @@ -281,7 +281,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  			goto out_free_pages;
>  	} else {
>  		ret = page_address(page);
> -		if (dma_set_decrypted(dev, ret, size))
> +		if (mark_mem_decrypt && dma_set_decrypted(dev, ret, size))
>  			goto out_leak_pages;
>  	}
>  
> @@ -298,10 +298,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return ret;
>  
>  out_encrypt_pages:
> -	if (dma_set_encrypted(dev, page_address(page), size))
> +	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
>  		return NULL;
>  out_free_pages:
> -	__dma_direct_free_pages(dev, page, size);
> +	if (!swiotlb_free(dev, page, size))
> +		dma_free_contiguous(dev, page, size);
>  	return NULL;
>  out_leak_pages:
>  	return NULL;
> @@ -310,6 +311,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
> +	phys_addr_t phys;
> +	bool mark_mem_encrypted = true;
> +	struct io_tlb_pool *swiotlb_pool;
>  	unsigned int page_order = get_order(size);
>  
>  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> @@ -338,16 +342,25 @@ void dma_direct_free(struct device *dev, size_t size,
>  	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>  		return;
>  
> +	phys = dma_to_phys(dev, dma_addr);
> +	swiotlb_pool = swiotlb_find_pool(dev, phys);
> +	if (swiotlb_pool)
> +		/* Swiotlb doesn't need a page attribute update on free */
> +		mark_mem_encrypted = false;
> +
>  	if (is_vmalloc_addr(cpu_addr)) {
>  		vunmap(cpu_addr);
>  	} else {
>  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>  			arch_dma_clear_uncached(cpu_addr, size);
> -		if (dma_set_encrypted(dev, cpu_addr, size))
> +		if (mark_mem_encrypted && dma_set_encrypted(dev, cpu_addr, size))
>  			return;
>  	}
>  
> -	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
> +	if (swiotlb_pool)
> +		swiotlb_free_from_pool(dev, phys, size, swiotlb_pool);
> +	else
> +		dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
>  }
>  
>  struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
> @@ -359,6 +372,15 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> +	if (is_swiotlb_for_alloc(dev)) {
> +		page = dma_direct_alloc_swiotlb(dev, size);
> +		if (!page)
> +			return NULL;
> +
> +		ret = page_address(page);
> +		goto setup_page;
> +	}
> +
>  	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>  	if (!page)
>  		return NULL;
> @@ -366,6 +388,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	ret = page_address(page);
>  	if (dma_set_decrypted(dev, ret, size))
>  		goto out_leak_pages;
> +setup_page:
>  	memset(ret, 0, size);
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>  	return page;
> @@ -377,16 +400,28 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>  		struct page *page, dma_addr_t dma_addr,
>  		enum dma_data_direction dir)
>  {
> +	phys_addr_t phys;
>  	void *vaddr = page_address(page);
> +	struct io_tlb_pool *swiotlb_pool;
> +	bool mark_mem_encrypted = true;
>  
>  	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>  	    dma_free_from_pool(dev, vaddr, size))
>  		return;
>  
> -	if (dma_set_encrypted(dev, vaddr, size))
> +	phys = page_to_phys(page);
> +	swiotlb_pool = swiotlb_find_pool(dev, phys);
> +	if (swiotlb_pool)
> +		mark_mem_encrypted = false;
> +
> +	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
>  		return;
> -	__dma_direct_free_pages(dev, page, size);
> +
> +	if (swiotlb_pool)
> +		swiotlb_free_from_pool(dev, phys, size, swiotlb_pool);
> +	else
> +		dma_free_contiguous(dev, page, size);
>  }
>  
>  #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..ac03a6856c2e 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1809,6 +1809,12 @@ bool swiotlb_free(struct device *dev, struct page *page, size_t size)
>  	return true;
>  }
>  
> +void swiotlb_free_from_pool(struct device *dev, phys_addr_t tlb_addr, size_t size,
> +		struct io_tlb_pool *pool)

What's the reason to pass the buffer size if it's not used?

Other than that, this patch looks good to me.

Petr T

> +{
> +	swiotlb_release_slots(dev, tlb_addr, pool);
> +}
> +
>  static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  				    struct device *dev)
>  {
