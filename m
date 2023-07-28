Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD4C8C9
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 13:53:46 +0000 (UTC)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-63cf6b21035so13971766d6.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690552425; x=1691157225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxrnTrWiSYuIti/e6mj5og7tc3tPre/F4OP5JFn2lEc=;
        b=PbXL5tfqIoiIOlztmYBBKy2j6rwIjTrH1hslKo1Am58Shts4u71Ynu30yT/gVlVGsv
         K6l9EtYHok/4ipqMYR48/PCF/LgeAOOjU3ThFHnuptYkUdg+KMPDtYFH04XDNu6lmG/P
         +3G4ogsHyGA54SU4w7OXLQzpuxRGVoZtkOCAyxgxpesgSlh426Cd2sQz8u+juVLG7q5F
         BD/TyH181zKuoJXml2FBlzJDVDfYROIr9pSSS4tOdLMRJsNgQlXd8T7rHErZLNv4g1tM
         iKH7zyD7006nYwIvK0FZCI7pXv5O17EWgca7htybT3UpPs88BfrQ+ZfW5QH93VKmiOs5
         jE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552425; x=1691157225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxrnTrWiSYuIti/e6mj5og7tc3tPre/F4OP5JFn2lEc=;
        b=BfgD4Be0hcOm5f/mahTtKz7oOgsUAnHcIUfJznYkxFfbMoE7BwNgMLOOxk+Uhihgn3
         Xk0pq0677soZmf9RBTQlNRvK/1RbZ5HbVLPqxCQpsfPkqpKsyvUENt753lQ2KGoU5OFT
         nBUKDnSQD4Oea0oeeZN+ueSHZ7GsKhZnz8VXHsZ5FNBNA0yFXJQ4vtyyBzEr3CmBStGH
         X2yq4Uun8xYqxSUuVFEup/6I5IxbcV0HbHcgArOToHk3JyfBf0u28NM71XsLnOO5pwGH
         iZ/ts+GMZUw4etZsc4lc53dJcXNXSOzS6fwPuXIKio/037bTQV24l71HlRQDPPggwV/j
         hXhQ==
X-Gm-Message-State: ABy/qLagzpSxCz4IwFEdbWv2UfjQCdhdce5UTv5JdttadVROfny4LI0g
	WEf2UFO5QOFGbskrBN+Euki6YzRNj9ILs7DKD5c=
X-Google-Smtp-Source: APBJJlHVjYg6+OSanq1uHjDt92+VFrQHTJj2u6gXRXzwIy1QLCaDdwoTfGE1N90MAdBCmNvXhYYjLQ==
X-Received: by 2002:a05:6214:18ee:b0:635:b4e7:185d with SMTP id ep14-20020a05621418ee00b00635b4e7185dmr2255750qvb.33.1690552425403;
        Fri, 28 Jul 2023 06:53:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g7-20020a0cdf07000000b0062df126ca11sm1242806qvl.21.2023.07.28.06.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 06:53:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPNua-001bLp-9W;
	Fri, 28 Jul 2023 10:53:44 -0300
Date: Fri, 28 Jul 2023 10:53:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 04/16] iommu/amd: Refactor protection domain
 allocation code
Message-ID: <ZMPIaG9IktvVqbI1@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-5-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:35:57AM +0000, Vasant Hegde wrote:
> To replace if-else with switch-case statement due to increasing number of
> domain types.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 46 +++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c2cb541b0553..09749ad4445c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2078,24 +2078,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	struct io_pgtable_ops *pgtbl_ops;
>  	struct protection_domain *domain;
>  	int pgtable;
> -	int mode = DEFAULT_PGTABLE_LEVEL;
>  	int ret;
>  
> -	/*
> -	 * Force IOMMU v1 page table when iommu=pt and
> -	 * when allocating domain for pass-through devices.
> -	 */
> -	if (type == IOMMU_DOMAIN_IDENTITY) {
> -		pgtable = AMD_IOMMU_V1;
> -		mode = PAGE_MODE_NONE;
> -	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
> -		pgtable = AMD_IOMMU_V1;
> -	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
> -		pgtable = amd_iommu_pgtable;
> -	} else {
> -		return NULL;
> -	}
> -
>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (!domain)
>  		return NULL;
> @@ -2106,27 +2090,43 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  
>  	spin_lock_init(&domain->lock);
>  	INIT_LIST_HEAD(&domain->dev_list);
> +	domain->nid = NUMA_NO_NODE;
> +
> +	switch (type) {
> +	/* No need to allocate io pgtable ops in passthrough mode */
> +	case IOMMU_DOMAIN_IDENTITY:
> +		return domain;
> +	case IOMMU_DOMAIN_DMA:
> +		fallthrough;
> +	case IOMMU_DOMAIN_DMA_FQ:

you don't need the fallthrough there, just put the two cases together,
the compiler recognizes the pattern

> +		pgtable = amd_iommu_pgtable;
> +		break;
> +	/*
> +	 * Force IOMMU v1 page table when allocating
> +	 * domain for pass-through devices.
> +	 */
> +	case IOMMU_DOMAIN_UNMANAGED:
> +		pgtable = AMD_IOMMU_V1;
> +		break;

I've been wondering why this was done, it really should not be
done. Unmanaged and DMA should be the same. The driver should pick the
one with the highest performance.

Otherwise it looks fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
