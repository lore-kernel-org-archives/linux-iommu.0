Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA174DBD68
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620819; cv=none; b=b3OhIXJLD/qvRawGMzaqlhP0yus2Dw6EHQi3Qa4CuhejEfYemk0nKsDIW5tIP4HLSn47flPl9ixX44UeNZnO6OLrnB+ZMWKAurm3LL9yEBDWF5+zYDv36bYuXCN80W4XoPcg04L9P1LOssOXnV9PmbL0FgbWI4nX6lxHWYLG7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620819; c=relaxed/simple;
	bh=bvUrlGSFk5YOKRSganZsEuUYcVv+Ux1auqFKnDwJzG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMzI/9frZMnSE9vzpTTes6bQUrpTljXlBvwJZMcEX333M/v0/8kpPArIaywzYI4OITy88mMSw/kKJTK7FMRUCzqettzCCnFIIsCKGfPph+Nv4w01gurvFKCDLrPrddIbiT5UuaXRd3IPItBrBzVbQlO34sU8VtZBHuF9Q+emO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W30nxUWe; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W30nxUWe"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c928bf172so381171cf.3
        for <iommu@lists.linux.dev>; Thu, 09 Jul 2026 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783620817; x=1784225617; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cHkQmsdB2OewXXEQfHxageXwJQg6EnEw6Gurdq9kErI=;
        b=W30nxUWesP6diPPmP3mg9MWKyOJiRr9vt4sLrFXlitBqiyqZMRgJ67HJTI7rGFymnp
         Jt29jaO/+dWLLQ8FFefyzDtY/jBnAETJ7I6GtPenFl6QYpwj6vM2cYTbMWkN5EF69+G4
         oJs/J/ucDfbyUc2nYJF4BpVR7hkwqKw1kV/K+5virlKijE4OPTBxHGdOJtQ97+wH0EHH
         722GqxAox1Dblv/+O68I5QXQ//Xz/7+4LiWget/D/6S7xI3mT9PO5/iRd3WuYPC7ZEwV
         g8BHlgKiMEafksKMpp6uFPKJZkZrLEYbaP/nPOdrdC65MhepWB9yEbtr+ZANqAB4xp6v
         xTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783620817; x=1784225617;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cHkQmsdB2OewXXEQfHxageXwJQg6EnEw6Gurdq9kErI=;
        b=qYQdsDvUTbi+H8DtgTmIccbnSEN/wuU6jMAaz99ly6Ina/yFkZ1uSrna5+1dhfEb4L
         PJlcyFTS/50/xF6A+Ga8Jqdj1rKXdFB1/rZ8xfFV46DzjIJYKiQExqLczz7Y3MkWiAvT
         1Ac+ag3CTLbUI6DBlQF2SaA2Ea30TirS3YFyMeUa1mc/zkvIufAkgCMkYhBilxcnVXMj
         WwrNpIkq6IBrn8lupNO61j2oMJMVudwJMvpb45HRwrrUKBvgxsrMgFneqN+eLgkqW/rh
         oa9NaoacaMn/GlYGhN1TPXJ5MgA+DN09Jax04G7dcBPIemt/a0A5jHicItwGefz6onpR
         +s0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrbmMBd9+vzKzw4u4QOS3WKBU8rF25Mjt7lKxBY5xVnOYdgfQojPRcqx04oPtwGZKeBXIu2Sw==@lists.linux.dev
X-Gm-Message-State: AOJu0YymvTnOr/utbyX9j+rFQCB5WEz+rlUQ360CvvNu+jtfu98mT+tT
	MeQbDvTVgciRvBeyPgfoePkTn1QJrTv1q2bD4WXX/AliECdX3u72dRf5gArh1IzJdxo=
X-Gm-Gg: AfdE7cn3ag867ZDKJX3jNuFFtbBiFu6AZlD+9KJcu+rIw0cm8ZMXDa9CSlBOt7Q6dTo
	LPifqrGPLay6V498gRn4cegtUjyG9Q/2rF+WGTIuzkfnCJc5JOOwVT2bGdmhjL+Tm0JOZowQN3P
	xbHglkYuPo+EeU1m0owovZsx65mQ6vDsvO1EJxR9wqt1BO8SqbyH27oGqg8YUJLLSfuglrK4SsR
	dhnsUjP+zKEFKrD0Nchn/X8fUNSbgnllNayLLD+Hcn5nrG/07zL3WCbGNtXuLYZxKuF4SKqaJkA
	v2MYtZK07OjdyOyOSJRyMReAnfZ9/CT9KnBZvSAGDEfEB2tVRRkXpLwsgIXlUAAHvaM64C/aNdN
	LMoOzDWHeVxfwtYI7nt5vFXF4d1xY79wQkcwaKhb5bL6od1hgZlVjr66NhZno
X-Received: by 2002:ac8:690c:0:b0:51c:43d8:8604 with SMTP id d75a77b69052e-51c8b3b4eb1mr92527611cf.51.1783620817365;
        Thu, 09 Jul 2026 11:13:37 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea9casm22695666d6.42.2026.07.09.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:13:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1whtFg-00000005Kqr-0IQc;
	Thu, 09 Jul 2026 15:13:36 -0300
Date: Thu, 9 Jul 2026 15:13:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260709181336.GM118978@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak-CT3oanlDfgTy4@arm.com>

On Thu, Jul 09, 2026 at 12:13:19PM +0100, Catalin Marinas wrote:
> > > For AMD/SME, on host with memory encryption we now end up setting the C
> > > bit for DMA_ATTR_MMIO. This is fine for RAM but not sure whether
> > > some other MMIO bus understands this attribute. Maybe we should stick to
> > > something like __phys_to_dma() for the !CC_SHARED && MMIO path. Or,
> > > since this is not universally defined, just use the old dma_addr = phys
> > > if MMIO and ignore any unlikely DMA offsets.
> > >
> > 
> > Considering for AMD/SME system an unencrypted dma addr is one without C
> > bit, will this be good?
> > 
> > 	/*
> > 	 * For host memory encryption and device requiring unencrypted DMA,
> > 	 * MMIO memory is treated as shared by default.
> > 	 */
> > 	if (attrs & DMA_ATTR_MMIO) {
> > 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) || force_dma_unencrypted(dev))
> > 			attrs |= DMA_ATTR_CC_SHARED;
> > 	}
> 
> Yes, I think it does the trick, preserves the current semantics for AMD.
> I guess you could use a single 'if' for all checks (up to you).

Please don't change it, MMIO P2P is broken on CC systems today and it
should stay broken. Passing DMA_ATTR_MMIO with DMA_ATTR_CC_SHARED is
an error that we need to correct in the drivers not make work in the
core code.

Jason

 
