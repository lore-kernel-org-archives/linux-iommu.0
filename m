Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F43C0635
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844309; cv=none; b=JFPGVHHuluSWoYScc/MxyN9aQ+NV7/PyskZvbQAhDJvtKLjfcPsGI+YbuLerZwrjXo5pzcSOdmIz3uwURZy7reltCs2Y14UwGoCP6plQTMMr5+r67Mkr2L9f2055mK/YErkp7jetHa9PJQc3al8T+33rqYzJUE3UOKVWxgCcjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844309; c=relaxed/simple;
	bh=usWOYWnYcX1AbQl2wC2HZ47sqdaQ/cZVDz0+E3wJc2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHwchIwI8zE9kiVLhbPjLJ7DESW9b5zgCtcDvwqEhQXGwot1B6KY0dccezzm9IGGPf7/whwisM5d6Yw1Jw3L94I9rMG5NTzF/nh+/jSjOzpwN90Azk5BYQjklaqaaGShoOy9S38EkiBodyGu/SWl/cM90nEdCwrddn2BKo8gs20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EiBvXcHL; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EiBvXcHL"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a154cc6a48so25250826d6.0
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775844306; x=1776449106; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DMIIkOGUTTrV8K244TmXAqc0Sap7K8R5PskuCUGSVEE=;
        b=EiBvXcHLXTlTCfMIhyaRe9SM+TZPMUb5G/XYzn37uoolkcZUlHuWhOhpd/CVoeGP95
         ChWQHFO9VFfcmpx6/2074y6E3+l+dzmiQEBCotGWI4cXs21Gm0g7MnE58BgcV+HVdMrz
         0TpMYxyVJBzWO8K6jZvYu+RxdxUE/I9qLzi0Gv0zzbZG9XuePlFNZ8sLETHKLysNpKMo
         9hagM59cejv5ntLqs4wxvXsdXIP/5MM/hf726Oc7xD49VTXYgBk7MIXxdMbBA56B8/sf
         31cCv9Z1NODVY7sDJkR4atVFmf1aiE5HS5jIR5MBfafFsj++I0XsbSxg3B2Q4gpQPUEG
         5P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775844306; x=1776449106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMIIkOGUTTrV8K244TmXAqc0Sap7K8R5PskuCUGSVEE=;
        b=hoqtN13YUNL/7dcNQwQK738b+7FkBPCVLBNv9RGszioTRc2zxxPUh82Qw3bkiPcHQf
         d9582tM5nBocmEd/McV3mQBI/S1RvvZGmCnkrQQ3KUYcChmSioyqi6tkcNTWzKTsXP8y
         METfgGScdwUwIerEzxew22r8RGFW7MkQ2yBF4cu8MVLnWxxzJGrB3OUOfy40oGm2mgBx
         PL4P8FSih/v0UrDXzFTVq2vzKTEhnYokXCz11ZGeKgUkXwUUAcfAAxkJv1oxTO5katQK
         7qEc03QlF/uPtLEZF25vIEEny8BrWVcHSxBR0UPOC674+plfryiwk+jGM7vJlrYP88tv
         jW4A==
X-Gm-Message-State: AOJu0YxKcXCJQE5SffKtNUzlDVBwfAOJvOruzmYay/AYCaTFHAqyrVuk
	KYXMBptiOG82FNBLG6TjEHIBnZTqCXzOHg8ff/j1+O2U0pKtFELDn+0Av+/GxGD+Iuk=
X-Gm-Gg: AeBDievb8pfUuVm9r0h1ujKolwexQ/xeWx5d2SJakk7Iea2QDI7xq8I8zpCdAy/juhw
	Dd3djOtdWdIjgBpP9u41kwQE5T36KTQZjXKjv30V1VDsOUdMkR0C6cs/cQz3TfGidz38AMHFhkq
	IJCMOMtDv0ygud5C/qXBjFYX9LTfRWN5UXQ7J59zxyIolGTuNO3nsTwOBMomCwHB8wJHKN6WmZG
	cFGFsYoUpSMmCJamL1SxO+C+m2+d/PiYQJtoHWBQOlvzTlXd0BjD914fBc/gDaWT891gwtDlr8i
	rfwwCEr8YoqGIxPOgiO5Ol7O0pcsY3NC+yUA4guH2dmyiG92iXrO8uRXSeCqKaohQHJ4TmAGxla
	OWUu1bdMAVcD8QaRKSODThSWF3Ice7+7vndfrAxyK5bEh//Mzmpy1dcEHMKcMFSjCsorr5/3484
	GJ+TZrexdKiD56O9Z9OwDpkgVqlvFa/ND1aFWSIlce7KNp462xstlqRnJQBYnDPtetXYSYDXbhV
	NxIASq0
X-Received: by 2002:ad4:5ecd:0:b0:899:f845:a29a with SMTP id 6a1803df08f44-8ac86299318mr67584926d6.41.1775844306091;
        Fri, 10 Apr 2026 11:05:06 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849dbb32sm29585576d6.6.2026.04.10.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 11:05:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBGE4-0000000FO91-401J;
	Fri, 10 Apr 2026 15:05:04 -0300
Date: Fri, 10 Apr 2026 15:05:04 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v3 4/5] dma-mapping: Encapsulate memory state during
 allocation
Message-ID: <20260410180504.GE2551565@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408194750.2280873-5-smostafa@google.com>

On Wed, Apr 08, 2026 at 07:47:41PM +0000, Mostafa Saleh wrote:
> Introduce a new dma-direct internal type dma_page which is
> "struct page" and a bit indicate whether the memory has been decrypted
> or not.
> This is useful to pass such information encapsulated through
> allocation functions, which is currently set from swiotlb_alloc().
> 
> No functional changes.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 58 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index de63e0449700..204bc566480c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -16,6 +16,33 @@
>  #include <linux/pci-p2pdma.h>
>  #include "direct.h"
>  
> +/*
> + * Represent DMA allocation and 1 bit flag for it's state
> + */

I'd explain this wrappers a pointer and uses the low PAGE_SHIFT bits
for flags..

> +struct dma_page {
> +	unsigned long val;

unintptr_t ?

> @@ -103,20 +130,21 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
>  	dma_free_contiguous(dev, page, size);
>  }
>  
> -static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
> +static struct dma_page dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>  {
> -	struct page *page = swiotlb_alloc(dev, size, NULL);
> +	enum swiotlb_page_state state;
> +	struct page *page = swiotlb_alloc(dev, size, &state);
>  
>  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>  		swiotlb_free(dev, page, size);
> -		return NULL;
> +		return DMA_PAGE_NULL;
>  	}
>  
> -	return page;
> +	return page_to_dma_page(page, state == SWIOTLB_PAGE_DECRYPTED);

Should the struct dma_page have been introduced earlier instead of the
swiotlb_page_state ? Seems a bit odd to have both

If these are actually internally allocated struct pages, could you use
the struct page memory itself to record the decrypted state? That
would require more significant changes to the allocator calls.

> @@ -184,9 +212,11 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp)
>  {
> +	struct dma_page dma_page;
>  	struct page *page;
>  
> -	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> +	dma_page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> +	page = dma_page_to_page(dma_page);
>  	if (!page)
>  		return NULL;

I would expect to see more usage of the dma_page here..

Like I don't think this is really right:

        *dma_handle = phys_to_dma_direct(dev, page_to_phys(page));

Does page_to_phys(page) really work on decrypted memory? On CCA it
will return the protected alias which doesn't seem like something
useful?

static inline dma_addr_t phys_to_dma_direct(struct device *dev,
                phys_addr_t phys)
{
        if (force_dma_unencrypted(dev))
                return phys_to_dma_unencrypted(dev, phys);
        return phys_to_dma(dev, phys);

Above is all nonsense now that you have a direct indication of the
address is decrypted memory or not, it should also be used right here
directly.

if (is_dma_page_decrypted(dma_page))
   *dma_handle = phys_to_dma_unencrypted(..)
else
   *dma_handle = phys_to_dma(..);

The later patch just makes it worse by adding even more confusing
flags to phys_to_dma_direct().

I think it should work out that everyone already knows what memory
type they are working with before they call down to
phys_to_dma_direct() - the calls to force_dma_unecrypted() here are
just hacks because it previously did not.

Anyhow, I think this series is alot better than the previous one. If
you work a little harder to make it so there is only one
force_dma_unecrypted() per high level DMA API call that would be
perfect.

Jason
