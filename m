Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9E3D2FFC
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248724; cv=none; b=lzX0ainrzD0JV0cEO6+Zgd1heOSJT0ESauYNkRi2Oa/+asFRuhXuoMGfSHq3T0Bd6cQDab2lfPTqoVbkyCs9zTekT9dhIgVoeamHoZqFR8F6iR+8j2f/ui80wDY46TYw/Hx+3liRkrM+dhKFtFOapdB5hWFlWQWB9RcMY4F7j8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248724; c=relaxed/simple;
	bh=egNeZU/QDoq/vLDQYCkE07iRqxJcGDGKBgWjXVKB+qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGjYWN7y3miQAxHhlExndytW3No/4IULfRPFCkur074bCOTeDbcWxsNz15vnewFvSSB0qfE7jfhTU7efD819cDndHsxNT6EmQZfIaPMIotvjJIZ3LA/mC0p0XY+tJW4Cl45flvTouWOuQQG7PUn5ScTT6RUVRKM7r80TIcQT3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twwtlI4T; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twwtlI4T"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954d5d814fso69885e9.0
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248721; x=1785853521; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hhyo6VG61tN8AV0h0asytp+Vqc/+CnuTmYLnyeoXGkw=;
        b=twwtlI4Tgemla1m3Eh7ALe+MTDB7Ox7En2VqNZRokpWuzNJvl2F5m5q71bSK09nqrs
         y1C7+0529M4+/Xmrzd9Q1rpPLqIBMOQqDrvtTwYGa+xUbmTApc3wrx+G/EBL1gdgSJpV
         XscaPHF9S+Ubtv/7xMfkuxCNDUBCSzJEUON3DPUYhmVdpOgZUMQGFqbi6CM2Ol49dzN6
         ak8jNqI4ueN/6/xoXo6lsqiaS5tIl7N+NwBidcmlzdvnydesOFdtSfo8xRpxuMrOjiH0
         8o5xdhuXX+EsZbwbC+2nVlMUSeTcDSln+CqHQFiP6PKuUYdg/e5iwNp/zdN0IW2AbXvk
         zSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248721; x=1785853521;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hhyo6VG61tN8AV0h0asytp+Vqc/+CnuTmYLnyeoXGkw=;
        b=Bh/DEaWCiEZr3esA7MFVvGeIBnmiaGhIQ555SoLO6rKbHSfE9bXKzG5bS9/2CSnVIE
         3vYAYtL0BVIMBGPrjoFAfWV2j41T71bZLYi5qyKKYeKsxT6NZT4C+A1oF/hCQHo/aPRe
         Oo3R8DH6Y3Fvd9/apb4+x18HyzFVejNPVY9hFvfhaJ7cnjwzjmR71uQByL6sYplfIQjr
         sNurV8Y0bkhJv3di7OTUAuBmKGRu9tiMQvl6LzX8IK8OtpUrEtRQUNkjjN+KT9/ufW0e
         CRN7aTWO8bEPIkrsegKSdNtfv8b7TIHfka7SEtVl7qIe2gJh2bUlh8d0FOQCW1nvU61c
         dIVw==
X-Gm-Message-State: AOJu0YxvxIYI1fk0n8uvNU29kL1PsaA5tqFZ73ebG/4jOUG2v4Tbt/ko
	7Oi5oBwNyAZhQCsB5hnI4xq/PtCEHt0Hz1pCvTGUl2w5YGblBRo+GAw9fckMrSDOPA==
X-Gm-Gg: AR+sD11/s5E2aNHhsBgdhDB62qqW5EaC3YhFuf2x7avLyZwWNNziAVqIyBiCgiKhcMK
	kIvZyyAfZ3I/OFjGQDOKfLX3WI1Rdpj4PgNSgHT18Wqnnrol5+79G08cuhyOR5jO+Nwcmht+/L7
	oZ9udFkHCK+zcumgADdos/3zG3eIRrEObsqs/qlfIUtjA04Hprd0MdfxQE3DqG7xQ2X9wwvpJIo
	dWlDT5OmGq6mSj61bzNrNyjfii3yXt/5udn0qdK7IrsinXXN/sSUYjLUh66JX4Y23rJdgZFF4Ka
	McFeFi45QPj90fuCguohezimU3Ft7Et+zxB9f98iesIazJAp07nIvzWu61DpN0ADKIMBpzcdhb5
	KtoKStI6gRZ9bpvjpIgi5ICjQPWaB2zwEPdNmlRapMGcb1E8qRlk+W/2LdsflbR6DRSjihlibbG
	XT1l9E5REZTb6xR+L6+/3BzjTdGFAOp7QaK+wzcxN68Ss=
X-Received: by 2002:a05:600c:6a8d:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-496b4d2f236mr4342575e9.6.1785248720307;
        Tue, 28 Jul 2026 07:25:20 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45e0424sm84654015e9.13.2026.07.28.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:25:19 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:25:11 +0000
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 05/23] swiotlb: Preserve allocation virtual address
 for dynamic pools
Message-ID: <ami7x9uXfRLmjVhK@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-6-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-6-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:23PM +0530, Aneesh Kumar K.V (Arm) wrote:
> swiotlb_alloc_tlb() can allocate from the DMA atomic pool when a decrypted
> pool is needed from atomic context. With CONFIG_DMA_DIRECT_REMAP, the
> atomic pool is backed by remapped virtual addresses, which are not the same
> as the direct-map addresses returned by phys_to_virt().
> 
> swiotlb_init_io_tlb_pool() currently reconstructs the pool virtual address
> from the physical start address. For atomic-pool backed allocations this
> stores the wrong address in pool->vaddr. Later, swiotlb_free_tlb() passes
> that address to dma_free_from_pool(), which will fail to recognize the
> chunk
> 
> Pass the virtual address returned by the allocation path into
> swiotlb_init_io_tlb_pool(), and store that address in pool->vaddr. This
> keeps the pool free path using the same virtual address as the allocator.
> 
> Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  kernel/dma/swiotlb.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1abd3e6146f4..6e8db52866bf 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -266,9 +266,9 @@ void __init swiotlb_update_mem_attributes(void)
>  }
>  
>  static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
> -		unsigned long nslabs, bool late_alloc, unsigned int nareas)
> +		void *vaddr, unsigned long nslabs, bool late_alloc,
> +		unsigned int nareas)
>  {
> -	void *vaddr = phys_to_virt(start);
>  	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
>  
>  	mem->nslabs = nslabs;
> @@ -409,7 +409,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		return;
>  	}
>  
> -	swiotlb_init_io_tlb_pool(mem, __pa(tlb), nslabs, false, nareas);
> +	swiotlb_init_io_tlb_pool(mem, __pa(tlb), tlb, nslabs, false, nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
>  	if (flags & SWIOTLB_VERBOSE)
> @@ -507,7 +507,7 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  
>  	set_memory_decrypted((unsigned long)vstart,
>  			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
> -	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
> +	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), vstart, nslabs, true,
>  				 nareas);
>  	add_mem_pool(&io_tlb_default_mem, mem);
>  
> @@ -605,25 +605,26 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
>   * @bytes:	Size of the buffer.
>   * @phys_limit:	Maximum allowed physical address of the buffer.
>   * @gfp:	GFP flags for the allocation.
> + * @vaddr:	Receives the virtual address for the allocated buffer.
>   *
>   * Return: Allocated pages, or %NULL on allocation failure.
>   */
>  static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
> -		u64 phys_limit, gfp_t gfp)
> +		u64 phys_limit, gfp_t gfp, void **vaddr)
>  {
>  	struct page *page;
>  
> +	*vaddr = NULL;
> +
>  	/*
>  	 * Allocate from the atomic pools if memory is encrypted and
>  	 * the allocation is atomic, because decrypting may block.
>  	 */
>  	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
> -		void *vaddr;
> -
>  		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
>  			return NULL;
>  
> -		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
> +		return dma_alloc_from_pool(dev, bytes, vaddr, gfp,
>  					   dma_coherent_ok);
>  	}
>  
> @@ -645,6 +646,8 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
>  			return NULL;
>  	}
>  
> +	if (page)
> +		*vaddr = phys_to_virt(page_to_phys(page));
>  	return page;
>  }
>  
> @@ -685,6 +688,7 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  {
>  	struct io_tlb_pool *pool;
>  	unsigned int slot_order;
> +	void *tlb_vaddr;
>  	struct page *tlb;
>  	size_t pool_size;
>  	size_t tlb_size;
> @@ -701,7 +705,8 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	pool->areas = (void *)pool + sizeof(*pool);
>  
>  	tlb_size = nslabs << IO_TLB_SHIFT;
> -	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
> +	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp,
> +					 &tlb_vaddr))) {
>  		if (nslabs <= minslabs)
>  			goto error_tlb;
>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
> @@ -715,11 +720,12 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
>  	if (!pool->slots)
>  		goto error_slots;
>  
> -	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), nslabs, true, nareas);
> +	swiotlb_init_io_tlb_pool(pool, page_to_phys(tlb), tlb_vaddr, nslabs,
> +				 true, nareas);
>  	return pool;
>  
>  error_slots:
> -	swiotlb_free_tlb(page_address(tlb), tlb_size);
> +	swiotlb_free_tlb(tlb_vaddr, tlb_size);
>  error_tlb:
>  	kfree(pool);
>  error:
> @@ -1851,7 +1857,8 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
>  
>  		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
>  				     rmem->size >> PAGE_SHIFT);
> -		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
> +		swiotlb_init_io_tlb_pool(pool, rmem->base, phys_to_virt(rmem->base),
> +					 nslabs,
>  					 false, nareas);
>  		mem->force_bounce = true;
>  		mem->for_alloc = true;
> -- 
> 2.43.0
> 
