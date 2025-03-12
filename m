Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E623C8A1
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779796; cv=none; b=GxzIIPI1i5yVBPXDgkv5XU5v3w3+LCennnX9ZjOUIaZ4IFSW//x6Y0VBeaMJIwdDIWUjIRIP3yfeMtdowpMPtKO6quAhDxLCQNryPP+wqBO4/HETHVVdjKySpBYySFrRVnTRaGYInyThFJwRZmQdkv9QROgpe950F1rpKDOYHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779796; c=relaxed/simple;
	bh=+MNq83J0FvOykak8Ryzy9D5d1zvEqohQjMDrlpBZzM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/fBkdSgzkt2yVWi3bTDhhkzC/EZBA79AIFG8EaxXY+1vOrUO9/NEIWm7ka52jj8VJqRIKFypZN+Rq0n8mzM7vPEqPrVmzsDhEvS4UN4eBvN6D/7DjYCZUkuWwhKDHCemmnu2lEqQCJTbVBzL+m4mZVsOSQoXYvxUWzxSF/MZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TQwsur7W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TQwsur7W"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso39115e9.1
        for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 04:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741779792; x=1742384592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/DRboL7iXAangnAe10zAw/fnPXaxzgNmenGuCjK+wlo=;
        b=TQwsur7WIWsaXm7xoXHv5M4pWGeWjtVFeUCw3pMgJmvpY2uEwsqrKu9MlUWPCvvVes
         EoG6ZZvOv/U64KxdJFR2YdsryahOngIB1IXpBwmAUPqqLDBaYiY4XaPQVOI0J2N4Xkht
         e+726J0x93FTY5D+DQLGyMpBwOieXNwrzJmtb43Vd7WC7cf9zfay+0ehbijJyfwk866K
         4StwIyDqyAGJgeOMceHizy6FA948tBlZqZIYBYHA/dflC1DdwrbkocOpu1M+RXHEhHJE
         AByk6GooIrf0o4+vTQheEBvZvHJoTUU+zba6kyoqwdX3I2tk0edYJiU0Wx1cjHrVMMZU
         /VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741779792; x=1742384592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DRboL7iXAangnAe10zAw/fnPXaxzgNmenGuCjK+wlo=;
        b=C5I3zx0EuPnU8sC7yZ3mCEmnpo2R/2T7j95eJIsuNkKdKY49M7ZH9yuUjno7HkxSQA
         DJ1bfMZdpkiV/scStJ9buxVjcWkZ+rLoCb+Q13+tPetXPLA03jI0ErsKyhuIkU+lQKlN
         CMQBlMLTgeVGPYOO57/X6VKz/V9tJqa8LW9z+bw1XxiDulVWaXkqFXRIhGLUliX77P6+
         fNemqKKlMZqWRBtkGU6XZOxbdxU3F0SaAv+4kGAp06r8/RUL0IeionirslPaME2X55Zw
         /krjM0o03zcolrxv+0+T7MG4XKkklmcR+nduLAuWj8f0lRrhRjKN5sGJFovUofwEyM3R
         6pjw==
X-Forwarded-Encrypted: i=1; AJvYcCV6nxCeE4IANMxOdAu8mS0Pj3wlCal8tRqHEppFn+yx819egp8TINYsRgW0EiiqzkSKRqyNgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyK+sct9xsRBFGuWtfC7aHWjrJJ/LmyQB3M1hWfF11CNI4B9Gt/
	MF0H0n7TrTbom/wptRPv02fCPwoYt+q6TTaOSDuSYF+4/KvkamhB9q+OFi0kEg==
X-Gm-Gg: ASbGncsuKxsPvYkno9OgPXQFz/clT6jsOzS9CDDEqs9ZOYkETyHbR0nuGBlhZP36d0C
	OwF9xFWoIJL7VcoYF7zkD358KN0pIKdK1LgzVVP4kgo5LzLg3gJnVSLrtKnMfyCDxXdRfAjyELk
	dX3wGO/fQ8tCacmwJpYErVUg7Rgh6iUoDOzrRqFn5EC+rGZhHumLazjNLdjWKWFA1EE1pjxUKcp
	hFjGin6MATF+5T3nl1q+V3qni2Uf4ZrArL4IPCOz5xoib9Tv/OVMBI5KHbPd0BF0I0sQFJXz62W
	4sD9fz0YAR4TT7hzlQ+OqRVo4c98zfS3lW3aEcl+w2cFem7HZpRo3umKTwGwLdrKb52kwbpVTsc
	gkFzh
X-Google-Smtp-Source: AGHT+IGAlRZ9FGEpVbzn9/E/l/2Ksb4Pgfv6rI6D7I3wU6Ogl1uoOZwLKHkEYMZpOjmtLPXmOnf3OA==
X-Received: by 2002:a7b:c8d1:0:b0:439:8d84:32ff with SMTP id 5b1f17b1804b1-43d0a5e40ccmr994365e9.3.1741779792013;
        Wed, 12 Mar 2025 04:43:12 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a72ea88sm18970735e9.7.2025.03.12.04.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 04:43:11 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:43:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Hector Martin <marcan@marcan.st>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
	Joerg Roedel <jroedel@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 03/23] iommu/pages: Remove
 __iommu_alloc_pages()/__iommu_free_pages()
Message-ID: <Z9FzS-AzZNzYhrou@google.com>
References: <0-v3-e797f4dc6918+93057-iommu_pages_jgg@nvidia.com>
 <3-v3-e797f4dc6918+93057-iommu_pages_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v3-e797f4dc6918+93057-iommu_pages_jgg@nvidia.com>

On Tue, Feb 25, 2025 at 03:39:20PM -0400, Jason Gunthorpe wrote:
> These were only used by tegra-smmu and leaked the struct page out of the
> API. Delete them since tega-smmu has been converted to the other APIs.
> 
> In the process flatten the call tree so we have fewer one line functions
> calling other one line functions.. iommu_alloc_pages_node() is the real
> allocator and everything else can just call it directly.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>

> ---
>  drivers/iommu/iommu-pages.h | 49 ++++++-------------------------------
>  1 file changed, 7 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> index 82ebf00330811c..0ca2437989a0e1 100644
> --- a/drivers/iommu/iommu-pages.h
> +++ b/drivers/iommu/iommu-pages.h
> @@ -46,40 +46,6 @@ static inline void __iommu_free_account(struct page *page, int order)
>  	mod_lruvec_page_state(page, NR_SECONDARY_PAGETABLE, -pgcnt);
>  }
>  
> -/**
> - * __iommu_alloc_pages - allocate a zeroed page of a given order.
> - * @gfp: buddy allocator flags
> - * @order: page order
> - *
> - * returns the head struct page of the allocated page.
> - */
> -static inline struct page *__iommu_alloc_pages(gfp_t gfp, int order)
> -{
> -	struct page *page;
> -
> -	page = alloc_pages(gfp | __GFP_ZERO, order);
> -	if (unlikely(!page))
> -		return NULL;
> -
> -	__iommu_alloc_account(page, order);
> -
> -	return page;
> -}
> -
> -/**
> - * __iommu_free_pages - free page of a given order
> - * @page: head struct page of the page
> - * @order: page order
> - */
> -static inline void __iommu_free_pages(struct page *page, int order)
> -{
> -	if (!page)
> -		return;
> -
> -	__iommu_free_account(page, order);
> -	__free_pages(page, order);
> -}
> -
>  /**
>   * iommu_alloc_pages_node - allocate a zeroed page of a given order from
>   * specific NUMA node.
> @@ -110,12 +76,7 @@ static inline void *iommu_alloc_pages_node(int nid, gfp_t gfp, int order)
>   */
>  static inline void *iommu_alloc_pages(gfp_t gfp, int order)
>  {
> -	struct page *page = __iommu_alloc_pages(gfp, order);
> -
> -	if (unlikely(!page))
> -		return NULL;
> -
> -	return page_address(page);
> +	return iommu_alloc_pages_node(numa_node_id(), gfp, order);
>  }
>  
>  /**
> @@ -138,7 +99,7 @@ static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
>   */
>  static inline void *iommu_alloc_page(gfp_t gfp)
>  {
> -	return iommu_alloc_pages(gfp, 0);
> +	return iommu_alloc_pages_node(numa_node_id(), gfp, 0);
>  }
>  
>  /**
> @@ -148,10 +109,14 @@ static inline void *iommu_alloc_page(gfp_t gfp)
>   */
>  static inline void iommu_free_pages(void *virt, int order)
>  {
> +	struct page *page;
> +
>  	if (!virt)
>  		return;
>  
> -	__iommu_free_pages(virt_to_page(virt), order);
> +	page = virt_to_page(virt);
> +	__iommu_free_account(page, order);
> +	__free_pages(page, order);
>  }
>  
>  /**
> -- 
> 2.43.0
> 
