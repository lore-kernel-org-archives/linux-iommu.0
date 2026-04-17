Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7E314A86
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439712; cv=none; b=EvGJ2YwZt1WDvrLrpRZi4cmw5sIuMykcanvvMBDM5tzqsFU9LKTQeNTVs3pxmpDQvL0qDbUzGpOAVVkZeJALiK91pFV7qXA2oUkYlujdR2U9ks1JpjNCwq2nk9WWgGaRjz6Jc1axNQJw71L/izIEBcGDzd1bG4OUaBOdqqbTQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439712; c=relaxed/simple;
	bh=qk8vOSmiSRbdYG2qRxtAcO/Kzh+bGUWmCB/WiPfL4Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXObrpoNFCvREwohrS8N486NDns7njiMcD5ufafsj0ddSrQmwTUlJNcXv5joRHDSkD2TICyN7rjWDp5+9oiVXmJ3m+n+NGO5sORmWyYNX7lk7WkXt/B4t4Eb5oOemU/r5M55uGQPX5Lonpi9w+JW0kR+iHvKeLZdENqiko8ZBXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J2dKb25P; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J2dKb25P"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfd122d78fso121257185a.3
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776439709; x=1777044509; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0POz2Diae06+nenoM1eObTMj7kqQWmlZs2+9Dadm4Fo=;
        b=J2dKb25P5/3UjWnxdVA1N7BbKvhWygevKVC6Py0SZXNIoeD1Teq6xKmAU5hRm5byM3
         Yv+SU5U4TiH7UjrkMcJsGHSAeHw/AQmbA6y75trwdCl3U79c8XEnpEqKJawsX1NjvUn5
         2YbJReLo8MT9+ZNAp+EGNYnPxkqiR2HGgq/rUR/v64QxMciVjY+FLUcb24kgPSctltMR
         1p3Aahi6f4U+ksd5sk8tUBxkOMZEr/Af4sEnB0p+xO4aUU6g/XRnraHpj+zD+kFZ+lcC
         xERwPVjS5pPkGThY91j5tsvL3nXWXpK129c1GdNkWnNcZfFSDWtaIWO7NKNUdZNe2+n4
         fBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439709; x=1777044509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0POz2Diae06+nenoM1eObTMj7kqQWmlZs2+9Dadm4Fo=;
        b=XMfVyXEkmeeKqUoYxfLLZS29Ac704CTRErOkK/Wmk5Mmc5PsI8k7uVOpkNBHxfoZqY
         o+drZn4ZY8OoYblaa35zS791jn4Yn5lillXY04dUniZd655Pks9ceD/XBMtenh9agsKN
         zrAtN8Ez6l4I2Jv1TdNndBgpd6jhgzbZ1/ffRNVDZqCtEe8fyYlnOjQEnrq4veihwx1L
         qtuyQo/aLQUOynIdWrm7UPlEAU+SRu77fNdNbF0BeMmXMSg/j5qLtjdsWG2VCa/DU5xR
         xh8x615Mhvj8IGAN1Q0/c8UaI3f5qQpUAyroZr1spGQbrqxhqIY4oYrgDHqbQV0fEWyo
         H0LA==
X-Gm-Message-State: AOJu0YzzMTxahCN1acVk0UCXD7rpUUNxH2VP86FpCqq9mddClEneMy/w
	p5HUw5uwaiKH9F3tj79rcZOvUqkb/87UAKSFF0/1KqKL+XhUBtIJhEYnaJx+zGZYp5g=
X-Gm-Gg: AeBDiesz7Ppb5ByK5w44e+ssPy3GBBVVyjB4SDvlOiZAaQJNDNH8imWhCdfLphfukfz
	sqxxMEJQ2+BcVuJcc8L9l8z0ebO+Nyl76HxGBHwRNVEzEHKHZRZPsVJRWu6ZHNXu7S+jT/YpSKk
	CnX7OQxhkOVaeQ058wHScXY3tXHQhedgWF8tK8EfAyZVRQV5944KNHX+htSatf99nNIwvhFu9h1
	YHnqoMknEjxoXlC7+lsGyEQ6MPM0tugFemU2vXTzY4UT8Qs4AkpzaUWGsdxDifQWADr9Ma64uj0
	Xe3XMuliWKyModaL6ZZf50nU9tyDd1VaKG2j8Hsqfo9t1Uwi6uD95U6+5hnISEHzHmPZC58T1OD
	NYJswQTJfskHcEupAQMrptZTUoPbK8ETukDC/KwfAYUGMs9n/9FxRgxrkIjHdxs1QeD8KxZRq6I
	M0u6WBKY0R1mTLUBb75otIm1qZm7ghQa9F5gEQx+cYTmfVR2z/G7MyrUcjyCihbx6FSz9LfAhdm
	O9q4s5zRhA/rwi2dHqT7zcXzbo=
X-Received: by 2002:a05:620a:459e:b0:8cd:b6b7:1e6c with SMTP id af79cd13be357-8e7916b1065mr436447885a.35.1776439709535;
        Fri, 17 Apr 2026 08:28:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe90afsm155521685a.3.2026.04.17.08.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:28:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wDl7M-0000000DQhO-16Cq;
	Fri, 17 Apr 2026 12:28:28 -0300
Date: Fri, 17 Apr 2026 12:28:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH 2/7] dma-direct: use DMA_ATTR_CC_DECRYPTED in
 alloc/free paths
Message-ID: <20260417152828.GJ2577880@ziepe.ca>
References: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
 <20260417085900.3062416-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417085900.3062416-3-aneesh.kumar@kernel.org>

On Fri, Apr 17, 2026 at 02:28:55PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Propagate force_dma_unencrypted() into DMA_ATTR_CC_DECRYPTED in the
> dma-direct allocation path and use the attribute to drive the related
> decisions.
> 
> This updates dma_direct_alloc(), dma_direct_free(), and
> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index c2a43e4ef902..3932033f4d8c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -201,16 +201,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> -	bool mark_mem_decrypt = true;
> +	bool mark_mem_decrypt = !!(attrs & DMA_ATTR_CC_DECRYPTED);
>  	struct page *page;

This is changing the API, I think it should not be hidden in a patch
like this, also not sure it even makes sense..

DMA_ATTR_CC_DECRYPTED only says the address passed to mapping is
decrypted. It is like DMA_ATTR_MMIO in this regard.

Passing it to dma_alloc_attrs() is currently invalid, and I think it
should remain invalid, or at least this new behavior introduced in its
own patch deliberately.

Meaning, if you call dma_direct_alloc() force_dma_decrypted decides
what setting DMA_ATTR_CC_DECRYPTED takes and it is EOPNOTSUPP if the
user passes it in.

Jason
