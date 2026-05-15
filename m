Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197430CDAB
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852165; cv=none; b=RW6dy8LQfKOON64ka4l/zwZ3nWlMwgBfoOaQjQYH38e0jj6PP3SZk8GRP2kqynw8ToRLzkFHOQ2DpS0wVXs70HVU/MTDl5oOQr0mKf9rBAu9pjAqQKAZeaFhbiLfSs5QLWYjKormJKtQtdJ+KoWZm6+NyhPU7oKtPl2HByOedbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852165; c=relaxed/simple;
	bh=Fwd7lj78za7/egg1q8Mo4PUhAXSEVczLRrgBepYO3+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYjBnia8vxyrej5i/jKMdDLcxGRNvstYdKoM4T2BjLK9vfzeYvduXv1MgLU4NPdsWA4EAVT83o6gBoQH2MgofF2TxNP4Kz9paKExxs1PPqDS+QfXywVW10HEpMHuVqtCXdhoevAfHnlWz/V5gfHt+nzETUBGZRlyXpBQc4+yLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oTo3f5wB; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oTo3f5wB"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b7f937ef44so53550766d6.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778852163; x=1779456963; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z72wSJNyYtME5egB+TN5Z3aN3HcOFHG2wgqQPaKQrhU=;
        b=oTo3f5wBFyaJ4QCDgO4dimapljdlry1bisU6N+zjGrj0shDDnWXcXt6UR4AQs7y1P0
         3g4Dyu/RzcbNlvdf+ohu1p47pYUF1OkgIqHRjygdzaF9tq7m4a0dcj+Y4dz7Z+ooIkc9
         jracCuGX8iuTNQ292Rtt7toszpgVpYnGHAvmpfv32hHmbKZFTbI/fCNjyNccNqOmSIyB
         J6IDzPnFcVgbcu07QzCEP6cbMPM/3gmHdU3O5dIC7d/ctYgpae/mkdGW/ddpTTuQnvvB
         J/gOzGlp+1l74HP9MdVIcsryCLaBnACuWu06OUxcVPHfWupvDNob/6BCCZWCswqBQyeh
         X/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778852163; x=1779456963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z72wSJNyYtME5egB+TN5Z3aN3HcOFHG2wgqQPaKQrhU=;
        b=GBHf3NQy56cRJLYMHh/OZDdhnaYXMo5+rfQKVrh7Bg/TlHwPUWL00zE5xBhlP9IzlG
         gF23F22cO0kEIWadvBa9K+NraTqV5jBI473uvVbimMnaTL2fqG95jG7w3Pz6MN2n6XfO
         g9BdPAAC9RXh6AwZlpVZoqgW/WTSd1B03tsf4nVrf0CWEj4xela2mGofAs/hTRgkzbAa
         dLiIQ/7PcZT4NiWFJkGEeazcWVbu42X5Cl1iCQgLnB4hF0vxdEtTafowOGnaslV0j9f0
         gXA8hBuZx5Dx8RuBgJyQPay9NpiKu8/ITsN9oV9n9lHNCMVRD9Qt1q/t668xaH3uUlH4
         jDRA==
X-Gm-Message-State: AOJu0YxehiCIEVKrnTpMC/BJnHU2Iu7ZctetsXy9OlWz2zPc5z7UHvtP
	CcxViQtVBTC6+pY/qCC5xNzEWdszqp3nMR4l7erliSC7Z3VwEJKKyZV2xNOyDwSBCR/hcSLtJUR
	t0jBma5c=
X-Gm-Gg: Acq92OG5hF5+Mi1bo83T/r0uf1seerQci7dslH1J/cX454OQGenAbXz2diFREZaU7d/
	woLe1cnFO6uJPnCXVOzCREEawbIXQ56AkcU0J4aD2dkOQJRKnqgt84oWGR4jtxDpMaPTJxjLjLl
	0y0in6viA65ORMsomvqqHjE3tadPMvplWfsa/N17n6DKMmdnFbRD7ySe56BrqVCuXYI6fQ8/uvh
	35X5jNWkhpyMIA2cb+GL5kJu++W41VSmAkfwhN0WfUAIhycWfrQ4ZvyXgx6OJcJIidajAd9pA9/
	yx8u1wayD7SJ/QqhgI2L1FoYniaaPCO3rkuoVa9CLjySXJ7Yev3Ix9ieyCYBO6A4DW3/66c/QJ0
	6l7BwE5krwujClSh3Feum9101UMfIMfcnakZdmYKRfKxFbkcpeKfO6PX0xY9K0YIa9th9OKgHMH
	ZDYuAuCCq1MWlOWawycmqhdcDHuEKA1hAHV0MwgBvTTRRal+PoyKyU7E3GaCOlHo2Lh1sj/GMKB
	nvZyg==
X-Received: by 2002:a05:6214:54c2:b0:8ba:b699:9e54 with SMTP id 6a1803df08f44-8ca0f69b454mr69231826d6.47.1778852163065;
        Fri, 15 May 2026 06:36:03 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c9093e62c5sm52289596d6.21.2026.05.15.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:36:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNsht-00000007QFF-3spW;
	Fri, 15 May 2026 10:36:01 -0300
Date: Fri, 15 May 2026 10:36:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Use consistent sizes for page
 allocation and freeing
Message-ID: <20260515133601.GF7702@ziepe.ca>
References: <20260513215203.3852661-1-smostafa@google.com>
 <20260513215203.3852661-2-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513215203.3852661-2-smostafa@google.com>

On Wed, May 13, 2026 at 09:52:01PM +0000, Mostafa Saleh wrote:
> At the moment we use alloc_size to allocate memory but then there
> is a logical error where we just size in the error and free path,
> which might be smaller.
> Also we size to do DMA-API operations, which is OK, but confusing.
> 
> Instead of this error-prone handling, just set size to alloc_size
> and use it everywhere.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This is similar to how iommupt works, pt_top_memsize_lg2() rounds up
the top table size to the alignment minimum and we just dma map
flush/etc the larger size everwhere.

Jason
