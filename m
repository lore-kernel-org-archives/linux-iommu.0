Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA830B533
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776169331; cv=none; b=I584fXEBTouor5tALL4v1h1GbluERUszo7jMcAcrkNS4EsS4bDolmezUJiIEMY5DMKSACYtb9aDsuTL6WgsESRhrHjjQ4Uxz+3SyEvbYBHV9rT9QMc7gNFMEEQPADy3H6/G6YjcZ8tDnLSp3ze5LQyY2C4HanM5ZT2IuXfHG78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776169331; c=relaxed/simple;
	bh=VB0PmZFz0Vpuj5FR1mGyq3uVzRofYi2J+yXFOeK9leM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcWCjCT4gzz7uFWaI8NPPyg0KyaII9lVDwyNuYdZY1ZodbcZQ/21f6xwqyBRkSmj6bxEYyPWHgVonIoX/rLiiGhip/pp9DWSGaLQVdOC470oQp4ipiTpPksLhYCTU+kdslLXsyT0zKE4QGSfZISgBKlU94EiIIPgVi2p9M7LMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kfQIum/h; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kfQIum/h"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d68bcf50fdso625871685a.2
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776169329; x=1776774129; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh0v0yqrIW3OeDFAvE5gZz9hJrlkiEewWWiSN7R/yBg=;
        b=kfQIum/hz9vgvB+T7QfHLUxOZbERhzF/JRoHE0s0ADCwLtWUyCLBmXDBuAsmW+q8sT
         Z3ibHILQXgTXsnW7EU/DyQISX1m9wX1Wzr1pep3821l5prjmvFll+jVpRz1/uaPojQdB
         eD+VWF3Oim/v/P2DQZf0z9lehLdmXxt8yVoRGjGP5Nd9rEyotMKqHj6gSc42ycSRD3sJ
         RfituwoCLswjhg0uhw8g/qx3N5kk0C2XM5asIQICoGQHBSC58yop7jvxmIcwt9vDSe7n
         CoDg1J2UfdDQxlEaFvYojA2+1TnnzAzrI4HPNappCOSS4w5B59jxphg8CvTXlgXWrCf2
         kSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776169329; x=1776774129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jh0v0yqrIW3OeDFAvE5gZz9hJrlkiEewWWiSN7R/yBg=;
        b=nKOom0hsfNSEk4FWVUCEjFmnCmtbgCWnhy7hjIQP0tN/7ZXT0F9L6+uimUoHqt3gmm
         jqhoJH0VfgxSR/gzx6FeCYeuiCDigJc1djhCpGxWRj2mpLoYHSdAcF2AvTavey7TWZ9r
         92zjhPJ4yBhamyLchH1U+bwdv8jEBBPMGAMYcZNnw32RvoWnwlmNiWYpNxJUaozoTzvz
         MTYSGeQA8axUKBsU0mpACNnP29ofOF/KfNZGpirF4i/Lxq0tdSrGUfQnTRcSQBekLngO
         LP2oyjqdvC6gszrhpNq4mceTXPDWOEro0AJkfZUzioC0hRcdOZQG/Ux5HF/vzsnraeFD
         WT0A==
X-Forwarded-Encrypted: i=1; AFNElJ8eBnvppWezrzpV0r4WgYP3WDdPM7+VwWWJyClb2izNS933qDwYnDl5FMYElUvWi7HG7HL3pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmLvKT5CCZ0xcpnzNGOZ8kIuO9IPVx/yVUB6+gtuZPs1zdE8RR
	xMTakBDlfkVEBQR6+eMKt/icR3PoPVZM7p4Yj5vhuh6z1BLhY4d7pcbyglJ8qZXeZG8=
X-Gm-Gg: AeBDietudGwH6QJPfyH6ASCCcm0o2UUQU5xRXS5QNsLDF2uRokkF7uRvBNj7hNo3w1l
	luO1lxq7dBLe0/7hheglxZtGJ4+YYBymmff3Rsw+w3Cf5F20yWAy9QpA2gXIWpn7EOcEWyLPeyJ
	VpwT/HtANM3BSaYu8siVcyD9wlx+722Hyb03nM8JNQZH+T8QCoNwiijMZNxGpEX071TqkRn+zji
	Scoye5V2yKSVrJFC/YTZalHDp1bQNfRQdzGjcAWnlnjTyQ+C1Ui5sy2YHt/F0DWKrRuUAiLxQSi
	hEcgq72EtdWTpuNLuUW5MkcJM7k05NrC0CDr9132irv3fYNlVvJN4Bscl/rjbNXdKHxmbyMm5fa
	wK1PXJ0m+qFVFuw5QVjrbv9n0yynpveiFEFCyX1I6WnizJyFwpVbRlb222Ho5fLgfJ8QlEqDuvW
	HHBiZhaF+jX4n2vtHTLVFTnlTBe9vmxBsLnA+beJ6eIYgNO6ksX7GOnHJVZ45r7qdzMG2wDqZTd
	UBmOw==
X-Received: by 2002:a05:6214:528b:b0:8ac:b70c:8ed7 with SMTP id 6a1803df08f44-8acb70c918cmr77953846d6.49.1776169329091;
        Tue, 14 Apr 2026 05:22:09 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849dd312sm121604836d6.9.2026.04.14.05.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:22:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCcmO-0000000AdeU-0XZ8;
	Tue, 14 Apr 2026 09:22:08 -0300
Date: Tue, 14 Apr 2026 09:22:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com, jiri@resnulli.us
Subject: Re: [RFC PATCH v3 3/5] dma-mapping: Decrypt memory on remap
Message-ID: <20260414122208.GV3694781@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-4-smostafa@google.com>
 <yq5atstdanx8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atstdanx8.fsf@kernel.org>

On Tue, Apr 14, 2026 at 03:01:15PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > In case memory needs to be remapped on systems with
> > force_dma_unencrypted(), where this memory is not allocated
> > from a restricted-dma pool, this was currently ignored, while only
> > setting the decrypted pgprot in the remapped alias.
> >
> > The memory still needs to be decrypted in that case.
> >
> 
> For ARM CCA, we cannot mark a vmap address as decrypted.

Why not? pgprot_decrypted is passed to vmap, why can't it work?

Jason
