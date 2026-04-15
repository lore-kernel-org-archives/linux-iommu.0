Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A43845D9
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776285793; cv=none; b=cRZDS6kCMprFbIQVEqj1KHvK7xNhNuisyb0eqqoKxXiLdX59UC1zSTIWCa3Ev4xj9nCCnuO7MQcyQO80+76aEcXNSPS7rIuotmVEBQvWUtsH/6m+EGr7BPbXsezqpn2lJhLutyqfPdE7QDXAwHnyaDivbLqvKkMgLP0/PmDLTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776285793; c=relaxed/simple;
	bh=vfi6Q1Mu41b5c1Pr+FpKRKl3TJAWTCn0dsYCuTL07Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAMEguiRGa9CZo7xGlQlYZjdVptwNoh/BkBXAj/uRZ4cEZjnzkwqrigBaGFOspC/iSZx3XB2P0MWeGsm8Oe2LEYLM9GoFJqK3Sj6i5l8aYVotwjF1sA+sF+TFSWCmCmSHEuqQ+hz0iZTCys0iKmCRj2xGAZVoti/DZ/MeC6HRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgDvW3YJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgDvW3YJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a62b7372so25815e9.1
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776285790; x=1776890590; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4YRQzWoS4RDEswHnpylQeJ+99oJ3JUS+eOagFQY/XkM=;
        b=fgDvW3YJVrEiIB41TcTmO/eVhgMVfw3nHmg56eMhw/UNlHqpFafVHL94o9J6AeL4iR
         3mikQzjvAKP0ZXO1B3qTCQ1hY7HZ9TfVmvaN+ck8R2wioaN2Hbs66fm8jQlRBSvBTMI9
         dQUnMvinStLeW9EjK+GhC/13/8m2+eIJhcAFqzCBcr8ad4K425bLMhwkapsWQOgJHJJt
         0kbr5Otk3KQTJTNuDZLOPZhJLeA7xUz2a0GF/OBFfZeFX3TFjfcuGI70lfeGTbm1wKMy
         uI/pzInR3WJX2IQyCdOGzYezS1lMvI7UO7NJ7EbqiCTmdkeAOtyNhDssMDJu24OprL7L
         iAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776285790; x=1776890590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YRQzWoS4RDEswHnpylQeJ+99oJ3JUS+eOagFQY/XkM=;
        b=BgAYx1HzAwv8mOas2mZvzuJuQSgDys7Bqsp6hOLPnRNlVvWmFPMK38+ijrMJaHYz0j
         Atff9GrEUZuL6Y6Q3BJJAaK0eJSMAH1faoScmPiEF+ON3+Aa68yRwH8p+UDEPIYA0dSZ
         DfiQE8rkJLX1OSaPgZ+zOqSc+0qW6SlauGe7wCi/XLzsMfOyrLRdhxkC15sWCc3wb5Qv
         CXcQJfEtgYjVXgxFYPbp7D9aLNYE/42VHmBJBc7CjO2SB9yfAZQUvu4VJtf843bGA190
         qx5A3XPuQamYgtZW6So4OMrBNQ20Dm4hvF3+iN7HyHTJn3jIB97QumevuQxinBMHrVhc
         VBSw==
X-Gm-Message-State: AOJu0YyXSS9LCQkroB+V5V58tsmXzSwogBCGP/21olANsp9P4INTTOkN
	dpqh6SZwdwjzVwjA8v3aBEQ8T/mK4CZBCSksvlHy1Mmte3jSZMvvHLZOtPhJNQSXPw==
X-Gm-Gg: AeBDiet1Apkx4x9DdmRlyPfEGVDChLkmfwvKnpqk6W42opAkN1R8o9qvnZ0wQgIZE4v
	VltletIDIB/pcKVI0In/uAtmf9sbGpvjQX3Bd5zQsdvdATweNi+p5Dl2BAZcuAGrK8XVwT5torQ
	VoEKCGkgK+w5sYium7Yo0MhhDOGPAu4UKJFifOybeLLhxQFpoDKpZwaSD+7T1qqxuZLMDe4Tkci
	zhNOza0Rs31StJYhlzMrqPwohXNmsq6ynoPwuBGH7ZK6UPFSdcRZsankTq3QpuwbPmek5mG7qS1
	tNHoAO10dQGI1UKfHHlFtHmivCPTKFtbqDdb0D6aaNz4O3ETRqyaWK8V7VxN/Ch667CqlJtauhV
	Pl81rMupC8y6WMYMuIEIyfdmPQScfu0fm6Vt1KhBga55i+1Ks3XRiDiMm+rlGsXaXxoQiaVTZzU
	7RqMhwAcFMvoDvUY/dxAPKJC2OL1eMazxJcj6KkuIDAN59rH5Q1NGBzePQfufrXYGFO01nyWlSI
	VNzhH4abD4T3aUC
X-Received: by 2002:a05:600d:1b:b0:486:fe1d:a60e with SMTP id 5b1f17b1804b1-488f4d77023mr103595e9.0.1776285790115;
        Wed, 15 Apr 2026 13:43:10 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm257930935e9.6.2026.04.15.13.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:43:09 -0700 (PDT)
Date: Wed, 15 Apr 2026 20:43:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, jgg@ziepe.ca
Subject: Re: [RFC PATCH v3 1/5] swiotlb: Return state of memory from
 swiotlb_alloc()
Message-ID: <ad_4WtW5uEZlDdLU@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-2-smostafa@google.com>
 <yq5awly9ao6q.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5awly9ao6q.fsf@kernel.org>

On Tue, Apr 14, 2026 at 02:55:33PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > Make swiotlb_alloc() return the state of the allocated memory, at
> > the moment all the pools are decrypted but that would change soon.
> > In the next patches dma-direct will use the returned state to
> > determine whether to decrypt the memory and use the proper memory
> > decryption/encryption related functions.
> >
> > Also, add swiotlb_is_decrypted(), that will be used before calling
> > swiotlb_free() to check whether the memory needs to be encrypted
> > by the caller.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  include/linux/swiotlb.h | 25 +++++++++++++++++++++++--
> >  kernel/dma/direct.c     |  2 +-
> >  kernel/dma/swiotlb.c    | 23 ++++++++++++++++++++++-
> >  3 files changed, 46 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 3dae0f592063..24be65494ce8 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -63,6 +63,7 @@ extern void __init swiotlb_update_mem_attributes(void);
> >   * @area_nslabs: Number of slots in each area.
> >   * @areas:	Array of memory area descriptors.
> >   * @slots:	Array of slot descriptors.
> > + * @decrypted:	Whether the pool was decrypted or left in default state.
> >   * @node:	Member of the IO TLB memory pool list.
> >   * @rcu:	RCU head for swiotlb_dyn_free().
> >   * @transient:  %true if transient memory pool.
> > @@ -77,6 +78,7 @@ struct io_tlb_pool {
> >  	unsigned int area_nslabs;
> >  	struct io_tlb_area *areas;
> >  	struct io_tlb_slot *slots;
> > +	bool decrypted;
> >  #ifdef CONFIG_SWIOTLB_DYNAMIC
> >  	struct list_head node;
> >  	struct rcu_head rcu;
> > @@ -281,16 +283,31 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
> >
> 
> Should this be a property of struct io_tlb_mem ? 

I envisioned that this would be mainly used by restricted-dma so in
that case it doesn’t seem to matter.
But generally, I guess it would depend on the discovery mechanism of
this memory property and I can imagine a memory allocator that has
multiple pools with different attributes. So propably it's better to
be per pool.

Thanks,
Mostafa

> 
> -aneesh
