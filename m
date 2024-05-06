Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899744C7C
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011854; cv=none; b=NljzTIHRfBFeMJly5Ur7re+mIxk4oq8lnJYokXfWj6FePXB7jAKFo4+RHK9qOUZmUZiiUzrAtOJsDOLhTZBvzVN+VcKTt6vvZuB7IngdEvIKmX/PI5wnHDPMu+5V8KyO/XmLIQMnAV0LQCiQdvDimjFYNe7KDg79wr/3OMNN7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011854; c=relaxed/simple;
	bh=yo0nITJjRLWahgSa48uioCkDwC6+fwDal7OzgmHRdnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jv5U92rCV7iBOA9UBeodlf9k2sbkcorT5Ldn0m1se8r9jdNNNXD9gcAcXhocsnu1ubYIP+ssxPlSVW9i7+DZ+xmNSz/v7ZhscsyfAK8ztHPGC1J3xxMOBo5Rc5laJ9lQQWBF+r6ob9OvkvjEBPcbfWuclTIc0MIohGwhHzpxIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jE588uB5; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jE588uB5"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de5b1e6beceso2428638276.0
        for <iommu@lists.linux.dev>; Mon, 06 May 2024 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715011852; x=1715616652; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZdW7T7aub3HEQGqdk4tAKNjulXPSd/s5jyMU+52RF8=;
        b=jE588uB5GCIiXnwThBpPM0VqaVtLbwyt9V8qFbVdKeQAOxGaylavDy6gm3ISjO9FEY
         ydsqS6d2JonSarZFzDcOIXoSEsP/g4+b61WguzfQspmU68Q79HHFhyU1J0nlXMxh6MoE
         rtJcQfjJR/wfnOmB/4/hfg8f869/mSSeBB+JrjFzDW5jwmpmTd/oPhbGC3jAWKNfwORu
         9JNOqYFcspt2w0uIDYGAYgdlEFicJgtf1j8VNPZTAqmx4QYMqbLPLkMw6005P8UyfcIq
         rQT1kojt/rFocjhXV6cQ44YDEhFTnfMvbDsckF29chC3eSEfQNBgdWHHoCLWJXCnJavV
         YZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011852; x=1715616652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZdW7T7aub3HEQGqdk4tAKNjulXPSd/s5jyMU+52RF8=;
        b=SSvZ/Un9MhGAIsiQvOszPLNkubqxvfBzSGMecVyF1q8FdSFNIyrMq0PyYoSutFV5XU
         FTnr0w8UfBL0pZAWA0YmQk8demKZoEioVFIVf39ZYr+ULufd9qwWfdyWL1DMACixIaBR
         yC9SNZN5CMa86GTwhE4XDrH7Xs6K0BTHIxL2Z8p71QhziOMili/Z0+jBgeIuTlsxn8Y/
         9IswuzytkHQZDheR9prVp/S5QvLyfgOCRHGSY+JiVtLDK3mZDGRgmUNWKeMbYMI2v3se
         OLUKcUVhctF4WoTA4UvXNAKzaFkEM3O3kR/ZLi3wxXZSOj+RKUTanmtTw72OLDsn64r2
         r1qw==
X-Forwarded-Encrypted: i=1; AJvYcCX/8aRwkFZk0F5Wad5POoY5ESmoI7VexRHw+waTx05fayb3vXuGt5HRmBSIX0BtoHgePM1n9F2b6L9O4ibyC98jsusRgE8=
X-Gm-Message-State: AOJu0YxaoxlS+i7BkXVOFMctbJaKFAsi4Cv8d0VTMrluRZAaRL5zZ5qb
	uIaMWmTEzi6d7cHSoNCD4yzS/x9jLVRnRurdLh8ZmX9CueqM6pPNZOOsN+UFRUGQjYJ5WgE3CTd
	bL71Z8frFwcjAS+J+bqardssEQrZHrvIrIyo3
X-Google-Smtp-Source: AGHT+IH8jnlh3YhBo9wAl/F96iqiRp8ETCI/ORncWjUCqbkz6bq8Nss/cI5z2ygcutWvZS2K3UNSgRNsHBT1vx2KzG8=
X-Received: by 2002:a05:6902:2743:b0:de5:1f5f:3682 with SMTP id
 ea3-20020a056902274300b00de51f5f3682mr12555260ybb.30.1715011851402; Mon, 06
 May 2024 09:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de>
In-Reply-To: <20240506160244.GA16248@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 09:10:40 -0700
Message-ID: <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	isaacmanjarres@google.com, Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:02=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, May 06, 2024 at 09:00:59AM -0700, T.J. Mercier wrote:
> > Oh, that's disappointing. I'm looking for a way to quickly check if
> > any addresses point at a SWIOTLB buffer without doing a potentially
> > expensive call to iommu_iova_to_phys. Since it's meant to be dma-iommu
> > only I guess I could use sg_dma_is_swiotlb if iommu_get_domain_for_dev
> > returns a domain, and is_swiotlb_buffer otherwise for dma-direct, but
> > it'd be nice to have just one way to check which it looked like the
> > SG_DMA_SWIOTLB flag could be used for.
>
> This sounds like you're trying to do that from a consumer of the
> DMA API, which is simply wrong.  What is the actual problem you are
> trying to solve?

I want to reject mapping a dma_buf for a device if any of the pages
that back the buffer require SWIOTLB. AFAICT there's no way to know
whether SWIOTLB is used until after calling dma_map_sg, so afterwards
I'm trying to check.
