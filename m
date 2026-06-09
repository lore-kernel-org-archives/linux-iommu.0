Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F3B4218A6
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010756; cv=none; b=QBIi0CFTAAQGBWEeh3UHkUiOMN6ia+wZl+ry4gbe9qqf5OjDSR8lrG6gyYFwhfCk9FzokCh0NNpykKJQpczn0T/Jnvnr0ZjAyF1NK2aFezC/yHv7rUh5ojCE095WbDQVvAl/n7G1MXjsKRaGE3xaGH/1mMe/Ccau3gKSjex5V7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010756; c=relaxed/simple;
	bh=cRmrex5oPCwg42dkdhJaD73cEwhY7jfqwVZ+TJf7vSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/O9RYGBP5NFxqakZ87aAuzNcnFrel25gcO81K+TE2i6ZfS5g9UzEztHHoxjg+BNzdjAqff5H91l+8BNCIju5OZT4zkfujJGag+KFh29MEudmmqW36FvCBDiB38/bNvv/tZNLBhzf7OoCINZhrMO8MRV6ShkWIcg32IYRJds9aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VI+azN29; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VI+azN29"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490d6730461so732695e9.3
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781010754; x=1781615554; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOb0YWdrCyqRf70PqWxcCcSyY2RJrYltX6EkSx4+w3M=;
        b=VI+azN29saguK39X9YkY6UqcJLDr8c4i0hv1xEz2YNGH1PYV5dR2etPSGRS87CXsFB
         +eSJc08/mfMBRJQoVgk151iSQ0kXz3TRCUMkpdWtsiZxtqEPtbdjDIhRpkZxDRxmpxNU
         c2QSDMPPL7WOiNBw2UXyya1j7HHl8NLgzp9hmoY1qvxGIAtV7HM6vVW01xxQoXVKW410
         F45bB+SGntGcBdn+7Tkq/qLUo29FgT7Fq1JXGBqmQTDuWdnmq9Mc+7x8SiFbckud4VMD
         mhgKzFegKW/LVE9JRsya3uSBQV+DC8r/UoXjfXTE7lHUIx6pcGstjgq6f5GxFRzviQjh
         +AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781010754; x=1781615554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOb0YWdrCyqRf70PqWxcCcSyY2RJrYltX6EkSx4+w3M=;
        b=DnuafR4/jHqa1I73dn76a4Oy3q/AUvc0wZqhFsjtuvGUtf7YtAMpiouEJoh994VjDW
         lcGBa/SqJJLTQqaI1rpZH8o2BfOuotMpTb9qT+YsXjC0OieNavGLg4eaHdvOJBO22vQ4
         TLdhTtipFFRc7+7gxYXVU4v6lS9wW+wXtCFMe2DoEPlMIBoECAPm9T/qwh5EiKShZ4E0
         QC3UXs8P0BjvvRSgoecdfoUnrgtrm8GypsWTeMzOH69gDlq1V0ir5yO2XTDLZDeYPLc1
         FIzEVfmGfOPmGkpjwomh6Fy7OVxVS3nIMpNCOvTJHR8uRkItYhlQR93LJ9NCRbC1tSyL
         TLow==
X-Gm-Message-State: AOJu0Yw6o31L7K3bp3T3artPV+l9XGBqVrO7nKJ2g1Tuh0rMYH0Eb/6S
	1D4cYYTatjVsOeGlIuJYD5HgtN3s5O6L4Eu6ANcd58dAZvh8spcH39DWKzfjvE+dVeY=
X-Gm-Gg: Acq92OHLzAYQ3C3olHei+kUtLLhb10ko4BfkYxUMyREHuNMA96WiwU0ldGvPit1xrBs
	VR0pKrtT8y2sM2+q4Gr+PV5WCXAHXaClhtEmDNjtXMd4xjWo1BCqFcDhoZ2A5rGN8g6u8vgR29C
	qHASuVKvUyaMtcP8Vk0cCT/zq5vNSTLz4QsRMnqpLZiSOpuuFNi4wEi2H1HPh9l/im3DzashP/R
	x40zJxrtxOvO0pZHndywW+68qG04HVKesf2QW/XyIddf7hdutjTHOImAkyjTatHldsqHty7dCtX
	IdwJWdzeCahqNAscZbEBQutPWk0nxht7DuQz+PhVb/y6ew8Aj6a1/0OfOxD0kTXsSk638C7HJyj
	l0UTpCtnGXzWfBZlIGCV9yzc5GmwAg1xLdyGWmA31worF8UwRfmZJQwuS6+9pnydZepdmEV8nlF
	nun+/7gCQdzCjAKNDjQqKnsCg=
X-Received: by 2002:a05:600c:8b65:b0:490:b4d4:5c16 with SMTP id 5b1f17b1804b1-490d72759f0mr16962775e9.8.1781010753634;
        Tue, 09 Jun 2026 06:12:33 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm111677469f8f.29.2026.06.09.06.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:12:26 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:12:22 +0200
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
 <svens@linux.ibm.com>, x86@kernel.org, stable@vger.kernel.org, Michael
 Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 14/20] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260609151222.476a5521@mordecai>
In-Reply-To: <20260604083959.1265923-15-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-15-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:53 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Commit 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool
> helper") changed dma_direct_alloc_from_pool() to return the CPU address
> from dma_alloc_from_pool(). That fits dma_direct_alloc(), but
> dma_direct_alloc_pages() also uses the helper and expects a struct page *.
> 
> Fix this by making dma_direct_alloc_from_pool() return the struct page *
> again, and pass the CPU address back through an out-parameter for the
> dma_direct_alloc() caller.
> 
> Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
> Cc: stable@vger.kernel.org

While I totally agree with the reasoning and the fix, it's interesting
that this bug has been apparently present in the kernel for 5+ years
without anybody hitting nasty memory corruption bugs.

How can it be? Is the buggy code path never actually used in practice?
Does it hint at a missed opportunity to simplify the code?

Anyway, these these thoughts are intended for a possible future
cleanup. For now, let's apply the fix as is, of course.

Petr T

> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4e446aa4130e..e0ab9ff3f1d6 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -157,24 +157,24 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
>  	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
>  }
>  
> -static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp,
> +		unsigned long attrs)
>  {
>  	struct page *page;
>  	u64 phys_limit;
> -	void *ret;
>  
>  	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
>  		return NULL;
>  
>  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
> -	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
> +	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, attrs,
>  				   dma_coherent_ok);
>  	if (!page)
>  		return NULL;
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
>  					 !!(attrs & DMA_ATTR_CC_SHARED));
> -	return ret;
> +	return page;
>  }
>  
>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> @@ -270,9 +270,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	 * the atomic pools instead if we aren't allowed block.
>  	 */
>  	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
> -	    dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +	    dma_direct_use_pool(dev, gfp)) {
> +		page = dma_direct_alloc_from_pool(dev, size,
> +					dma_handle, &cpu_addr,
> +					gfp, attrs);
> +		return page ? cpu_addr : NULL;
> +	}
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size, attrs);
> @@ -445,7 +448,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  
>  	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>  		return dma_direct_alloc_from_pool(dev, size, dma_handle,
> -						  gfp, attrs);
> +						  &cpu_addr, gfp, attrs);
>  
>  	if (is_swiotlb_for_alloc(dev)) {
>  		page = dma_direct_alloc_swiotlb(dev, size, attrs);

