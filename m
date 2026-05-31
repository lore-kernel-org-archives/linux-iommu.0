Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E183546D1
	for <iommu@lists.linux.dev>; Sun, 31 May 2026 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780271513; cv=none; b=NLtgqImfNYcBfkzHdYEjuIv6fmpIct9EeBllndcqnqJPFo7JEgfdSrVlK+iVuGpZ0pN7sDoDDCBPhU7RKSAbbAPsfDKryOtFicp9DTISeha4nvfzlqMSMgzcu/A/PmkfgqYhFTBoXGIjjXGQWvPw1q6+oTU/qXnxfoQGntM1+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780271513; c=relaxed/simple;
	bh=vZPmrTp86MbPzKorp7nUexYwkpoU7a/NNFPpiXKZRk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLs0DVxib7Ecu2jTN7B/MzdjUvJzfyXBso4tFbtWUMK4lM6clq/UIw5XmfoB/P/y+3aq/NeVfxha/8rdMQQwT/kZFVWhHIDT6jnNbNZDX+l9uCvuXgniC6u36uM2tE4EYAJlcXRseN3S5H9nASl2KF+2ngo54Mj4a9pH3iQ1pH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mnWpApYj; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mnWpApYj"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91550eca866so129234585a.1
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 16:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780271511; x=1780876311; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jT2+faPEqgvyyrZj7GkiI+MQEalHKPFUv4mZyF5by/U=;
        b=mnWpApYjdDEwHkHVlnJcn0ZAMmTjBo6lWb6WULlhymPm+MI0sxycWh9UPnV2YqdK/m
         CQTwSjPbWAW6/oMhN8vnYrprs4UAwshoWgqwn83eR0vT71RZFRw5JfTg/eqpN/9WSqOv
         gQp2IHdu2694Y6cIMa4AzhGDjRw0OndTsppEHH9OjOgW4RoKOqyIStSJObLZokKomb9e
         UDBlm1TLaho7J9Tq6XbcbSKuGsxMS+iDPW098wYdkH66B6SSaA3+/f+yplgyaQaUUMx4
         8ZAYH4xVrZslOWVyPirhviRky5WB3Xrr9/gJhAQKwdY6EXgZOR8w7AGNHdj4oPq55PHL
         rhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780271511; x=1780876311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT2+faPEqgvyyrZj7GkiI+MQEalHKPFUv4mZyF5by/U=;
        b=W1LemJ4RrQPzcDb+9S1awEiQABkrXs1FY0O6ndF6YM9+JAX31ezKLRZS3uKS21Ru4r
         CsmH4K7q6ovHJWGPHg4YJF/L9pXNDsQUdlG7XR7gPGojlZ3I4UZYC/jsKunWIQdS0Vm9
         usvfePV6mjWA64QI80HChNYpq+Nt4svl4Hj7wuAmBdJrlBQkPxeZNs1UqWi54yo/L4gR
         oHs0KaEEIrZZjSvFPaL0Tn4Suwiu2sKvTHWz/P9dUNG1+hSn0iI3Zzx/ewkNzryy2Gkx
         v5iVzB2c6dcgAGVtqC/UFQiiSJlHktMkO0GwGMqFEGWFBI9vyaGQxSQbLB2k+EqkVGBu
         DkjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QwXFTPnyZ8vWPYj6LPf4rsIgqOhyVM9urQ1AHHi5XeVSm3cc0994H0CgcjL1fzGLrGJTV+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHmMR+PjUrGzGwkup/QfLDj9quCILCueIMLhZJ42tUDlNXmoPT
	7ZJD8D17FBNrmjs3+yqQ4BGDdioV9YllU4DIGQHCl7187hiohiAYljALSS6vGhYmKnE=
X-Gm-Gg: Acq92OHMCnjhbWj+pMuJ0n9I3sXCKuqhB4n+2KLOFozspd1UDDtIZH6rceQXjk159Q5
	GFHZwRGuahIyotPUlOpaCI6200pBNPw/38w+l/DckrFDvc/QTSTRB3dmvwoX6g494vpdB+XzeKn
	9MaUaI90NULKuMJsgkglG/VmsoV7AKoOZ2+f80926mWfNB8gubdEzxgNPBW7xmGicadcEnXarmd
	1r50k/rS04lw+akVp60ez5uW4DIzANSsX4RroanJmse+TnNqynFUY2PlqtVy9B/bM5rqJfED/Pi
	bAVwQVyLe6YiBPkhFIImdGqydLSdFMCcOm6zp/9MjNbBmIVyUFMj21cNP6kqE/x/wuSOSmmyQRz
	3fR7Sbp1V0ZGUquq6D9itJjacDDVdtS4fT/9xx9OSM/OVfIBo3nARweQQUxcoLwwWfa07bjaf2j
	K6/wz9C2qK5DdINYAqb9jtsNvTyyD1r9yqIvDGBV23H0e1nINxPqiCAp4go5czQsyvsHgpIKwjT
	fgVJPwjLJD3J/fq
X-Received: by 2002:a05:620a:439b:b0:913:7bc8:79b9 with SMTP id af79cd13be357-9153d9b617bmr1323643185a.22.1780271510817;
        Sun, 31 May 2026 16:51:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532473bb9sm854276585a.11.2026.05.31.16.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:51:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wTpwa-00000001LoH-3dmS;
	Sun, 31 May 2026 20:51:48 -0300
Date: Sun, 31 May 2026 20:51:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260531235148.GV2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>

On Sun, May 31, 2026 at 05:36:29PM +0800, Guanghui Feng wrote:
> Add iova_to_phys_length callback to struct iommu_domain_ops alongside
> the existing iova_to_phys. The new callback returns both the physical
> address and the PTE mapping page size in a single page table walk.
> 
> Add iommu_iova_to_phys_length() core function that:
> - Checks ops->iova_to_phys_length first (preferred path)
> - Falls back to ops->iova_to_phys for unmigrated drivers
> 
> This enables callers like VFIO to efficiently traverse IOVA space
> by actual mapping granularity instead of fixed PAGE_SIZE steps.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
> ---
>  drivers/iommu/iommu.c | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/iommu.h |  9 +++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1a9e713d3a0..43323229a1df 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2545,15 +2545,45 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_group);
>  
> -phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
> +/**
> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> + * @domain: IOMMU domain to query
> + * @iova: IO virtual address to translate
> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> + *
> + * Like iommu_iova_to_phys() but additionally returns the page size of the
> + * PTE mapping at @iova through @mapped_length.
> + *
> + * Return: The physical address for the given IOVA, or 0 if no translation.
> + */

When introducing the new function I would like to fix this 0 error as
well, it should return PHYS_MAX for error

> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return iova;
>  
>  	if (domain->type == IOMMU_DOMAIN_BLOCKED)
>  		return 0;

Any domain that doesn't have an op should fail, blocked is one example

>  
> -	return domain->ops->iova_to_phys(domain, iova);
> +	if (domain->ops->iova_to_phys_length)
> +		return domain->ops->iova_to_phys_length(domain, iova,
> +							mapped_length);
> +
> +	/* Fallback to legacy iova_to_phys without length info */
> +	if (domain->ops->iova_to_phys)
> +		return domain->ops->iova_to_phys(domain, iova);

If it falls back it should return something sensible for the length.

I suggest you approach the patch plan a little differently, the first
patches should implement the new function and an iommput
implementation

Arrange things so the normal iova_to_phys calls the new function if it
is available and discards the length.

Then convert callers that can take advantage of it. Have the fallback
path also compute the length by iterating internally.

Finally one patch per driver implementing the new op, this could even
be a second series.

Don't remove iova_to_phys(), it is fine for things that don't need the
length.

Jason
