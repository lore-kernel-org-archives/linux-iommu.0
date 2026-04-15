Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90F382F33
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285086; cv=none; b=O7W+CLyYh1uU6u3QUIPy+Zn/+E9GoQrzC3vEzdiYthoqpmrkPbA0Emavxmh9kiq1wKeM7ejtLfXb36QkBJW8QDgTLJQDxliBLLLn1dBsWkoXGWUUOmX5pLzf9jg3/F3keVOQYzBACz4ggCx3k/10fLf2xFfRseWTYBkqyHHrl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285086; c=relaxed/simple;
	bh=J4JAh0k8ECvYiDro/BanJC1prOJ+uW424pa2aQLT0ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNUv+YlU71e7AxRHDjCaIzahz9j0GSCqmuvRefEoOVppzeffC0B6r+AjEJISoEmfl2ZQvwfMQsZaPQStrOpm7PIfOaJi056d/ngHhQrSQJ6e9kM52qhxzH1qPJ5I3oCAHvva9fHh8vtWbD+fgMiq7C6rcPLfA0CKRdxAUSlQMHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEXdDqfk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEXdDqfk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so23125e9.1
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776285083; x=1776889883; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dA240JTANsz7Fy6selVjd2W4K7WhqmCNOmhAF00iECU=;
        b=aEXdDqfk+L5h/sU2UvukkhkG6DY3WsY2z7rMLZBPswzweFmTZcibWpU2HtzdJjXhIi
         /ULTJ64bgLswZcAtqtuXj5Bn3y6Suoqut6bBrxhGsqjLl8/SCa36bxIjOlCx7enkZkJW
         K6meM2vkBz3QFZyrJ2PTOpgZkji7tiwBjEzHmq4rvtkjT9ZFEStlMbLz3x433FMzdOHC
         GzH779sQEY9cAC9perPLkRf4n6gmkwx6ZmOlGy3JwgWOQljcEAEb2XZNBEmrU8dWFOdN
         EmZVOdHlhoP9E7sEvV1hgHHkEJbBCIYHF2qD+/y/NWIHNjnpIrH803odAwZMQ9DY6J4Z
         mIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776285083; x=1776889883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA240JTANsz7Fy6selVjd2W4K7WhqmCNOmhAF00iECU=;
        b=peT7dZCXUR817GU6Gqt+vxxv7J6CmY72LBBfdingkD+sYGlt3uGqgLJp+jEHfg+bwj
         6KWDP9OEQEmiT7xXmL9m3mcsEM5fcigpRphsnctuAcLT/ZI/rHS+jGg8rQBGxSJUoFVi
         2zAYN4yuzQkELYk7hTiMGeYLGblI+SJyjjjb5rdaQ7mC8ERqhS+5ILwmOMb5iFkr+Jf1
         0wGbZZbz6rO2RKKuU5Zkf/1TLCRckQAwktwiEp4ekjkEvQqygF4aPGVhbSCekgn7d1Qw
         GdrEJ1k2sONbmd3hm2UwxA0jocOeZbCzsRYjbw74yr4/DvW8EhLHGxn+CXFxErgXO/bY
         +v5w==
X-Gm-Message-State: AOJu0Yy563MRCAu1rSlPxL1XeZgI1Fw0fxcBlakPNf7ohAoB+jZAKzn+
	anZeiWEgfkyKPjHqmVqUZJ/OKDbgQmRLAu3Qn9KdApg8fEp0CL9ricz1Dp8WsYUVVg==
X-Gm-Gg: AeBDiesxylxaQ0bOYaOZjPEtrPdmvwiuav9YKq5sI/kFmqIRYfam12Ccftz7cwFEf6Q
	+FTMiEjeR9Ub1JlzeVz6hd6NQ6TjRBu5ur5WEjb5uHZIPMzkY02ysOtwge1sfBvjIO5lo+ArmSu
	PP6gccVlXOSMOrXUNQVygRQj2Fo2ZqWJrh46Bwhfvpd05XBCk8BIxzOxDz8ZaIl4XdrQ/SVy+yv
	zQiBLQPg4NgdNwObRwUdog+Nt8WeyZye+9/Dy2ZR/HMzc17MmQui+w38+QsVxPQuZDPgpOwSOyH
	uWK2RteFwVI5vV4eQgP9v0Sw3ksTDLJAwGr/0uT+iFRfFrrdk3nkbuSyGjr3TtdvPdrlC4PaCH1
	Tn9FOr9+ypbEq83fiQKCnBs4X5X6ib9+vUG5Y7ZiotIgSPwotFSQKd1BiLpCWvT8qx22NBq5HKa
	XdPcP9QWMPfJQpu/uIPILuoei8oQyoiodiGt1hxroOPMpDP0J50vZ4DwcYp2EOKPMGpMig1+awQ
	e5hfw==
X-Received: by 2002:a05:600d:8445:20b0:485:32b7:5b87 with SMTP id 5b1f17b1804b1-488f4aaae31mr152765e9.14.1776285082458;
        Wed, 15 Apr 2026 13:31:22 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm8126874f8f.17.2026.04.15.13.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:31:21 -0700 (PDT)
Date: Wed, 15 Apr 2026 20:31:18 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v2 3/5] dma-mapping: Decrypt memory on remap
Message-ID: <ad_1lhk44pr6wsSl@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-4-smostafa@google.com>
 <yq5a8qarbcpg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a8qarbcpg.fsf@kernel.org>

On Mon, Apr 13, 2026 at 11:53:39AM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > In case memory needs to be remapped on systems with
> > force_dma_unencrypted(), where this memory is not allocated
> > from a restricted-dma pool, this was currently ignored, while only
> > setting the decrypted pgprot in the remapped alias.
> >
> > The memory still needs to be decrypted in that case.
> >
> > With memory decryption, don't allow highmem allocations, but that
> > shouldn't be a problem on such modern systems.
> >
> > Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> > Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  kernel/dma/direct.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 1a402bb956d9..a4260689bcc8 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -203,6 +203,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> >  void *dma_direct_alloc(struct device *dev, size_t size,
> >  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> >  {
> > +	bool allow_highmem = !force_dma_unencrypted(dev);
> >  	bool remap = false, set_uncached = false;
> >  	struct page *page;
> >  	void *ret;
> > @@ -251,7 +252,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> >  
> >  	/* we always manually zero the memory once we are done */
> > -	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> > +	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
> >  	if (!page)
> >  		return NULL;
> >  
> > @@ -265,6 +266,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >  		set_uncached = false;
> >  	}
> >  
> > +	if (dma_set_decrypted(dev, page_address(page), size))
> > +		goto out_leak_pages;
> > +
> >  	if (remap) {
> >  		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
> >  
> > @@ -278,11 +282,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >  		ret = dma_common_contiguous_remap(page, size, prot,
> >  				__builtin_return_address(0));
> >  		if (!ret)
> > -			goto out_free_pages;
> > +			goto out_encrypt_pages;
> >  	} else {
> >  		ret = page_address(page);
> > -		if (dma_set_decrypted(dev, ret, size))
> > -			goto out_leak_pages;
> >  	}
> >  
> >  	memset(ret, 0, size);
> > @@ -300,7 +302,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >  out_encrypt_pages:
> >  	if (dma_set_encrypted(dev, page_address(page), size))
> >  		return NULL;
> > -out_free_pages:
> >  	__dma_direct_free_pages(dev, page, size);
> >  	return NULL;
> >  out_leak_pages:
> > @@ -339,7 +340,12 @@ void dma_direct_free(struct device *dev, size_t size,
> >  		return;
> >  
> >  	if (is_vmalloc_addr(cpu_addr)) {
> > +		void *vaddr = page_address(dma_direct_to_page(dev, dma_addr));
> > +
> >  		vunmap(cpu_addr);
> > +
> > +		if (dma_set_encrypted(dev, vaddr, size))
> > +			return;
> 
> 
> Right now, a remap is required under two conditions:
> 
> 1. HighMem — I assume we are avoiding this for devices that require memory decryption.
> 2. The device is not DMA-coherent.
> 
> Can we assume that condition (2) will also not be supported alongside
> memory encryption/decryption? That would allow us to simplify all of
> this. We would then only need to carry the patch that disables HighMem
> for devices requiring unencrypted DMA buffers.
> 
> I did post a patch along similar lines some time back. There is also the
> challenge of presenting a vmap address as decrypted on ARM.
> https://lore.kernel.org/all/20260102155037.2551524-1-aneesh.kumar@kernel.org

In v3, I prevent highmem allocations for devices that need decryption,
I believe that modern systems with CCA won’t have a problem with that.

With pKVM, it’s possible to have non-coherent devices, but they always
have an IOMMU, so direct-dma is only used for virtualized devices
which are coherent. So, this case is not important.
This is a theoretical bug, I am not sure if any systems are impacted
by, it but I included since Catalin mentioned it on v1 as I am
already including other fixes. But I am happy to drop it or just add
an assertion that it never happens.

Thanks,
Mostafa

> 
> 
> >  	} else {
> >  		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
> >  			arch_dma_clear_uncached(cpu_addr, size);
> > -- 
> > 2.53.0.1185.g05d4b7b318-goog
