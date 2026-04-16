Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78107C14A
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298287; cv=none; b=UqGs/Y9U9tzbwFxKn7lewE3PwDPqhucrGdqVWdPHPZlCSmZoL6eaeZrL3cmfWeb1lGlLDtedUcD90shhmUWTuPfop/lEEFjkZWJ6i6O+QtJ10GqDMvAA1e15bL4I78npZihfjFjAiHOeGmQDGrahGEXpy9mK4i/Q8qJVkCbK2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298287; c=relaxed/simple;
	bh=feXCvwpsEEjpTwhvns9yVw6ARPELKAJq+J9FkdOVR+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvcVpiW/d62H7oowczOrh6/eR9CsaHqFXDKxWK6omDs1hNhX3APm55mJQxmL+BNwHUwVnH5kYtPOm+KWkHDfvB1a/UCSqMIkl1D7hQH5JbDxEZksr99PRQ7iW58ZNUT8lQHRkOggM4xO3q71onylIxA4aHTQydpyLOk8WiYTExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yr+f5hNY; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yr+f5hNY"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d67a483d3eso798517685a.1
        for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776298283; x=1776903083; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yw2kAdSjJZX4ssR5Exz+4kJYfDN2ANXckXMlNb6VVo=;
        b=Yr+f5hNYtQsupAhjNLBBHAGBoJEQSO7J1KqVSP3vsv/OwpgezZs6xDPhGI2uLzLHxL
         mQnxzvVWUbtVGjyGMDPeV7/QNVTW7grW0LEOvTi3+U821UnTsy8FFUm27J8EOzbsH+Wt
         0Ynt+HQifgQXWHgP6cTNPHzeZgciR6RH+qKvbj/0Zv4ts+XhKxO8WNbC7nMXqbb+3gof
         M6UUptfZI2eoaHp/XnZQIDmA/lEqsTqsTA6JL/wrOs+rpclejcxyc57kfahrGts6K346
         SJ69s0QZZaMbVDa1P6w8FKbPYlt5n8H3eRyp83IyEohyNH8QnZx4t/i9uN4zdYdQukIi
         9KRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298283; x=1776903083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yw2kAdSjJZX4ssR5Exz+4kJYfDN2ANXckXMlNb6VVo=;
        b=VYdEPY+0u/pRmxl9SfX69d44fTtnjLFlKiuIURUi9CCrKlk0ocApEBMKBQC3/aIwVn
         SM1hEAaHn7PsVvFLGf/ZiZ7CYm8Akg70a7TM53/FnH5n58nToMd7l2Z4Gw1vkxPpXwRw
         XDTSwZ3owS+9CCkfiKnq4e76JC9OciGIzejaffPYpz2oka0NzKqMzZZ/f/RKM15ehaXt
         PPUxZuCn79bh5ubo8W+Wd57GTtPnlpC9QkWsRUPTTYoG6ZxAZIqjOJA20EocIwStXZL9
         WZwZTd5kE+xCOlUNDyQEAzVA44//0k74ZmbAGjw48m+cLaeM2Npjhobh8Ph3wHdEasxK
         iYmw==
X-Gm-Message-State: AOJu0YztrL+OcAmfb0VsUR9VNAMRKykhfBg2kHUyffiI3LH9dS2NcI3E
	C7cu70zI3M4GKS1spfMm1UBgw1XcvviC4j9uyuizg5LCe3WcBT1PzgFfWl46yGA1SVs=
X-Gm-Gg: AeBDietCwbbns9Gk+UeBUwZwbULJrC3L6kaYVA8TfvML+oCK8K6vh440/pLFGB8OHC2
	0IhnTCEgFt+GbLQuXfQm64q2dO88Gw7BNVuO+9DgRMgOqG3zEvN7+IBfDGY4hdLohpeLR60psve
	9F9ql7juh0ym/NKhWSCQvzhtiA13JnYCQ8yAL49h2K04XWroaPLkLu6trDNP1g9HbRQv5wHq88Z
	TbgE++PpV+cModlBYopASuSPRs2HVhS4viOhRGvl+hvnZhLoJQK1f3LouOgwfxp1c19mCzsLoiO
	Ao9ylaMDp/oIlVEmF1w37RyuSYR6eSHwBsbWe8NMPql2Q5Pi8BvimfGH0cecmdTpMp+Gm2El+br
	o65GTtw7AmSf7vj9mf5qUyPKh3Dhq0khDHP7CJIgXKFvmtinBv9isrVbu/W7Hw6gy2AKLuh/8sg
	64uDQ+olawE++DMby/4tfmNUMQ2D2vtDqsIq2pyO4MudqyI3ZRvPlBG4+PaWr3h4HtWPL9YEzYH
	Yp7zg==
X-Received: by 2002:a05:620a:298e:b0:8cd:8f18:d1c0 with SMTP id af79cd13be357-8ddce2c8436mr3332825985a.27.1776298283348;
        Wed, 15 Apr 2026 17:11:23 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2345c2esm244820785a.26.2026.04.15.17.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:11:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wDAKI-00000003CNF-06a5;
	Wed, 15 Apr 2026 21:11:22 -0300
Date: Wed, 15 Apr 2026 21:11:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 2/5] dma-mapping: Move encryption in
 __dma_direct_free_pages()
Message-ID: <20260416001122.GI2577880@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-3-smostafa@google.com>
 <20260410174553.GD2551565@ziepe.ca>
 <ad_5xGkg_3XbkN9b@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_5xGkg_3XbkN9b@google.com>

On Wed, Apr 15, 2026 at 08:49:08PM +0000, Mostafa Saleh wrote:
> On Fri, Apr 10, 2026 at 02:45:53PM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 08, 2026 at 07:47:39PM +0000, Mostafa Saleh wrote:
> > > In the next patches, we will need to avoid encrypting memory allocated
> > > from SWIOTLB, so instead of calling dma_set_encrypted() before
> > > __dma_direct_free_pages(), call it inside, conditional on the memory
> > > state passed to the function.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  kernel/dma/direct.c | 22 +++++++++++-----------
> > >  1 file changed, 11 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > index 6efb5973fbd3..ce74f213ec40 100644
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -97,8 +97,11 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
> > >  }
> > >  
> > >  static void __dma_direct_free_pages(struct device *dev, struct page *page,
> > > -				    size_t size)
> > > +				    size_t size, bool encrypt)
> > >  {
> > 
> > This feels like it would be nicer if it could be the
> > swiotlb_page_state instead of a bool, maybe the enum needs a different
> > name.
> 
> I am not sure I get this, at this point the swiotlb stuff is not
> introduced yet, 

Just that using bool as a function argument for a flag is often
frowned on, and you already have an enum encoding the same flag
state.

Jason
