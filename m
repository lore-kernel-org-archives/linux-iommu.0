Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8583F1F872D
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772083; cv=none; b=h1EkUuslmyXnzmdMhvGQJXYj7wcwWbFR9yQIkM2EJYw9tyys/aa613mE+d7eIpsvqf9+BIvU5W3/B2AxFJpG5Gk4Ludns1YzwC/X2PJZQtAyPUlKngxOYdEOW+we052xkZswbGVMQtqcJPqJTRyLtuOZjYksp2nZf3Ee6O6lBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772083; c=relaxed/simple;
	bh=vLDXifex6CMPpmMVfGUyQJJg+jNDL8TydpPfnKchmcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4AEmD7+REhyQgiw/8Y6wg9R+/Qiu5RYTEz9fz529n5Eqt6VK/+gtDSlO0+aPr29TzRcxe9wXeyL+4Vb1WejVqmw4hJ7/ICX3BwTZJqlk+fQ4GmdXbTne+pVApQr5Bs3SDvq14bDgIRdSvuBujYcJR8qaWg+qjEbJbovVr6yQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KPbuJCWX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KPbuJCWX"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fadb9a0325so11922076d6.2
        for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752772080; x=1753376880; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVGkYAXzDbe9Y19xEn4w9roL2m9VoIdkgN7aWNqL1/I=;
        b=KPbuJCWX19i9XqPivaI8LaiNhINqCXWNQuCXLl1JXf9VeufGbZUfUVVkZZETp0cVNH
         5bNNpBtJLyLjcm6i2BH0QJwsxLeBGOBCitszY2dsqZahBil/AFulG6Zb6rK5QbPtDJsq
         LJuilae7cwQsndWS4bjPekTvOQhMd3xg3Yv609V/bfkd7Zoh6i4q5A69VQ0FsWhoRefs
         TE0Ttl4p3dfuhUsHHopo0Ddctc5OtZDKqJpQK36dLDosxN1fSuByX38nlnShtjuE1Dye
         agkg3GPf3gn4JKcNSN9pu+dRr+Qv8CzPOVTXgnDCOBbB/iunH0yyGpYEXHbs7mky1wTh
         RaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752772080; x=1753376880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVGkYAXzDbe9Y19xEn4w9roL2m9VoIdkgN7aWNqL1/I=;
        b=sahj3nqdhard07VSAxvSnmktg4jrpbSFMxFsxI7W7Bn4wHxpAYionGrgJUwcqnBGNA
         dgiBJZPBuao2L23jWNJwpVbCKBoaqrXQInQBSF8vx+PRDpEk/WgV1NPzwaPqzCtrDsrw
         KCceEWjqpGpy4zOY9/lSSkIZ4ot0vNICDkrdxZzcJG7ygpWNPfS63YR5fQDD8JFuahg8
         AjX1G/9TyPyDFBCzwrT72hExOWTfipVF7b1+ooNfrQ/NOSbnXT2qVz4jgggQ35yyDVio
         2Oxwo11lQIVMKxFsAdzmsgvzvnqkdfLWL0KjV4V8jizgVbal2TELqJvuMLXvK0GYJBCW
         lWTg==
X-Forwarded-Encrypted: i=1; AJvYcCU45hgTPS2TXXWCuGVMgRDCp1kBXivUKhjPJubkpyZCKZ9CV/BxlZ9YQXKGL9OciFoQTXULfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHVEh02mL2JrK8mVttlk7xoLAa9a5EGzyY2MAOBtg3HT+prIpT
	1AS9XIzZ00PbPPGMZSU3ZIoG9V2QYl2f4Mpw4KBxkbxZlktNdG2/Wj+5mgNpnUhgEZs=
X-Gm-Gg: ASbGncsKPr2E7Ei5GYBQofllJ4rgOTqjERyzu+CMKaeS26qjFhUJEqwz1bK84+cpU9z
	bfru0GAA3qUKj1a73QwRJd+oSQF1tc3c8Q8UxCP7AArjTmxA8LBWHxeiGp/k9rb/lHRe3c0BUXc
	Xk4+mv0oBN7x4Gpz22BU2uw4toocO5C/v5Kn+Wvss6AB3k3Mc5mAezckZc/kyhnXtJaUlVopFJy
	ysZWFM1chnRjNgt9QZs1BYINxY1OoGBDvj8SVq8KXvPeRLLtpOneZhML/2KkSlOaqhzT2pjG9gn
	EKNargeStoPEFsg1RPAJS/8cFnp+Y29F19BRYE4xVpPQdm/Brgx3b43LyOCDBAKUmxbAMRVGx4y
	DvpZk+kCxe5A4z5Vjc//NLgHKRTEPZ229+X7F0P/RmDfj7dRCtCviWFoqMdm/agoCBP/w0Rk4zA
	==
X-Google-Smtp-Source: AGHT+IHmL4Gcl4ie5Ko2WR29od0GTesRJqPqvUnVqpsrlcE58Si7J0fzQOs6WWd9t0tyOQGLXo3/NA==
X-Received: by 2002:a05:6214:20a2:b0:6fd:c80:98f2 with SMTP id 6a1803df08f44-704f6ac51efmr103219776d6.27.1752772080119;
        Thu, 17 Jul 2025 10:08:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39450sm86764726d6.75.2025.07.17.10.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:07:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ucS5O-00000009TE2-3ond;
	Thu, 17 Jul 2025 14:07:58 -0300
Date: Thu, 17 Jul 2025 14:07:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] dma-mapping: prepare dma_map_ops to conversion to
 physical address
Message-ID: <20250717170758.GB2206214@ziepe.ca>
References: <cover.1752734252.git.leon@kernel.org>
 <1798a3351dcabccaf0749221e9e9b66585a7b2c6.1752734252.git.leon@kernel.org>
 <20250717134435.GA2206214@ziepe.ca>
 <20250717145213.GB402218@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717145213.GB402218@unreal>

On Thu, Jul 17, 2025 at 05:52:13PM +0300, Leon Romanovsky wrote:
> > I would expect 'else if'
> 
> I don't expect both of them to exist. There is WARN_ON_ONCE() to catch it.
> If it is important, I can add else.

Compiler generates better code with the else.

> > > @@ -213,8 +221,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
> > >  		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
> > >  	else if (use_dma_iommu(dev))
> > >  		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
> > > -	else
> > > -		ops->unmap_page(dev, addr, size, dir, attrs);
> > > +	else {
> > > +		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
> > > +			/* We shouldn't have both functions */
> > > +			WARN_ON_ONCE(ops->unmap_page && ops->unmap_phys);
> > > +
> > > +		if (ops->unmap_phys)
> > > +			ops->unmap_phys(dev, addr, size, dir, attrs);
> > > +		if (ops->unmap_page)
> > > +			ops->unmap_page(dev, addr, size, dir, attrs);
> > 
> > Here too
> > 
> > What is the practical difference between unmap_phys and unmap_page?
> 
> There is no difference. It is provided to provide symmetrical interface
> to .map_phys, simple rename.

We really should not be converting phys to page without knowing there
is a page available..

IMHO if the underlying dma_ops are expecting a struct page it is
better to leave the ops with the struct page versions and have the
core code do the conversion to struct page. At least that way there is
one place we can prevent things that are not allowed.

The phys versions of the ops should never touch struct page or KVA. It
looked like there were a bunch of drivers like that - cache flushing
was the main issue requiring a struct page and KVA.

Jason
