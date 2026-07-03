Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2250B388E68
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079219; cv=none; b=gUWziP05bWTGUq8t/JwRSy/ZYG7TLMc4+ZK+TXClTjvuGiVuzTSIRRjvAx6Ww6TuJNIy/T4x8HG3osrNuJndCKpSDOZYGWz7YGfky1/EN4LRjhUfieBv7VWoX88LNR/jBhQ4a4PVBESG1COdFcJbGdOREwiyuvW/UoaYBhPOFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079219; c=relaxed/simple;
	bh=ErVa6O+H+ziQoQxw89SnZ3zm/NmC5i67ydJ72rOS0eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rX76iY3pwHGy2hiB8olsa3XMcX7p6y8PIrujNfn2KXmcm1NtQDS4x/V2Vdkqe0XtDGMEzv/nOOLfomTuuVmq757AiT0vRCIxthTgttjLrc4R15mdXtwA2dW6iT+ZcoJzMkVcIfwyIHTd9KVMAI9nOyeLKSZrYE4fAvaawcVm0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=b3idcErl; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b3idcErl"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c4436d02cso1394671cf.1
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783079217; x=1783684017; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GF/dZxM95AsUU1wWK1B0B/CUui/snGJUvA0tIkHl1DM=;
        b=b3idcErlIeQB36DyX2V8uG4M/1xQSYHXJwYvS7hMQq8dM23e1qk9uKesz2nWC8tiKJ
         6qE7EoucabPBhw3nwXpniN6lrgQpkuqZdzqDHoT635btbmzIxRvt98l9eazeh93XSN4+
         nQ6jsQY+M2ZQsGXvFJISx++AosLgNxA89C/BzSIXbY7eXZKtVlPE6T5IYqoxmND1F7He
         j/gqZ6WA3IyeNPpPkeHEl46yfu2NM/viAXeLhgsVexCrETMRS1ZLp0+djOuCvyyfviPl
         tzINoRtXieqjs9WMgLw002OcK7Pb4B0wkL6xvcFkQs/vhLMIONFuM+ISBMHi67HSA7E4
         1Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079217; x=1783684017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF/dZxM95AsUU1wWK1B0B/CUui/snGJUvA0tIkHl1DM=;
        b=UKw89bbRspXHzpR4MYYXOl31yG8dkaeYxnZTDruZwLLriPiibdylDRLthuO1amIP9G
         MqH/QJgiP/LGnnXbTkKV2A2Gx2BGXEaS4G+ZPXNIaw3RVuJheInoO6PlBdokBdxk7yQl
         a3eQWtOjJLv9cdHHcfsgiXQY9tJdGVkw2Y5l45CAbmYi4HitFeoLVtIAxVdVirM0XLVw
         Yj22Pwj0K+Y1ohQljr6iAHUMkfXLRYzmu5dhQei+k3tLAlaONM+oNBrRXWdi0avNPwkx
         L1iupWFbQUQM7R1/WU90nOaRM9l4hoCeIGQW3JA3NmYmLEg9IYuFdp6xs1Z4z7mdnLcm
         aGMQ==
X-Forwarded-Encrypted: i=1; AFNElJ92EgZIFbJDtcTyA9wEzVBj112Rda5q29ps1nFxrHDybH71WBoh7oAOyWAkGM13EuYm0Pf2Wg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxUA8PnnOroho5C6xI2os0xVnCSy1ysd2bXghnLA5qzpEbEc/N
	qt/OMNxjEdLxuhLv+qRffudvFV/fkzCmJjaAMQL1gc4lN2yuHgK84wnN0TSCkNhZi6o=
X-Gm-Gg: AfdE7cl9a2oLzpbJErLjbhTxm6XOKVpKRRxK69ELcwFp4MXERREfiM+J1oyK0nIXAK9
	bcQYrrVMaDiYJ77eT8i4jSrD4D4X5g3/a+3WA69ZnbU/BkpM7B/qSyZgyUWWeUHeec8N/m6JA3x
	XivVnYeB5BgZFTTPVOG8xcx69Tep7+O43frlME+jRCkgU8n7l/1oWlMoJPUuUAuQ5dh+ovA/n5M
	323SJ1RwnXg9Ec/rTqORd/XeJjoy6DVUAPLlnnF6GyRa4kupNdyXqXvnHaPbqRvKmLMwjZNtwkW
	nhmdhOmZpJlFKkmtJ8cqv79PhZeQ2mQYHCEJDSrlqaqa23GSiNm1627iEsuk1ABINf5ENbI9wTM
	TvHIf90bDiPDAQIrRy799X6kVmIs5didKXK2jRN4SzocHzbO2ChedlwgJJ5cVWHqDky+UoAXh0r
	omsJOpVhTHc5Oe+9VP11ujoMVrvMnaeoZGkxiLnYGIROrnSTlwAvs2xy/RG84K4RNclqk=
X-Received: by 2002:ac8:59d1:0:b0:51c:555:7dea with SMTP id d75a77b69052e-51c2ad42df1mr112307971cf.30.1783079216951;
        Fri, 03 Jul 2026 04:46:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c4202366csm13366551cf.30.2026.07.03.04.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:46:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfcMB-00000007ngp-0vd7;
	Fri, 03 Jul 2026 08:46:55 -0300
Date: Fri, 3 Jul 2026 08:46:55 -0300
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
Message-ID: <20260703114655.GW7525@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
 <20260617154101.GE3577091@ziepe.ca>
 <25155bd6-4348-4aa8-ba70-0a882fc84db9@amd.com>
 <20260630160242.GI7525@ziepe.ca>
 <98800d21-18f6-44d6-9ba0-da9b77567d85@amd.com>
 <20260702144729.GP7525@ziepe.ca>
 <58bb92a9-c5ea-47a3-b19a-934573f15305@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58bb92a9-c5ea-47a3-b19a-934573f15305@amd.com>

On Fri, Jul 03, 2026 at 08:15:49PM +1000, Alexey Kardashevskiy wrote:
> On 3/7/26 00:47, Jason Gunthorpe wrote:
> > On Thu, Jul 02, 2026 at 10:25:16AM +1000, Alexey Kardashevskiy wrote:
> > 
> > > > > not externally available so I'll have to trick the DMA layer into
> > > > > using SWIOTLB (which is still all shared, right?) as I specifically
> > > > > want to skip page conversions. Setting low DMA mask won't guarantee
> > > > > that the DMA layer won't allocate a page outside of SWIOTLB and
> > > > > convert it. Manually do
> > > > 
> > > > Why so particular?
> > > 
> > > aahhh I missed "pre-". I need a way to get pre-shared pages for my
> > > sev-guest activities.
> > 
> > It sounds to me like you don't, what you are worried about is
> > optimizing the dma_alloc_coherent flow to avoid fragmentation and all
> > CC architetures require this optimization.
> 
> It is not about fragmentation, it is about unwanted page state
> changes when few pages are shared for a very short time.

That's really basically the same thing. The responsiblity for
optimizing the shared/private conversion lies with the DMA API not the
callers.

> When I needed these pages, I could: get a private page, convert,
> (possibly trigger RMP and IO PDE smashing if that 4K is backed with
> 2M), do the VM<->HV communication, convert back to private (and
> possibly unsmash the page).

IMHO it would be better to use something like dma_pool to amortize the
coherent allocations instead of trying to hack with swiotlb.

Jason
