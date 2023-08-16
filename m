Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502415AEA
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692200585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7ybRXFky5FJW2y2G7vzYHhM/MhJhslm/CXzESwXBqs=;
	b=c6rqpPByAudo3bN+gUbd1s9IZU57GIDiRbRPM4hnIfELVFYP0oiOfLueWm4zXggRKypA/6
	1H4st03wYd6i5PfXCAgT90+OA+PLnFmWv5weqPKQt2Tzp6EgCfoEkVJXvxvudmeu5jTjDH
	JaBd5fa4eUbeRLTGt1N15mfAGiOXzlc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-O91GMlytNf-Si9dwEt1iUw-1; Wed, 16 Aug 2023 11:43:02 -0400
X-MC-Unique: O91GMlytNf-Si9dwEt1iUw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76d79cd9575so8096285a.1
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 08:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200582; x=1692805382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7ybRXFky5FJW2y2G7vzYHhM/MhJhslm/CXzESwXBqs=;
        b=UxEGlDK5Vrir65rcIulUBQTaOPz5LNZC9G8kElyQq8U9H37HvWE33oLjMGG9ML42/z
         AdEypTpRGL4nor8ep29h/zMlpPwLFZuf9zxBDd7oMG6cFc+h2lTdtyWpgalVW4zS99wa
         OuHRNGcD1nHtsvGQun7pIrcP/s7ex2Hpk1GEHxoud87Baog0CfwBM7mKyh/v5Btr0sIi
         bUGN7Vh80dUEPL8/UTIMqm0DSv7wYS2l6mDPhSXXLGaZnqQk/p41ZxASP6b6opV5QPZB
         GxFm7RhWr+Zl76rB09flpqBTKKU2tQBVRzfvoL/hsZgGBfd/rIXKK2rCaRl5jocwA37Z
         aSyA==
X-Gm-Message-State: AOJu0Yyf0+q0uP7ES5yEBbDmMOPs80Pt+w8PDdPTis4aUxNHuhYrjiI7
	32x6/D8Pg9xHFA331pZmn19yooRGb3I1Gzdb1NzNWFdaQjvq9yfG8XsHkvJfCyPoNYQ3qkB3MF2
	SvwqDo4XxiySbI3E=
X-Received: by 2002:a37:ac05:0:b0:75d:52fd:bb79 with SMTP id e5-20020a37ac05000000b0075d52fdbb79mr2255686qkm.46.1692200581995;
        Wed, 16 Aug 2023 08:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7JZmo2pM8DRSylBT1Pur2jq/qBRGDeCdAzqns3MBwzaZKGnXPcJYsoiaw/+b8Xb0YdDlQ1g==
X-Received: by 2002:a37:ac05:0:b0:75d:52fd:bb79 with SMTP id e5-20020a37ac05000000b0075d52fdbb79mr2255678qkm.46.1692200581742;
        Wed, 16 Aug 2023 08:43:01 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id d18-20020a05620a159200b00767c61ee342sm4481276qkk.48.2023.08.16.08.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:43:01 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:42:59 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 03/14] iommu/amd: Consolidate logic to allocate
 protection domain
Message-ID: <wynws4dhgosoojnm5tg23zsjxse5fubchqh27nqh4bio637vnf@rfumluw6aaqb>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230815102202.565012-4-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2023 at 10:21:51AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Move the logic into the common caller function to simplify the code.
> 
> No functional changes intended.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/iommu.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dd586f69a9d8..c2cb541b0553 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2046,12 +2046,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
>  
>  	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
>  
> -	spin_lock_init(&domain->lock);
> -	domain->id = domain_id_alloc();
> -	if (!domain->id)
> -		return -ENOMEM;
> -	INIT_LIST_HEAD(&domain->dev_list);
> -
>  	if (mode != PAGE_MODE_NONE) {
>  		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
>  		if (!pt_root) {
> @@ -2067,12 +2061,6 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
>  
>  static int protection_domain_init_v2(struct protection_domain *domain)
>  {
> -	spin_lock_init(&domain->lock);
> -	domain->id = domain_id_alloc();
> -	if (!domain->id)
> -		return -ENOMEM;
> -	INIT_LIST_HEAD(&domain->dev_list);
> -
>  	domain->flags |= PD_GIOV_MASK;
>  
>  	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> @@ -2112,6 +2100,13 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	if (!domain)
>  		return NULL;
>  
> +	domain->id = domain_id_alloc();
> +	if (!domain->id)
> +		goto out_err;
> +
> +	spin_lock_init(&domain->lock);
> +	INIT_LIST_HEAD(&domain->dev_list);
> +
>  	switch (pgtable) {
>  	case AMD_IOMMU_V1:
>  		ret = protection_domain_init_v1(domain, mode);
> -- 
> 2.31.1
> 

