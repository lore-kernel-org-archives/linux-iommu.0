Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09773E0C52
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231884; cv=none; b=kv9FGQNhOSdppCBn8X7hT0EeBIOiqE4hgpERDBD9/z5LfjMqWmd3wi9N/wGYLdCnFfYUEUzPqa+JSzBjZJOQZ0wtl1ZAiEYzUvOYwAClE4ejejcyew7SW67kIxwoAjYjZxc4zQtg6e6cBLyS6eT7rAm0uWwlNj4Q4SjApWehrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231884; c=relaxed/simple;
	bh=rmLt2Zd1Svv94StO58JTVqPThQKGl0ZJLa2inCyuhrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT+gUyvSa2dhwKQul32kaIELt1/l4MHxQHXhkolex/KOAW5GAZatnr05vy4sHhp4VtL8b7umREuPPphtVKpeb+eQz9HxWLJdf3HwehbF2bjda/5greFzZn4/fhgfOviRoGZ0+nj5ULSgm3rimB7+gCL+iYiLKcr+Pu5bMjq7iKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cyQuYyu5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyQuYyu5"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852ef20fe8so61085e9.1
        for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773231879; x=1773836679; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeBGnYAajUaTqEiFUt5o86dxRkDw0LV7oFcPjSzEHkE=;
        b=cyQuYyu5kLlcMxnAsDBJAMr8mhXw/5+Ae/rpwPXMwxw9TV6x8G167xEBF4xmfSUwPT
         Yn+YBPeOO78HFsyxXYd6vj3DLb9eisHvSnWfWK7IOyHipMKU8eCr6kXyqqHV775xZKQx
         B7DibYnmcq1cH67LDrZzV0b/k5uhDP72Obim2mCKo4EsqaZyWUrhP+TLi6+LPJmwVGxJ
         gGeeNLkDzOot+7pea3+KFbN5SOjetkB/qS+4AfgkS7qAaEdBAq4GvwjxNBKHzWi29Mw2
         i8sqRd61O6GfKG+O/fY6GopBl9OSEJMqjXt5dyc0f7vJcc+U9JorzdwQKCd9RVHTfv2m
         7v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773231879; x=1773836679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeBGnYAajUaTqEiFUt5o86dxRkDw0LV7oFcPjSzEHkE=;
        b=t9rE5Pjak+S5X2Kzx6ku1DTIkWkzpKpiVZ4kY+JDgIu35tEcUMFwCmWk4WyEEM/j5m
         6SzolrhdeukzCM1UlnMrB6N9Lg9vl8QEk+lrZn/e5Z+CPBZKZh1RO79ucDfij+JFuwxy
         N/0B5e7P6yAKqrO9YhrIldC+3Ti8QAiey5QNaR6Mu+ACJJfqAmuzgMep4ihsx8ZyXmBg
         QraWhVWZhvqWztadRKp3/Q7Gk+4YmafbBRa1rm8M0yQgHFj2SPrP3WrJ/ZW9sB/+v86u
         R0mjS673tL4ePrWHRRQZUsJ3HYiFVAhXEV8lPX9sGEPLAu84dxOMPH1Dt02yKWAytXXw
         8X/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVO8N8WMEkDxyCKCR2cpgYoG6NU0DYjB7+B5j3CgS9ersrAqhXMLh6ECWyZG6aL2MOhLb1oDw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVeKClQVDR3JM1Td2najOxif+YHpwT9su3FvJ/4XpYeQzqkw3Q
	/br2glJrcRgA39bdgA6IUPp4As54cZtMLCo4qf7uAKLp3wczdvJm2sBwjs7C4X2YuA==
X-Gm-Gg: ATEYQzyAnRbPXK0VvoH+AV/1e2baLSaF96cZ/NORssKTdW61Oyvez60MOSlUwjHHycy
	yalu6d/MLOUJsGLbfLWBAFYR0L1lgujca+ADNb5v6ZcJDcSa/sUz2Z9dSbwx4kVK9UjG/n1BNS/
	AY0SuG/rhq6BolSrddCzDiJ5WoJhDJH7FRWaeFZaADIaQN1zguxCtOjicGW9lPXHPtPRERFPnG1
	O7VfuWHuWafN5jipDxsA/4z6FlRyfPSFngx+ySf8q5QCrIDyKjW897P8lr5GJCWol8ZhzrBkm8S
	oAABwOapPd/Si0tt/CIP0T92iYhHWFCu6GHFvJlzRxRvdKn1S58RkNrkWwNvhu2EWjC/gzo3zqs
	arpzgvsLhMNldtS6dZHqMFv6vUKNJYCGJwHpMl4hOTf6kvlPyscMclBhK+e/xfM9XMuFgmsvZSh
	urdm5a14sf3W/xI8UUQFcv0pH97LwmJayAL1+QmZvBq2/14T5NcbOcAHYE
X-Received: by 2002:a05:600d:8446:10b0:477:86fd:fb47 with SMTP id 5b1f17b1804b1-48549e6f504mr699505e9.8.1773231878612;
        Wed, 11 Mar 2026 05:24:38 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81f1318sm7153025f8f.21.2026.03.11.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:24:37 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:24:33 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
Subject: Re: [PATCH v2 4/4] dma: direct: set decrypted flag for remapped dma
 allocations
Message-ID: <abFfAQp2arV9eoae@google.com>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-5-aneesh.kumar@kernel.org>
 <5820e8f3-9cf8-423f-89df-0df7ca78a84b@arm.com>
 <yq5ams39txvk.fsf@kernel.org>
 <yq5abjjl4o0j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5abjjl4o0j.fsf@kernel.org>

On Fri, Dec 26, 2025 at 02:29:24PM +0530, Aneesh Kumar K.V wrote:
> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
> 
> > Suzuki K Poulose <suzuki.poulose@arm.com> writes:
> >
> >> On 21/12/2025 16:09, Aneesh Kumar K.V (Arm) wrote:
> >>> Devices that are DMA non-coherent and need a remap were skipping
> >>> dma_set_decrypted(), leaving buffers encrypted even when the device
> >>> requires unencrypted access. Move the call after the remap
> >>> branch so both paths mark the allocation decrypted (or fail cleanly)
> >>> before use.
> >>> 
> >>> Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
> >>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >>> ---
> >>>   kernel/dma/direct.c | 8 +++-----
> >>>   1 file changed, 3 insertions(+), 5 deletions(-)
> >>> 
> >>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >>> index 3448d877c7c6..a62dc25524cc 100644
> >>> --- a/kernel/dma/direct.c
> >>> +++ b/kernel/dma/direct.c
> >>> @@ -271,9 +271,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >>>   	if (remap) {
> >>>   		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
> >>>   
> >>> -		if (force_dma_unencrypted(dev))
> >>> -			prot = pgprot_decrypted(prot);
> >>
> >> This would be problematic, isn't it ? We don't support decrypted on a
> >> vmap area for arm64. If we move this down, we might actually use the
> >> vmapped area. Not sure if other archs are fine with "decrypting" a
> >> "vmap" address.
> >>
> >> If we map the "vmap" address with pgprot_decrypted, we could go ahead
> >> and further map the linear map (i.e., page_address(page)) decrypted
> >> and get everything working.
> >
> > We still have the problem w.r.t free
> >
> > dma_direct_free():
> >
> > 	if (is_vmalloc_addr(cpu_addr)) {
> > 		vunmap(cpu_addr);
> > 	} else {
> > 		if (dma_set_encrypted(dev, cpu_addr, size))
> > 			return;
> > 	}
> >
> 
> How about the below change? 
> 
> commit 8261c528961c6959b85de87c5659ce9081dc85b7
> Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Date:   Fri Dec 19 14:46:20 2025 +0530
> 
>     dma: direct: set decrypted flag for remapped DMA allocations
>     
>     Devices that are DMA non-coherent and require a remap were skipping
>     dma_set_decrypted(), leaving DMA buffers encrypted even when the device
>     requires unencrypted access. Move the call after the if (remap) branch
>     so that both direct and remapped allocation paths correctly mark the
>     allocation as decrypted (or fail cleanly) before use.
>     
>     If CMA allocations return highmem pages, treat this as an allocation
>     error so that dma_direct_alloc() falls back to the standard allocation
>     path. This is required because some architectures (e.g. arm64) cannot
>     mark vmap addresses as decrypted, and highmem pages necessarily require
>     a vmap remap. As a result, such allocations cannot be safely marked
>     unencrypted for DMA.
>     
>     Other architectures (e.g. x86) do not have this limitation, but instead
>     of making this architecture-specific, I have made the restriction apply
>     when the device requires unencrypted DMA access. This was done for
>     simplicity,
>     
>     Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
>     Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Are there any cases this happened in CCA, the only cases I can see
remap is true are:
- PageHighMem(): Where that fails for CCA
- !dev_is_dma_coherent(): AFAIK, all devices with CCA must have an
  SMMU, so direct DMA is only for virtualized devices which cannot
  be incoherent.

Thanks,
Mostafa

> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 7c0b55ca121f..811de37ad81c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -264,6 +264,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * remapped to return a kernel virtual address.
>  	 */
>  	if (PageHighMem(page)) {
> +		/*
> +		 * Unencrypted/shared DMA requires a linear-mapped buffer
> +		 * address to look up the PFN and set architecture-required PFN
> +		 * attributes. This is not possible with HighMem, so return
> +		 * failure.
> +		 */
> +		if (force_dma_unencrypted(dev))
> +			goto out_free_pages;
> +
>  		remap = true;
>  		set_uncached = false;
>  	}
> @@ -284,7 +293,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  			goto out_free_pages;
>  	} else {
>  		ret = page_address(page);
> -		if (dma_set_decrypted(dev, ret, size))
> +	}
> +
> +	if (force_dma_unencrypted(dev)) {
> +		void *lm_addr;
> +
> +		lm_addr = page_address(page);
> +		if (set_memory_decrypted((unsigned long)lm_addr, PFN_UP(size)))
>  			goto out_leak_pages;
>  	}
>  
> @@ -349,8 +364,16 @@ void dma_direct_free(struct device *dev, size_t size,
>  	} else {
>  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
>  			arch_dma_clear_uncached(cpu_addr, size);
> -		if (dma_set_encrypted(dev, cpu_addr, size))
> +	}
> +
> +	if (force_dma_unencrypted(dev)) {
> +		void *lm_addr;
> +
> +		lm_addr = phys_to_virt(dma_to_phys(dev, dma_addr));
> +		if (set_memory_encrypted((unsigned long)lm_addr, PFN_UP(size))) {
> +			pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
>  			return;
> +		}
>  	}
>  
>  	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
