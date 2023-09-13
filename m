Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42988F68
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 14:39:30 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-76dbe263c68so47646185a.0
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 07:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694615969; x=1695220769; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JlhpFrfkex272LQWM62BfB7o6I+dpDprtSnMTEUDBmE=;
        b=Ws4PEZIkF0ziyxpXp46EaM9umJdWcD2W83G3Gy2DraEshDqavyw3wfwFhJSH7bVMOk
         I1Jl+2YcvylGzvGXIrCgvgQUa/d0UZaKXR3B+EpxIO/JQPrHphZmrwCJGfDWo9PuJZ4a
         ZIJJROpL0WzC0l0Z2OWuCp21i4iQacnazKz2KxS9ltQGxUHMca58yrGXw41KdMMFczxT
         Z6KE1NGp9lG2/31FR4p9xC4f2QyLrB85D/4rwwA6EIc6vlkVIRBcZybiuGHLES/x60FC
         X0S5cr9mstcxO8038wuCEgvRy6U5pUdjXtgHvJTn5lwdrzcSMUQGXdXBDUw3eYgK+czK
         XJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615969; x=1695220769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlhpFrfkex272LQWM62BfB7o6I+dpDprtSnMTEUDBmE=;
        b=coH0DhEW056h12FIfzniMTMakJvtgAK6yEKeVRXnWREB+yMHq1Q1dNfKvf2NpJq/Bi
         wBSAxFvd9NQvixrhpECAZZmFrbUIdZpV+SobqvyhUpF4l+J3/izNnGFdXC06/mDpRawF
         1ohxApivbRkCS0S8FMnQdrUkUkJMChU9sFU8lsPaVk0wywult5fIMmehyqbRCKGLPEKc
         uYPpRSWgFPSiQQ5df+OiBT+AN10QY7P/7QU7N5qf2jJ4XuUKk9CFpnlvaty9Yjgbqp1s
         HtZy76gzsH+HbPikMF4ZOR7AhtdICHYienM453mcz/7PET9FjcbVvwHiU72UPWoP/Qlh
         1rVQ==
X-Gm-Message-State: AOJu0YziRJtpUjuCinorAkyItWcwW315tU0h1LiXBCOAsaJjSP9d3i7F
	9c4aUB0NXA14Jg5cpPTJMu0f0Q==
X-Google-Smtp-Source: AGHT+IHFn+RVxePFaIvutkcLCHF9rYeStRPYAbL1N64yIQdIG34uxFMfk08Ra/XUBaYLhmT5rFNPFw==
X-Received: by 2002:a05:620a:46aa:b0:76c:ba9d:3ec7 with SMTP id bq42-20020a05620a46aa00b0076cba9d3ec7mr2927143qkb.6.1694615969613;
        Wed, 13 Sep 2023 07:39:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id c10-20020a05620a134a00b0076816153dcdsm3923576qkl.106.2023.09.13.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:39:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qgR1c-003edV-B2;
	Wed, 13 Sep 2023 11:39:28 -0300
Date: Wed, 13 Sep 2023 11:39:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
	heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: Re: [PATCH 8/8] iommu: Improve map/unmap sanity checks
Message-ID: <ZQHJoK0Er/nekjL6@ziepe.ca>
References: <cover.1694525662.git.robin.murphy@arm.com>
 <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>

On Tue, Sep 12, 2023 at 05:18:44PM +0100, Robin Murphy wrote:
> The current checks for the __IOMMU_DOMAIN_PAGING capability seem a
> bit stifled, since it is quite likely now that a non-paging domain
> won't have a pgsize_bitmap and/or mapping ops, and thus get caught
> by the earlier condition anyway. Swap them around to test the more
> fundamental condition first, then we can reasonably also upgrade
> the other to a WARN_ON, since if a driver does ever expose a paging
> domain without the means to actually page, it's clearly very broken.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c83f2e4c56f5..391bcae4d02d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2427,12 +2427,12 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>  	phys_addr_t orig_paddr = paddr;
>  	int ret = 0;
>  
> -	if (unlikely(!ops->map_pages || domain->pgsize_bitmap == 0UL))
> -		return -ENODEV;
> -
>  	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
>  		return -EINVAL;

Why isn't this a WARN_ON? The caller is clearly lost its mind if it
is calling map on a non paging domain..

> +	if (WARN_ON(!ops->map_pages || domain->pgsize_bitmap == 0UL))
> +		return -ENODEV;
> +

And these could be moved to after attach so they are not in any fast
path, and eventually to after alloc..

Jason
