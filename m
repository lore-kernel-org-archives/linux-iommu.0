Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFF156E8
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 16:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692202711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utCqjvLWV+V/c7XJX2ABIVH6zi2wdXRdM2D5kmd1Rxk=;
	b=EA0z7NO67jyePgsYteo685QvfjO3mZ96sDtOcePodfFG7qZ9Jex+QvDWDkha8NATimTuCB
	WhIUFDnGM7W2xxOpQlsuTKbnq9snIavNxH7uE7yF2xCULFJADQExF0I6qM1srA0NUzKWKD
	G75vW0Vhy0K4lnnyq8uIslL4zdcumEk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-AmxIe5n0MaqHAk-Z0TOE8Q-1; Wed, 16 Aug 2023 12:18:29 -0400
X-MC-Unique: AmxIe5n0MaqHAk-Z0TOE8Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76c939bc1adso1015931585a.3
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 09:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692202707; x=1692807507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utCqjvLWV+V/c7XJX2ABIVH6zi2wdXRdM2D5kmd1Rxk=;
        b=HieLYJ4LKbNuVDM8pUVRwLiG/izxqDTFUdDfHqcnCeoA4EFWSd8PerEVNAa4dN23Cm
         QICjuLUs9ZpjFChwYy8SD3McTzvKHEdwHPkys/NMy1PGn8qUBfsQFncp/RU0+hYAFLWH
         WtDw2thbg75M15eqdjwKNLw8wlXnNJTMJDI+HgE5trE0pCMn33+2L1I+0cPEmVVZWUks
         X0vWaCCDFhGOJ30veejjDNA93gfKIuuKvR5tEetJEyQkJf9QGrVGXwjvVjCfa/DDnkAk
         rnIF+DRJ12NqeF3/C73cNGlAlEZkMRXWSsJ+54TAHIvw8qEsP9DYgko7wc7sQ3aAr18U
         g/YQ==
X-Gm-Message-State: AOJu0Yz3zY2UC0tEM0akv66ZxFl6XjdsMKRJ6Dg+36ZUjuv747/+aeTV
	Uq+3AVt7xpN2WJDoN1K4w3u2KObNkpL0cZABKXiJFub42xmadppcF2ROIJnQveFPBC7Y2xsfoq/
	5N6hiWE+pPzaTbRM=
X-Received: by 2002:a05:620a:280e:b0:76c:6f89:e5f1 with SMTP id f14-20020a05620a280e00b0076c6f89e5f1mr3055921qkp.18.1692202707719;
        Wed, 16 Aug 2023 09:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwhb+M+6S83AgVcUjZS1FcS2lSLxUabEN4Rh3f/GnfQf0y1lSVD/qrhsMZyP2jtTC5iybQCw==
X-Received: by 2002:a05:620a:280e:b0:76c:6f89:e5f1 with SMTP id f14-20020a05620a280e00b0076c6f89e5f1mr3055903qkp.18.1692202707511;
        Wed, 16 Aug 2023 09:18:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id op29-20020a05620a535d00b0076c84240467sm4496374qkn.52.2023.08.16.09.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:18:26 -0700 (PDT)
Date: Wed, 16 Aug 2023 09:18:25 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 04/14] iommu/amd: Refactor protection domain
 allocation code
Message-ID: <zje4mpek3tqojvai7kqibhqmq32l2accvns63hxkzbkwgcno22@kr4n4jywbuu3>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230815102202.565012-5-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2023 at 10:21:52AM +0000, Vasant Hegde wrote:
> To replace if-else with switch-case statement due to increasing number of
> domain types.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c2cb541b0553..d5569eec0fe9 100644
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
> @@ -2106,27 +2090,42 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
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
> +	case IOMMU_DOMAIN_DMA_FQ:
> +		pgtable = amd_iommu_pgtable;
> +		break;
> +	/*
> +	 * Force IOMMU v1 page table when allocating
> +	 * domain for pass-through devices.
> +	 */
> +	case IOMMU_DOMAIN_UNMANAGED:
> +		pgtable = AMD_IOMMU_V1;
> +		break;
> +	default:
> +		goto out_err;
> +	}
>  
>  	switch (pgtable) {
>  	case AMD_IOMMU_V1:
> -		ret = protection_domain_init_v1(domain, mode);
> +		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
>  		break;
>  	case AMD_IOMMU_V2:
>  		ret = protection_domain_init_v2(domain);
>  		break;
>  	default:
>  		ret = -EINVAL;
> +		break;
>  	}
>  
>  	if (ret)
>  		goto out_err;
>  
> -	/* No need to allocate io pgtable ops in passthrough mode */
> -	if (type == IOMMU_DOMAIN_IDENTITY)
> -		return domain;
> -
> -	domain->nid = NUMA_NO_NODE;
> -
>  	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
>  	if (!pgtbl_ops) {
>  		domain_id_free(domain->id);
> -- 
> 2.31.1
> 

