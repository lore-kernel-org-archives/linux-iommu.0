Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892132D94AF
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 13:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680734; cv=none; b=FtqJIadZEjCj82RzzfxF+qsUJJABnnUaRZmXjnhmJdky27pZ3Bxu14EGN6mZINwK/jzFL74t6IyKumcS3+xGNGYfb9qVme99dyMlu2y5WxA22l9e891GQoN1i0G1iLQrxEczl7FQ5h5jqr2Q+4ngxnU/w+nMyGcgKIBslNkYAEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680734; c=relaxed/simple;
	bh=VgIxgGXl3Ha/Ri0FMajjsfOQaiUiAXPug9JjQfnZm8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1IMoGf9slTwQA0qR9sACFYVZMxoL6ihiMp4YV6TSA97WdofrtTRay040e7/GPtA5csq1El9Vu0GBA84FgEWvVH31CqLCxDa58Y9hoI6xiYejVWrngdT4FmRR36Jjeh59Ecrq7fSE/57zuMiQaUdaMVlp7tSuhLFRXJ6Kv+d9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5cu64V5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5cu64V5"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso2445e9.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 06:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778680729; x=1779285529; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tPMVkSo7vb48jv7YwJ0Vd+mCEf6970EXP9V58QWiGq0=;
        b=l5cu64V5nMlFCZThuci8fn/PIno4gVlw/7ubkqqvSPTZySGopnZ+Gt1CGU+Emar/+0
         dE+B0lUVZKxke2xXqCYJpSX3kjdmt125BUmEnLsIfe35/wE5nvpKNpy5b6ZrRIotUmTJ
         OI8tE/hK7vVTgkysX13CVtVMqwznVx6bTe3xsV3Zs1LWYppfIMBkGZHvlZTlt6r9d/eP
         /u6v1QQtsLn2DYglN5FJyQ8XNDROSCjhlUTxP2+JDbq8Y66s27UGC01Tq4OEk9L/Dyy2
         qNVWhBzTFzSLVsyGSst8eIjd4/kSljoF4PZbSII3PjFFQhmiUgQFiTz1PtfonCmwZqR8
         JY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680729; x=1779285529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPMVkSo7vb48jv7YwJ0Vd+mCEf6970EXP9V58QWiGq0=;
        b=CzTMK17H0FdLbtScUVnB1q2HaKEhR6x2yovSVXtFYDVODj5M2r81vXW7rJ+ay5W8QB
         Rm40i7N9Ou3LG4qxvqt2iTieEFmWisXHCfE+rGz4ESOqoJFfnKHt4B9ZtiI1Bx1XubRp
         811CsyE09kcMLfB6u+hNner2OVkZ82h/ZIsglIZZyEmzuUwrtsSkmpmtOU5lqrSYztSN
         EHcObQ7Z5y6HBmLWQo2N+CUFsbZ0z+kks0n5MjAS1EPfhcoawVGRu4hgsuw1i4O/Kf26
         BxNq/q98QuEctmfWsQIQlgggsG7FzrzMFKXyH3Tteo3Uyl0TJW139NvHU4ZZSw9ZvorS
         LjFQ==
X-Gm-Message-State: AOJu0Yx0HQ/UnT4v3ba6sGss8j11yTiUw3P6mdmgGjnA8goub9WvCHva
	lYnF80s3sZem5TFmdTK5DlCjv19mb5nEiygOvPfgQ9MA1dL5Dvpo0ESiN4sdzyQJbg==
X-Gm-Gg: Acq92OESfbgjeQeZhAVq7S/QEOnYCWfWKSei1MTwCHZdrPaR4TPSqYvy1+xM1L+KG4E
	S4WIDTeIBJvJxa3p9UhPrEuXmavKHOjP6iGflKPv9H7i/8IPAR6c0W5lqjazt6x3li/Pi1tNEFf
	Fp8QKXVRA5a09SIUB1/3ogzZA4zt4onOHld5E5pk1ZNPsV9vi8lxgt9+ingfsxtGlOMkRSE20dl
	5aeZSsDrK3usrP2tLp9BVIhfWv3JSYrAutWh5CqpVz0UoQIV53Avn4nTP9PDaRVa4qTkNj4pJ7j
	ZaocaywVZcWR5l4SJ94Op+TnWEXV7qeiiI8fN4YrjwZj/TnIVKGzC17bVMsKn2LN5/utyvQzUWf
	taPDKWnRGr38crE0hHZYDvgYCKnAvWTT1a6iN7UAGv6aRXEtDbcep6Aw0LMjp4TVJWxi2yNXCpy
	VdOx3c0Fav1vb6eKz4NtFijIgGms6RIRuvnBzEGCqIF78F4gQi6UZ+ZLTpdwbg/ZkUcNc=
X-Received: by 2002:a05:600c:8a16:10b0:48a:5618:b4d4 with SMTP id 5b1f17b1804b1-48fcacd0d81mr589735e9.1.1778680729194;
        Wed, 13 May 2026 06:58:49 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6cd75sm39576190f8f.16.2026.05.13.06.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:58:48 -0700 (PDT)
Date: Wed, 13 May 2026 13:58:43 +0000
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
Subject: Re: [PATCH v4 02/13] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <agSDk0QsEM0ZBCTA@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512090408.794195-3-aneesh.kumar@kernel.org>

On Tue, May 12, 2026 at 02:33:57PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Propagate force_dma_unencrypted() into DMA_ATTR_CC_SHARED in the
> dma-direct allocation path and use the attribute to drive the related
> decisions.
> 
> This updates dma_direct_alloc(), dma_direct_free(), and
> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index b958f150718a..0c2e1f8436ce 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -201,16 +201,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> -	bool mark_mem_decrypt = true;
> +	bool mark_mem_decrypt = false;
>  	struct page *page;
>  	void *ret;
>  
> +	/*
> +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> +	 * attribute. The direct allocator uses it internally after it has
> +	 * decided that the backing pages must be shared/decrypted, so the
> +	 * rest of the allocation path can consistently select DMA addresses,
> +	 * choose compatible pools and restore encryption on free.
> +	 */
> +	if (attrs & DMA_ATTR_CC_SHARED)
> +		return NULL;
> +
> +	if (force_dma_unencrypted(dev)) {
> +		attrs |= DMA_ATTR_CC_SHARED;
> +		mark_mem_decrypt = true;
> +	}
> +
>  	size = PAGE_ALIGN(size);
>  	if (attrs & DMA_ATTR_NO_WARN)
>  		gfp |= __GFP_NOWARN;
>  
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev))
>  		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
>  
>  	if (!dev_is_dma_coherent(dev)) {
> @@ -244,7 +259,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * Remapping or decrypting memory may block, allocate the memory from
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
> -	if ((remap || force_dma_unencrypted(dev)) &&
> +	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
>  	    dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>  
> @@ -318,11 +333,20 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {
> -	bool mark_mem_encrypted = true;
> +	bool mark_mem_encrypted = false;
>  	unsigned int page_order = get_order(size);
>  
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +	/*
> +	 * if the device had requested for an unencrypted buffer,
> +	 * convert it to encrypted on free
> +	 */
> +	if (force_dma_unencrypted(dev)) {
> +		attrs |= DMA_ATTR_CC_SHARED;
> +		mark_mem_encrypted = true;
> +	}
> +
> +	if (((attrs & (DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_CC_SHARED)) ==
> +	     DMA_ATTR_NO_KERNEL_MAPPING) && !is_swiotlb_for_alloc(dev)) {
>  		/* cpu_addr is a struct page cookie, not a kernel address */
>  		dma_free_contiguous(dev, cpu_addr, size);
>  		return;
> @@ -365,10 +389,14 @@ void dma_direct_free(struct device *dev, size_t size,
>  struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>  {
> +	unsigned long attrs = 0;
>  	struct page *page;
>  	void *ret;
>  
> -	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
> +	if (force_dma_unencrypted(dev))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);

What about dma_direct_free_pages()? Nothing inside uses attrs, but
that’s quite similar to dma_direct_alloc_pages()

Also, at this point, shouldn’t this patch also remove
force_dma_unencrypted() calls from dma_set_decrypted() and
dma_set_encrypted()?

Thanks,
Mostafa

>  
>  	if (is_swiotlb_for_alloc(dev)) {
> -- 
> 2.43.0
> 
