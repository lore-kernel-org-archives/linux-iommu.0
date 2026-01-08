Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191825A2BB
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767883524; cv=none; b=s15gtFElrP+QS0rUVJigyjiDwSbgG90yl4GpmmmfQlZVXMoO/X6nbRy9MD2FRUHp4PwmRvNApWBNSBUe5hjZ5Jsg5h4D8Ex48wx/my/VdXfMwHA1Dts6NVc6yP5mo7ZM8EM1FgfDAcRL/VjlF4mondRWSPBMPuTHVgWOaPrExcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767883524; c=relaxed/simple;
	bh=DhBkaXnKGIzDRLsxPLOuraqjH4fA+nbCX0ARvwiyQ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzD7QNnHjP+kJ3qT279yOdo4goR+bFW95FZdo8Xcs9Aqq7+46oGy9/k3TB2F/VRUtinUppHq7uhiP+kPaLfUIQqFgOBV09I3aTmdpmjPYYF7UYk+pSP5BjG/FZsHFgQJcXBtho+zxVWVcNmqecCyqgUpxmWw0h+Wpu+5RyGBAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AbiAIT4p; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AbiAIT4p"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so43990481cf.3
        for <iommu@lists.linux.dev>; Thu, 08 Jan 2026 06:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767883522; x=1768488322; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N4LHsOGc5pju7+ZZ7G/UCMXvDe5juRNxgmay6MHvgpc=;
        b=AbiAIT4pYoSvn91C5XrRDKOsmf1ufzMFkYdSYSkc09m+fCGZGsjr+ZyiQJHTRQ7mLo
         mGvKRBqF2CWfg1fv1405LKUY/ihB5fEDdBcM6yGcmIvwwJNx8gOuuIXGH5tVMYPHbT2S
         UrgacWG2zWYreHw9z1ECxGOX1dbSo1LDuJwXubzsc4omDOU8ttZnu8Ex+qCAQkNT/dzM
         ZbUsRMeh2jyKzfSi+HO6Dr7VDF/EhUKS9mV3LhLVn5xgi7A00P1nW1w7zhtkhEXuoI9u
         8HdX5O9m6jkBYw+I6xBldd6/VZgxGwCftqPuSoUfCf0o3vdIeCVPnNrNDjXZmjLA7EUL
         dBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767883522; x=1768488322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4LHsOGc5pju7+ZZ7G/UCMXvDe5juRNxgmay6MHvgpc=;
        b=rJ/woNViUjR3ul/oyLQ02QJ9R3VLnmiCmn1MO8FmV9QFvxSBCPdMB2uuwsL/FdXc9l
         2fgFdsxv9Z/Sp50GKHkBa82Xo2lYRWhwVLxO9aKF21CZznSbLDEMWGBe5wFUhTJZ21L0
         tqmGFIwjjPpN5/2shfXSh3I4LZVX0tdqYcDKk4iUKqPR+VO9611nIjJDMk1kmSf503Hl
         IZUlMqYZRwhINa8f2874GHnXokzbioV1QtCtY1N2iAZ/w9oMXnOxNFb41eGUEELOqSk/
         IDqPutYvEw0DXXGXNgTRWszS0lULPsLzCUDmPo9Y2lvyLjHBCwceIjgTLEfPcj7Jq5eX
         wFDw==
X-Gm-Message-State: AOJu0YwI5gZM6/4mXJx+jnVrXvMPKWOVJyW/GujVQmNSdWJBtFxmKbEv
	2LC9+lNZsYh9aifs/IYA4JuLXzyS/vWUt/jfPtevkJhi2Wam6oaABPDCSxxwfJ1E0sQ=
X-Gm-Gg: AY/fxX68dbhirUA7GEdTSUZV5DK42W2ehOONa0ypyEhfoFw2u4wVfJ+JvW/ntvDJp8l
	shtSNhvHrOd14id/iYWW1J4HDTETKg9eIJFSOFTPfUY8zYgBfhO71zW+u7cLVBIY436qFgGg/tO
	XVhnt8pTBj1VX0kmmCxEP63O5HAwm2av3qXMwscXDM3CyfNczUlMreSTUFLI1NGenaPEH8rWDwT
	NYy9jTf4cce3bX8jsiLy0urDdHcPhrZYedAAbM63lUjCduAQlfIPLWQJXUJGny2hXk6aMrLPsGJ
	Lr+E3OUPBVSFit1S+tfHGdVRBuV7RsoI6+BU2CuUarMcQL2T8b2opgvzdDqwlw8/XKLzzPHPUvX
	6d5QdHwZfQcKvtMMI/O2voNesi9VlF0tvcN9J2sOt0oXhh9JWWKAcFfYIKGK1ygdrPBz0v+bM2V
	lo1mJQaR3b/n3nsuO8pLP6yONZUGasOJtQ3G/7PqYKAQF93HpgQ2VIJOn/QdDy8zx7i3Nyv8HI7
	x/vRg==
X-Google-Smtp-Source: AGHT+IES3ov00CDdYvOziEIM2g2UrgYu5X+EmgztTduCXnjzLnO2ob95S0v4/KfSRH05axzpnJtLpA==
X-Received: by 2002:a05:622a:2297:b0:4ed:b8d6:e0e8 with SMTP id d75a77b69052e-4ffb48a86e1mr83270651cf.22.1767883521678;
        Thu, 08 Jan 2026 06:45:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d64563sm48461021cf.13.2026.01.08.06.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 06:45:21 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vdrGK-00000002MBP-1mPB;
	Thu, 08 Jan 2026 10:45:20 -0400
Date: Thu, 8 Jan 2026 10:45:20 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: Drop DMA API usage for CMOs
Message-ID: <20260108144520.GE545276@ziepe.ca>
References: <20260108113846.56179-1-smostafa@google.com>
 <20260108125934.GB545276@ziepe.ca>
 <CAFgf54ocNybHR_Mp1+i7cff-jkeMUV1QxBCt04jnKxwfwnyUfQ@mail.gmail.com>
 <CAFgf54o+YZUyZTszFt-uBW4ZhjrAMsfPFUb9kKTK1uHWdS+++w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgf54o+YZUyZTszFt-uBW4ZhjrAMsfPFUb9kKTK1uHWdS+++w@mail.gmail.com>

On Thu, Jan 08, 2026 at 01:44:51PM +0000, Mostafa Saleh wrote:
> On Thu, Jan 8, 2026 at 1:27 PM Mostafa Saleh <smostafa@google.com> wrote:
> >
> > On Thu, Jan 8, 2026 at 12:59 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Jan 08, 2026 at 11:38:46AM +0000, Mostafa Saleh wrote:
> > > > Jason pointed out that the DMA-API calls are not really needed [2].
> > > >
> > > > Looking more into this. Initially, the io-pgtable API let drivers
> > > > do the CMOs using tlb::flush_pgtable() where drivers were using the
> > > > DMA API (map/unmap_single) only to do CMOs as the low-level cache
> > > > functions won’t be available for modules.
> > >
> > > This isn't what I ment at all, the iommu-pages.h could do the flush
> > > inside itself using the already existing
> > > iommu_pages_flush_incoherent() instead of open coding the dma api
> > > calls everwhere, and maybe that could directly call the arch function
> > > on arm (as x86 does) which would be easier to implement in pkvm's
> > > hypervisor.
> > >
> >
> > I see, so basically, we add the check for IOMMU_PAGES_USE_DMA_API in
> > iommu_pages_flush_incoherent() with the DMA-API stuff and call it from
> > the io-pgtable-arm instead.
> >
> 
> iommu_pages_flush_incoherent() is also used to flush non-cacheable
> pages in generic_pt from flush_writes_*(), so it might not be that
> simple; We might need to add a new variant.

There are no non-cachable pages in the iommu-pages system???

All memory comes from folios and is mapped to the CPU cachable.

The general API requires the user of iommu-pages to know if the
underlying HW is going to do non-coherent DMA, in this case it must
call iommu_pages_flush_incoherent() before the HW does DMA.

Effectively what I'm saying here is to convert the arm page table to
use iommu-pages and then put your pkvm abstraction at the iommu-pages
level instead of trying to hack up all these users.

You can also do the same conversion to the smmu driver to use
iommu-pages instead of DMA API, AMD and Intel are doing this already.

Jason
