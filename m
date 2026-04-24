Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93BF25DB12
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777071318; cv=none; b=IdCKletJqs3b96b4IBbdJGj++o5n+3QgGEqhvxTCJJKqG+2p7hq+raNyfSuX/GiWJ8Vi1Tpoyyg3jRkLkpypEtDeynrZnK3FIDFMc+NybcPHDub6q+sQ+kyZP8IxyanMjI82p/+6HewVntI30bwW19Z5GoXNwDVvGh9S07OA8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777071318; c=relaxed/simple;
	bh=cV0Gxz7W/U+/DxuSBdghEEEy6w6inDWrgGPifnEQWHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfys4mLP6MndIKXNenf3BeMtZM/li6++xfzML9kHkVM+HS4cfZP4inmYbeY8AWWgOTUPkRs5YAkwZlptuYZ3iJVJi3vGRsfXDqF4AdneBVNNUPkvB/Vh+X5TvzyEMrgRcvOuU1jghV7hZO7/jGKTNcbp5tGxbDY92+Ppxw2Ii3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=j2s6gtMi; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="j2s6gtMi"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899a5db525cso65839336d6.3
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777071316; x=1777676116; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dw33gELuGUNq59I/OY2f7G4Yqpl4DyjVQaY1TU/E47I=;
        b=j2s6gtMidN7T236PMkGx+W4FXYwRa6eIECKjvlTJY82WwyHmZRaKuNaSDUmc+WNFsV
         cekEdt/9KprVLPLDQCiMzVnHKVWKWH4HsUXvHrQb7pkVSv4VbhVNR6p7tPI+Z8v1zLbZ
         jolb9ZsQ5nODJc6zqd0LgQvEAyWxZ8LB79i8M/UPA1VDFpMJDkzr8fsDayLx4sl+iI2i
         YSNU/eAQhCfGU9CEGyvJLDpOjn2t3NjXsX/PCdJKy5Z1xwmULACsg/Zs/q+meNJcYcfw
         Ic3RKOmv+Ho+7op0txrn/ntUQvTXqgdw6cwXfVzE8Y8v4vBpebI+RE9J6+1fF+yrYVj+
         eL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777071316; x=1777676116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw33gELuGUNq59I/OY2f7G4Yqpl4DyjVQaY1TU/E47I=;
        b=ZrYBqNoMtC/1QY/orUNHHPaiosmelIqE30aMej4bxWsClsdBD87UwgFhhkLI6BcKMw
         wKoqBxBjkmx854FKGVLf91+y6lM9AkARzsXfFORHdT8spEmNQI9HP2sj3VNU5VYAsD/U
         KLNXqwJfrKKFB/wWGSN82RvgDum4yyg4/7TtOUX/fIkxBk2ge0+sD70XaF2Cfe+Q9RKD
         SEOu7IiwUH7pKL+CNVvknuN6fib/EBjXhta46SjKFlW/r10/FxkKM7aBcxxg5qQwUkN4
         zsrFsmaDXWVXj6ugivomQAqyTJyN8Nm4HyaosEAcNe9w2YBcHa4YIjSJQ9eAbMeFiyjC
         gGVg==
X-Forwarded-Encrypted: i=1; AFNElJ9k00hCoGzzjPrVXu1X7hcR7Fn1tgj6HAruqvlryNJC5bRYEByZe3rJzVoLx1IXLAgXEoTd5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmscDsfY3k4LA/fKBPoq5rtqSa/xGMcJyBZscfbpaczj195Bza
	4ijJ++/r5RtPjvDBm8LEiyiVVbzVZI6azCMbu6q+bXbDEA6P/6H90vGFY/phsH7TsHw=
X-Gm-Gg: AeBDieuaGX/XjJhHa9lxOdEO+cY1+tUIN5TKRK7dOl98qnUJufL/t2+Je3Nx+4uLuJu
	N06dre8a3D+2ZVevENYMsZNZc3mi0T5YRpxmai5ze4bo3+V/5XKCCqxQxkoS2PfzcM9aLK+ZqNR
	R7nNi17EHYjDEAa3hRcxbGS7CHYxRO48U1IFmgAlb/HfisrC0SUdv0X2qNG2Wi5fbIL2yEgw9Xi
	J2q+zbqfnSNFr4cRAg8Sa65kFW3nqyz6xppPtmvYWDHFI0jTCuumwn8ldWR4jMuWA9UImvQQkP5
	6j+mX5/jBnzjehRTiliuP9RlPaf0NiKaPidEBmpxWn3xIcCx4buD3NdoSzYnH8GihSIY0GsBP4+
	EWpkhmolO5dfx0KjqRifQ+5EZ7GMMGlDQqCqnxuDmTfuRxheEcEoruzfPZE8GS8gKel+mP/CL/2
	tmTD2YACCPvZd52ylHGNqUnsYcmDC98vMGAzQlajo1fbVUWK2nA6w/QCKMVYPJWLWmXBt2bkg+C
	stChrI7JvTXlrUb
X-Received: by 2002:ad4:5f0e:0:b0:8b2:2474:8f3a with SMTP id 6a1803df08f44-8b224749034mr37604816d6.25.1777071315667;
        Fri, 24 Apr 2026 15:55:15 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac78513sm198480506d6.19.2026.04.24.15.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 15:55:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGPQY-00000004wIG-2XfJ;
	Fri, 24 Apr 2026 19:55:14 -0300
Date: Fri, 24 Apr 2026 19:55:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	suzuki.poulose@arm.com, steven.price@arm.com,
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260424225514.GE804026@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca>
 <yq5aik9jcpzm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aik9jcpzm.fsf@kernel.org>

On Wed, Apr 22, 2026 at 02:48:37PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Apr 21, 2026 at 01:53:31PM +0200, Jiri Pirko wrote:
> >> >> You reach there when is_swiotlb_force_bounce(dev) is true and
> >> >> DMA_ATTR_CC_SHARED is set. What am I missing?
> >> >>
> >> >
> >> >So a swiotlb_force_bounce will not use swiotlb bouncing if
> >> >DMA_ATTR_CC_SHARED is set ? 
> >> 
> >> Correct. Bouncing does not make sense in this case, as shared memory is
> >> already being mapped.
> >
> > It is a little bit mangled, there are many reasons force_swiotlb can
> > be set, but we loose them as it flows through - swiotlb_init()
> > just has a simple SWIOTLB_FORCE
> >
> > Ideally DMA_ATTR_CC_SHARED would skip swiotlb only if it is being
> > selected for CC reasons. For instance if you have the swiotlb force
> > command line parameter I would still expect it bounce shared memory.
> >
> > Arguably I think this arch flow is misdesigned, the
> > is_swiotlb_force_bounce() should not be used for CC. dma_capable() is
> > the correct API to check if the device can DMA to the presented
> > address, and it will trigger swiotlb_map() just the same without
> > creating this gap.
> >
> > Jason
> 
> Something like this?

Yeah that reads pretty sanely.

> static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> 		unsigned long attrs, bool flush)
> {
> 	dma_addr_t dma_addr;
> 
> 	if (is_swiotlb_force_bounce(dev)) {
> 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> 			return DMA_MAPPING_ERROR;
> 
> 		return swiotlb_map(dev, phys, size, dir, attrs);
> 	}
> 
> 	if (attrs & DMA_ATTR_MMIO) {
> 		dma_addr = phys;
> 		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> 			goto err_overflow;
> 		goto dma_mapped;

I suspect P2P is probably broken on CC because this doesn't make
sense..

This should flow into the
phys_to_dma_unencrypted/phys_to_dma_encrypted block as well AFAICT, it
shouldn't just assign phys. Assigning phys to dma on a CC system is
always wrong, right?

It is is more like

        /* To be updated, callers should specify MMIO | CC_SHARED instead of
	 * implying it. */
        if (attrs & DMA_ATTR_MMIO)
	   attrs |= DMA_ATTR_CC_SHARED;

        if (attrs & DMA_ATTR_CC_SHARED) {
 		dma_addr = phys_to_dma_unencrypted(dev, phys);
 	} else {
 		dma_addr = phys_to_dma_encrypted(dev, phys);
 	}

        if (!dma_capable()) {
            if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT)
	       fail
        }

> and dma_capable() now does
> static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
> 		bool is_ram, unsigned long attrs)
> {
> ....
> 
> 	/*
> 	 * if phys addr attribute is encrypted but the
> 	 * device is forcing an encrypted dma addr
> 	 */
> 	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> 		return false;

Yeah

And with the above little edits it works for MMIO now too.

Jason
