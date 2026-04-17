Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BDA39A054
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438435; cv=none; b=VA7ujnVlO5uDcwa5SKqM1l6yVINq11P1u3q7veVB62MVkmTdpNzNJfb2f0p7c2tjHzWfAZXWdckE1eqDdc3K0zHWTOU7jIpCG6vrMnLMTOiZ//7UollhdddCmry1yBCphpew+CWvGa4Kuk3WT53pQ7ydefBOHhPWaX2VQG/DGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438435; c=relaxed/simple;
	bh=qRoZV4X18vNFvmPDnw5TV3Kd1sVASGdoZqtHvXbs3Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx9+VsV8IpaWU3ah8R/bMHLa9uiWNdnVXaZd7bh9gpIfHWvL0xIkAPFZ5Y0Gt8ca0AQjFdvjRz1c7rfxW7mKXcEQX/ZjdN0OYP0mRFnxfQBPvJO36BP4UZuoS70dSP6JU0mmV6+XkxBlGy1/dbi8nuinGb4F4HDaUnm9Mb8ZRcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iG6J+RZz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iG6J+RZz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671588ab0cfso9504a12.1
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776438433; x=1777043233; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4W1PvFTWyy9P9TaXChv1j05m0pIed2QAEvBCS3K2Pw4=;
        b=iG6J+RZzgUffxhiq38Nd6cquVaUqnA6Z0oUGd0k56JiMVraxuECty56MUCexTUYVFp
         RKkNv7GTxfuXS5wRCf6XiUM/QFB0RyKZ/ay/2jAH2xgtWlvflrTZhtFT1Oh51SbGLEHW
         JMAsRPNQQQNBXK5/kn+z25Optp8ACkYd1UkTfjpMGh93MPEFT05RKGAb/mSChEiroOeM
         X/2N6VQAxCy/7R80ymZzX3uIEIdxj6jC9a/4hkkDsvZy7NaQYEluVltTbc7uP0SqsNzP
         EYKZslK+Lxb5fDWhOGFQ4JgN/yr4aSL6RJ6dhQgPbw7G8Wg0VWEjc5BtkdhyqxV5G0T0
         me9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438433; x=1777043233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W1PvFTWyy9P9TaXChv1j05m0pIed2QAEvBCS3K2Pw4=;
        b=IncGB1S3Yv5PPcA7Va95sc0+itjxGtE+2UwZ7FG6cfB1pGE9RF/EocefalenTBfv6o
         X2rOVrL//95++sF/0i3sUl34TZOLRWVE9G1JJUd4/lHh7KNHYspRnyPaRV7AgGwvF6AW
         sO5G/dpsyInro/mPyRw51kxO29S0h2+GXtyLCz9q5CZ6N+LHxB/0oWYNUkdpNd8TrPga
         52DJ63k1k95qL6uwBhxltEJM+H6U7nsvjbkbYIVq3CcAq9SzcLEiX46C8Y/NEz26c1RH
         e0lZ3lOcGZLdonYZL3PYr73WWApGxEGR7XKcp9eF948IcJecztBefUTnzjqnigfzbO8I
         Sztg==
X-Gm-Message-State: AOJu0Yzw8Vl60lGS/1cNYv3QmZ0VTQB+2FLROhLF+YMCFLwmilFz9lti
	QDwNX7VNcuw2NFjmztzEhfh2prR8DOv7bD7fBdzheAwLvZn7ZjyFZlXvMSzgvAweGQ==
X-Gm-Gg: AeBDievCbQcqmjCJO7IfbzLvvaHLOtylLHEoIvkvZd9XqbrlNaYhUfouIGecbm+wjL4
	t4Pq+oXrq7wraF4+oNnQ0/1L3zTz5ZQEb90la9+riyeUr1dBPSFcAP7I5pjhZSjuDyalwVxrFOF
	sF+E1NLpx/tXBWZ/h7GGuavDa/0FVWN8QuEVVvEcI/b0cZMTyGOife9dRMB76CTLjP8/NmqCD8u
	hOfUxwIWJTSGpdVHnWEoeNtMXTE7kn5GPmTuMtjC9lEwy36G1APC5N9zCrpfN7fhXs4yWpLXNkh
	mjdDEpwofuPbXputMbCLceSTgf+6M/zEd9egLnh/Vt28qRVWchPQhHPOctLt2lZ59eNbnhGRE2Y
	XGZ5SN456ngGM6pprzfeQfSjHna/V2XFuroKHtltkz+5R2F6DPMMiqrW/495nfJshSoLGDVGwrE
	Bkuw7WKpnnslQHVdWux/S+29WNqxluT21OyuSjNk7pfIdXEsHdyPA2YpohKr2mc/yK6Fj5xEEH1
	t0ZWA==
X-Received: by 2002:a05:6402:304a:20b0:671:e657:449f with SMTP id 4fb4d7f45d1cf-672c08c88e5mr38646a12.13.1776438432370;
        Fri, 17 Apr 2026 08:07:12 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553980csm64494366b.58.2026.04.17.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:07:11 -0700 (PDT)
Date: Fri, 17 Apr 2026 15:07:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 2/5] dma-mapping: Move encryption in
 __dma_direct_free_pages()
Message-ID: <aeJMm1oiRUjPFtCn@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-3-smostafa@google.com>
 <20260410174553.GD2551565@ziepe.ca>
 <ad_5xGkg_3XbkN9b@google.com>
 <20260416001122.GI2577880@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416001122.GI2577880@ziepe.ca>

On Wed, Apr 15, 2026 at 09:11:22PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 15, 2026 at 08:49:08PM +0000, Mostafa Saleh wrote:
> > On Fri, Apr 10, 2026 at 02:45:53PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 08, 2026 at 07:47:39PM +0000, Mostafa Saleh wrote:
> > > > In the next patches, we will need to avoid encrypting memory allocated
> > > > from SWIOTLB, so instead of calling dma_set_encrypted() before
> > > > __dma_direct_free_pages(), call it inside, conditional on the memory
> > > > state passed to the function.
> > > > 
> > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > ---
> > > >  kernel/dma/direct.c | 22 +++++++++++-----------
> > > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > > index 6efb5973fbd3..ce74f213ec40 100644
> > > > --- a/kernel/dma/direct.c
> > > > +++ b/kernel/dma/direct.c
> > > > @@ -97,8 +97,11 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
> > > >  }
> > > >  
> > > >  static void __dma_direct_free_pages(struct device *dev, struct page *page,
> > > > -				    size_t size)
> > > > +				    size_t size, bool encrypt)
> > > >  {
> > > 
> > > This feels like it would be nicer if it could be the
> > > swiotlb_page_state instead of a bool, maybe the enum needs a different
> > > name.
> > 
> > I am not sure I get this, at this point the swiotlb stuff is not
> > introduced yet, 
> 
> Just that using bool as a function argument for a flag is often
> frowned on, and you already have an enum encoding the same flag
> state.

I see, the enum is not introduced at this point, but I can change
that.

Thanks,
Mostafa

> 
> Jason
