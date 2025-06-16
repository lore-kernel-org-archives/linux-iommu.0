Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB7925E450
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072877; cv=none; b=H7pRSoBDOhvVcJ55b9z6z3Z620M9LtOgTv6C9anyImGv0P00+jM+jR32CYuSmgt/tm7a5jbn8+snXYIlOtHff6paf5jRR8hadlwZDFQv0X6fGgGJ41pzM5u+ZIM+Tm2D4r3LJWN5SSELPmwj0H+8QeIVpIC/kGhsxyO8Prakw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072877; c=relaxed/simple;
	bh=qgYShiCICLGlyXPXkMFaa9MBddkYx+zhgvPZouJhpug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW4Gx+kc9rCKEMKgxUG1GuviqzWAleyVx6rfPV3QjBexiNTZb5b3gYgriUBdxDY4af1W1UCa2oy/VoppOLoudVwqCDxhYo8vRy3cug0sDUlPPf/te1S/VtBo/mDy6+GTK0win0+XYT6QHeJVZu058tdDjmvNXRbwcglanWvVVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lvbQnGuv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvbQnGuv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d54214adso33941775e9.3
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750072873; x=1750677673; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4euJ7IL/UtIuqUuTsf6umM3mNJN/f7JKsQPFpax4oo=;
        b=lvbQnGuvd2YcR9/6esGAnjWfODxW5l7Qlll99STlNnBcr3wtaNvsldpX2SiGBETLbm
         dbUYfJ8j336mjNV/QNyb3VPAJVT4drL+ILana+7W2TuDUC69HeZCYpGEWvowuujAstFG
         /gGiIIMme/FKYQkbSK5477uIq37JS6Aj23EPh3j4ZFRoxGLe8vUiNEUzQSTCAOggMWNT
         YIKQpPMuIa8RvvwZkKhBcIEe3vE9VhxLdv+3QHb538YxDlkw/gxQK8kxtIbLSmBiMHtJ
         eY0JdpHYe1+quSXWd0JF5OD32CnVeTvdjTVWtkOpojkNnVEm9GjvgzW1vI827AXjDdSx
         nPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750072873; x=1750677673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4euJ7IL/UtIuqUuTsf6umM3mNJN/f7JKsQPFpax4oo=;
        b=vq9Zrhsck80LiWhEPHQx1aBXwx9bJ96Y3jmCkvWOP0IRmPl0ghVRQK0NO/ByT8RMr4
         JaQrMYAqiMXsOnq6J4IPfjB05sUy2FxlPnRQ27txFix6JH8Me6s3aDGKN2S+xR3YFmIr
         y5USrHNISTmlsvFDJsrFrWpdyqrDyGkwJWRcCLaXaqLwEzfp/Et/WYGuC3OK5Xauxk+U
         7AU9T/qat6JKOoWqw6dC3CrX8jhH8A81Vy1DJryGMTUftpkkeH98D9xFR41Jm5dc7Dal
         BK6jcfFVQR4GiAZBRx5oPHqrh6f66uwM8d0RgGHeOcJQFaUMZxCbBSs2lTprsDnegYMm
         hMpg==
X-Forwarded-Encrypted: i=1; AJvYcCX365HIuq6Y9yqYXVE79XSJ1RQOvdkYlmdRqe5EYCOrR3K+faa23osTio3kiOKMFszhAsZjlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3DwJrSGoL5mjBO2+DQETOWOzQIn98XFXP/4II97ygGt9WVRB+
	kpkbQVU0cnEFTRYx6/QYvWMgDmsU2mTCX8leOVt5EQkshCh1XwVt1B2oJQpLGtV0Io4=
X-Gm-Gg: ASbGnctkuFpcC95B9Oyq9itvBSS0zGKQmG959+VtD5aMeIt6OLUn9L08guV/0Qvn168
	wPPMhpv5S75nu30ITLsUycqKwG/9nOmJnQLZB09kbTLzslAh74x7dvho9g9aZpqjsaBzjk0CKWs
	9ah4PgAqLee3XzsOseaCBM0qG1YLncTdH7nQUH4cRwr7yEiqh/BPvusTa5d1BrMOiA8ZXpbvzme
	CYJGDyZhWC1JhkOhoJRghhb0GWC1QuW7z/Silt7fMnKYHFSXvIRRVi5lS3W8CLWpEIwL1KpK9Gf
	gvDyR0bz3dtzceGW0u8/Nyvzj2cgJAwue2WzQOv+rD1ZnyEAD00tzMw4N9strwu8mVU=
X-Google-Smtp-Source: AGHT+IFm7lURtK3nakQke2Eo0A04R9F5ogbYQ5oAvV51pSxGomor7dB0raebWDwLvF03RocQuXgBNA==
X-Received: by 2002:a05:600c:a218:b0:451:edc8:7806 with SMTP id 5b1f17b1804b1-4533e57d98dmr39178155e9.32.1750072872918;
        Mon, 16 Jun 2025 04:21:12 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e254396sm145401575e9.28.2025.06.16.04.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 04:21:12 -0700 (PDT)
Message-ID: <7cf90a89-b381-48ae-98bc-1316022e03b6@linaro.org>
Date: Mon, 16 Jun 2025 12:21:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
To: hch@lst.de
Cc: olteanv@gmail.com, broonie@kernel.org, oe-kbuild-all@lists.linux.dev,
 arnd@arndb.de, larisa.grigore@nxp.com, Frank.li@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250616111749.316413-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 12:17 pm, James Clark wrote:
> The implementations are in mapping.c which requires HAS_DMA so stub them
> out if not present. This is required for some drivers to pass randconfig
> builds.
> 

So the commit message makes it seem like this fixes an existing issue 
and it would need a fixes: tag. But I didn't add one because it seems 
like it would only hit new users like in the linked patchset. It might 
be better to add a tag but it was changed 5 years ago and nobody hit it 
until now so I'm not sure.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   include/linux/dma-mapping.h | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 55c03e5fe8cb..766f28a0e11f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -161,6 +161,12 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
>   void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
>   int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
>   		size_t size, struct sg_table *sgt);
> +struct page *dma_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
> +void dma_free_pages(struct device *dev, size_t size, struct page *page,
> +		dma_addr_t dma_handle, enum dma_data_direction dir);
> +int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
> +		size_t size, struct page *page);
>   #else /* CONFIG_HAS_DMA */
>   static inline dma_addr_t dma_map_page_attrs(struct device *dev,
>   		struct page *page, size_t offset, size_t size,
> @@ -291,6 +297,21 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
>   {
>   	return -EINVAL;
>   }
> +static inline struct page *dma_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
> +{
> +	return NULL;
> +}
> +static inline void dma_free_pages(struct device *dev, size_t size,
> +		struct page *page, dma_addr_t dma_handle,
> +		enum dma_data_direction dir)
> +{
> +}
> +static inline int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
> +				 size_t size, struct page *page)
> +{
> +	return -EINVAL;
> +}
>   #endif /* CONFIG_HAS_DMA */
>   
>   #ifdef CONFIG_IOMMU_DMA
> @@ -438,13 +459,6 @@ static inline bool dma_need_unmap(struct device *dev)
>   }
>   #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
>   
> -struct page *dma_alloc_pages(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
> -void dma_free_pages(struct device *dev, size_t size, struct page *page,
> -		dma_addr_t dma_handle, enum dma_data_direction dir);
> -int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
> -		size_t size, struct page *page);
> -
>   static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>   {

