Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81F34845C
	for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109719; cv=none; b=juHAdVzpYOm7e7GTxQjGLJiOhNEu81AO/t8sEPVIseE/xUQVB+1OG1EPXAFXU1gogaIhJx+d10Cf6VJ9fQXejB6i8ZHUvmjW6qRhHO9qXf8sIUXoC8jVqJlH+60LuhA7W5v16QxKSVqS5PqYjiAnWiOukaBPPmMJnhwjhNfS6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109719; c=relaxed/simple;
	bh=aoQpijLFpdT37b0Bpmvd//AN2Bj/cbJFhcJiveomuZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljEyBSB1x4rLTt1h/RL4vZD8BFZxj63bRIZNUGHZbaVcfYYsa6OCpk7zQyd1gk31Am6qVAXMSsv4yNQB1Q7BdlHxFEW1GAVHzDhIynWp5wGjQv7CKc60nqA4sgHHuGjsDwqERkMQKrPFyMNHPyKKijnVD0ETRhtcb2LLCb800e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IPaNqlas; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IPaNqlas"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91587626ae1so785793185a.3
        for <iommu@lists.linux.dev>; Wed, 10 Jun 2026 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781109715; x=1781714515; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeYS8psnLhx+0nTbu07Q/N5cf93jt28LjVA9fcxz2cA=;
        b=IPaNqlasS91c9E8D6tMIAELiF5MWobZ8ZeO9AQPUltCmblqZ0QiTbmPVRtbefStpSs
         N4roP++GYEUVqMvzXdb0+bqmtG/60LEzcMJsnsZdluXc0PsJSUQAEtRx+bdfDzGObTb4
         uf1HIjJaAKFXLFpPt3PzWB1dvEAFH0IyJ9OrTUOevVg0EKc+I7QIlgt/56LlRgCwBkLu
         sVOlBNr5uiDzUKuPFEh2ReNQCk3hvW10n8SDRzxI17a6VbjrGp/39ybOi/k6Ubt0qCeK
         hlI74Wak+sV2JJSpoy0UCCmCISVeQ4MKhAYbUolFANVssP/iU4wKuc+h2e/rLhPc6Q+Z
         Krkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781109715; x=1781714515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeYS8psnLhx+0nTbu07Q/N5cf93jt28LjVA9fcxz2cA=;
        b=bsha/xh7xMnkQBPMAK335jCTenAQpO10SELTekSqNU2CM2INJynQS1fJN1y08pETfP
         7BDsuoaOn/FCqBcZ8U8zCddjFO5BOhHHjdetfVbrh4VXOIoquN5sotKaeD2WFjwRNjia
         aT67Fu+p5sip3bI8jhUGmBtKAAdBFeGO6pHNkONcXfFJ3VOLg3M912ieAlBj5/lBAbh4
         IR0blraLfKViledRffUc+W9mw7mIhbf9pa00K0bdkN8VY16L9pGpAHOtYTsI3FJdljdC
         JH2OXCWoL66Qw7cYQtKQ3sjJrZgViHPmY4LBoTKujcwPfvZE4D4axa6XoBVTCGzADI95
         WgHQ==
X-Gm-Message-State: AOJu0Yy2zQxkfuBRFRVZSjjG14Aars7SV1LluDhLKc0s95/pCYJ/B8y9
	c8jdjfavRnS0dSowtoiUJDlYOfvbzlQswlEDWpiKVBG+Tqi7RFqD+6wbej6lQPnsg9o=
X-Gm-Gg: Acq92OE80cukm5Nzb9kpVpXbNHdkkaww4xAHxfQr4HhrjOyYcHmNp7/04NNBffcgeFT
	9w99drLLXSla3m3R7rmsV0OzaGNhFOXMDVKzucx8SQd9f5SGSFHlqoY6MYfXAkrUQhg1MOOWzeQ
	BVegkAh6grE2/XMZP6MT5TOIVbfu63ZrZvsewCdFRQlrwyXxaUqwn74dmq5Gvi6muYKGr7ibfPM
	LPDu7WCwqWb6jYYBh/7iQtMxxcJ+x5KAUx9Yq8MtRm5WF6OPyQSJZNhHwMHXna/EP1IAHoa7/A+
	EDfv/51LC1KhFneHC3PDT9g4GBPcDPMp/UUYwTS164I/LKXoiIJnj2lMLWEIbIRkQ4yOMWJJDOE
	/uJA48U9M3a/7sQMiHhRaEYeUoxnC9Wk8c3v5T/260HJLWjCyq5mo/AbhIamwKbQD1hFhyM0Raj
	TXNlDeNawsHeba+Oa9Uk5QyIvCipQ1SjRLncHPtfwvixFgxi+kQeVVYm0NasNeooovTEH+xqn5a
	OBJINknrlFsFvr7
X-Received: by 2002:a05:620a:a414:20b0:914:afc1:c66d with SMTP id af79cd13be357-915a9c75c96mr3039706285a.11.1781109715064;
        Wed, 10 Jun 2026 09:41:55 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a22dbbesm2438570085a.13.2026.06.10.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:41:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXM01-000000048i4-3DtT;
	Wed, 10 Jun 2026 13:41:53 -0300
Date: Wed, 10 Jun 2026 13:41:53 -0300
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
Message-ID: <20260610164153.GQ2764304@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
 <yq5afr2uzum9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5afr2uzum9.fsf@kernel.org>

On Wed, Jun 10, 2026 at 01:37:26PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Thu, Jun 04, 2026 at 02:09:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >>  struct page *dma_alloc_from_pool(struct device *dev, size_t size,
> >> -		void **cpu_addr, gfp_t gfp,
> >> +		void **cpu_addr, gfp_t gfp, unsigned long attrs,
> >>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
> >>  {
> >> -	struct gen_pool *pool = NULL;
> >> +	struct dma_gen_pool *dma_pool = NULL;
> >>  	struct page *page;
> >>  	bool pool_found = false;
> >>  
> >> -	while ((pool = dma_guess_pool(pool, gfp))) {
> >> +	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
> >> +
> >> +		if (dma_pool->unencrypted != !!(attrs & DMA_ATTR_CC_SHARED))
> >> +			continue;
> >
> > I don't think you should be overloading DMA_ATTR_CC_SHARED like this.
> >
> > 	/*
> > 	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> > 	 * attribute. The direct allocator uses it internally after it has
> > 	 * decided that the backing pages must be shared/decrypted, so the
> > 	 * rest of the allocation path can consistently select DMA addresses,
> > 	 * choose compatible pools and restore encryption on free.
> > 	 */
> > 	if (attrs & DMA_ATTR_CC_SHARED)
> > 		return NULL;
> >
> > 	if (force_dma_unencrypted(dev)) {
> > 		attrs |= DMA_ATTR_CC_SHARED;
> > 		mark_mem_decrypt = true;
> > 	}
> >
> > It is fine to have a bit inside the attrs that is only used by the
> > internal logic, but it needs to have a clearer name
> > __DMA_ATTR_REQUIRE_CC_SHARED perhaps.
> >
> 
> Are you suggesting adding another attribute in addition to
> DMA_ATTR_CC_SHARED?
> 
> Is the idea that __DMA_ATTR_REQUIRE_CC_SHARED would be used in the
> allocation path to request a CC_SHARED allocation, while
> DMA_ATTR_CC_SHARED would be used in the mapping path to describe the
> attribute of the address?

Yeah, it is a thought at least

Maybe a comment is good enough.

I just find it hard to follow when we have this dual usage. Like the
code above for dma_pool->unencrypted is completely wrong if it is an
"attribute of an address". Easy to cut & paste that into the wrong
context.

Especially if you move things up higher.. having the alloc set both
CC_SHARED and REQUIRE_CC_SHARED or maybe ALLOC_CC_SHARED would make it
clearer that the alloc code lives under that callchain

Jason
