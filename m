Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3483E8335
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177447; cv=none; b=N+hO8X+AfRL3wRZf8js5eaWdS6CORtTEhFl6Ch0xEe9e4p22LHUsI2Hpu9kagUMWQzW0orpiV2bDzoKHdaIQMLuc/Jbhq9NUxpnPQA6SN73uluTBFznOIgw27iL8BgrXeSsESPVqRNacWEIw/XwtoENoyKggLcOD0sajcFflgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177447; c=relaxed/simple;
	bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWTdZStjrceKMMuzCCqXFG57V+6K47bPAeneh/l/2bLRlRec2Ua/FT1KsSWjq92Y2/bigibiHjyMUy+MeWJY6EOUVzAzstUQe+qgJxWTX7tMM8rAcVeA4hU0hUStTIfQA5AzPFPkmRBPmDkYkSBf/HGmqNFNSKRRv/B6rtHvfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Iq1lOZ8R; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Iq1lOZ8R"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517583cb07aso84173731cf.2
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 04:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781177445; x=1781782245; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
        b=Iq1lOZ8RZe0moH5N0hb8bGIYJ5WBFM1t8JVsBtHxKlPsiHD0Gr0dIrlJCiwojYNRkh
         VDz4dSAX9eecKRgoatYAXLehJH8G2D1Fme7UYQzQjz4h7ird5OZP9GqvxiKBMKpb4glR
         HRAxeATB3+0R36u+cNQO9ZgkSWUqPlP25GvHfeoHyRiM39DRJyQjXdcNrtorIVkz3ofV
         140Qd28Mlqx2fADbxp5uI+h0Fpg4AtKkWYyzxBVOh7SDA8rFPsjj21vOKw0ou7VidhAf
         /CWzWnWzAXP3ZsQSFqH/JNLmKhU3lo6O7fXr9EHHaV0TDJpq6Ce9643H06i9eQV/AYeA
         tBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781177445; x=1781782245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haH/H6OcYua3Z5rTl0sktjLmKVSLqKAqacU21OYuo/8=;
        b=S3eJdRJOmOOemctRiVcYrwskXWWsy/kAjvUXeGcEiwIG5YX0S0hvPsvMJO9NT5l6hD
         Vmo/A778GxeHyohWzdOZPPfZNSXtDzAtX+z4VseN8SveQjgEjznCqR5k5gzEjwVYvKWG
         cfwRXx0vJw5zT9vOw5w6G7VGj76y5+SRTjHpqnAXs4BWh6x8bKeREmhL6EkA6OFKhEAU
         BTHhTy+5BEhTmYvhGUcilhwOQFFVaswtgftR5MHGzCd0cdjBgDm7Tiw5vq1ODJXcC8MW
         myEekpYbKr5AgESTJZK6yblFyEREPqi0iQwGUhL1PBOu8i9WqKzrRn1tEWAwB5hCOhw8
         8hvg==
X-Gm-Message-State: AOJu0Yz0uGr9Z7oNgn/tiCvtqv5E+D2SuwNowl9PDFU1tSLxzFvNn6dd
	WBBH3/IyrCKfVZ7ca1yVnF8yVJwL/JB0CzG+JWJ27YDRm3OQtxuy2Nc+JmoL0++mD90=
X-Gm-Gg: Acq92OE8OO7YSyD3xC9z1oPNX9SsPOM+MZw+E8IXTFx+AlMPktkFxqoKpX3t3vADd2H
	uOlvwqymu83Zf5Cj+5LDSeoFdXG6zJ1WppkWfiZrIqoh6M4Dp5W9APJHfI0zChSizfUS5stCNYT
	Pfmjc0uk8o4MKHw7E9Io2WIUl8E0qgXBFzeitiu09f2Z4TITWUG4QS0rVsdCD9GlyRHHOosNhI4
	zCwRZVsh/Zlg0DGYgEVMuUWJG47l73nr3mOfNtvRKekkXj3VMlEb18bhGZiVpWUFkxB421Fm1oJ
	meQrGBScDeo0BI6I63VHiz5cecwkU/0gF3xw69uXmWgRPrPj6KGvetsIWdchQtoAh9dnQLYc/Sk
	8j2Gk9pCe2XY0nGd60BOwtSqOjsvWyZpgX5j4YGnbkNG3nf2+SW2d7Fv8s140XI8bprV/Ohs7cp
	m9eV9dBU5tjSPY46xbINWSTk5vGVsfXT5lZVyjItEdHsN+3oEkXeoKWfWwn+WVwgKJeCu/8awLq
	S6lxRwCaGf3g2L9
X-Received: by 2002:a05:622a:354:b0:517:875a:d619 with SMTP id d75a77b69052e-517ede4125cmr35159281cf.6.1781177440327;
        Thu, 11 Jun 2026 04:30:40 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef61dfeasm14521801cf.24.2026.06.11.04.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:30:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXdcM-00000005deq-1WZO;
	Thu, 11 Jun 2026 08:30:38 -0300
Date: Thu, 11 Jun 2026 08:30:38 -0300
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
Message-ID: <20260611113038.GA1066031@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-5-aneesh.kumar@kernel.org>
 <20260609143242.GK2764304@ziepe.ca>
 <yq5afr2uzum9.fsf@kernel.org>
 <20260610164153.GQ2764304@ziepe.ca>
 <yq5acxxxn0gp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5acxxxn0gp.fsf@kernel.org>

On Thu, Jun 11, 2026 at 10:21:50AM +0530, Aneesh Kumar K.V wrote:

> If we are adding DMA_ATTR_ALLOC_SHARED, should we also allow
> dma_alloc_attrs() to take that attribute value?

I don't think we should..

It is hard to see any reason to allocate shared memory through the DMA
API. The way the DMA API works only the device that it is allocated
for can access that memory, so it is effectively private to the
device. Thus what purpose is shared device private memory?

> +DMA_ATTR_CC_SHARED
> +------------------
> +
> +This attribute indicates that a DMA mapping is shared, or decrypted, for
> +confidential computing guests. For normal system memory, the caller must
> +already have marked the memory decrypted with set_memory_decrypted(). CPU
> +PTEs for the mapping must use pgprot_decrypted(), and the same shared
> +semantic may be passed to a vIOMMU when it sets up the IOPTE.
> +
> +This attribute describes an existing mapping. It does not allocate shared
> +backing pages and must not be passed to dma_alloc_attrs(). For MMIO, use
> +this together with DMA_ATTR_MMIO to indicate shared MMIO. Unless
> +DMA_ATTR_MMIO is provided, the mapping requires a struct page.

Yes, though we need to fix a few ATTR_MMIO users to make this
statement true

> +DMA_ATTR_ALLOC_CC_SHARED
> +------------------------
> +
> +This attribute indicates that a dma_alloc_attrs() allocation must use
> +shared, or decrypted, backing pages for confidential computing guests.
> +Allocation paths use this request when they select shared DMA pools,
> +decrypt newly allocated pages or restore encryption on free.
> +
> +DMA_ATTR_ALLOC_CC_SHARED differs from DMA_ATTR_CC_SHARED in that it
> +requests shared backing memory from the allocation path. DMA_ATTR_CC_SHARED
> +describes an already-shared mapping and requires the caller to have
> +prepared normal system memory before mapping it. Callers that need shared
> +memory from dma_alloc_attrs() should request DMA_ATTR_ALLOC_CC_SHARED
> +instead of DMA_ATTR_CC_SHARED.

The semantic is right, but I would make it a private attribute since
no driver should use it.

Jason
