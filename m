Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0442DA76C
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680858; cv=none; b=mYZ8P8Lvvdf5f5lcv1qfAwwY+RvVR5Tv1wlCAkYDdJ7oh5ggthCYOS6ojo1IhhXTqaJ7ABInR6+pvFszHlgvRkUwY5HbqPpeRHGTbkufeowt8Di1QPLCNo2IdQrgh3NkMU7hEp2M1GrwCcImxNuS8NkmTypgkqA3r/UVb+0FE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680858; c=relaxed/simple;
	bh=tA4mj49GBz7QICtMHah6T45obMxtc0nvPifveZaEvg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpdnIT6ZEmVavdTHPfHsabW3jSudHMfSthXFUJLc3F0NqvbnT+gJJ2AoxFXLRvD7AuUJ3Nudgh9Wo33kDcLAZFRyV5e1+DHtDWfTfaSYioy1/ubHDUmwilk4YzHuyMNYj5LIl0RO2p12tHqcQwhAFnzjI9Q3n2DXGlZFILa7lBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGok1W81; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGok1W81"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso2925e9.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778680855; x=1779285655; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ohb7c2CR8w1L87LMNGtcWIBqhE/iWnrcXRwZ5bjEG7Y=;
        b=lGok1W81gOkT2+uZrAKbjwk1JYUr8bqR9xfCJVmE/r9nQ56Pu048lsRuWGoqzWE+lR
         eIj3Jcd//fPL3TMBQ3yqnNUN8FhlNySotl6BxksEssYfE2ff6RYA0wjoUgicfO+nMRvl
         blDY3txEhq3CC6v/Kg9fqo4tcO0HFI4uF3GSmSQqTtHnA0orFXc22XQ0jJohUoFW9C9r
         PUzdJC2UIPgtf3arusYkT6CHpTFDT3DvwPps8O0pLYZk8wcGz0Cm/kISwGoSQ/D3Vx17
         w/EREUUmWpmg/wMkFH+6YsKSMkOR6iyTjqqLQFtsDQ2VAMJhtCNfWx30GuTLMDNfrO56
         LvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680855; x=1779285655;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohb7c2CR8w1L87LMNGtcWIBqhE/iWnrcXRwZ5bjEG7Y=;
        b=oeHFiqE1wYlZGezlphwaXo3mItc/PMkJrHQssWA/i4YuKtJQIlpENwgqPQ+l89Cgk6
         rbZzVKoAeCF6tofNPf89Mb99MyM5ltM4pQyUc/hIwMaNHe/udF2pyCLDykn/UAzX5fQ0
         70xc8j3asfsahF8nFD0ze/INF/U95vdrVEPv9CV28nB1S+hrfpKo/yaGychyLj4I0lnu
         nxW10m1GJfi3cIEGaG/YsNfQqNkyCOp+ok9Fg3/SfjVs1ShM4A8ZrOKxCB473R9IC/+4
         yM58YbOmbyDqgX2Phi9qL4d9OwDhwVTdu6STPZSTH1mJPaHWqrNEGZoFBNPdmgsX6jzx
         AxBQ==
X-Gm-Message-State: AOJu0YwuhjmEMINFOVHxKhY5v2j6d+sZTNQ2I6D7+SXIu8zB24RG83kM
	6Vs6sH6vJN5btCKfGJRNRQPjYsjAMfQxm/jD859V0UQjCmZd44JtIOTy+0eiEdQ2SQ==
X-Gm-Gg: Acq92OG392vs2JSWlv4kXvVo9T5j5F8p1W6hi5F/bI3mA4VDPWmTy2SUTM2ai5iOPNY
	V8vYkKPGvzBnFcpGDTOWfZhzVss2KYH+WwBDjKvD/l187GMwIF8QXSvzryx/2Fl+0SVC5SX/ZQQ
	OWrDAV4QV7qDvdi2Jw97qEZHhHzsQ1+bComqlZPacgRnYR+UU2e4Q62NGp7CvTQT/HSjAlmKZQU
	IXQ54ofkGT0o6Ee6w1Muh7tpepO92c/zHywl9JvPpubi9BfjSiuI8E55BDYy04ONxzIg+SNr4aM
	oaytUL/OnRZGAmkGHmsVfficXNa9YircSzu4eCNJ7pT8MZAqMIOfyfRPAG9UB4eGDNczp6P8pJu
	wMbDBo2xxVdJmTcfSZDmghffJKyl+QpEkJ9PbGAAj/kWBSN/Vn3oVOSG59U468//MjfeLxM2ete
	NV+szNyIpbhSRV0QFHX+lE8MqR7IP8RVtgtiRtyCMPxiu2zp3KrKN/vcor4sH+1XhmhAQ=
X-Received: by 2002:a05:600c:a011:b0:489:1adc:f017 with SMTP id 5b1f17b1804b1-48fcacd087dmr1010345e9.5.1778680854415;
        Wed, 13 May 2026 07:00:54 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454913049ecsm39669111f8f.19.2026.05.13.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 07:00:53 -0700 (PDT)
Date: Wed, 13 May 2026 14:00:47 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 03/13] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <agSED6BdSXBhbDYI@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-4-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512090408.794195-4-aneesh.kumar@kernel.org>

On Tue, May 12, 2026 at 02:33:58PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach the atomic DMA pool code to distinguish between encrypted and
> decrypted pools, and make pool allocation select the matching pool based
> on DMA attributes.
> 
> Introduce a dma_gen_pool wrapper that records whether a pool is
> decrypted, initialize that state when the atomic pools are created, and
> use it when expanding and resizing the pools.  Update dma_alloc_from_pool()
> to take attrs and skip pools whose encrypted/decrypted state does not
> match DMA_ATTR_CC_SHARED.  Update dma_free_from_pool() accordingly.
> 
> Also pass DMA_ATTR_CC_SHARED from the swiotlb atomic allocation path
> so decrypted swiotlb allocations are taken from the correct atomic pool.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/dma-iommu.c   |   2 +-
>  include/linux/dma-map-ops.h |   2 +-
>  kernel/dma/direct.c         |  11 ++-
>  kernel/dma/pool.c           | 163 +++++++++++++++++++++++-------------
>  kernel/dma/swiotlb.c        |   7 +-
>  5 files changed, 122 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 54d96e847f16..c2595bee3d41 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1673,7 +1673,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
>  	    !gfpflags_allow_blocking(gfp) && !coherent)
>  		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> -					       gfp, NULL);
> +					   gfp, attrs, NULL);
>  	else
>  		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
>  	if (!cpu_addr)
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 6a1832a73cad..696b2c3a2305 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -212,7 +212,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size, pgprot_t prot,
>  void dma_common_free_remap(void *cpu_addr, size_t size);
>  
>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> -		void **cpu_addr, gfp_t flags,
> +		void **cpu_addr, gfp_t flags, unsigned long attrs,
>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
>  bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>  
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 0c2e1f8436ce..dc2907439b3d 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -162,7 +162,7 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>  }
>  
>  static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp)
> +		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	struct page *page;
>  	u64 phys_limit;
> @@ -172,7 +172,8 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>  		return NULL;
>  
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
> +	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
> +				   dma_coherent_ok);
>  	if (!page)
>  		return NULL;
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> @@ -261,7 +262,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>  	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> +						  gfp, attrs);
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size);
> @@ -397,7 +399,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		attrs |= DMA_ATTR_CC_SHARED;
>  
>  	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> +						  gfp, attrs);
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size);
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 2b2fbb709242..75f0eba48a23 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -12,12 +12,18 @@
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> +#include <linux/cc_platform.h>
>  
> -static struct gen_pool *atomic_pool_dma __ro_after_init;
> +struct dma_gen_pool {
> +	bool unencrypted;
> +	struct gen_pool *pool;
> +};
> +
> +static struct dma_gen_pool atomic_pool_dma __ro_after_init;
>  static unsigned long pool_size_dma;
> -static struct gen_pool *atomic_pool_dma32 __ro_after_init;
> +static struct dma_gen_pool atomic_pool_dma32 __ro_after_init;
>  static unsigned long pool_size_dma32;
> -static struct gen_pool *atomic_pool_kernel __ro_after_init;
> +static struct dma_gen_pool atomic_pool_kernel __ro_after_init;
>  static unsigned long pool_size_kernel;
>  
>  /* Size can be defined by the coherent_pool command line */
> @@ -76,7 +82,7 @@ static bool cma_in_zone(gfp_t gfp)
>  	return true;
>  }
>  
> -static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
> +static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
>  			      gfp_t gfp)
>  {
>  	unsigned int order;
> @@ -113,12 +119,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>  	 * shrink so no re-encryption occurs in dma_direct_free().
>  	 */
> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> +	if (dma_pool->unencrypted) {
> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
>  				   1 << order);
> -	if (ret)
> -		goto remove_mapping;
> -	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
> -				pool_size, NUMA_NO_NODE);
> +		if (ret)
> +			goto remove_mapping;
> +	}
> +
> +	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
> +				page_to_phys(page), pool_size, NUMA_NO_NODE);
>  	if (ret)
>  		goto encrypt_mapping;
>  
> @@ -126,11 +135,15 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	return 0;
>  
>  encrypt_mapping:
> -	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (WARN_ON_ONCE(ret)) {
> -		/* Decrypt succeeded but encrypt failed, purposely leak */
> -		goto out;
> +	if (dma_pool->unencrypted) {
> +		int rc;
> +
> +		rc = set_memory_encrypted((unsigned long)page_to_virt(page),
> +					  1 << order);
> +		if (WARN_ON_ONCE(rc)) {
> +			/* Decrypt succeeded but encrypt failed, purposely leak */
> +			goto out;
> +		}
>  	}
>  remove_mapping:
>  #ifdef CONFIG_DMA_DIRECT_REMAP
> @@ -142,46 +155,52 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	return ret;
>  }
>  
> -static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
> +static void atomic_pool_resize(struct dma_gen_pool *dma_pool, gfp_t gfp)
>  {
> -	if (pool && gen_pool_avail(pool) < atomic_pool_size)
> -		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
> +	if (dma_pool->pool && gen_pool_avail(dma_pool->pool) < atomic_pool_size)
> +		atomic_pool_expand(dma_pool, gen_pool_size(dma_pool->pool), gfp);
>  }
>  
>  static void atomic_pool_work_fn(struct work_struct *work)
>  {
>  	if (IS_ENABLED(CONFIG_ZONE_DMA))
> -		atomic_pool_resize(atomic_pool_dma,
> +		atomic_pool_resize(&atomic_pool_dma,
>  				   GFP_KERNEL | GFP_DMA);
>  	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> -		atomic_pool_resize(atomic_pool_dma32,
> +		atomic_pool_resize(&atomic_pool_dma32,
>  				   GFP_KERNEL | GFP_DMA32);
> -	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
> +	atomic_pool_resize(&atomic_pool_kernel, GFP_KERNEL);
>  }
>  
> -static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
> -						      gfp_t gfp)
> +static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen_pool *dma_pool,
> +		size_t pool_size, gfp_t gfp)
>  {
> -	struct gen_pool *pool;
>  	int ret;
>  
> -	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> -	if (!pool)
> +	dma_pool->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
> +	if (!dma_pool->pool)
>  		return NULL;
>  
> -	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
> +	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL);
> +
> +	/* if platform is using memory encryption atomic pools are by default decrypted. */
> +	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +		dma_pool->unencrypted = true;
> +	else
> +		dma_pool->unencrypted = false;

I believe that’s a good start, although we might need to have more
fine grained policies in the future as CC guests might need
encrypted pools

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

>  
> -	ret = atomic_pool_expand(pool, pool_size, gfp);
> +	ret = atomic_pool_expand(dma_pool, pool_size, gfp);
>  	if (ret) {
> -		gen_pool_destroy(pool);
> +		gen_pool_destroy(dma_pool->pool);
> +		dma_pool->pool = NULL;
>  		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
>  		       pool_size >> 10, &gfp);
>  		return NULL;
>  	}
>  
>  	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
> -		gen_pool_size(pool) >> 10, &gfp);
> -	return pool;
> +		gen_pool_size(dma_pool->pool) >> 10, &gfp);
> +	return dma_pool;
>  }
>  
>  #ifdef CONFIG_ZONE_DMA32
> @@ -207,21 +226,22 @@ static int __init dma_atomic_pool_init(void)
>  
>  	/* All memory might be in the DMA zone(s) to begin with */
>  	if (has_managed_zone(ZONE_NORMAL)) {
> -		atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
> -						    GFP_KERNEL);
> -		if (!atomic_pool_kernel)
> +		__dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size, GFP_KERNEL);
> +		if (!atomic_pool_kernel.pool)
>  			ret = -ENOMEM;
>  	}
> +
>  	if (has_managed_dma()) {
> -		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA);
> -		if (!atomic_pool_dma)
> +		__dma_atomic_pool_init(&atomic_pool_dma, atomic_pool_size,
> +				       GFP_KERNEL | GFP_DMA);
> +		if (!atomic_pool_dma.pool)
>  			ret = -ENOMEM;
>  	}
> +
>  	if (has_managed_dma32) {
> -		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA32);
> -		if (!atomic_pool_dma32)
> +		__dma_atomic_pool_init(&atomic_pool_dma32, atomic_pool_size,
> +				       GFP_KERNEL | GFP_DMA32);
> +		if (!atomic_pool_dma32.pool)
>  			ret = -ENOMEM;
>  	}
>  
> @@ -230,19 +250,44 @@ static int __init dma_atomic_pool_init(void)
>  }
>  postcore_initcall(dma_atomic_pool_init);
>  
> -static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
> +static inline struct dma_gen_pool *__dma_guess_pool(struct dma_gen_pool *first,
> +		struct dma_gen_pool *second, struct dma_gen_pool *third)
> +{
> +	if (first->pool)
> +		return first;
> +	if (second && second->pool)
> +		return second;
> +	if (third && third->pool)
> +		return third;
> +	return NULL;
> +}
> +
> +static inline struct dma_gen_pool *dma_guess_pool(struct dma_gen_pool *prev,
> +		gfp_t gfp)
>  {
> -	if (prev == NULL) {
> +	if (!prev) {
>  		if (gfp & GFP_DMA)
> -			return atomic_pool_dma ?: atomic_pool_dma32 ?: atomic_pool_kernel;
> +			return __dma_guess_pool(&atomic_pool_dma,
> +						&atomic_pool_dma32,
> +						&atomic_pool_kernel);
> +
>  		if (gfp & GFP_DMA32)
> -			return atomic_pool_dma32 ?: atomic_pool_dma ?: atomic_pool_kernel;
> -		return atomic_pool_kernel ?: atomic_pool_dma32 ?: atomic_pool_dma;
> +			return __dma_guess_pool(&atomic_pool_dma32,
> +						&atomic_pool_dma,
> +						&atomic_pool_kernel);
> +
> +		return __dma_guess_pool(&atomic_pool_kernel,
> +					&atomic_pool_dma32,
> +					&atomic_pool_dma);
>  	}
> -	if (prev == atomic_pool_kernel)
> -		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
> -	if (prev == atomic_pool_dma32)
> -		return atomic_pool_dma;
> +
> +	if (prev == &atomic_pool_kernel)
> +		return __dma_guess_pool(&atomic_pool_dma32,
> +					&atomic_pool_dma, NULL);
> +
> +	if (prev == &atomic_pool_dma32)
> +		return __dma_guess_pool(&atomic_pool_dma, NULL, NULL);
> +
>  	return NULL;
>  }
>  
> @@ -272,16 +317,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
>  }
>  
>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> -		void **cpu_addr, gfp_t gfp,
> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>  {
> -	struct gen_pool *pool = NULL;
> +	struct dma_gen_pool *dma_pool = NULL;
>  	struct page *page;
>  	bool pool_found = false;
>  
> -	while ((pool = dma_guess_pool(pool, gfp))) {
> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
> +
> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> +			continue;
> +

nit: If we fail to find a matching pool, a slightly misleading message
is printed as pool_found = false

>  		pool_found = true;
> -		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
> +		page = __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
>  					     phys_addr_ok);
>  		if (page)
>  			return page;
> @@ -296,12 +345,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>  
>  bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>  {
> -	struct gen_pool *pool = NULL;
> +	struct dma_gen_pool *dma_pool = NULL;
> +
> +	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
>  
> -	while ((pool = dma_guess_pool(pool, 0))) {
> -		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
> +		if (!gen_pool_has_addr(dma_pool->pool, (unsigned long)start, size))
>  			continue;
> -		gen_pool_free(pool, (unsigned long)start, size);
> +
> +		gen_pool_free(dma_pool->pool, (unsigned long)start, size);
>  		return true;
>  	}
>  
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..ab4eccbaa076 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -612,6 +612,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  		u64 phys_limit, gfp_t gfp)
>  {
>  	struct page *page;
> +	unsigned long attrs = 0;
>  
>  	/*
>  	 * Allocate from the atomic pools if memory is encrypted and
> @@ -623,8 +624,12 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>  			return NULL;
>  
> +		/* swiotlb considered decrypted by default */
> +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
> +			attrs = DMA_ATTR_CC_SHARED;
> +
>  		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> -					   dma_coherent_ok);
> +					   attrs, dma_coherent_ok);
>  	}
>  
>  	gfp &= ~GFP_ZONEMASK;
> -- 
> 2.43.0
> 
