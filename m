Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4154DB574
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693100; cv=none; b=Iul9Fq6sy70Xer1vy0ouvXD7KsIFwxJVX5+DomCxeIiCUTv8bUsbt75rczRCbt3FUui211MgJGz55RNWpL6JJxOxw4TAiI3ffJ2O2wPdE42LD8s2sw+FHwlpXvUX0nesdYx3W5QIsXXfSlg3f2ASwN8fAM2IsoK142qCAQsgIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693100; c=relaxed/simple;
	bh=BfC504n+kThMXbLodptWdwF+5sTWwaf4D5wXQNX5RnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esbdUbn9Jl3xkUQ48caUupHF70eqGrzzjXRWocHHT+6FU9zNhPgFhOxEbk1Lx9tj0XoGkDsHncqWKfhGoxKhfApytM2+tg+vtXDnDu1WmViMcUGuLKsucxSmFKyG9+REO3tTPtrJcu+tbPPt+9gn+B7xZc1My0e/5LhiP9x448I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=diTLTNGm; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="diTLTNGm"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9103019f8c4so73483785a.3
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778693092; x=1779297892; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fQtwNmxswhQih8gmC6FPDl+zfVKzr3i0rq4YmglfcBk=;
        b=diTLTNGmhCzdtJ+NRsujqK+1p/V4K8syBN7koLP8469L3r5vDF8JmO9dVYvGRYQ0JO
         GQ4+v62TgIC5yZ1XXI+khnEcjBWf/vMziwrSTq5V2Zif5/iDDg4yqURpG3pgf5FSAxqy
         NkAeHJN4Ur8P53UGvYapAHzmCTTP3l7radxOY0U5LkTOxRHhuQBzKAOmFzf6MPFqgF/g
         y7JU21ZOfCTiroh9dQkDRAfVqKQ3+IAih6J//pbBVvr2OYjGhBBDmUdlMy5SgVaWVIzR
         olnPTOMuYD0xzd6t/cQaassSeCkY5IGJZKhVn9/mzDDbj8tnnsjsOo8gSa4r3MfB81Ho
         HJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693092; x=1779297892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQtwNmxswhQih8gmC6FPDl+zfVKzr3i0rq4YmglfcBk=;
        b=e5WuONim//nNxaTgmNEMbdplLefz75ACyBYhkbdEMEBOw5VrVbV6zz4qeKoMv14jRG
         xaZ74Vp5Roj9WyyvJCpHyAnqsRSWbslMBqDcqDF7kkYl3RrB7z41z2T2RPlKEY6fdK3q
         tze5sl+CjQOQkAAq4pRJ0+/XwBMPPty9PbGY+5PeywjxOHk6QpwSNsA88F6V+YMzE3Pf
         YocRqDteg2grwMPV88H3Acmo9vMWyvRyeuiRbu1GrWaqojSKVgIws4/SMJGbS6n7/dXz
         WzUpC91gvRNhF0Fv1Ng6mD8yKRvADIxYOo2Utr2TE0XUakfmLgMvhT1IBLNVgVG1QqFZ
         zN4A==
X-Forwarded-Encrypted: i=1; AFNElJ8jIhHBstkfNlGL+o1moMlj444xSBk8D5kJrLGQ7ZouXfRDPYfIS2pFpRly75DYhtwmOh8/FQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxgsus6j3+34nB1t9duEV+w9q0EsRNCnUcyktJz6JqVP1V4iXoW
	1YbcYoFbe6FTXQc0uZSkr4rrM44CelXB2xVpEzCqbNNajLeH5ZCSBBBphutfCEO+PLg=
X-Gm-Gg: Acq92OEDrXG1XVHOSAM0RMtL939P1q0+Cvbv0EkZCXPL/FCDfvG7OeWdVhl36oPaCQx
	lnn1znCxDgrhf0bn5XW+d1UPQkB3cZGzTdCyJMRm+stHetWkLL2cP3d3h0a0LdazFISnoUf1ujg
	bAIkTiKGxZuZx8zzxqKi61KyK6AJihY/S5wRZL9V4klhlz0zjfSJPrnElsqXFvYKLqJW09OrgMP
	y7+5gLLi8gfvYV7Vs7i6RB0jrIg0qckEpwNy4EkMyAIMCss43ljnrNFgmOt08bZZODNOYqiqG8O
	R/WQIetMevcHiA7T1nZdW5AjRxc68JwZUbPF7CMvNXQBZnUDSnHFwFGWYikuXYoGh4javFZ3b1F
	ONwVf8MGIGNdYGAlkgltI148rJ1FfrWL+yaXljozbqxUv2Q61fiPP357YbTp4yovexgn4hW2Xx7
	NsNRTv9iGOhTdrYbpzp8ynGjSS9oA4dzy3akkmKPSRKBwvTBqZ2flBvJ+X66U527vrSJTAAE1kt
	78KyA==
X-Received: by 2002:a05:620a:19a3:b0:8ee:42cc:4d9c with SMTP id af79cd13be357-90f8ac08735mr658592985a.39.1778693092335;
        Wed, 13 May 2026 10:24:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83bbf5sm13598685a.28.2026.05.13.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 10:24:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNDKE-00000003dZu-0jxL;
	Wed, 13 May 2026 14:24:50 -0300
Date: Wed, 13 May 2026 14:24:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260513172450.GR7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agSKQrSIhizCXKwx@google.com>

On Wed, May 13, 2026 at 02:27:14PM +0000, Mostafa Saleh wrote:

> > +		/*
> > +		 * if platform supports memory encryption,
> > +		 * restricted mem pool is decrypted by default
> > +		 */
> > +		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > +			mem->unencrypted = true;
> > +			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
> > +					     rmem->size >> PAGE_SHIFT);
> > +		} else {
> > +			mem->unencrypted = false;
> > +		}
>
> This breaks pKVM as it doesn’t set CC_ATTR_MEM_ENCRYPT, so all virtio
> traffic now fails.

How will pKVM signal what kind of memory the DMA needs then?

Does it use set_memory_decrypted()? How can it use
set_memory_decrypted() without offering CC_ATTR_MEM_ENCRYPT ?

> Also, by design, some drivers are clueless about bouncing, so

Oh? What does this mean? We take quite a dim view of drivers mis-using
the DMA API..

> I believe that the pool should have a way to control it’s property
> (encrypted or decrypted) and that takes priority over whatever
> attributes comes from allocation.

We should get here because dma_capable() fails, and then swiotlb needs
to return something that makes dma_capable() succeed. Yes, it should
return details about the thing it decided, but it shouldn't have been
pre-created with some idea how to make dma_capable() work.

If dma_capable() can fail, then swiotlb should know exactly what to do
to fix it.

If pkvm wants to use the hacky scheme where you force a swiotlb pool
configuration during arch init with force swiotlb that's a somewhat
different flow and, sure the forced pool should force do whatever it
is forced to.

But lets try to keep them seperated in the discussion..

> And that brings us to the same point whether it’s better to return
> the memory along with it’s state or we pass the requested state.
> I think for other cases it’s fine for the device/DMA-API to dictate
> the attrs, but not in restricted-dma case, the firmware just knows better.

The memory type must be returned back at some level so downstream
things can do the right transformation of the phys_addr_t.

One of the aspirational CC things that should work is a T=1 device
tries to DMA from a decrypted page, finds the address is above the dma
limit of the device, so it bounces it with SWIOTLB to an encrypted low
address page and then the DMA API internal flow switiches from working
with decrypted to encrypted phys_addr_t.

If we can make that work then maybe the flows are designed correctly.

Jason
