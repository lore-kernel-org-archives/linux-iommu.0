Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4C8229B38
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883220; cv=none; b=OK3pa+gEuhxKCRYpP472Z739sIJUjx2S1Cwhe8Xx3KaDBU4lPdWdt01fDk1Y5m1HsYqxKzwiSgdnLynf5a5WnRCQd9MJ7WTFMGD9uou3hSLTL+VxwAoFrfHl2aKXY2C2arqI2xCBKU/ddVIxwuNeZsurDlqWi7Bir/mY+o2/RTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883220; c=relaxed/simple;
	bh=oMFumgtcsviaIMOGVLWdowRzwi9JxPG7CRNRp/XrgAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMlUKren394BneIu975mzekW8KS3M9bZ8sVLY2T3l6zS6n87x1GEqDncEwCf3JsHyWH6Z8xlB+VDVQDIJJSZR3ACkP3IpzfNKYX1sKjmhidaILb6myZsKJHe648X2WblNe+2sBPCimkFc97bGJw0El6kcdufbBvdi6hgSHA92hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oskLDkC9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oskLDkC9"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c70b5594f4so544725885a.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774883216; x=1775488016; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvmm6aMgtMQBn9OgUBPy3rK/Y3NLNwW+81YPPtVWi5U=;
        b=oskLDkC908aiS9uSYoKSv8bRxkMX3H6nvfsCk3CSJ+fN3/ha5Up1GguvRkNCXn7EdE
         l0+SHzBvpgfdQuahEK9/0QzO3lMqUnY+IQB94an+C5nrfSARoquwhGt+1tMzQxPiz0Eh
         qMQt8gpn6pCe28HTmARnv43xM4kCNNazUeSsXfd5Za+xfJsSZH4/zAAaMLyRJqcK4lgk
         Uzp/YOGTfjli3hhE1NssfC0OX1hsLr9IiK3HzBsMXicR+2LKphme/UNUtGMoslGZ+E/j
         WQ9TTzO/kEPh58SG7RHx8u3uMxrJu+XuVtTZK4rjXh2y2Nql2Wf+r8LSSrrz6JaX+nTg
         sG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774883216; x=1775488016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vvmm6aMgtMQBn9OgUBPy3rK/Y3NLNwW+81YPPtVWi5U=;
        b=Xby1Anb6JN4WpcTNeBjPy7crQB4DJEb4ZQNQYUxV9d/ezQqTN6dJWEHOKMEKL6vqsP
         mX1Tp38SZ1yyOHJiUaEkGCSdkm7DoQZQ053lAN1xPHwzcEE+fBiYSZEwwxxnJK97R8Mf
         IWOUbp9jHKTzzEUqfEFtRM8N6LHNaot1nd8JiowCArsIqKK/Y/1EHm9NEFNRIqy2RglW
         cDW2lU6FU9jHa+ftYN2V5kGczbAZQsIVoUN6ynuIHNXohgs6qJDUpqcnqiji51OhhbPV
         i3nqM05wJBUa9n4VHNkeQbflltgfEkB+KgvJTFteH8LzC51AAmvSJ3PJ/X9l+A4gjrJK
         WD8Q==
X-Gm-Message-State: AOJu0Ywd+n5A8JKaxEkhh/6ws2fpJNQc3nL7PiKTi98wYPb8ENReb2rd
	2owuaU6f7aucTy3vz3tND6du1VFC58AUBqgxs57rjStSaxEfZ88MLkQJ5t5uKa7FmyY=
X-Gm-Gg: ATEYQzzQ3rsFuAN/+Apq4Hh5muliY4EYzOguSxkxMYFZJWnyYt68awrvp1eOx5Dkco/
	ldaCiO0CzOHs8Vbui1myKWscywHwWhzJfcuGQjW52yg1cMc5YTIkSWoI8SrO9MWB4jxO0W4OYeN
	vtgWmKhb04WnYALlnx8V89IUDp+QB5SY58cNbnmBmLBNuwLkyG/PT5veJ0aKvncGwfQXiEDpnW4
	Omv5MvMwxRnoY/8QxGjii0vqqnIjphXai5FdJf3MIHRcNiN3tenEsKrRuAekvSRonYW12oGCaB3
	OYzA4oKPin3jSsg9L/G77NmqDc0YJsshZVOBBP3IFcWMLmYn+JnPs+jJelc+5ysOtkmz3xPAIXw
	EILRiHSYw2F1SWJqPuxCvWAF/22xCPSCfpFbtjJsnBiIsxyoEsUmt8xZq+IXBgifYAwtMwzQVy6
	snVsyxsDMR4mRnNl+zthyV+C+XlgLNad7PXwUre2pt/mBAw+DFr2FputDD+6/kwA3gQpTBwA==
X-Received: by 2002:a05:620a:179f:b0:8cd:b6da:7714 with SMTP id af79cd13be357-8d01ce265bcmr1628614085a.18.1774883216113;
        Mon, 30 Mar 2026 08:06:56 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02806a37bsm615516085a.34.2026.03.30.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:06:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7ECc-00000003PSU-29gv;
	Mon, 30 Mar 2026 12:06:54 -0300
Date: Mon, 30 Mar 2026 12:06:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, aneesh.kumar@kernel.org
Subject: Re: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Message-ID: <20260330150654.GA809900@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330145043.1586623-2-smostafa@google.com>

On Mon, Mar 30, 2026 at 02:50:39PM +0000, Mostafa Saleh wrote:
> In case a device have a restricted DMA pool, it will be decrypted
> by default.
> 
> However, in the path of dma_direct_alloc() memory can be allocated
> from this pool using, __dma_direct_alloc_pages() =>
> dma_direct_alloc_swiotlb()
> 
> After that from the same function, it will attempt to decrypt it
> using dma_set_decrypted() if force_dma_unencrypted().
> 
> Which results in the memory being decrypted twice.
> 
> It's not clear how the does realm world/hypervisors deal with that,
> for example:
> - CCA: Clear a bit in the page table and call realm IPA_STATE_SET.
> - TDX: Issue a hypercall.
> - pKVM: Which doesn't implement force_dma_unencrypted() at the moment,
>   uses a share hypercall.
> 
> Change that to only encrypt/decrypt memory that are not allocated
> from the restricted dma pools.
> 
> Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  kernel/dma/direct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8f43a930716d..27d804f0473f 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -79,7 +79,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  
>  static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
>  {
> -	if (!force_dma_unencrypted(dev))
> +	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
>  		return 0;

This seems really obtuse, I would expect the decryption state of the
memory to be known by the caller. If dma_direct_alloc_swiotlb() can
return decrypted or encrypted memory it needs to return a flag saying
that. It shouldn't be deduced by checking dev flags in random places
like this.

Double decryption is certainly a bug, I do not expect that to work.

Jason
