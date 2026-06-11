Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D733E717C
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177864; cv=none; b=ZttuLY/oR06X8jdjoiXk8XKqlyY0u24imEBJbZbIE89Dfy6bOLVnMCe+vVH0MK89J7AB01x3AkK73IwNvB9qiTaVTBs4NYaPEmv2ltB4xin/b76ftP4zr9NNByoevnBEZzGOfL5Gcn24sBvXOdJrm6RL3wUEdsZVfjtno/rfL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177864; c=relaxed/simple;
	bh=orxD3R+xslULBC2Qa+4Si7LAvHUVQFpXJKWY1Fr3wjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPfNSKGbkdvMBjLvK/YHchzA3cJN6qQuIQyGWClF9gDFJ0uLo9NdhACb6SMI26XTNPgqIeb7uGYM1l9tRMzTSiMBzOgVn8ETloqRvraxR5FPZ/innA0BtS4fxTANGRaObK1MWyBvghiE5Z4V+8p9L1A14lIgwksmZjgmTSsFouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TFVdIrHZ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TFVdIrHZ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ccea53f35cso78707546d6.1
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781177862; x=1781782662; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4CsqKJTBvj+SobIiLXzFxApwnBR8BVsF1yARBI6K1lw=;
        b=TFVdIrHZ0tS320SxQ3wdg/Yk2Ti1PxH7+EYUWiKtzEJ6WFor87OkFs4m1bY+JMfQ2D
         +X2YkrL2tDbhOcW4mOBXZf+WqkMachSwO3tJIQNbCmFjsEBF2A9f/K7izt9XhAAFUac3
         E3xEw51Vs1u501ehM8sIK8K9cOhiyu/YuMURiuJ41C6X2OKMBViYLBfgnqnpfnclj68i
         6VDNW2LV18Vvv30RNqps7eKXgjG+1xvu9Ovgc74+U3b/poGZwZ44mEKH+bpcwpUxdvW4
         nD4CtZxs1aab6oU7IMuABiS/OMWrQ8sgpZH/GbiWaxSLScUY0q8VW5d/QnIF+xjvvjFT
         BCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177862; x=1781782662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CsqKJTBvj+SobIiLXzFxApwnBR8BVsF1yARBI6K1lw=;
        b=mw2OuNPq/ZEOMv7Q4JvYViOTZk6/m5pA9hcocc5vd4b8lwn6bURRlBYC5ZO2tE7Upm
         hPsl/59rJ/fD31UHJu+88b+m0vdQhyN3qqxOk+wF/rblv5BvdEUXluWPDa8tss7Cr+Uh
         zsRpNmzFARGfQYteoagjMlQ9sVziKwhZ86Kusc7IKRwgtsFSS3tR+MG9ohOQWndUdK/W
         8EE41ye8T5EKdXp1SPc9R+lnFMk0BB4CHAlq8E3NtuD0AAzdRsIY5eMhzRb/MXnfU8y1
         10WJnCxngqhszNqlc1am1y/xzVUxHgfZKcJb+9W4rh/7+HLWnW+xM3VnZ1m2c+cUlna8
         rsaA==
X-Gm-Message-State: AOJu0Yxbd9NOX0jEn1GDQM5XmNdvOHo92SCxtXlFB7D4r8muRIxanPsj
	IMYFIFXthOEto1BJjAjvchSFvGBAWUdz4jchVbeezwVZMKiDeZBWhb1kxTWXgr5DmmdJ0pRAxc0
	FuEuc
X-Gm-Gg: Acq92OH2Q0xAs4L5KadcNFsCncRohFl6qjKr+8+pxE+W1/gRabeiq7ryTBQWBHF8htO
	y/gybc8z3r0zxC/r6kzcAQY73qQ2/CAv8DQX1IgIIJ+9kN3Zdx1f6PiAGFy/8TXoLlI1kx+Fui7
	6xMXSl9qbFDoZQx8mPg2GIgaVfNSPBemCvUGvudCK6y6Z5MU3ch3B1vO86x9Njho7qvOJsiIPLp
	54SGp8uL13ANkln0HCZAbhraPUeW8J2soAKW+MLyp9Vj5lAUDec2JTTq77x8oAxTeDOeuvgROoL
	4Wh0IwThXWzjTJUYD68Ah6Olb6mHQW66+PAX5RRbI9JTBBiJDt9Nmp0gbKbeqVUULmggkCnpDup
	pVLRIwu4DsRp24MumwGVV+Y3qRRrF+1BqppqOyLAwLOtrjz20l4sEM832esYhRxxdPwclO7O1rJ
	qkyl2QI3qDQ/tvaJgYvsp7zdBB599wWSRg3C4PuNTX72rb6KCTLtvkrFsmZhHxh2wcpbRcgp2Gn
	FPVx9Bq7gkfO5Gg
X-Received: by 2002:a05:6214:410b:b0:8ce:b2e9:a4c1 with SMTP id 6a1803df08f44-8d1d8cfbdc0mr38674016d6.14.1781177861623;
        Thu, 11 Jun 2026 04:37:41 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e838f586sm15478786d6.20.2026.06.11.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:37:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXdjA-00000005ezW-0ftx;
	Thu, 11 Jun 2026 08:37:40 -0300
Date: Thu, 11 Jun 2026 08:37:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Message-ID: <20260611113740.GB1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
 <yq5aa4t1myw4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aa4t1myw4.fsf@kernel.org>

On Thu, Jun 11, 2026 at 10:55:47AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > The sashiko note does look legit though:
> >
> > 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> > 	    !gfpflags_allow_blocking(gfp) && !coherent) {
> > 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
> > 					   gfp, attrs, NULL);
> > 		if (!page)
> > 			return NULL;
> >
> > I don't see anything doing the force_dma_unencrypted test along this
> > callchain..
> >
> > I guess it should be done one step up in dma_alloc_attrs() instead of
> > in dma_direct_alloc()?
> >
> 
> I think we should do something similar to what dma_map_phys() does here,
> considering that we only support DMA direct with DMA_ATTR_CC_SHARED/DMA_ATTR_ALLOC_CC_SHARED.

Yeah, I think that's the right idea for now..

> +	if (force_dma_unencrypted(dev))
> +		attrs |= DMA_ATTR_ALLOC_CC_SHARED;
> +
> +	is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
> +
>  	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
>  		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
> +	} else if (is_cc_shared) {
> +		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
> +				attrs);

But it would be clearer to put the test in the iommu_ functions I
think, since they are the ones that have the issue. We will need to
fix it someday..

I think we can ignore the op-> functions, arches cannot support CC and
still use dma_map_ops..

Jason
