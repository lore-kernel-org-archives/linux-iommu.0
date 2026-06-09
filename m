Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858BE345CD3
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015567; cv=none; b=TgiFXV78LpkWkeppQEsO3v2xkwkyZrOX1P++IZVgKwFjOAq/rnCvAY0VMPtC/CXRe+zzF3Boiv6ac4djdqlM4gqTzS/y/Ux8Ju+3PlnLPn4qjL3q0mmyDU8jSJ8eafCvPO7slFMc68VXyy1Lcagp+IOWcxe+b1a5t1fh872eMEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015567; c=relaxed/simple;
	bh=HZyPOuiNCQ2/FcFDihBMt8c7vcnJQS9bgoylFwsrqHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/l0pCGpP2g91jPavIZYgnemKR4MWk3Pt5SdLHCi4Tc3gvAVXHaqD3dBb+iX3oneDHdxECnA/upLe1KPZc1OBDH0mt+ny+R5kqQ1Vnf4Tv2gO9z5wcbFAZS1meBOBZQ3izlzGJshBriyJzs9HfrR5p38gn5I3RI0C+3FN934yh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=l4ulVzMc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="l4ulVzMc"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-915c48e6ae2so234032485a.2
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781015564; x=1781620364; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9KAUhO8tYdZLzMRayCE9PmCg2//sOlzvRLMvdEyREI=;
        b=l4ulVzMcJs2+BxlBOD7AFkOYRSvnOzZHDn+UbVr/SfYOogdxfJID3kjbF7ldxRLxVa
         OPg/nTmFit9A5CKQuVSuEyZ1kYV2ExSvsm23RTktAcSzzmbE/Oo0nvFOHsBU5X/mc6qL
         xe4o9oDGvC7DVpQ5n7W18KScEnjbJADW+3+meAMSE2MMDd3EtCXMJx/KPr5oGHCV98mg
         smkVpHV7g9kTMdKEPlNJQFi6OFoGjz+GorabCQ0EKSQFfbLL180RCyyBhRON04TAp1hp
         Lw4MEcewpPPyMn0ryUZGUA1z6ly+d+apPrDYAzUd+3VcaD3QRTJhAewzGPN/RYCeSS/Y
         tWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015564; x=1781620364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9KAUhO8tYdZLzMRayCE9PmCg2//sOlzvRLMvdEyREI=;
        b=Hf7N3Hs3lgq2GkrGHkJMtE0+Su4oW4tzQ6wO2LYQz8hfrIbSaA4ajxruqivXkgTbjh
         PQcU4RrfE6T2XncqjKI4N2khcDj6XDCxpoRaivkLYtTBbByK6h90WQc3Ez9wf5l5JCk9
         RPXVLS1Wb9uOo9eSeKyh/JhSf4+/X7lbwceAiAEP5xcm8Y1tWA/Oz6+lHEmxtWm3ILdo
         bTLGAPbeyFAEJqnxHMHPhS3eXpI9alpKLyog63PUcoAyEJvuIkqJmRJuB9MOsBAzJXFR
         ZL8RnCwCy7cnL4N+YwxoBt99ZjjXRyiJmgPJ1V1rsYVmgWOuZHcCs5t0bOf5qvdNb9EZ
         XzJQ==
X-Gm-Message-State: AOJu0YyPc0Y7AkjFo6DP4STruwDul80WSmNO+VFXGcQJC7Gz+e0fXFEU
	EeM6s/gp04pqsle6jr9ElimrGVtBuEGyoD1cGa1vcwlDwdwBoSLCyxoAL0S+bstapWA=
X-Gm-Gg: Acq92OFarfll9cROQZMtNw8FRlgMho6r3nZJ1Hnq4Z8KDwKuglM7fV7iT+bSpdE/E0s
	duc+xUHHkDA43I2buc6Ox9ZFUorzSruIoETqQSa9TJfgK2T6asvaNv3nVT8Ci5sHT8MzZsfzvgh
	kqJjtXASAGtBNBW3eSZs07eJJzepOztkB6e9OThvvwkN5CZK7gMzDznpMfr3xZKXD+Lr24SYEdA
	JBXf1ZKSDo/NdTJ+3PwGI7H9hBr+PmaBOfP/gCctO5Uica1NB2X5rFLoTcCDCKU8B8wHQJ2qk37
	uk2IwCyIUzpQHoAEYuzgBJvKiZrowRG87rUP7X0opzdMHnX3ZvxOy4w/ek+NAeV8HF+vrN7IRoy
	SKFTmgLKFbQ3jj65v1YHOOztP6pzlazsbY7UjZqUSlz6NDkKQ8oklwtXBUKESw9hppaEDubqsAN
	+QghoUCFYDhCci3olHGGbZmtPFuzAMEvngjQwXJ+nnNgca5bi06NnGRJs6EmxkyrEkP2/MWZgX2
	YcI2voCFsobGkIT
X-Received: by 2002:a05:620a:c46:b0:915:9f28:6748 with SMTP id af79cd13be357-915a9cdcf02mr3443110085a.23.1781015564257;
        Tue, 09 Jun 2026 07:32:44 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00afafsm2106743685a.2.2026.06.09.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:32:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWxVS-0000000241b-3Vv0;
	Tue, 09 Jun 2026 11:32:42 -0300
Date: Tue, 9 Jun 2026 11:32:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 04/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260609143242.GK2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604083959.1265923-5-aneesh.kumar@kernel.org>

On Thu, Jun 04, 2026 at 02:09:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> -		void **cpu_addr, gfp_t gfp,
> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
>  {
> -	struct gen_pool *pool = NULL;
> +	struct dma_gen_pool *dma_pool = NULL;
>  	struct page *page;
>  	bool pool_found = false;
>  
> -	while ((pool = dma_guess_pool(pool, gfp))) {
> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
> +
> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> +			continue;

I don't think you should be overloading DMA_ATTR_CC_SHARED like this.

	/*
	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
	 * attribute. The direct allocator uses it internally after it has
	 * decided that the backing pages must be shared/decrypted, so the
	 * rest of the allocation path can consistently select DMA addresses,
	 * choose compatible pools and restore encryption on free.
	 */
	if (attrs & DMA_ATTR_CC_SHARED)
		return NULL;

	if (force_dma_unencrypted(dev)) {
		attrs |= DMA_ATTR_CC_SHARED;
		mark_mem_decrypt = true;
	}

It is fine to have a bit inside the attrs that is only used by the
internal logic, but it needs to have a clearer name
__DMA_ATTR_REQUIRE_CC_SHARED perhaps.

The sashiko note does look legit though:

	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
	    !gfpflags_allow_blocking(gfp) && !coherent) {
		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
					   gfp, attrs, NULL);
		if (!page)
			return NULL;

I don't see anything doing the force_dma_unencrypted test along this
callchain..

I guess it should be done one step up in dma_alloc_attrs() instead of
in dma_direct_alloc()?

Jason
