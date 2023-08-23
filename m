Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E133B1F188
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 21:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692827913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kYBw/rjJ519igQAWI5TAdaYRHf19t9AlhiH33BYPJ6w=;
	b=Dult92kJ6u6nFklWKbPLQLQPZr5TTdNH7J35BYHq5EIIDlFI4tUVGN9t6RbJHEC4D9Gaku
	uOelWVwmh/GlDA6dFUALFnjXNsTOQyiKpOYKf5Csm7ePllPEarXJPqgod65Nlv2V5lt1Hw
	ojDxye/ALNHm0dZl2DZK+6ofbBPIKao=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-N-M7fTMRNwmDAliEGABk0A-1; Wed, 23 Aug 2023 17:58:32 -0400
X-MC-Unique: N-M7fTMRNwmDAliEGABk0A-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-64bca259c4bso69535496d6.1
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:58:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692827912; x=1693432712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYBw/rjJ519igQAWI5TAdaYRHf19t9AlhiH33BYPJ6w=;
        b=D4XG4m8ddgN/+TgNAiaJye6P/WbUtjIOa1MqVOoSIk0I2taF7aDxuvXYOlWxS53a4V
         u6u7VboAZJ0UwpOS2r2U3deqGjwiOs3w88fM+8YktwUlKo3nF6BhvuZ4xfvywGjCcX06
         5DUS+P7HXHVDw3OemmCQ0OwxwWyj2M3VZOek18uqyTqRXj2Yzoo502pwbebypCozrrcH
         +bdu0I2ZZBzZmxOUByUh1PL4ztMclne1MeHx66iwxFwdu0Jlbol0zLWjbf/9iambeeiG
         9v1GxgE3MhP5UULOhIcyivKSLf2G7ujbmbThLyp5XmaQJJkxKmDLX3lLK/hjeqw3kkB4
         Anfg==
X-Gm-Message-State: AOJu0YwQDDbOQxtMrMhNWjasIpA7kO5QOA74kh6c0GVXdwsxObKbnd3D
	CXVcbGMLCzpyJzPnbEkalz0QAmu4fbxYATSUkxsB79ur436dFQwewpKxenBmK7anfl2VO5I70/O
	9+kevkIemkUvPcpE=
X-Received: by 2002:a0c:dc81:0:b0:63c:dde2:5a20 with SMTP id n1-20020a0cdc81000000b0063cdde25a20mr15122735qvk.0.1692827911845;
        Wed, 23 Aug 2023 14:58:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy4X/FIBMHkXhjH2n5gUp9oK2UJ34UUDaSgRspAjvIFtGBWhgUBF7n5g5LW2aRRZwAjTCbhw==
X-Received: by 2002:a0c:dc81:0:b0:63c:dde2:5a20 with SMTP id n1-20020a0cdc81000000b0063cdde25a20mr15122723qvk.0.1692827911568;
        Wed, 23 Aug 2023 14:58:31 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id m1-20020a0c9d01000000b006472e929300sm4901984qvf.35.2023.08.23.14.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:58:31 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:58:29 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 07/14] iommu/amd: Miscellaneous clean up when free
 domain
Message-ID: <mulrdplcsxy37jlvdkh6clbs4iinqhwfdh6ipunpzg2t3z4cxt@vpcfq5cxvafz>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230821104227.706997-8-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 21, 2023 at 10:42:20AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> * Use the protection_domain_free() helper function to free domain.
>   The function has been modified to also free memory used for the v1 and v2
>   page tables. Also clear gcr3 table in v2 page table free path.
> 
> * Refactor code into cleanup_domain() for reusability. Change BUG_ON to
>   WARN_ON in cleanup path.
> 
> * Protection domain dev_cnt should be read when the domain is locked.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/io_pgtable_v2.c |  8 +++---
>  drivers/iommu/amd/iommu.c         | 44 +++++++++++++++----------------
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
> index e9ef2e0a62f6..f818a7e254d4 100644
> --- a/drivers/iommu/amd/io_pgtable_v2.c
> +++ b/drivers/iommu/amd/io_pgtable_v2.c
> @@ -363,10 +363,10 @@ static void v2_free_pgtable(struct io_pgtable *iop)
>  	if (!(pdom->flags & PD_IOMMUV2_MASK))
>  		return;
>  
> -	/*
> -	 * Make changes visible to IOMMUs. No need to clear gcr3 entry
> -	 * as gcr3 table is already freed.
> -	 */
> +	/* Clear gcr3 entry */
> +	amd_iommu_domain_clear_gcr3(&pdom->domain, 0);
> +
> +	/* Make changes visible to IOMMUs */
>  	amd_iommu_domain_update(pdom);
>  
>  	/* Free page table */
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index bf1640f4287c..f8319214064d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2047,9 +2047,11 @@ void amd_iommu_domain_update(struct protection_domain *domain)
>  static void cleanup_domain(struct protection_domain *domain)
>  {
>  	struct iommu_dev_data *entry;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&domain->lock, flags);
> +	lockdep_assert_held(&domain->lock);
> +
> +	if (!domain->dev_cnt)
> +		return;
>  
>  	while (!list_empty(&domain->dev_list)) {
>  		entry = list_first_entry(&domain->dev_list,
> @@ -2057,8 +2059,7 @@ static void cleanup_domain(struct protection_domain *domain)
>  		BUG_ON(!entry->domain);
>  		do_detach(entry);
>  	}
> -
> -	spin_unlock_irqrestore(&domain->lock, flags);
> +	WARN_ON(domain->dev_cnt != 0);
>  }
>  
>  static void protection_domain_free(struct protection_domain *domain)
> @@ -2069,6 +2070,12 @@ static void protection_domain_free(struct protection_domain *domain)
>  	if (domain->iop.pgtbl_cfg.tlb)
>  		free_io_pgtable_ops(&domain->iop.iop.ops);
>  
> +	if (domain->flags & PD_IOMMUV2_MASK)
> +		free_gcr3_table(domain);
> +
> +	if (domain->iop.root)
> +		free_page((unsigned long)domain->iop.root);
> +
>  	if (domain->id)
>  		domain_id_free(domain->id);
>  
> @@ -2083,10 +2090,8 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
>  
>  	if (mode != PAGE_MODE_NONE) {
>  		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
> -		if (!pt_root) {
> -			domain_id_free(domain->id);
> +		if (!pt_root)
>  			return -ENOMEM;
> -		}
>  	}
>  
>  	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
> @@ -2100,10 +2105,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
>  
>  	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
>  
> -	if (setup_gcr3_table(domain, 1)) {
> -		domain_id_free(domain->id);
> +	if (setup_gcr3_table(domain, 1))
>  		return -ENOMEM;
> -	}
>  
>  	return 0;
>  }
> @@ -2162,14 +2165,12 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  		goto out_err;
>  
>  	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
> -	if (!pgtbl_ops) {
> -		domain_id_free(domain->id);
> +	if (!pgtbl_ops)
>  		goto out_err;
> -	}
>  
>  	return domain;
>  out_err:
> -	kfree(domain);
> +	protection_domain_free(domain);
>  	return NULL;
>  }
>  
> @@ -2207,19 +2208,18 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
>  static void amd_iommu_domain_free(struct iommu_domain *dom)
>  {
>  	struct protection_domain *domain;
> +	unsigned long flags;
>  
> -	domain = to_pdomain(dom);
> +	if (!dom)
> +		return;
>  
> -	if (domain->dev_cnt > 0)
> -		cleanup_domain(domain);
> +	domain = to_pdomain(dom);
>  
> -	BUG_ON(domain->dev_cnt != 0);
> +	spin_lock_irqsave(&domain->lock, flags);
>  
> -	if (!dom)
> -		return;
> +	cleanup_domain(domain);
>  
> -	if (domain->flags & PD_IOMMUV2_MASK)
> -		free_gcr3_table(domain);
> +	spin_unlock_irqrestore(&domain->lock, flags);
>  
>  	protection_domain_free(domain);
>  }
> -- 
> 2.31.1
> 

