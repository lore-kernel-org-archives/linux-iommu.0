Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61D921257F
	for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776528381; cv=none; b=T6jIIVqukeQJf9sIhTF8wK08IvXMe+JfWxMTCmAe50MGiPgZsofhQaoI1yzhAT9IKRPY1TlLn0VFP4/kejRtiXPx7IC13/uht7loIqGCS9ZLN4cuAxZPpNNT1Nh3N2qTFi9S9saPMqcYS+NZaeBu0WvkqX8nLYXSsS/PjxgjObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776528381; c=relaxed/simple;
	bh=MWftFaJ8O2Xxs1l+puqj+8RM2P83r283+ik5iQi8dFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZDJt+cUQThqM3OAPEYVtXXzkZfBQJgB9d1zaeYrK4lGIMuZrQcjiWeXzhpjD7BYIKcyYTEGI+07ON+reU/ryPIuQPaoZwbv48rFVD1PbpNVwhuA4w36x1vRb5aVtNsbbRDXRUonFjBumdHY5xFjeCwzceP2O4ruiiH/t8nltsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LzPbqeF8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LzPbqeF8"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d4f78fc9f6so193888085a.3
        for <iommu@lists.linux.dev>; Sat, 18 Apr 2026 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776528378; x=1777133178; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVLecyRDPAZGCV69dw7J/uwCjzmXG5zEQpv/sopb5tk=;
        b=LzPbqeF8lePhLx4qv6S4o1SwJpKQFANVtnVzJdyfcWiVZSJfHsB4mtKbIC9KyeA7Sp
         +rhaUtcX10YfsQ1MKgkeiV92GACYczYydIQWLdHvPjC1A176snYmuYGjeV99OS8Gbu2y
         shytkHCdWbGdRCsSfDpici5qlKci/IbsQ26vUe3fTGessBlNN50e/ALmtHWCvhyWbpHC
         gp87eCYfQkhO4re8oTXYqWqMU6ZHP0f81BAPm33qpZ3IWpexXQchNNQpuU200dOVZYfH
         Oo64c8LNpsCT8dReMTfw9Jun5Lfd6jY3EERjvjM0/XVU19n5bV/6/uneJWXv1zradwwi
         HIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776528378; x=1777133178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVLecyRDPAZGCV69dw7J/uwCjzmXG5zEQpv/sopb5tk=;
        b=pKowF4TmFvCiJKryNjFPOB0hIySYQGzi5Aot1Wy3uhTGC8Hd7Ld5UNgk9Lpd7dq5Cu
         SjoenODBSrPP8mZdLBhfZjmdIZr7nzRXsLCjhi0mwNJG0WkggBhH8WOY3n9qzehqfiSC
         30dkjP4zHCGpo+bTUV23/1AYFkTObTAh3gR6P5K48vnmWlobnYM2gu1KEtSa5dp4nL+Q
         omNpRin5TgWFthmgrbwF75M1Mi135iYyY7eDmMrJTnSpFBCoVI4Mi1/l/UPoHmdMsDlz
         vSV1MGmCbWve2HC+AvFFb5+fNpTmI3IMACwHpTNWP6X/uVNXkUeJDV4LQvmXUZR1F4ol
         UQ4A==
X-Gm-Message-State: AOJu0YyyGQUDHFEB/ND1XTDONW4UFTX5NsmDOB7Iqlnbp5ueZ7OE7XAU
	uAiwyjpMaLNqb+ItM7y6jG+bLwCM9symYx7pbZZtRBtVfLS5cinQUDX1d6ULGTsPh7M=
X-Gm-Gg: AeBDievtIfbckTWMagdhqmUTE72IWV4n1PAB52F8SQa+F30TLPf6XePWVWTn3fr72Lr
	5PuEQpnujRO+2ddP6c4xgptTIK1nJ/8rmnA4V6yAykp2/k62iiFIGoYpP5BN/wwfYGatlJmfH9C
	3eJXQ9qzL4uzzP2pgZY06k8nq3QSQ7B5yHP1vn6UAjFzaLyd2bigHh7R5yPJG8fQ5rW+ZgSvqxl
	EgkWdijhhOZvGM0KvCwG40impvIr359IL2R6VtWJjhuHYV1RjFxqczVL7KfTpWNPzZ4Yl4VOzKK
	ZUVT2Dz1SXLWv7bGPrLKaLZRh9nHY3LlzahFiWvxTOiO7ztlIlQi1TGD/d3U8lNowlTVbYgZSZ3
	yfE/gbgTwXsaPf27A8Svb51vITroJMgb9rcDXauZgiggxxjJSvOUfnP5pFVLJBZJ07J2sQkx28M
	PU10N7ZwZgPst+3Qjc1icrLP62sU4TcVScr7/PHx8NSRaeUD5cwqPSVv4TSvUVbhzvKxRsSdZzH
	4VmfjyG9NpTddXrBUkgDDev3Ic=
X-Received: by 2002:a05:620a:1a26:b0:8cf:d565:fcbb with SMTP id af79cd13be357-8e78f44328amr1064295685a.11.1776528378312;
        Sat, 18 Apr 2026 09:06:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d65c1321sm378625285a.15.2026.04.18.09.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:06:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wE8BV-00000000tDf-1Ira;
	Sat, 18 Apr 2026 13:06:17 -0300
Date: Sat, 18 Apr 2026 13:06:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [RFC PATCH 2/7] dma-direct: use DMA_ATTR_CC_DECRYPTED in
 alloc/free paths
Message-ID: <20260418160617.GM2577880@ziepe.ca>
References: <20260417085900.3062416-1-aneesh.kumar@kernel.org>
 <20260417085900.3062416-3-aneesh.kumar@kernel.org>
 <20260417152828.GJ2577880@ziepe.ca>
 <yq5a340tiorj.fsf@kernel.org>
 <yq5ay0ikhjfl.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ay0ikhjfl.fsf@kernel.org>

On Sat, Apr 18, 2026 at 11:57:42AM +0530, Aneesh Kumar K.V wrote:
> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
> 
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> >
> >> On Fri, Apr 17, 2026 at 02:28:55PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >>> Propagate force_dma_unencrypted() into DMA_ATTR_CC_DECRYPTED in the
> >>> dma-direct allocation path and use the attribute to drive the related
> >>> decisions.
> >>> 
> >>> This updates dma_direct_alloc(), dma_direct_free(), and
> >>> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
> >>> 
> >>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >>> ---
> >>>  kernel/dma/direct.c | 34 ++++++++++++++++++++++++++--------
> >>>  1 file changed, 26 insertions(+), 8 deletions(-)
> >>> 
> >>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> >>> index c2a43e4ef902..3932033f4d8c 100644
> >>> --- a/kernel/dma/direct.c
> >>> +++ b/kernel/dma/direct.c
> >>> @@ -201,16 +201,21 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >>>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> >>>  {
> >>>  	bool remap = false, set_uncached = false;
> >>> -	bool mark_mem_decrypt = true;
> >>> +	bool mark_mem_decrypt = !!(attrs & DMA_ATTR_CC_DECRYPTED);
> >>>  	struct page *page;
> >>
> >> This is changing the API, I think it should not be hidden in a patch
> >> like this, also not sure it even makes sense..
> >>
> >> DMA_ATTR_CC_DECRYPTED only says the address passed to mapping is
> >> decrypted. It is like DMA_ATTR_MMIO in this regard.
> >>
> >> Passing it to dma_alloc_attrs() is currently invalid, and I think it
> >> should remain invalid, or at least this new behavior introduced in its
> >> own patch deliberately.
> >>
> 
> Thinking about this further, I am wondering why you consider passing
> DMA_ATTR_CC_DECRYPTED invalid.

It doesn't do that today. My point is if you want to add then then do
it in its own patch and justify what it is for..

I cannot think of a reason for anything to want to do this. The
purpose of decrypted memory is to allow a T=0 device to access it and
you cannot take memory allocated by dma_alloc and pass it to some
other device as a matter of API. So it would be *really* suspicious if
some driver wanted this.

> How about making the change below so that we only prevent
> dma_alloc_attrs() from accepting DMA_ATTR_CC_DECRYPTED?

Yeah, that is what I was trying to say. No issue with it using it
inside I think.

Jason
