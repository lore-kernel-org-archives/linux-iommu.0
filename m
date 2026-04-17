Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5429898B
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440719; cv=none; b=SG4UGtOBi0YjYH9EpMQOhBzeL2nVJDIYC+5uSpmtYUXvoFqA7NGbP23gyhjDBsLjkPhcRra3ZtqJdYYzqtUnaVOx8jqlv49c63R+8NcmVQ/fCI9zALCkaaS8Je4q/dM5/rlQh/qRwtbLnS1UFz9hOVQEgp7KgtdfAvbL+/uXnvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440719; c=relaxed/simple;
	bh=Gl8kE8HK2eP1I/oXTMNyLW8reLr2Jq/jekKmiGtmB1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqzYxND5HwDJdv7QP50IWlBOfA2yGzBxPgLca/+SpmFTZEbvvC9rwbOHrOK7XKEff79kuaIVcSn6d4He7dSzBVu8c9KC9S8Hjd9PQdcTdO3t8Ft0pcKXsh/RKGbcylMJp09lSEKRFjzOPIOa+w5VAunPpG4bobVg6tfER6TRop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yzci0KHU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yzci0KHU"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso9916a12.1
        for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776440716; x=1777045516; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XOjUkINNAjTnixFvSOXIPg2UwuFFNqW8hRRJAYiWUNY=;
        b=Yzci0KHULWLcUZGeC+iZp/0w/hakpgLppMI6uaJrqROdMsK83iCt4LttlPQnI5VkgB
         DLn8FNtrUDdM/Z0pFgaGEwLCEo2Pm0faazpnGYwBXlKvPDwUfpzIxmP+0G7KB9dUDQc5
         fh1cbyrTxwwdLUH1CHNQjPoESlMTj/It5JLQ1/4c4UH4a9w03z2jSgbUe4f5GLCU6cTn
         MpkVhSUCwBwT71imFYjywB99tQdlAWunvxptunpZMivSmb7trDkY9hU81iiJYUfG16W+
         FlPKWELlhRNr3PbbJRmRE7WdzszjYh899y9xT7oLKJ3IHSpwW+H2hGI8FW5OxcR2Ss7P
         8hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776440716; x=1777045516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOjUkINNAjTnixFvSOXIPg2UwuFFNqW8hRRJAYiWUNY=;
        b=bIyEg+Wmc7PAXaoI80cjQ+12GSB8QgnDqF8qhbmSeLk1HeitEbhydXdPzh98UQ2Z/o
         Jj2HR4qUtqIzsi5FUspaAfPQeXtGrRa3/T8sDIQHym1IfItiV3HAadXsk1dQ2UEVW/zv
         Rigl2KQ5+CZx4RG2h93/9+wdukhxOMZelvUjNX5YDNO+qk+19Wt1ENaUACQ/SWK6C45W
         JYy49z26Baf8lOiz/BioU6g0j4JR2d5bNfPojy3rop7Prb47KHnVoR9II4H4mqeRYhVM
         OBGleo3jKwOUTVN73rNZAUJuNFcoZoswSapk+lLzxsIom9URaF8wrc4oxSnxZFdHXimb
         /2VA==
X-Gm-Message-State: AOJu0YzmHmtK9CNNmAJIhOEZYnPIyV6Gi+DfIkrraHddJmYfua2LQmKj
	dBASmXQ1Shnx34LSP+A/yIgYxaTb4O7nR8h8e/j+7wBoA386u07SMraYDlTZvLrcVg==
X-Gm-Gg: AeBDievoSJJH9FJlqfICZOIv9Fi3KSR8iwn/LGPbf8LzO6pfkPD9CXj8uxN13xFFRK4
	LhF02zoITeINpdXa2QT7AR7asnBq5Jp2OVJ1kfP95I7RSFSDr3EhVXjsBBQij9/IgW8A2lSKdFP
	RotlPZESxqrEBQfmAST4Oz5Po8+0gRg8IGu8cJghPltELSNka2ZcoeVfnNBeDlgwimCb79w/z0B
	b2RcpF95ReJdDMlwHHcD0rIlYZ763Rkf2LeC/AXaND/SsVjzijL8gog7JTT20HOD3KzZk7TkKqs
	WbdaOUxAG/hdLe/VviScUjZ72We/WoM/QPn40rwZmgBoKKUySBL7gSg87qxNQX/iZvgmauN5wwU
	9uOPq0iU5D/cxeqDlWxefTznXpsmABHInwzfM5l33EUEaFwS5A3Jm62GKilIqT9Yq7Ad0V4xkCe
	p0TcoIhEXW/qkOcD6Tmkq+qHTLk46iETTDm3LsgpRIgIZNQGoRA+dEAMrBgsRUA4NmjbZTM+OTZ
	uGx0g==
X-Received: by 2002:aa7:cb84:0:b0:670:d5f0:2595 with SMTP id 4fb4d7f45d1cf-672c06ba790mr36266a12.11.1776440715653;
        Fri, 17 Apr 2026 08:45:15 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451210e54sm67992466b.9.2026.04.17.08.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:45:14 -0700 (PDT)
Date: Fri, 17 Apr 2026 15:45:11 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 4/5] dma-mapping: Encapsulate memory state during
 allocation
Message-ID: <aeJVh5VbkzxHDBEK@google.com>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-5-smostafa@google.com>
 <20260410180504.GE2551565@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410180504.GE2551565@ziepe.ca>

On Fri, Apr 10, 2026 at 03:05:04PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 08, 2026 at 07:47:41PM +0000, Mostafa Saleh wrote:
> > Introduce a new dma-direct internal type dma_page which is
> > "struct page" and a bit indicate whether the memory has been decrypted
> > or not.
> > This is useful to pass such information encapsulated through
> > allocation functions, which is currently set from swiotlb_alloc().
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  kernel/dma/direct.c | 58 +++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 46 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index de63e0449700..204bc566480c 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -16,6 +16,33 @@
> >  #include <linux/pci-p2pdma.h>
> >  #include "direct.h"
> >  
> > +/*
> > + * Represent DMA allocation and 1 bit flag for it's state
> > + */
> 
> I'd explain this wrappers a pointer and uses the low PAGE_SHIFT bits
> for flags..
> 
> > +struct dma_page {
> > +	unsigned long val;
> 
> unintptr_t ?

I thought about that, but I don’t see unintptr_t anywhere in the
kernel, it seems similar cases use “unsigned long” as in xarray.h

> 
> > @@ -103,20 +130,21 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
> >  	dma_free_contiguous(dev, page, size);
> >  }
> >  
> > -static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
> > +static struct dma_page dma_direct_alloc_swiotlb(struct device *dev, size_t size)
> >  {
> > -	struct page *page = swiotlb_alloc(dev, size, NULL);
> > +	enum swiotlb_page_state state;
> > +	struct page *page = swiotlb_alloc(dev, size, &state);
> >  
> >  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> >  		swiotlb_free(dev, page, size);
> > -		return NULL;
> > +		return DMA_PAGE_NULL;
> >  	}
> >  
> > -	return page;
> > +	return page_to_dma_page(page, state == SWIOTLB_PAGE_DECRYPTED);
> 
> Should the struct dma_page have been introduced earlier instead of the
> swiotlb_page_state ? Seems a bit odd to have both

It can be introduced earlier, but It looked cleaner to decouple swiotlb
from direct-dma and keep the dma_page type completely internal.

> 
> If these are actually internally allocated struct pages, could you use
> the struct page memory itself to record the decrypted state? That
> would require more significant changes to the allocator calls.
> 
> > @@ -184,9 +212,11 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
> >  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
> >  		dma_addr_t *dma_handle, gfp_t gfp)
> >  {
> > +	struct dma_page dma_page;
> >  	struct page *page;
> >  
> > -	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> > +	dma_page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> > +	page = dma_page_to_page(dma_page);
> >  	if (!page)
> >  		return NULL;
> 
> I would expect to see more usage of the dma_page here..
> 
> Like I don't think this is really right:
> 
>         *dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
> 
> Does page_to_phys(page) really work on decrypted memory? On CCA it
> will return the protected alias which doesn't seem like something
> useful?
>

Not sure, but that’s not related to this patch, that’s already the
status quo, I can look more into it.

> static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>                 phys_addr_t phys)
> {
>         if (force_dma_unencrypted(dev))
>                 return phys_to_dma_unencrypted(dev, phys);
>         return phys_to_dma(dev, phys);
> 
> Above is all nonsense now that you have a direct indication of the
> address is decrypted memory or not, it should also be used right here
> directly.
> 
> if (is_dma_page_decrypted(dma_page))
>    *dma_handle = phys_to_dma_unencrypted(..)
> else
>    *dma_handle = phys_to_dma(..);
> 
> The later patch just makes it worse by adding even more confusing
> flags to phys_to_dma_direct().
> 
> I think it should work out that everyone already knows what memory
> type they are working with before they call down to
> phys_to_dma_direct() - the calls to force_dma_unecrypted() here are
> just hacks because it previously did not.
> 
> Anyhow, I think this series is alot better than the previous one. If
> you work a little harder to make it so there is only one
> force_dma_unecrypted() per high level DMA API call that would be
> perfect.

I see, that makes a lot of sense.

Thanks,
Mostafa

> 
> Jason
