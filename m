Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86BF3D9DC5
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055482; cv=none; b=gAv9pHNebf1CYD8DAKId8vq3XmSmqlh6+eI2RVAa2dSztPWyAk+Azf5e407RS4dsCWQa43AY6vdHLpLyARFA2YkhioipLur870qPMSBU5KU9uPVUz8wYjUd8klOqhWr95mY0xR2ZXqZZuYzJiVDtqfr5QSDCPMxC7grfnN6Z8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055482; c=relaxed/simple;
	bh=54vAzaIEYqsXM3xuiGWXl2HbeuhzM33ptPMT3OM8+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFW8MD4SCcp8lyeANgG+GIsNKVe0Yo4hQtp9zQ+hv+oWqfAHQJQQ48+hKjC4AB/F+0UnyjtZT/KlcieDjdxz/9Za/TIpcQt58yAobd4wttooJeeawCwBeTenDWFXzUpgjgkPmq56Uuka8XUOjjoW1yoeDMVsgdgybhfpsq9F9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UBlxds/F; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UBlxds/F"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ccea53f35cso4449466d6.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780055479; x=1780660279; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MawsOr5g5TsZEGLcgJS401SzBvbOX6ouP0Fchc3e/Ro=;
        b=UBlxds/FrMMG1khhSHQe69oiHGhSAmKKFHXvV2ykMg/v3HsaXbgfCcPCPTtLHUkB8P
         5ynWJNc0EtAYDUgdxhtQa8s7ysqc7zHKAy95z+KQB+rl0g5IoW9ly5U9fToLipD6+XUP
         QAgt+PhDGOxaYJlqpoc17BHCAEK1spw0h1EkM1b86W7h0VNU7r43BB6EfLVInshKlD4m
         PbNja1XWF3LaJM9MqTCG165qzipBFt6+cJm6qkBhnAb5IDeLzAQfcy583/1lUsOLj5oc
         xafJ2jr955D2Ozs+rf02owphKrNsc1aNkj1hihrp6yb45YPTg54BRKGxDKOmrHHoxU2l
         da7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780055479; x=1780660279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MawsOr5g5TsZEGLcgJS401SzBvbOX6ouP0Fchc3e/Ro=;
        b=ftwg2OY2Rzmv4yU9VkvLMvI+BdAg0kmFk4z4ToBwu09v81MizKguJ9FCHbGzOjbFUF
         fbSufrPtTALQX9qnMCKJxHNm+S2RwesEX7MwwswthValbQxD4DUIESAMpU8o+GlpwHpz
         eLykrpY60DviVzzQHYHwEAH4pobWKGmm5F0erV7KkA//A29Yf9/u5SlgavrOuxEw6jXr
         0OOEImcwj53LTl4RLkgGkIqqLNwh/m4GAOpzCRIll5EixXpws7f3MCkqNOz6sNey5ZnI
         TQSyn/gKBoC1xSmE11w2mnjNSHrebqgENMibq016CEQRCGwOmfG/FaqFR8XrT5TDvQ4Z
         rEBA==
X-Forwarded-Encrypted: i=1; AFNElJ9cJdkilm+HOmCZK4slfdI4nMlbqkxu22MfJQ3BQVCIl3dBChbqBZf25K8itVFAqlaupWPmOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzgYvHq0qEPYW7NQu7o5+VfXTa/GOo8Ys1BgHtDlXyr2imW4I3
	k2yEcWA5JYuA+rW9qeLnt5lAAzFOtBy51l6Dc7FziLQn8766lFNXT6GOD1TwehCp4EE=
X-Gm-Gg: Acq92OFvRQO3aMSLPgAQSdZk7hWFTkbqCMFXmnELyz1jcY3lb8DpBY5mTXUqTFyb5cQ
	Mzw1maF/30FlnmQg2orm0iW+A8Gyc+H8a6gbq0nM9aIqF/pDNG1olrHYahcmfY1BMDdg54dc7Tr
	HpgtOhwUn7tD1vhXmkHtJUARRv0ZYLEh6AQ93ATvJx52ewJOQ6OY0w/SotUK9eQMZPsfraE/HRi
	+Ix9tree0vZv0ukJ+dEj26J1P3vkFMSmJJ313ihRUl9de0GauWTXnT3xzKtHy4ilN72v+JZj4Bq
	MDnCwSGZtUM+s07w4uZGd+/C3BGt4tPgvVrI5Cz+CK23uHsChDxIn+gj6s6IJrmCYfPpkVcm2U2
	ivFipjC9ffg4ZJ8wE+TUjrnc1Zfjwz/BDJL4zxwyEyp9xNwn1schvA4GPXJoZJQvO9vqePFZV6t
	iifeGAxMsApK9FyeXhGQuIwMW7YeLXFtL17qQPKBsn+aDMFf/gQSGgtJdhV5HO3QOBwKRZRV9cs
	JkU8b1KhhKtrqA/
X-Received: by 2002:a05:6214:3d08:b0:8cc:e14:9594 with SMTP id 6a1803df08f44-8cce829b0admr31409816d6.33.1780055478649;
        Fri, 29 May 2026 04:51:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0451c7sm12666566d6.6.2026.05.29.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:51:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSvkC-00000000SKF-3RtJ;
	Fri, 29 May 2026 08:51:16 -0300
Date: Fri, 29 May 2026 08:51:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	alex@shazbot.org, kevin.tian@intel.com, skhawaja@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH] Optimize VFIO and IOMMU mapping traversal
Message-ID: <20260529115116.GR2487554@ziepe.ca>
References: <20260529070932.2632907-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529070932.2632907-1-guanghuifeng@linux.alibaba.com>

On Fri, May 29, 2026 at 03:09:32PM +0800, Guanghui Feng wrote:
> In VFIO, vfio_unmap_unpin requires performing iommu unmap and mm
> unpin on the address space. However, VFIO doesn't record the PHY
> address corresponding to iova, but instead obtains the iova-PHY
> mapping through iommu_iommu_iova_to_phys.
> 
> In IOMMU, under conditions such as address alignment, it prioritizes
> mapping iova-PHY based on bigpages. Therefore, during the
> vfio_unmap_unpin process, traversal can be performed at the
> granularity of the IOMMU map, reducing the number of
> iommu_iova_to_phys queries and significantly improving conversion
> efficiency.
> 
> Therefore, an iommu_iova_to_pgsize implementation is added to the
> IOMMU driver to return the pagesize used for the iova mapping.

This is the wrong API, what we need here is an iova_to_phys variation
that returns a size so physically contiguous IOPTEs can be joined.

>  drivers/iommu/amd/iommu.c           |  2 ++
>  drivers/iommu/generic_pt/iommu_pt.h | 53 +++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c         |  2 ++
>  drivers/iommu/iommu.c               | 25 ++++++++++++++
>  drivers/vfio/vfio_iommu_type1.c     | 17 +++++++--

If you care about performance use iommufd, and patches like this have
to update iommfd too.

>  static const struct iommu_domain_ops amdv1_ops = {
>  	IOMMU_PT_DOMAIN_OPS(amdv1),
> +	IOMMU_PT_PGSIZE_OPS(amdv1),
>  	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
>  	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
>  	.iotlb_sync = amd_iommu_iotlb_sync,

It should be routed through the private ops structure, and even if not
no reason to make another macro.

This would also need to be split into a patch adding the core API
function and then updating callers.

Jason
