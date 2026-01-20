Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17A428849
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923813; cv=none; b=QZqPOZnuqJZMamo7JvlGig4tpQX9hmmd+6NIyMkIso9ZfO7Q8ywxEI7/OgTLR9RMNG/3XXuIk7BExImlaJSNt/ApYKzfpHuYciuwqPlBQ4q5pFJgAvYSoTHMJ/WQaRK1j68HXFikl+94EL3BGx1esKqjBKFemRRP7JNAmLeS08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923813; c=relaxed/simple;
	bh=AEk4f4OIqZky6anPZNNVQrU2C24WolRBC945N1z2OPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxgzhGaklOHqinL0zINmcycipWKd7A+pNaH/e72aiFY+Fg+R+88LWL688pqV4t2C9flMUKlmVyzluCiqCo3pW1kP9LNxBXiqSY+Y9Se2iRNUBomQiPtt2j+p4klav4tmzy9zfhmygc3bE04GLgS94RipokU6LTTlyheli3thNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ehAvu3hO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ehAvu3hO"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c6af798a83so376042985a.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 07:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768923810; x=1769528610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KkQRFRlJWlhxPTDnYLiUDFN/tlogfKFoNh9WT8HEULI=;
        b=ehAvu3hOqBsKsoJ5qG8kGADQoff1pnMW+58xpCJT+XAufbLz2o8SjRcuJRtDQHrRue
         Ru0HtsXVokTnQzSv4u+aeP4ST+C4IeLIxxXMwL0VrYiaIfpF8Ey+aKWb8BGAA4mogDQU
         W0lKVp+V0vqkkMuo0PlPQCM2KBVrREelLyi2stvu4CrazsmtwdtXKpbT2hB53K9sArMT
         Tf3qmAQAhap2h9cdsWNbA0f/3Oo+PCgC7LOvGM307tcpdZaJjxYUEJyC5tF8q3PIBc6i
         Hc1QnkYPqTSWGgnobbc1sMOMR3L3nHP7XcQ7YzzGebkrUVgwKczG3xnLPC0by751zFA2
         oolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768923810; x=1769528610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkQRFRlJWlhxPTDnYLiUDFN/tlogfKFoNh9WT8HEULI=;
        b=D5vJQ7XZBCVTjGJE2AXlHtibpzKJIIe4qutk3/FNZhi3E/9xXXzfe09fR1fj52V3qJ
         y/AYV3X4KjBxrLw5AFF1kEYhhQvSo9FwL2iiecd+Tj37AyNB6lrWvJFM72l+HGOg0SOl
         mikWBiVtav6tnn+MUxrhEbTCBrMXE6kdihtJFtSAtwJ9FZrDsS0UpGRxXYS5YsqPbjf5
         UQPv3Vto9ZuZSqBL6MRWTcNdCcQGfly7E+KA1bc4dpkwDqPQDW7bYyEk42W2noY9iefZ
         mhQBRPucXcvKPGv1gb5dV9j9NSg8AafSanOEqo4nOIc40OyaSukNIZaxhSKA9B6qUqDv
         6nwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuP1d+7Vl3w9LL7xh0lnjiQMf6ex+oFPKN6efuJMfJHmfBOc1O076M8e/GQFBTAWS7huLEPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg5HKc+IuW6tsr2TXBvalyvQBkqG/1WlZ0hNRiZQXER7PyHBkm
	39uj5pc8YSAn843Qzu4q4urUkRY5jAUX7B4hb3yftbWG8M/saD//2pcVnSiaamTJ0PM=
X-Gm-Gg: AY/fxX7reS+IervUHzYUhWAb+M31YMJNTtw2oxuaW5ACK5jGig5kKqA5HHvr3xwkoyT
	tntx7h4/VmEkdROffVNhxgkSiR1mpIN/rYypdYM+tQlUeVn2uwrjnT7yqf8IxA1Ap9VchHoiI5v
	Dt9V20GCSIjOoBApJsNx82wn1jaCwUOcnuVvX7AEO2oTl2a9jBjkULI8X/p7319uoavgfxqGtTo
	VXwIjXpnXeSvCkOiDR8g7mu7eLPJ4T3lgL9kdT+qtlKOUBphjVu4CQ4eKoFY5xNfaDklOCW6KQD
	MUYrq48JPHnQ8s0xnXsNA9Kp7xkXwo7KNWGQqefWIDfWbWGxDmNF9inLr2sYL+RNCMoSGftJkii
	/6jpfJtH9dOq6/RHS5YeUuJOGy1Ez1EJAaVRM2NddXbqc4us+NYWjTz0o717zLKEqf6ZGZETicF
	T3H/HM2ZKG0g1NsiZD1mefSMuw41/1qrXFkPE5k8hRwjqCfWzmwyMhNv8Y5aSIhJa+5vI=
X-Received: by 2002:a05:620a:19a9:b0:8c6:770c:40d8 with SMTP id af79cd13be357-8c6a670cd8fmr1985028785a.40.1768923810068;
        Tue, 20 Jan 2026 07:43:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a724ec87sm1101806185a.30.2026.01.20.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:43:29 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viDtB-00000005Y4O-0KLT;
	Tue, 20 Jan 2026 11:43:29 -0400
Date: Tue, 20 Jan 2026 11:43:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	robin.murphy@arm.com, suzuki.poulose@arm.com, steven.price@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
Message-ID: <20260120154329.GQ961572@ziepe.ca>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <20260120132657.GO961572@ziepe.ca>
 <yq5ams28jog8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ams28jog8.fsf@kernel.org>

On Tue, Jan 20, 2026 at 08:55:43PM +0530, Aneesh Kumar K.V wrote:
> > The check in dma_direct_supported() is checking if the device's HW
> > capability can contain the range of dma_addr_t's the DMA API will
> > generate. Since it above is generating dma_addr_t's with the
> > PROT_NS_SHARED set, it is correct to check it against the mask.
> >
> > If the IOVA does not contain PROT_NS_SHARED then I would expect all of
> > the above to be removed too?
> >
> > Can you please explain what the probem is better?
> 
> There is no specific problem identified. The motivation for this change
> is to ensure that the trusted device mask check is accurate.

Well, don't break untrusted in the process, and please explain
motivation in commit messages in future. Why things are being changed
is very important information.

> > I just had a long talk with our internal people about this very
> > subject and they were adament that the ARM design had the T=0 SMMU S2
> > configured so that the IOVA starts at PROT_NS_SHARED, not 0. I am
> > against this, I think it is a bad choice, and this patch is showing
> > exactly why :)
> >
> > IMHO you should map the T=0 S2 so that the IOVA starts at 0 and we
> > don't add PROT_NS_SHARED to the IOVA anyhwere.
>
> But how will we support a trusted device access to both shared and
> private memory? Commit  7d953a06241624ee2efb172d037a4168978f4147 goes
> into some details w.r.t why PROT_NS_SHARED was added to dma_addr_t.

The IO translation path used by trusted and untrusted devices are
completely different. You don't need a T=0 device to have the same S2
as a T=1 device. The commit doesn't explain anything, it is just
documenting the poor S2 conventions that CCA already adopted.

What should be done is that the T=0 untrusted translation path, which
can *never* access private memory anyhow, simply puts what the CPU
sees as the PROT_NS_SHARED region starting at IOVA 0. This path is
setup by the host VMM (ie qemu) and HW can support whatever
translation you want. There is no use case to ever not set
PROT_NS_SHARED for T=1 DMA so why break so many real devices by
requiring this useless bit?

The T=1 trusted translation path should have the RMM setup the S2 so
it mirrors the CPU S2 with the private memory at 0 and the shared
starting at PROT_NS_SHARED. An address width limited device would then
be unable to access shared memory without bouncing through private
memory with SWIOTLB, but it can probably access all the private
memory. The existing SWIOTLB address limit bouncing machinery is
designed to mitigate exactly this condition so it can be used to
bounce buffer from private memory to shared if that use case ever
comes up.

Given this little mistake has already happened I'd suggest that the
VMM/qemu be changed to double map the same T=0 space to both 0 and
PROT_NS_SHARED, and have a discovery bit in the guest that it is
allowed to use 0 based IOVA for T=0 DMA.

Then you can fixuup the DMA API calls so that:
 1) If an old VMM continue to use PROT_NS_SHARED for T=0 and continue
    to check it against the DMA limit, de-supporting address width
    limited HW
 2) If a new VMM drop PROT_NS_SHARED for T=0 and check it. Since
    everything must use SWIOTLB ensure that SWIOTLB allocated addresses
    within the device support range, as it already is able to do.
 3) For a T=1 device assume it will not DMA to shared memory, we don't
    have any way to describe that in the DMA API right now. Check the
    native physical address against the limit and SWIOTLB bounce to
    private memory for outside the limit.

This way CCA would work on alot more actual HW :\

Jason
