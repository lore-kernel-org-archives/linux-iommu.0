Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB16D17ADC
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692227892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IfnyCOhU0+j6utAb6AM3TsrH4dFJ+GkKbrx24qtPkIM=;
	b=WzHeYYn3PqUlaTTTSbgA16KYSBUMPP4XdKKPI0WWv0szaupabyeeqR1jI1Y6no/MCdoINw
	osfGbPUQdny4bNOb29l/Ek4hOaYV49XVEW9fKNx4S966JOHhVv84T+tfX5+b49JAcxhN2M
	RRox+Mbdfou9MFI7n1AKPIzlOyxgVVY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-cYllDhQLPc6ZlxapmtYSZQ-1; Wed, 16 Aug 2023 19:18:10 -0400
X-MC-Unique: cYllDhQLPc6ZlxapmtYSZQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40ff238340fso83851451cf.1
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 16:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692227890; x=1692832690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfnyCOhU0+j6utAb6AM3TsrH4dFJ+GkKbrx24qtPkIM=;
        b=gYsWZLSwuMOnVIR9z41utlG/69FwwcarOVuc8x/HN29XWSjHh6jhYM9CmWVjd9jusC
         1/f5I+MZ+NtEwIoThqkZHBOPwdtMNQvvoo5w86zEO0fli7us9bZbAbE4LmiiKnyibrkg
         auhrGJccXxl9l0dRqj6t8TAgus/o/w0XRj2WVLw3fyCX6seHsqeWr6uGRAIberb7anww
         WNvneHJ270ujgz9tQrEVG4jcknf6myGK48eokG4NAVCURiTxnpevP398Mrnsn/mJ49A9
         TYLO0IKtz2wDCowuLg9NuTeJa5s+u5Ff1RrdGz9tlmR4LAVWwW8C1F059DJJnO3u/dCf
         js9g==
X-Gm-Message-State: AOJu0YzhgoHbkqyERCxFY/hXD24XIK4uQcJU1tFOWktZK0EMC53lyt1z
	Kdh1GYvbDcYt8u4p2jlZjzTXt3rXvDaVX1c2ctE6CKTMlXpofeOnPa4fT3pH8IDw5fyqO09/9IA
	IbTOWP/tbD09VSns=
X-Received: by 2002:ac8:5b0d:0:b0:406:8bc2:6ba8 with SMTP id m13-20020ac85b0d000000b004068bc26ba8mr3291366qtw.2.1692227890387;
        Wed, 16 Aug 2023 16:18:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHulCPv9VUc9k39eOBjdLJrZG/uehp1Bqnd9xfBC359UMpVHZf0CD2YpFpcLumNiJir15HHA==
X-Received: by 2002:ac8:5b0d:0:b0:406:8bc2:6ba8 with SMTP id m13-20020ac85b0d000000b004068bc26ba8mr3291320qtw.2.1692227889517;
        Wed, 16 Aug 2023 16:18:09 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e905000000b00767ed2e6436sm4735107qkf.78.2023.08.16.16.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 16:18:08 -0700 (PDT)
Date: Wed, 16 Aug 2023 16:18:06 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca
Subject: Re: [PATCH v4 05/14] iommu/amd: Introduce helper functions for
 managing GCR3 table
Message-ID: <tg2suaamch4cacvx4kxcmvcscmpkw2jyg2bfcs5mrglhn4whvp@uvsm3rg43is3>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230815102202.565012-6-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2023 at 10:21:53AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Refactor domain_enable_v2() into helper functions for managing GCR3 table
> (i.e. setup_gcr3_table() and get_gcr3_levels()), which will be used in
> subsequent patches. Also re-arrange code and remove forward declaration.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/iommu.c | 65 +++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index d5569eec0fe9..bf1640f4287c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -77,7 +77,6 @@ struct iommu_cmd {
>  struct kmem_cache *amd_iommu_irq_cache;
>  
>  static void detach_device(struct device *dev);
> -static int domain_enable_v2(struct protection_domain *domain, int pasids);
>  
>  /****************************************************************************
>   *
> @@ -1575,6 +1574,42 @@ static void free_gcr3_table(struct protection_domain *domain)
>  	free_page((unsigned long)domain->gcr3_tbl);
>  }
>  
> +/*
> + * Number of GCR3 table levels required. Level must be 4-Kbyte
> + * page and can contain up to 512 entries.
> + */
> +static int get_gcr3_levels(int pasids)
> +{
> +	int levels;
> +
> +	if (pasids == -1)
> +		return amd_iommu_max_glx_val;
> +
> +	levels = get_count_order(pasids);
> +
> +	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
> +}
> +
> +/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
> +static int setup_gcr3_table(struct protection_domain *domain, int pasids)
> +{
> +	int levels = get_gcr3_levels(pasids);
> +
> +	if (levels > amd_iommu_max_glx_val)
> +		return -EINVAL;
> +
> +	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
> +	if (domain->gcr3_tbl == NULL)
> +		return -ENOMEM;
> +
> +	domain->glx      = levels;
> +	domain->flags   |= PD_IOMMUV2_MASK;
> +
> +	amd_iommu_domain_update(domain);
> +
> +	return 0;
> +}
> +
>  static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
>  			  struct protection_domain *domain, bool ats, bool ppr)
>  {
> @@ -2065,7 +2100,7 @@ static int protection_domain_init_v2(struct protection_domain *domain)
>  
>  	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
>  
> -	if (domain_enable_v2(domain, 1)) {
> +	if (setup_gcr3_table(domain, 1)) {
>  		domain_id_free(domain->id);
>  		return -ENOMEM;
>  	}
> @@ -2514,30 +2549,6 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
>  }
>  EXPORT_SYMBOL(amd_iommu_domain_direct_map);
>  
> -/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
> -static int domain_enable_v2(struct protection_domain *domain, int pasids)
> -{
> -	int levels;
> -
> -	/* Number of GCR3 table levels required */
> -	for (levels = 0; (pasids - 1) & ~0x1ff; pasids >>= 9)
> -		levels += 1;
> -
> -	if (levels > amd_iommu_max_glx_val)
> -		return -EINVAL;
> -
> -	domain->gcr3_tbl = (void *)get_zeroed_page(GFP_ATOMIC);
> -	if (domain->gcr3_tbl == NULL)
> -		return -ENOMEM;
> -
> -	domain->glx      = levels;
> -	domain->flags   |= PD_IOMMUV2_MASK;
> -
> -	amd_iommu_domain_update(domain);
> -
> -	return 0;
> -}
> -
>  int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
>  {
>  	struct protection_domain *pdom = to_pdomain(dom);
> @@ -2556,7 +2567,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
>  		goto out;
>  
>  	if (!pdom->gcr3_tbl)
> -		ret = domain_enable_v2(pdom, pasids);
> +		ret = setup_gcr3_table(pdom, pasids);
>  
>  out:
>  	spin_unlock_irqrestore(&pdom->lock, flags);
> -- 
> 2.31.1
> 

