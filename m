Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0B140BCDA
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009699; cv=none; b=I4nLp1NYICOWeLtx9YK03MbwMJrgkUzSbkFlwtI7F7+Ky3PPhLL/ac9zFDA/DNFAn5GcTEm4VkzF8rCNixYwsoxkGZRB/TVPB2FNjCg/4GPw8cSCtw/jeK9NIsgCdEQbGwtjABXjjePkweG/GpmgFk5+yQuCaKKXgqeej09MLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009699; c=relaxed/simple;
	bh=OgLNrWHYEcaZ4Zdrui9d0vfhtIPJeVbTPOTGD0Cye5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgEsrTsVjoDHdtO2GKgDguMmSV5QKb7gmc6UmrzmluUfg3wiUN15jLxfw3WjkVcpU7yjfCDeb7IOCiYWmCG8b1yV3pnvsQ5BQL4L927zycSHtHKrbnQ3KgIIDRjDeWqA/5hA/WKO+p28ZCeEq9hJMaciDdNJ9rYdxhp46KfIxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eZmUkvwy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eZmUkvwy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef42b6399so416805f8f.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 05:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781009691; x=1781614491; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkYHspRdfakTgJWTmfOhWR71X/NTXsb3/ZhoDPOxGQs=;
        b=eZmUkvwyGIT/0eRkEpltPjA10MYI+IKpYgstmPlLhB2QnqQWSB0kYQ+bbDgvVXm6mm
         gpqw4KSfcy774bgoc4N5q/JofX0d3PVPNAQbErs5phLXbxli3pVwnzEyEJqwk3nFCRJ+
         i+Lk2Xfx63cAJunPfRyhFINrYyjhTRCx/uV6oQnfElFn9Iek0H8262sAruqO4pVoBik5
         NvS4WDrBlpCE1IxMCxxJBJteKbhCebEns4GScbJ1fy/4KFysY0/vNxnBA+Kg4Ka0Aip6
         gSwBQmdp/YZZf7hbRcJJj5uBq/hoTyHSwpVjUmTOLaKi5q88l5p2kgQEnnHo9EsAS9hJ
         jpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009691; x=1781614491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vkYHspRdfakTgJWTmfOhWR71X/NTXsb3/ZhoDPOxGQs=;
        b=g9H48dZ0DeDaHNpT7nTzGaCKxxbGCyGjZqLgMRG8Y7kgVZzotT+BE9YWJpl4ce/u5n
         tn9M+FhJcWBw/tzI36WWdT/W0JhrUDrR4IgcD+SeSf5gDN0ai9dnGAdFjBjX85qmc/qM
         2HIMxg94FuvZJXB+7ZBkjxHAREoTg9JsRcpkSYHi4E5iBN6HM6yUizN8fi1ttgoAHtXh
         jO9N/Mj3TPrLIfK9ZWhbUDtlqnZ4k+MRcORD2vw6gerQfwKcZ4kY3wT83zVxu/D3EexB
         fi4mWIVaGVDu6lqlxZHeEQ248Vp36s/MO1S5BJsLE/gdksag3R4uMwXvfX3XIVvJCtQ7
         IRlA==
X-Gm-Message-State: AOJu0YxbiJ1pOqOPIFYWpburgZhTifIObR5IqMjQVRD84FnYB/GWzVF7
	/umRd/rupml8/L5+FrWJ9LXlns0C69Pwvu4xW3N0GprbRCbMBJTvoZoO2/J5w27NdrE=
X-Gm-Gg: Acq92OHbC3PqqtydENyFngpRT9+eTclzgfiEdXjZzugy1SgnNLC1od1mxwToasnEyxh
	/mNECA5dEeXczo4Yk9/A44xB7HRZYd8krfHpPBGE+a1jPIMKx1uNP101R2eLP5oyXAqk2qn7aVF
	I4Y0Gw6jnOBZV9pk0uAskaxgwrmbqM49ZgcUXn60kebQrEKOnBsRFnPRFO3S0gDq+yNciv4lKln
	O+F1Hasew3GjFmNP2JuVvifsPJ/QkfIWwelAZHuEmnaAA/qiwEmhNwHCyIMlgZlyNC1xfgoJOVF
	wOEuX2DRbU2SY5nH7RU9XATjXe8rqP0hIYP/UgVlyKkTkKv5VuB4jVc8H98U5ZcyvL+Z6ZXn2Ww
	WqwklsDRJysrzQde8SCN6od+6F1KL/uFfDCg7GngSRTE7TnWTRZi7bQoOP/g2GlThEIMF9aCp8o
	iW+5F14VurKUc2ia1NnZGQsGc=
X-Received: by 2002:a05:6000:4a02:b0:45e:ced1:19c1 with SMTP id ffacd0b85a97d-4603063eee7mr14300728f8f.3.1781009690891;
        Tue, 09 Jun 2026 05:54:50 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc577sm63402978f8f.3.2026.06.09.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:54:50 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:54:45 +0200
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
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 13/20] dma-direct: rename ret to cpu_addr in alloc
 helpers
Message-ID: <20260609145445.6144add4@mordecai>
In-Reply-To: <20260604083959.1265923-14-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-14-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:52 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> ret in dma_direct_alloc() and dma_direct_alloc_pages() holds the returned
> CPU mapping, not a generic return value. Rename it to cpu_addr and update
> the remaining uses to match.
> 
> This makes the allocation paths easier to follow and keeps the local naming
> consistent with what the variable actually represents.
> 
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

I wondered if cpu_addr is descriptive enough (a CPU address could
theoretically be virtual or physical), but I can see that a few other
places already use cpu_addr to hold virtual addresses, so yeah, let's
keep this name.

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  kernel/dma/direct.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index aa3489aa10a0..4e446aa4130e 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -204,7 +204,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	bool mark_mem_decrypt = false;
>  	bool allow_highmem = true;
>  	struct page *page;
> -	void *ret;
> +	void *cpu_addr;
>  
>  	/*
>  	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> @@ -318,34 +318,33 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		arch_dma_prep_coherent(page, size);
>  
>  		/* create a coherent mapping */
> -		ret = dma_common_contiguous_remap(page, size, prot,
> -				__builtin_return_address(0));
> -		if (!ret)
> +		cpu_addr = dma_common_contiguous_remap(page, size, prot,
> +					__builtin_return_address(0));
> +		if (!cpu_addr)
>  			goto out_encrypt_pages;
>  	} else {
> -		ret = page_address(page);
> +		cpu_addr = page_address(page);
>  	}
>  
> -	memset(ret, 0, size);
> +	memset(cpu_addr, 0, size);
>  
>  	if (set_uncached) {
>  		void *uncached_cpu_addr;
>  
>  		arch_dma_prep_coherent(page, size);
> -		uncached_cpu_addr = arch_dma_set_uncached(ret, size);
> +		uncached_cpu_addr = arch_dma_set_uncached(cpu_addr, size);
>  		if (IS_ERR(uncached_cpu_addr))
>  			goto out_free_remap_pages;
> -		ret = uncached_cpu_addr;
> +		cpu_addr = uncached_cpu_addr;
>  	}
>  
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
>  					 !!(attrs & DMA_ATTR_CC_SHARED));
> -	return ret;
> -
> +	return cpu_addr;
>  
>  out_free_remap_pages:
>  	if (remap)
> -		dma_common_free_remap(ret, size);
> +		dma_common_free_remap(cpu_addr, size);
>  
>  out_encrypt_pages:
>  	if (mark_mem_decrypt &&
> @@ -439,7 +438,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  {
>  	unsigned long attrs = 0;
>  	struct page *page;
> -	void *ret;
> +	void *cpu_addr;
>  
>  	if (force_dma_unencrypted(dev))
>  		attrs |= DMA_ATTR_CC_SHARED;
> @@ -453,7 +452,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		if (!page)
>  			return NULL;
>  
> -		ret = page_address(page);
> +		cpu_addr = page_address(page);
>  		goto setup_page;
>  	}
>  
> @@ -461,11 +460,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (!page)
>  		return NULL;
>  
> -	ret = page_address(page);
> -	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, ret, size))
> +	cpu_addr = page_address(page);
> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, cpu_addr, size))
>  		goto out_leak_pages;
>  setup_page:
> -	memset(ret, 0, size);
> +	memset(cpu_addr, 0, size);
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
>  					 !!(attrs & DMA_ATTR_CC_SHARED));
>  	return page;

