Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00046AF3C
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 16:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835370; cv=none; b=YLOy+IG6MJLsbkTbAWuwcqtffrJdEspoVmxOXYJu77gkMUSErzbZgzo9wC6TlBnhqGdoBylpgkug01I3JOzuaoclKlS9suwrz37DtcSaCm8fyTN8Hj793jvjJ5DM6rH9j0Rawav5uTL3gYrdhLq2QRFTAfDtx+5ptqP1W0KK6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835370; c=relaxed/simple;
	bh=kHw7DLrL4QjCK55x79lTHIkq15rpEE6+NeVSt2Lz+08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzp5GWfhxVyiphoe4SR8dIxFeG3C1UbsQl7Tc4RYYozidXXi76ywgMPgdCunPfd3YDCGVi5+r6BG3i9/ScJikEuaeJSq7YwSy23ExAT54neX0up1SrIcw3rPggUd0m99ec2eqIEaiF9KTLiqyMQmJyksAfsRMvz9HC33nksV8sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TBw/Q1pk; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TBw/Q1pk"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9217d13c276so340131685a.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782835366; x=1783440166; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GI+sDv/bw0RypxsaDxkfRwNjpEKuAX+hIc2iRD1v3+Q=;
        b=TBw/Q1pko6zt+O9sZJveMKx2EO5HJXx4007+gUJVzbOhs5B/NOJZvtdIsmIoVBxm5u
         d64SMjpDC50PYoGrrPqJLzk/eDGq3UX2Hks8xGbWrn9M53bc3sMiAvunK/a13y9TnSJU
         NUvI5jz0cNoVdzn//Kof7dETuDQBb5FAvADfgBJZ+U78X4ZTkKtEeLdS7xMXPqVku3Vv
         ri4hqojUrtmNxwXWar08AqX0hAqjVhQZDA1SVwE1cuhXunxB8zqjB1PtouTl9ty0lT/+
         VjVyA5gx+64s93Y9gKmcnlmGOVi/ZE9YdwhOxIA+vF/Boi1WvqsbreVtcyncTURRLFxI
         FqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835366; x=1783440166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI+sDv/bw0RypxsaDxkfRwNjpEKuAX+hIc2iRD1v3+Q=;
        b=BKMA4oRKNdLnRfYVZxOgZ5NvDh2DFO+Q0XL+vbNR+M6OUuXPtBoHgIXG1Gm04IAs5B
         oZGRLdSICbAzNL58+zSb/qO75K0TmQB0/nivWQN0eYFRvLraFkAP4WnXiH6J9PW3AmzU
         /zl0JGX+cg7NPVGGyf1kLw/R2o2RFTawcVk6sgWWeYjR8uCRL1JlRfMmJfABZxv88sQB
         crPimYlO6hUtSJAACxbJMGlv97BeymojG4ZxA1pv9UzzDp7xRP4rWXbiA5ag32GaCwmp
         mCA7xt/LyDm4sngBgrrT583QPhMtnubrc37mxkt7LYtxrxIaCRcSZqDg1cY7orCBpX0w
         56KA==
X-Forwarded-Encrypted: i=1; AFNElJ+Wh5f6vb8cqnV7h1dWG1QZ/gO8RuRGRAFwjZWHVpQe9JWeao71KKp2zvzREz2eIzeZYMUO0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg9anASBFauaXyzUKPamSY8G+ZQBjiUtb9MbxDHrCndVNDOlYs
	JVJeBBqXNlu5/gEsc1wq6qe2xynpkWKcfW33j74dO4oS3ZwFnDMxRbLLdWLF0wafoJI=
X-Gm-Gg: AfdE7clmeO+TYRY7A+T0QO2v116DrL9u/kxKLrEN9Dylcs8vwNz/Gw0Mt3noeMT45LP
	DBsuyElRxuFwmOQw31/hyuMmD4dXYxFf1oGqO4wdN49yL0+z5UkwmceucFxb3EfSajLFXqHexRm
	2nOsbQeruJ7xKv6n2GW17LcQJpCk2Dy707nerpguVoraC5O9oSgsOXPTFD7X5wMU3/lU0SGB2aw
	v2SHbjUOKvmRJDoltN6xKEyk2dVfVw5KlKkkJpw+r7e95qtDl008NHOZSYwEXxt/JRa969UOndu
	YXTHVX5girkZZpPCLC4744k1j500JUw8LTkfMiO5M0zylaxrbCMoLDBow0bGdqDuGqp/Vw2+Q80
	b0uJ6ndxLIvqcmLK53Yyfyh+eT0Gq3ib0LfMCnBQiz9ag+DJE5+gUvpwZhcyEg8OVdv59i+4BQ1
	WlZTHYtynhB9DQI9K3h4nRY/OUWReWpcoBgYnKUWS+ZdxlTyGm6eX3XBPHyQ8roZu6UKc=
X-Received: by 2002:a05:620a:839b:b0:915:c4de:7ac0 with SMTP id af79cd13be357-92e6278d80fmr646181785a.31.1782835365891;
        Tue, 30 Jun 2026 09:02:45 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6236b9fcsm262102385a.41.2026.06.30.09.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:02:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1weav4-000000027Ay-3dT0;
	Tue, 30 Jun 2026 13:02:42 -0300
Date: Tue, 30 Jun 2026 13:02:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>,
	"Cheloha, Scott" <Scott.Cheloha@amd.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <20260630160242.GI7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>

On Thu, Jun 18, 2026 at 12:39:21PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 18/6/26 01:41, Jason Gunthorpe wrote:
> > On Wed, Jun 17, 2026 at 10:50:39AM +1000, Alexey Kardashevskiy wrote:
> > > > @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> > > >    		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> > > >    {
> > > >    	bool remap = false, set_uncached = false;
> > > > -	bool mark_mem_decrypt = true;
> > > > +	bool mark_mem_decrypt = false;
> > > >    	struct page *page;
> > > >    	void *ret;
> > > > +	/*
> > > > +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> > > > +	 * attribute. The direct allocator uses it internally after it has
> > > > +	 * decided that the backing pages must be shared/decrypted, so the
> > > > +	 * rest of the allocation path can consistently select DMA addresses,
> > > > +	 * choose compatible pools and restore encryption on free.
> > > 
> > > Why this limit?
> > > 
> > > Context: I am looking for a memory pool for a few shared pages (to
> > > do some guest<->host communication), SWIOTLB seems like the right
> > > fit but swiotlb_alloc() is not exported and
> > > dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed.  Thanks,
> > 
> > Then setup your struct device so that the DMA API knows the
> > guest<->host channel requires unecrypted and it will work correctly.
> > 
> > I think this is a reasonable API to use for that, and I was just
> > advocating that hyperv should be using it too.
> > 
> > But it all relies on a properly setup struct device.
> 
> Sounds good but how do I do that in practice? 

I think we haven't got there yet, I understood Dan's plan was to add a
bit in the struct device that signals if the device must be
unencrypted or can support all memory.

Currently the dma api assumes all devices must have unencrypted by
default so it should be fine already, shouldn't it?

> not externally available so I'll have to trick the DMA layer into
> using SWIOTLB (which is still all shared, right?) as I specifically
> want to skip page conversions. Setting low DMA mask won't guarantee
> that the DMA layer won't allocate a page outside of SWIOTLB and
> convert it. Manually do

Why so particular? Any address that satisifies the constraints should
be good enough?

Jason
