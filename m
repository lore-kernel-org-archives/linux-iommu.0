Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D709F387569
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286156; cv=none; b=IDilmsNrYew8a2qoa5TWlauyRivhphCsS51ZBxzUTMDrJljbL4PBxvZXJIv1KWrPNM1NkpcCFO2snya1lUUPEoAqHrLOoIbCJQodEoVo2LyfZKwihuSedUnMt3lDlRsC2rcYj33rFPWgeF39bNHXhm2pzGaCW9S01MvIlE/CJbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286156; c=relaxed/simple;
	bh=87ZnNVw54Ect91QfjKmfKw5fIH72SgBecZYAMYQC1tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElP4Q+UR95BLPjGtAwP8J61hJWLGvr5RyrOb7UdAI0ZNLWRPQIk67hfxCU/4yFsZRSVormtnYTaYLwOiGN0r9pcyNEARbCgilgnv3nkMpp4He+11LYtkAEleSXFyjTU4qrmZbH6BOpAZ8ku4Kas+P0715YF0Og5Znlrnot5ynmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YnQS0lqh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YnQS0lqh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4887ec3d8e7so2075e9.0
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 13:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776286153; x=1776890953; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aVP/1KbfVghlSudtY96ZNkOwitIzJUOvnr4jYxspHw=;
        b=YnQS0lqhWVMs+5BtPWRYZC/g+Gkb3cXaqpbmE40+osUtecNxWtB0obwlG4HG0J8+Hx
         CBMAog1cD25jld3oux1qNNPjoLuO39QOYFWzg2wm5e1hU40a+QrehLizBtrCqr1l+Hu1
         aeob32FKO5pl6a14YObJq+WiqOy6MZEgy0+lJJdF5pSs/KZmT0ibYnn3ZewaFtH+XYYF
         6wN6XXWo9NvyQWahHsT2cPenlxlBXzvy0lDabT0VJDRKRE5B1eBkcwyxdC/Dv+CW0pcS
         WvNRvEFckv9UIe4PpA71ZSUQqkcGGrYNRCAwopP8MpdVhPrUx12W6acKYfTCYIz1enJn
         fgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286153; x=1776890953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aVP/1KbfVghlSudtY96ZNkOwitIzJUOvnr4jYxspHw=;
        b=Kbn++etDWuemnoya1SqNXLZsAv7jgvjTyfrO9MewiT/atJpprJHF1zwmNKUOEoG6Vb
         o3R6C27LkdGmKCqiGuvMO0SkyXmPYcbVneR0Hw5wamdlkN99w8uyq4ZMbU7XyfL2nDbX
         k8brE/LzqC9LLM8REkeQEMAXVAmUgm4m6R3abg/R/sl/RZe5k9aMk7WeH6kjyQUxkxrA
         Up1YjiPO8Sqhsex5xBOjfVexr+i6d3xPFNxbKkFghxz0F8VgoNbLIt7KSOD2Bs1qM33/
         XdEPEq0uSQnhXql4tRiv7rfxlc/I+PqR32YT214cs4yss1Ss6KdgdhXt+IsegiT+bxap
         amyA==
X-Gm-Message-State: AOJu0YwspIKittJu3hPa3GJWFWgM4J+7KXNv0AsED9wzW3F4gt6JMsGS
	K9t4eZRZLf+ZNPbYnIrfhOV1du1w+k8/gchVnK3PvF7kTtWYLLdIAecsDNySOEzVzA==
X-Gm-Gg: AeBDievAak3clPxFMvUuj4Bh2wMtfQDIyeNBPJk+1WImlKQudCLrOFEVrzBL6tpNZ4o
	wUCEtCfxeVhN7KxqcJqF0Gw/r//Myv24sND5i3JY+GbpZkzvX+t3945yVJSMMq6X/4fj+EIVvKv
	KuIjBtmWUzsyCuDncpDzhO/AdWQBeazQCoZB+frfnvsF8IXzfMIILuNGBSafCWr+MtN65Ou87oD
	S42N3OMqOOAvGoprKyHpMlQL7/YAnCaXqYUK2pEKWjPLtL82kpLALmMyDmtesNcwd8YIKj995BE
	rsJrYoc1As+Of7gbP8PIAot6Tqcg6V1UR/KkXxlDMRfskbI3aeYnabYztNuMS34EFKfDnvXTYB0
	o3qWx7fzwd+CiewMHf0Io+TVwkvpZf34SgUCJ/1VEM9CxonQ8dmEyFQlWZA7SELexCmSHxYVhvN
	qZ+YWJ6HZdZ9jvQB5Q7S2QvMSmLbED17nxJqsHKwLQXiNn2NPYxCF5XcD0E0l9Cf/TtncxgZPdR
	ktn3A==
X-Received: by 2002:a05:600c:22d4:b0:480:683f:743d with SMTP id 5b1f17b1804b1-488f4ae929dmr170495e9.14.1776286152833;
        Wed, 15 Apr 2026 13:49:12 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1df12sm351296065e9.4.2026.04.15.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:49:12 -0700 (PDT)
Date: Wed, 15 Apr 2026 20:49:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 2/5] dma-mapping: Move encryption in
 __dma_direct_free_pages()
Message-ID: <ad_5xGkg_3XbkN9b@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-3-smostafa@google.com>
 <20260410174553.GD2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410174553.GD2551565@ziepe.ca>

On Fri, Apr 10, 2026 at 02:45:53PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 08, 2026 at 07:47:39PM +0000, Mostafa Saleh wrote:
> > In the next patches, we will need to avoid encrypting memory allocated
> > from SWIOTLB, so instead of calling dma_set_encrypted() before
> > __dma_direct_free_pages(), call it inside, conditional on the memory
> > state passed to the function.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  kernel/dma/direct.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 6efb5973fbd3..ce74f213ec40 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -97,8 +97,11 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
> >  }
> >  
> >  static void __dma_direct_free_pages(struct device *dev, struct page *page,
> > -				    size_t size)
> > +				    size_t size, bool encrypt)
> >  {
> 
> This feels like it would be nicer if it could be the
> swiotlb_page_state instead of a bool, maybe the enum needs a different
> name.

I am not sure I get this, at this point the swiotlb stuff is not
introduced yet, I try to refactor the free path to make is easier
to modify next, the bool encrypt here is typically set to false
from the error path.
I can replace that with a wrapper doing the encryption and calling
the free function.

Thanks,
Mostafa




> 
> Jason
