Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6D3CAE70
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496526; cv=none; b=Fx2kBHyVz1QNmb5fIlCtFHM2z8WA6TdwJkwg/2w89+3VW2tO4+h9P+PuxWEpGpaZiZ3RnTyN+4toDhTciu0VcaAuagC68nl1cq0iDANek88Mjidj3BrOf4spB1KfI4yxdir3E+iYn9MeuiDl7rq7zIGu9KJRf5OoarENFhdBRIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496526; c=relaxed/simple;
	bh=Swp3xGW3vTawn+izWd62T9fOozzOrIouuue1VdtxNLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtaaIiopw9ZFAxvGZIlPMg7uvhwI1JPMoeQh7BnwWEUBEugQbvB7PHE9Wjh5tAI/4IBvynR4UlUQkFCh+4gn8QweVzBlVnsikCR7IrOnnlYQlEwC+sj8roFJmVmd9z+5+WbNLKyeVAl5xdULadI0ieT52kCs4FICHBwjgQKJN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFOHxFzS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFOHxFzS"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so1495e9.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 03:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778496523; x=1779101323; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EgO3YEbraGVhlJDckmxk50y+7wZISWCLqWPhmHwgijY=;
        b=oFOHxFzS67LLJYrY8rkCyTHatD8KQ4PLWewwcg6xjRvXTgCrIf+xVAajCbHFn0eDu6
         MobhTKChDMyrbQsD9/lieOl9V2QdR7m1PlWVWzbOA+ViDwW43GJKog6KtNb6uHuI0+XH
         rltJ1yRLyVFukJuUdY4VvKg3Q/SB9V487WaSOrv79heOO9k+Mjf5LL/g5WWW0A7xqhPH
         o7ndwSYl49XHpzUkH/4Du1OMST43Epc8HeIAplTfyJTapSFox7TANiXrKq6oh8ApL4Ye
         /l3+6KH37jB5Z+xylniCDw5r0Euo1JVgUE+qruFk+k3cB8yWpq2Ieas2v9JbieHhS575
         xWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496523; x=1779101323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgO3YEbraGVhlJDckmxk50y+7wZISWCLqWPhmHwgijY=;
        b=QIZgyIZUaTybuyOeJ+a4AzLxrS8LKQEZyT22VnuhRp7GOV5BykBd5Vg0WynapfDXgF
         C6mP3aVlb+/iVAu6dObUt3jdt3HJYJVEboReQsr9G4kJR/m3kzxvgtIro1jWURNj8ZZQ
         C02EHWn6668TnMPRvlEIPIKOhVYRVSpLiyKN/b7XyscGFx5zIoGtiXFrKUfmErK0V8Sp
         H+2D4uYQjQ7Baho6xEHJ1fvbLAy52chtyHJbrj+ETHkxZqtGtVyj0BSNERjVDBdEfo2R
         y2kxgwSkKGKhQeBAGpZKdOyrDiXE+n2mq4KSmFQIXB28eWj1C1/FDN9J29QK7YpAByKS
         /aSA==
X-Forwarded-Encrypted: i=1; AFNElJ/jG4kC3MyyCtQ8jdlGXB9+1UjBvQjeUoL6RiwK5zHgHccbXiDHLovlmMguJZ9z88Fdy1k4OA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvRGPYscF5JqkXuX+I9cSAnpzKlORWO/CRxZNH8fIZW9PqT1hM
	Zh3vpuFxWS3RbrN+ux+N69ZMRGm+DdGxoqzXFrqlVIJ8rdrJOijx/wndHg4Ja6nYbf1lojSepYo
	LySim+A==
X-Gm-Gg: Acq92OH+6rIfdvpGjcs3f28rr407ecbJ4j9jg3DFP5Cq2UdWAL3xJwZR1YwfTJ41+QN
	CzoZvaE/e3R5m8eRLvkoGYn/R7O5348daAOmnSlexSJJv6TBjsBi3Kv5Q2FfsjeDxPGnLgmKgZ1
	S8bMUIV0HP5PsHzaMddZRM127tymHC3TJc24QxZqKDqtI2mNvl3Ae0+hi0iCPsf3OvwXpLaLI27
	N2liMNDvOiEkx1R9+cHc7QhnJP0oiZulUnZylS+r21evvBEES5wT8xCq+CYVzO2rFiZJ/xhoTGA
	Iw9MO88an+bOX+9YzOXQJxnFCyxeqQmAE8z0EqXX9TnZHnGZY9lD/TVkUYd34KcXYhZoh07pemm
	UrlhaIO0LM24H9Ud5manwsB4Z956HJRikC64kAvOK/hzWbEDeIcqQDEbBz7Z4F6ECQTRYWqNt0X
	FCjEzWcFTaMBB8VJjCm+yPZZ3y4c95JVoOF5BAZ8/JvflX7eSJ7RwbFHqofUxKCzDKU7U=
X-Received: by 2002:a05:600c:34c9:b0:48a:56fa:36dd with SMTP id 5b1f17b1804b1-48e6f50a1b5mr2391805e9.11.1778496523100;
        Mon, 11 May 2026 03:48:43 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549130549bsm24986752f8f.18.2026.05.11.03.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:48:42 -0700 (PDT)
Date: Mon, 11 May 2026 10:48:38 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 4/5] dma-mapping: Encapsulate memory state during
 allocation
Message-ID: <agG0BpB0ZwvcvE3r@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-5-smostafa@google.com>
 <20260410180504.GE2551565@ziepe.ca>
 <aeJVh5VbkzxHDBEK@google.com>
 <afzNm6ZmR6c8_SMk@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afzNm6ZmR6c8_SMk@arm.com>

On Thu, May 07, 2026 at 06:36:27PM +0100, Catalin Marinas wrote:
> On Fri, Apr 17, 2026 at 03:45:11PM +0000, Mostafa Saleh wrote:
> > On Fri, Apr 10, 2026 at 03:05:04PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 08, 2026 at 07:47:41PM +0000, Mostafa Saleh wrote:
> > > > Introduce a new dma-direct internal type dma_page which is
> > > > "struct page" and a bit indicate whether the memory has been decrypted
> > > > or not.
> > > > This is useful to pass such information encapsulated through
> > > > allocation functions, which is currently set from swiotlb_alloc().
> > > > 
> > > > No functional changes.
> > > > 
> > > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > > ---
> > > >  kernel/dma/direct.c | 58 +++++++++++++++++++++++++++++++++++----------
> > > >  1 file changed, 46 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > > > index de63e0449700..204bc566480c 100644
> > > > --- a/kernel/dma/direct.c
> > > > +++ b/kernel/dma/direct.c
> > > > @@ -16,6 +16,33 @@
> > > >  #include <linux/pci-p2pdma.h>
> > > >  #include "direct.h"
> > > >  
> > > > +/*
> > > > + * Represent DMA allocation and 1 bit flag for it's state
> > > > + */
> > > 
> > > I'd explain this wrappers a pointer and uses the low PAGE_SHIFT bits
> > > for flags..
> > > 
> > > > +struct dma_page {
> > > > +	unsigned long val;
> > > 
> > > unintptr_t ?
> > 
> > I thought about that, but I don’t see unintptr_t anywhere in the
> > kernel, it seems similar cases use “unsigned long” as in xarray.h
> 
> Jason meant uintptr_t. However, we have a similar pattern with struct
> encoded_page as an incomplete type and encode_page() adds the bits
> directly to the pointer. I'd use something similar as there's precedent
> already.

I see, makes sense, I will do that.

Thanks,
Mostafa

> 
> -- 
> Catalin
