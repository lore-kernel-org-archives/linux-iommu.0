Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CFC23FC41
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903401; cv=none; b=c4/hWS737IxWElBapHx/pZ1/0aR/Mjo+jWzOW5y7R4r3WUBQiWMGy55+owBdNb7dvDfZpinz0HVOy8vxtgApjZzErdTok6EOvVxOLkP++g4XfMXHXVVcZBTBUmesZJx86GCNAyBnZ8ucxZef9Bw8GeJ1/svjPCGaZVJr3N+UUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903401; c=relaxed/simple;
	bh=j1DH9+4DKc3WNPzE9spva4DKtqqPXG1KHbtj05J2lOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3uY4Fh9IXwY9exloX7LAiMUF4PYRLpUwlp2ADC7LozRrxgpmMDwX+YX9ju/c1Xok4dxGWHHPuYyG5o0NgLhON8XV77nKF/C39eT8xfJSWmTdn8F22tzUjslkkni92m62+4EYDN40mijJN+2EFfDzV5faHnOhoTB7WeVaTfjISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cruLPvoO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cruLPvoO"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-485317b6bd0so7325e9.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774903399; x=1775508199; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K266JrUFCYcLzRBq6imblWcGN9WBD0YfXv5+zsA8i54=;
        b=cruLPvoOEdPLMXveWyOeRlMrxDIO8MHTEKd7mK9NdTIou2fGTOE/jzs1ePFz7egigm
         BL+aFJFmlAq9JnLsw7X/oY1uTVna5OIkla32MTIn/kGY8YsMLl6+vQsGeTfY7qRoWVSb
         LajF5ZQjXK4DFPTPs4z/u/BOhNwdDNc8Fgxw9okU5dcSDEErhWrdLlwaP6Lt9eSIfMKw
         rfb8zTgE1bzjA1Z1Ki01pwciIfxFRDX3L0dQK+kyxR1W9dHftRcUUUtxNezSLmhOiA0q
         pzID4nRqywRvWc5V6JhfJhYuLKmsdSnJ2Hd18peZtJ5SltlGgRSSTNo+Cmo9PsVPZHAm
         31nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903399; x=1775508199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K266JrUFCYcLzRBq6imblWcGN9WBD0YfXv5+zsA8i54=;
        b=fdH5QV+FsCqyw+uuyMms/dMV0Kt6vhlp5OWJRlCQU7K22OhGeXpS0eb1PZo+OyYilq
         mjkUlDn8gKWaiLLtQl5nvHsQ9vvKd29PwbzelqG+77wnP6Hqp3zr1+da5oYiE2i7ZA9d
         7WVp6lUlZmuTWdwqX+Bwb9d3EgMx5XAbeMPtbNbRgmbOmIMrs8Tg/aotzHwiASp3pZdU
         Mv3KJ9BHhRqQEz2lYM0+VsOZpj4gPN/m85I6LrscVws0hRpi8Usm4gPzARMj8gNJHlAF
         yW0BCoNMFQLNdkesCndgT+uukswAhWKW63E1u930LO49ICRk6nfm2JHwe0BGU8ltsT2n
         8XWQ==
X-Gm-Message-State: AOJu0YwovMDoJq/cRnXlq7wHOU+N8FIt/FoRmgPjE6z6QwrJRlEqVr8X
	dHBDsb3weTPAty3x+qy5wy+VGCl/elosmXs90Wp/JVlarYpDqEjmC5FAOgzFbm1NzgMxjsnGohA
	E4wFjJQ==
X-Gm-Gg: ATEYQzwDKHWy423n4lRe5iroTeuLMxstk8loZKnLnRsK/YcI2p4OB1tM63tQpjOsfKB
	NqMc11NZ7jLFcdOfdw7UEi6TUUbFDn1X3BsDvPfPGJHnh1/xdllkhb0r/NDHtMNjxPv1U0AySti
	w87j92W08qvd+JIoAJLXAvyFlTF5dU85qH/VzecNOpvP1ulfqs5rnUeCMPQkiy261wbxNMWuIiq
	zp4CJhVaYMpQOCP0aov+SSlxhE4dX2xgQTcvBqZaUk7UqeLyTIIZ6lofauPSc3VmcLJpLfLkxIy
	jNaRKqRVSB5HK2ms2V4LLOC8CqTN1TReBzcmQamHE+XMmNZnnuKAAndz/Xu/FDBEkAqgZwvN/7P
	/ld//CtlgsnfTACe5WHiqxKp6hs3SoJ5ZwxPk00tRsysO8EusRZM49bXyXVMCT31B/ENUEC2EWq
	f2bv4wn4AxiMIrFtSmUNbs+prKGGqXQliDxAUAZqCFT3wsAUPBYt3XAfcs
X-Received: by 2002:a05:600c:6a94:b0:485:4133:4021 with SMTP id 5b1f17b1804b1-4887b30da7dmr28865e9.7.1774903398437;
        Mon, 30 Mar 2026 13:43:18 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf257cbc3sm21530567f8f.35.2026.03.30.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:43:17 -0700 (PDT)
Date: Mon, 30 Mar 2026 20:43:14 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Message-ID: <acrgYotBExJhEJkK@google.com>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-2-smostafa@google.com>
 <20260330150654.GA809900@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330150654.GA809900@ziepe.ca>

On Mon, Mar 30, 2026 at 12:06:54PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 02:50:39PM +0000, Mostafa Saleh wrote:
> > In case a device have a restricted DMA pool, it will be decrypted
> > by default.
> > 
> > However, in the path of dma_direct_alloc() memory can be allocated
> > from this pool using, __dma_direct_alloc_pages() =>
> > dma_direct_alloc_swiotlb()
> > 
> > After that from the same function, it will attempt to decrypt it
> > using dma_set_decrypted() if force_dma_unencrypted().
> > 
> > Which results in the memory being decrypted twice.
> > 
> > It's not clear how the does realm world/hypervisors deal with that,
> > for example:
> > - CCA: Clear a bit in the page table and call realm IPA_STATE_SET.
> > - TDX: Issue a hypercall.
> > - pKVM: Which doesn't implement force_dma_unencrypted() at the moment,
> >   uses a share hypercall.
> > 
> > Change that to only encrypt/decrypt memory that are not allocated
> > from the restricted dma pools.
> > 
> > Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  kernel/dma/direct.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 8f43a930716d..27d804f0473f 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -79,7 +79,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
> >  
> >  static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
> >  {
> > -	if (!force_dma_unencrypted(dev))
> > +	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
> >  		return 0;
> 
> This seems really obtuse, I would expect the decryption state of the
> memory to be known by the caller. If dma_direct_alloc_swiotlb() can
> return decrypted or encrypted memory it needs to return a flag saying
> that. It shouldn't be deduced by checking dev flags in random places
> like this.

At the moment restricted dma is always decrypted, also it’s per device
so we don’t have to check this per allocation.
I can change the signature for __dma_direct_alloc_pages() to make it
return an extra flag but that feels more complicated as it changes
dma_direct_alloc_swiotlb() , swiotlb_alloc() with its callers.

I can investigate this approach further.

Thanks,
Mostafa

> 
> Double decryption is certainly a bug, I do not expect that to work.
> 
> Jason
