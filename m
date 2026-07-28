Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA64448BB9
	for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248773; cv=none; b=ZBZO0FhbO+7Q7s/oUcapVpt6mTIhowgHWJ9rKwkgqwjOgiOUXVIHSpIu5g5oVG7my/1wZjZN7FfiWOAyheBPmRrGOtcgH20qDy+/2Pd7J9sviv4I+sg9qEd5PMAn+cIcg1NuRvc635tN9Z4T1YGLKk4sXoqjBLsGuRcJ0lntv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248773; c=relaxed/simple;
	bh=kcHzJYFXRY1vN3ZEMF3nRLAjfmrJkH7B2gEfA9eBK5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZIh8tEeUxHBOnRVHN7bJAYEOlJ0FcA5xMPcCXrgNFQAN5v86FxtLLLZHKLsB/Ni/KeifrgymHaIni788UfmSa3kRvfl4TKu1OQKFdcEEwjcSw5A1aACzH0krR2H+NqF092JJQxF/tDbwjdcVWv6DSHhRtnzDLq/aPlIXPb9RqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJhzITze; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJhzITze"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so62295e9.0
        for <iommu@lists.linux.dev>; Tue, 28 Jul 2026 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785248769; x=1785853569; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vpWtv0pYfxndfeslGolf2QwgOrAZhpu3GPmCVKvsSLo=;
        b=bJhzITzevdph98qSJCMEbGe8bjdUHRCuXNmmNBwhEgwR0D1nEQ0YA9d1VP+S38Z/de
         RSC1da3nmVkcJgF2VV1HpwhMCMtoADIq4zB5kGVSuMS4kTxUFPpbwhD0jzdWyBSDByoy
         /zSan0lwYjOWFGOfmVqyheXbOQ8Y6n3y+r0QZazKNZA1nnGkqY4bp8fh4gUoCZM+Iicw
         EeEAyDrjwmSnAOZQ+k2fG8dbE05ytgEa0aJu6RFPNM1dkRv2J9HLXPqAY8ef+UGwdUwi
         YUgXrsaen9UnwbtLt+nQqSYLkMNp05iCbZgyUACwWE6aNoNam0DyJoKEXZ9pjwt0VP1J
         dElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785248769; x=1785853569;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vpWtv0pYfxndfeslGolf2QwgOrAZhpu3GPmCVKvsSLo=;
        b=iz7PcQs4mIFnQlpmYs8HH6Uoi2Hn3AYLhcPY+2twGQciqXCXGEBhFTsRtAx/qjbAEa
         IwTwKGBOTvoJ2fpy9ZQOH6cMUoR11N4eIHvb/7Y09+raWbHjpwGhgkiy+R8/VsaTKT21
         pqhDSTn80OnMIThpj3vQ3vBydJrXcnldHAKgyYhDWYObEWSk6CyEhQYC3DXQqvmn0S3u
         6s8C1Chrhi+8uMjBjk0n86gzfEkG6cDKQEDdTOn3fadrkUMbLlEmDWwo7IjOhcMlVn5O
         vxM9gHXTI9bueIRgWMXX31SfTliP30uV7j1ggolVU1k4oTtg83vqLNZp6MtntQA4Tc5d
         pnXg==
X-Gm-Message-State: AOJu0YzrQHYZytEBriEmHfpP3lxTRYDipb7TA0YcnwJvIxISjK1PUi35
	bKIcbWkr0HfvgmStuyZnUtCmxlcgvHPlF9+P4xmQgEvgck5G50q3OsiuiTwG05rl1g==
X-Gm-Gg: AR+sD101gBlfSdpqXrfmnpEpIBsiFgQvHW7XaalUcEG4+JqDR2u9M+OYtEEd6ABGMtZ
	06XJK/MizmK2CXpZMRd1PwCNgEOkDjnWKEXiMM2z9wziO69YeqDDGyo/X6wxElfAXFIkdAMd5m9
	Vf6Nn4hXNzNIXyGvDNqii3DOMnDEi4S3q+xz1dnPZDu5DK8XIWbbF1L2qtD/6dakwqCRQNm62+h
	DzS9pUWEbqAe2fR7PcmJJaOaEz4qIX5oPLfbQvZ/A+ZEJzPn2R0jcLIB8XX9KqlXnsx+tlbRxge
	dcgWJzKB9x0Oq151x4HraP5y42TFvQjlnBx+7idCZ3PWWohGTE5uAeTiBeU0wZ1Zw5q+TCwjgW8
	MED/3iDa2/jcO8us4zNyOcOLlfCKYqlpphJrFWFxjWB09rFi7aXujiTJ00nkVx9GDn+22RH/NYa
	a+mAsdmZQtw4so6C5/52lcMk7V28wbf0+EV3bgnuNmOEE=
X-Received: by 2002:a05:600c:4583:b0:493:aca0:32e2 with SMTP id 5b1f17b1804b1-496b4cf6c38mr21115e9.4.1785248768109;
        Tue, 28 Jul 2026 07:26:08 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm60556481f8f.11.2026.07.28.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:26:07 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:25:58 +0000
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 09/23] dma-mapping: Add internal shared allocation
 attribute
Message-ID: <ami79lwqbqcaFpqo@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-10-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717180442.110954-10-aneesh.kumar@kernel.org>

On Fri, Jul 17, 2026 at 11:34:27PM +0530, Aneesh Kumar K.V (Arm) wrote:
> DMA_ATTR_CC_SHARED describes an existing DMA mapping whose backing memory
> is already shared, or decrypted, for confidential computing. It is a
> mapping attribute: callers use it to request a shared DMA address encoding
> for memory that has already been prepared for shared DMA.
> 
> Allocation paths need a related but different state. Once the DMA core
> decides that an allocation must use shared backing pages, the lower-level
> allocation helpers need to select shared pools, decrypt newly allocated
> pages, derive the DMA address with the shared-memory translation and
> restore encryption on free. That state is internal to the DMA-mapping
> implementation and should not be passed by drivers to dma_alloc_attrs().
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  Documentation/core-api/dma-attributes.rst | 29 +++++++++++++++++++++++
>  include/linux/dma-mapping.h               |  8 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  3 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 123c8468d58f..eee743184acd 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -179,3 +179,32 @@ interface when building their uAPIs, when possible.
>  
>  It must never be used in an in-kernel driver that only works with
>  kernel memory.
> +
> +DMA_ATTR_CC_SHARED
> +------------------
> +
> +This attribute indicates that a DMA mapping is shared, or decrypted, for
> +confidential computing guests. For normal system memory, the caller must
> +already have marked the memory decrypted with set_memory_decrypted(). CPU
> +PTEs for the mapping must use pgprot_decrypted(), and the same shared
> +semantic may be passed to a vIOMMU when it sets up the IOPTE.
> +
> +This attribute describes an existing mapping. It does not allocate shared
> +backing pages and must not be passed to dma_alloc_attrs(). For MMIO, use
> +this together with DMA_ATTR_MMIO to indicate shared MMIO. Unless
> +DMA_ATTR_MMIO is provided, the mapping requires a struct page.
> +
> +__DMA_ATTR_ALLOC_CC_SHARED
> +--------------------------
> +
> +This is an internal DMA-mapping attribute for confidential computing guests.
> +It is used by allocation paths after the DMA core has determined that the
> +backing pages must be shared, or decrypted. For example, the direct DMA and
> +SWIOTLB allocation paths use it to select shared DMA pools, decrypt newly
> +allocated pages, derive DMA addresses using the shared-memory translation, and
> +restore encryption on free.
> +
> +__DMA_ATTR_ALLOC_CC_SHARED differs from DMA_ATTR_CC_SHARED in that it is not
> +a caller-visible DMA API attribute. DMA_ATTR_CC_SHARED describes an
> +already-shared mapping and requires the caller to have prepared normal
> +system memory before mapping it.
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index cc0823a99cfd..a3e880649fa4 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -103,6 +103,14 @@
>   */
>  #define DMA_ATTR_CC_SHARED	(1UL << 13)
>  
> +/*
> + * __DMA_ATTR_ALLOC_CC_SHARED: Internal DMA-mapping attribute used by
> + * allocation paths that create shared (decrypted) backing pages for
> + * confidential computing guests. Drivers must not pass this attribute to
> + * dma_alloc_attrs().
> + */
> +#define __DMA_ATTR_ALLOC_CC_SHARED	(1UL << 14)
> +
>  /*
>   * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>   * be given to a device to use as a DMA source or target.  It is specific to a
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index 31c9ddf72c9d..9df02c1511de 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -35,7 +35,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>  		{ DMA_ATTR_MMIO, "MMIO" }, \
>  		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
>  		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
> -		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
> +		{ DMA_ATTR_CC_SHARED, "CC_SHARED" }, \
> +		{ __DMA_ATTR_ALLOC_CC_SHARED, "ALLOC_CC_SHARED" })
>  
>  DECLARE_EVENT_CLASS(dma_map,
>  	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
> -- 
> 2.43.0
> 
