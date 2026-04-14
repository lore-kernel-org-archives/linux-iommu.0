Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD92C11FA
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174827; cv=none; b=W7PNiWL8y84GIlFMRs+rOc/9hKOiQ3LLInL0DjdCM2zID1R8Id9i2wlBrj9SVTWTjQVo89ETs2K7D7i+Tk8rrYYqI5pXyWq/psmz8A/JCojAPh0pmR6iizwJdhxBjBb+aWnoCz+xxxsMnVx8SI3ZzkWue20h08ewyMa76vDDqFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174827; c=relaxed/simple;
	bh=agaeRtwkMA9kaPGKqOXGTWRQI0ciOIvM/jSTFUjl92g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSnoPLoTtBtMSqcreWhZdOTdu9via2fww9MFjMLiHn7ATWmwsXK/pR4ip6HdqmnZ5ccVgONPB+nCp8h1pysFSPrZF+09vfS7ZAzo3EGcs/VLfJ2/6NRYRqBsOCDGm927BeDrxwwFgKkQEOcGyVVafXdtANM0jVnzIf1uwNooMKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=POMEUypd; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="POMEUypd"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb20bcff5aso519219185a.3
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 06:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776174822; x=1776779622; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7axfg4tAJWa7PpDSpQhlxF21z1bYy4oCdCdcYbJBzTg=;
        b=POMEUypdL6zI1Ar1hpnIeQzNryfYw3eCfBtefeZQyiMLxuA4gNSEEFQOkR/Vk+5ZmX
         xJ6YOmTKWL+187RAcWXNBlRXAaZjGPOjNqQYbhzapNpPNgluTu91X3xITWLBSSgn1SfF
         K9JWGw54/O48MPwxXC5iWtsSdpSrcn2oRMezQBQ0TSsRd+aVN8VZgWuo5Z3JEpTmocHC
         KdjAY24eo294H6GZgB6cQf7OxLWz/+cXn3o2cha4BAlUgXcdS4JM3mc95VVTRr6tu65Z
         1Vce7e/fS/maKo5EMdoWFoUrtjat7IIIpybEhJOz4/Vo/Nmq8aTPGQJKjDdKPKCyjYMm
         U/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776174822; x=1776779622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7axfg4tAJWa7PpDSpQhlxF21z1bYy4oCdCdcYbJBzTg=;
        b=fRk+iZUGv3iJ5a/OPTrUM6JAscBH2aE+ph6lyG4hdpQia4vw6jNb668ngGOZLn3C7k
         ISiWYbmidoFlcdGUWHX4KL5oL2RgXoJdchd6zKjnY9M1T6zLPAjnJrwx53TBjPmxQfDn
         ijWuZymCTu04b/Gtkr+e8m9Pw69ndoh82eUbIqlG1n0K6GU001jGcj5F/mQuG0jrzqJm
         aB5igj8L/4c+gVa3ZN7QKrTBwOYPYfLSDGXjhPKbP0h0FffGPpjFS3jlw9qrue9Z1d7j
         zUenz1nMktvLPHdpoV/qlE187foTvTiSB4bgdn/75hkzebC24j9hRaslg4CVyOXbcsUv
         /74Q==
X-Forwarded-Encrypted: i=1; AFNElJ8UBojJMkkflXS2qgUrN+c2y+rqyEbxx2MKolEhVU9I2aVBXKLyrvn6RKYzTGsHv1OYu8+8pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzImPdxlLfBtNM0JK1YEGp7pT4mmo55F7DGaLZef/8YoffRTdpt
	MoLXq0f8mce8clRqKTXcu3RhNfmFlXITfQaBOS7JF1nduWE7eQrF3uPdfwwYoRpzkeE=
X-Gm-Gg: AeBDietWH7HnOZeeWyLwiQ96LiJ6RCoIrR1qvLQfC0TofH3CLjMjcAEtopGLhZL35VJ
	7S2qI++cs+DOHetH7rFzkoLmLMXOmMusXXdJGJA/AgysrN0OPvvNgyHQVR0/GTpgW08ZF7Udg2q
	PY2VWam8D+owhS2D4fZRYudgRIyGc2ZVASTau45yA9FJ+YwzzOM87/xo8XkCaQ2zJzfbPZwxlzG
	xPlZSDI1RaPCl7NkxMl/QFnCsi+sBxvbBB+NFyQneilvglArNzrlqraLg61V1h+1y80fXcTs2gr
	gV0OXI34Ry0o8o776lvP6111x83RWnDVK4UglXddz+Po4j0UKHkZPhLGBH/iE1cKY79Z9SvR4lr
	Pick+YesoJnIc7uESJlrVNd/TTI+K7PBfBBz8lyNUbA5m4K0+BWG2rbacKKSYbTE6XsdLuoHVOc
	1CgME+h9DSiO1/jBVzA5OqJL9NxV78m18xN3dgKq/W0cRZgFTZPt3bHPHrLnZbxFxcvs57e/PXL
	Q2oT5MLmVlnGC/V
X-Received: by 2002:a05:620a:4588:b0:8cd:9665:9ef3 with SMTP id af79cd13be357-8ddcd8f3ce7mr2452245185a.19.1776174822349;
        Tue, 14 Apr 2026 06:53:42 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb6562409sm1117411785a.17.2026.04.14.06.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:53:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCeCx-0000000B2yS-341Q;
	Tue, 14 Apr 2026 10:53:39 -0300
Date: Tue, 14 Apr 2026 10:53:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com, jiri@resnulli.us
Subject: Re: [RFC PATCH v3 3/5] dma-mapping: Decrypt memory on remap
Message-ID: <20260414135339.GB2577880@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-4-smostafa@google.com>
 <yq5atstdanx8.fsf@kernel.org>
 <20260414122208.GV3694781@ziepe.ca>
 <yq5abjflptv6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5abjflptv6.fsf@kernel.org>

On Tue, Apr 14, 2026 at 06:43:49PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Apr 14, 2026 at 03:01:15PM +0530, Aneesh Kumar K.V wrote:
> >> Mostafa Saleh <smostafa@google.com> writes:
> >> 
> >> > In case memory needs to be remapped on systems with
> >> > force_dma_unencrypted(), where this memory is not allocated
> >> > from a restricted-dma pool, this was currently ignored, while only
> >> > setting the decrypted pgprot in the remapped alias.
> >> >
> >> > The memory still needs to be decrypted in that case.
> >> >
> >> 
> >> For ARM CCA, we cannot mark a vmap address as decrypted.
> >
> > Why not? pgprot_decrypted is passed to vmap, why can't it work?
> >
> 
> 
> I might have confused you in my previous reply. What I meant is that, if
> we do not have a linear map, we currently cannot change the page
> attributes. 

I'm not sure that is really a CCA issue..

We have an API design problem with set_memory_decrypted(), it needs
three flavours to accommodate all the different users

 kva void *
 cpu memory struct page *
 physical mmio phys_addr_t

Currently these are all being muddled up with quite some creative
mis-use of APIs. The DMA API should just call the page * version and
not invoke page address.

I guess this became extra complex because Intel needs to track down
the KVAs and wipe them out.

> What I am suggesting here is that we should document this, or perhaps
> handle it as a separate patch as done in [1] by explicitly stating the
> challenges

It should be centralized.. If we had a struct page argument version it
could do the page highmem check and fail with an appropriate comment.

This shouldn't be sprinkled all over.

I suspect it could all be made to work even with highmem without alot
of trouble.

Jason
