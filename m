Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BF212CDBE
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726253903; cv=none; b=DjwgBfjm8eaZBZ/Zcb59TY4wd1N0HhNm8rCREY6MQInlaMMJVzUdC5BpgVjnN0MBjs6/8bIw58Wdy1vmSHlpusLx+iysByTpnvyZHXbpukzJ9s8om1FCZwaP6cKX+R3d+CU+W7d8NUFZ1oLG0PeZlvOVxkGXYw/XVKxNOZoQFog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726253903; c=relaxed/simple;
	bh=fOQe/MFa6wz9Dv/6AV8Uxi9LSglbhZWH8boe0/4m5vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDal0vhIkvlPipJ4cTuKFq+uCkfsChFl75QaHq1N88Fluss8ijxbkShH2fa5u8sbYqfFDD5V0FuXYWmRtGTk+2UEtDRqhLc8Dr7OngIdCVjtlsWrt6eCxhi9kOBKVDkEaqVUsI1JlNI6zBnJrOhdcJFvf+n5M2VyiD0uXXkrC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MbrM16zl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MbrM16zl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5356bb55224so2935092e87.0
        for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726253900; x=1726858700; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3J4NFIOs0+/FX7PgSd9/Ty6QD31sDeKjmeTpTdP0F8=;
        b=MbrM16zlDRrD4nOkax65mlfZwxoQ38GEdqyxUZujO+uhMqqyLpRgJD1nIDQIMqZoFm
         pNffzPDRYQxPav16icHQrHfxjpIQ8cnVSrMWT51kiVWaEi5dO2Q8A2m2RFyQIgGImLMg
         gXcuBMSGZVUULfjt8hoh4X4RFDL4CDzwHM/a6Oqyv8qGkCWqtDFM6YMhbzxNqMyVHwgL
         /yeITJoutwsTgiDINLC1pabKIVAs03Hygz+iSmx0dkVISrGKELW7bK8afp/u19udMB7y
         riWSW4nkEeqhHczpgJ8ebdc/ZbBjgoRx3+ImhJ6jU+vF+YADramaYRsYSRhmfp/oyZ9+
         MMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726253900; x=1726858700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3J4NFIOs0+/FX7PgSd9/Ty6QD31sDeKjmeTpTdP0F8=;
        b=fXE5pC0rl1XXECSxiSYik5v6DzVxzKjKNU5bIowsOQimrQYA77XO5I8Yw7gK+kjTML
         3BVqv0ItVEzJDBdW6jm7c9HrzsU3/P1kcGBQy6Gh+wktmu0k/WkSsAcrQxXgbt2sEW4r
         t/PldaRsJknrBWLpYhZyKL3NZ+GqXOByP9cmWox1HMQ474++MeamKiMp82fpRdBXe7wg
         36fdNFc3X4WtwetQfEtrH8KuGQ60MIBxk95bysWiAJWMAbE11IKogLwryis/xZeBkjAa
         9NjzlNkR2xGynMyX4TI/fsksKnqZsoSh/0oVv799eUAAr20DJYtU5R/l3T9I7F5DFjl6
         fDTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0JEXVxIb4ANW2KK2SxEeUGlB+skBuySC4jhrXWKyJPCwfJ1vMcEzgbZ5riso4LPbXeQjaWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YycdlUIevBzo2RT3UTvhP1kkbE20o67hJhDSpUyazySV3F/WZiW
	Jvr9DW/uckc0VjVawGQmlvCcWU2Lv/FbqTa2Za1zwFjc/+sMeZWO7mfl7xy1Nw==
X-Google-Smtp-Source: AGHT+IF5N3upnOExA4ETmw6SPMAW1YtxHaD4AcLqU3pOspc/IzZqS/Fny+Rg32WkLJRydanP7pzleQ==
X-Received: by 2002:a05:6512:220c:b0:52f:df:db40 with SMTP id 2adb3069b0e04-53678fec496mr4582246e87.56.1726253899415;
        Fri, 13 Sep 2024 11:58:19 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25835abbsm899355366b.9.2024.09.13.11.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 11:58:19 -0700 (PDT)
Message-ID: <a0b0dec5-03c1-4b69-aa0e-65771251d859@suse.com>
Date: Fri, 13 Sep 2024 20:58:18 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/swiotlb: add alignment check for dma buffers
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240913145655.10076-1-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20240913145655.10076-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.09.2024 16:56, Juergen Gross wrote:
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  {
>  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
> +	unsigned int order = get_order(size);
>  
>  	next_bfn = pfn_to_bfn(xen_pfn);
>  
> +	/* If buffer is physically aligned, ensure DMA alignment. */
> +	if (IS_ALIGNED(p, 1UL << (order + PAGE_SHIFT)) &&

Why this check? xen_swiotlb_alloc_coherent() guarantees it, while
xen_swiotlb_free_coherent() only checks properties of the original
allocation. And for xen_swiotlb_map_page() this looks actively
wrong to me, in case that function was called with offset non-zero.

Unrelated to this, but in related code: xen_swiotlb_alloc_coherent()
can't validly use XEN_PAGE_SHIFT, can it (in the way it does at
least)? If XEN_PAGE_SHIFT < PAGE_SHIFT, and with order calculated
from the latter, the used size will be too small afaict.

Jan
