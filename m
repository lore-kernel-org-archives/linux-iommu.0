Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459233DCD9B
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841340; cv=none; b=SVzRpvyuqBGbfPiidkAJqOgmIGdlEzFXB+h43Cg17U0IpBk4fE3KTlvg/iW7Rw2JWq0OiktfwwTLTX/+2xMMyi2CoXi/t7vW9Px1g/Ozb8FFWoKYnj3+O2aqm2QKvkpLuyZnoW543c/TuRbhiqkm3y68wb/9Xf1iFaNzDDgTbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841340; c=relaxed/simple;
	bh=40oEbRtFZjh6zocY8nSse6CdFmdhYjJwkaMk4N2oNpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLZiSksaVXfYhxjtzlPloEcEzyuKFxhbpolKIH8HW4Z6qaDBW5ENDwx/TUZwMuW5uYJaFo7u6ujS+TjO7zX+Fhz+gSe2mQjiqdmH1h36UffPWumvxypEQNoP96kHelntVXbaF/OQFZV8NLKk7jFK7CbK0WtDlDxbz13K/lKpCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=naEzMBKM; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="naEzMBKM"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c19f91d7dso5352781cf.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1782841338; x=1783446138; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zClWOUjkDWFvMHOUBkD6PB+uKy7SGdgOfe7bM5K85sk=;
        b=naEzMBKM/o3XhzGwYn4QKVmTG/TY8X25tX7ADYf0IJIQW+fmEbQNHvPaoGfjgg8LEj
         inbxQe4tXC8GG+7w+JPgoXNtiWpw7bLCGLLFoRmFmxnKEu1Cq54GdmVgwxzDKx1xBRGJ
         yaaBHUxjECEpwmtfNmjzgzVKn/rgCQiSGZHg4FHbIXkAc+VzrmczrzJLN/uhtjNwJY0G
         SE63E5GMQT9O//4dCPJ2lySLUirM8pZUcmyrOkyQ3BfXJsFhzd4vy4lX3yRbQ6+k8Mf9
         TtzOsdW47gg8oPdZNV/bXAxNGJR6CIKrQ6aBA979vHpJO3Twl2z1ZF4KMEiru53OisGB
         IMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841338; x=1783446138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zClWOUjkDWFvMHOUBkD6PB+uKy7SGdgOfe7bM5K85sk=;
        b=nbopeXn/hvKP1pv9BGbwiLfKm0DlxbaOpkr/W2XPWzZngpPGmx521ZYQrklzX2UUS3
         10X5YIz9LrqROmakxLWuEOVPT++vVwdYbAkAiaXky9CtJC0Hssl3m/Y8ophYAby58iI8
         D+ss9y+evTR5ExQsx5ECivUP/9syNWKsswgty1O3CjRGCalKAql+83f2+96Abyl2Vr5S
         Xt2S3mdhDb8CUGLOIzFSBpJosHaRfHI5JmdYxqE5H9YTupT9a/jF2GLXfhhjRjHFV30z
         9rO9I/rQ/CzCHc7EM0lzw9YVVNUoW0WUE69UskDk1gVPBVna1KgQjXRnb2egMr8QjFfY
         6HQA==
X-Forwarded-Encrypted: i=1; AFNElJ+q4lVKeljMk/b8Jo69O5dk5qzr/42Y6atOW/v4DfqgLALhdDoTIOYcGvQ3zVkHDWCQ0C5zeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQ/PiwebwtgzJj9emvmVIO9oE4GwJTA4OTxykjWYrLVDq2OPKd
	bRHhhF2+pqz9c6swBRjwT2izZv0NHoFSqOzLVmlWELYsWLc/AiS0IgGL5WpJxguMScI=
X-Gm-Gg: AfdE7clxbee8egZmW0eK7Vm6pxPzDP18Wvt9QUXTtyonnQMT1wEOFkYdTgfziwJQRaw
	4CLAz7swZiKRLr6aOW/YklgaP3iob80LiFfmfXFikRnRtcHzpzrOHU1qDXgPiQM7rANor68RjTj
	J1rlKpCxbIWxKMpS+czJaEpEgs+7AMqljey4L3+zFL8nX8acyh6L292MtTP2O4LELzEcPbHPipf
	HD9oARPHB8sBrdEU+QIS4Un9mZ8I7VdTfuUs15d/7ORXWCRof9Ea0xas8/rEz3uZDcCI3lEUaIL
	BXpfQOo6T6AQgj1w5PJ8MwBMGu+gP33dgyiJaJturfAvDL3kx3EYt42ENrs7hN/Fxu23gLwvcjW
	9Yz6YMBll/yATSns+EiF0v2t1T0F0MOr5TMkAFAO3NL0ZkebC5LculKGdTYcTDtgYv1pWrlgVLB
	1rZE/4fPm9qwgqtsG/3EXicYXGF/dY5XwepZip5+kfrgK48bJYgArpRkJhetH/OJ6BWE0=
X-Received: by 2002:ac8:59d4:0:b0:51a:8c99:1f14 with SMTP id d75a77b69052e-51c108ca48fmr58918701cf.67.1782841337969;
        Tue, 30 Jun 2026 10:42:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d4dcsm22942861cf.5.2026.06.30.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:42:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wecTQ-00000002FOX-35V1;
	Tue, 30 Jun 2026 14:42:16 -0300
Date: Tue, 30 Jun 2026 14:42:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v6 00/20] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <20260630174216.GK7525@ziepe.ca>
References: <aigYbK12D8uKQvJF@arm.com>
 <20260609144746.GL2764304@ziepe.ca>
 <2ecfa1a8-6202-4319-9692-a6ffeb5a3dbf@amd.com>
 <yq5aqzm4dz25.fsf@kernel.org>
 <20260618153705.GH231643@ziepe.ca>
 <yq5ao6h6enhm.fsf@kernel.org>
 <20260619122148.GL231643@ziepe.ca>
 <yq5aldcaejos.fsf@kernel.org>
 <20260619140616.GB1068655@ziepe.ca>
 <yq5ao6gtoncp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ao6gtoncp.fsf@kernel.org>

On Mon, Jun 29, 2026 at 12:16:30PM +0530, Aneesh Kumar K.V wrote:
> >> Thinking about this more, I guess we should mark the swiotlb as
> >> cc_shared only with  CC_ATTR_GUEST_MEM_ENCRYPT instead of
> >> CC_ATTR_MEM_ENCRYPT as we have below.
> >
> > The name cc_shared should be used for GUEST scenarios only.
> >
> > I guess there is some merit in keeping swiotlb using "decrypted" to
> > mean it usinig pgprot_decrypted and set_memory_decyped() which AMD
> > gives meaning to on both host and guest.
> 
> Are you suggesting to change the struct io_tlb_mem::cc_shared back to
> struct io_tlb_mem::unencrypted?. 

Yes

> > IDK what AMD should do on the host by default. I guess it should setup
> > a swiotlb pool of low dma addrs "unencrypted", but not "cc_shared"?
> >
> 
> If by low DMA address you mean using an address with the C-bit
> cleared. 

Yes

> The current code already does this and uses the swiotlb pool correctly
> on SME.

Well, through the force_dma_unencrypted() hack...

> The challenge arises when we want to force SWIOTLB
> bouncing even for devices that can handle encrypted DMA addresses (more
> on that below). For such a config force_dma_uencrypted(dev) will return
> false and swiotlb will be marked cc_shared/decrypted = true; This trip
> the new check we added.

Yes, because cc_shared (guest) and unencrypted (host) are very
different things and we've mixed them:

> 	if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))

I'm aruging force_dma_unencrypted should mean cc_shared and be
guest_only, but the SME hack breaks this.

> We can also do
> 
> 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> 		/* swiotlb pool is incorrect for this device */
> 		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
> 			return (phys_addr_t)DMA_MAPPING_ERROR;
> 
> 		/* Force attrs to match the kind of memory in the pool */
> 		if (mem->cc_shared)
> 			*attrs |= DMA_ATTR_CC_SHARED;
> 		else
> 			*attrs &= ~DMA_ATTR_CC_SHARED;
> 	} else {
> 		/*
> 		 * Host memory encryption where device requires an
> 		 * unencrypted dma_addr_t due to dma mask limit
>     		 */
> 		if (force_dma_unencrypted(dev))
> 			*attrs |= DMA_ATTR_CC_SHARED;
> 		else
> 			*attrs &= ~DMA_ATTR_CC_SHARED;
> 	}

If we do this I would like to split the force_dma_.. functions into
guest and host, ie force_dma_cc_shared() and force_host_decrypted()

To make it clear there are two very different things here.

> Here I see value in having DMA_ATTR_UNENCRYPTED. The question is do we
> need to split this into two flags and introduce the resulting code
> duplication.

The external flag name should be DMA_ATTR_CC_SHARED and only used on
CC guest. Internally that turns into using set_memory_decrypted()
which works on guest and host for AMD. I don't know how to make the
host only case clearer and still keep the code efficient..

> > The dma api has to detect, after the driver sets the dma limit, that
> > none of system memory is usable when:
> >  - The direct path is being used
> >  - phys to dma for 0 is outside the dma limit
> >
> > Then it should assume the arch has setup a swiotlb pool for it to use
> > to fix the high memory problem.
> >
> > Similar hackery would be needed in the dma alloc path to know that
> > decrypted can be used to fix the high memory problem like for GUEST.
> >
> > I guess some 'dev_cannot_reach_memory(dev)' sort of test in a
> > few key places? Setup with a static branch to be a nop on everything
> > but AMD, compiled out on every other arch.
> >
> 
> If we are not able to reach the memory because of the memory encryption
> bit, then isn't dev_cannot_reach_memory(dev) the same as
> force_dma_unencrypted(dev)? If so, that is how it is already done.

Sort of yes, but it is properly named to its purpose and not confused
with what should be a guest-only function.

> x86/dma: Disable forced SWIOTLB bouncing for SME IOMMU passthrough

Maybe as a crutch to get this series merged..

Jason
