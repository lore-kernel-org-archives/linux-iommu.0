Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA3C8FF
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692203208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jQkaFytZGX7yJJ2vsYreBzQaDeKKS8xau1s4UNGJwzI=;
	b=JsCVJHGqnerRixj/xpa4BOPVN2D43wyu/RX8ODymU/ta1Jk/frIsYPU2oVBNsgVrRzVBke
	dygfuFdqPHAAvsHBN6QDSNYhHiVHXuFjD1u+M2t3uodRCKGwBcfLvDqZUwDzOhAgdsb4eQ
	tvF7xwh5lOXTmw5eQ5lKLRUHrC9uETA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-kxNAoEr0OoinDWvSXWrptg-1; Wed, 16 Aug 2023 12:26:45 -0400
X-MC-Unique: kxNAoEr0OoinDWvSXWrptg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40ff2434811so71304461cf.0
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 09:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203205; x=1692808005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQkaFytZGX7yJJ2vsYreBzQaDeKKS8xau1s4UNGJwzI=;
        b=GzOQjvbItbGJMRoRoEGjqs/65HELvP6bA7Rj6PwaCT4P9PGYzfh89YX6mm26s3tTWh
         Urw8LQu8A+F2KyMoT+BKEzYJTsY3wF9vqnDlVHIyeTX2A857hOsGn6b1AoaKmRVc/MFq
         2lK91PWch9p1y9H/Z6osFeZ9iDgY+j2hxZHts0vSBO2GCWSSY8JPNytHEUyO1W1Paqj0
         4OvK8l3xYV4VgL4fdmjoUl7yiBPQzPsfJsN+XuvUaAp9qyse/c5PnMPooZ+G116RFi0L
         hbt0t+yRooDSg8wKWTmhExmsFNq4iRqBnGSVwaU7FfcV7/xqhxC6cjzTnn5YN+ebOrxL
         ALqw==
X-Gm-Message-State: AOJu0YxR7UX99efQ2RZPpQMSRym0tkspWhCenCc5nhu42WM6adEhzK3N
	Criyj6HENS8YnkVwIAgBZS4hgxZpCHYKZS5HRlnQ8aulZz9vpne6V1Ghnpr4qcDqnZUxv4j0Jm/
	fYG2SgDWVkpyiL6Y=
X-Received: by 2002:a05:622a:148b:b0:40f:ce6d:775e with SMTP id t11-20020a05622a148b00b0040fce6d775emr3068032qtx.42.1692203205117;
        Wed, 16 Aug 2023 09:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/GIHUNnf0oTe9+lJSswuapo1QCkEBRxNQD7m9vEFR9QkAuiRF7N23s0B5uwbYvEuT3jqcMw==
X-Received: by 2002:a05:622a:148b:b0:40f:ce6d:775e with SMTP id t11-20020a05622a148b00b0040fce6d775emr3068016qtx.42.1692203204888;
        Wed, 16 Aug 2023 09:26:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id cg3-20020a05622a408300b003f872332a9asm4553935qtb.64.2023.08.16.09.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:26:44 -0700 (PDT)
Date: Wed, 16 Aug 2023 09:26:42 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 06/14] iommu/amd: Do not set amd_iommu_pgtable in
 pass-through mode
Message-ID: <g7pvo7zmaswoni5jzrrrwd7driuoucyujd72qvrx5fm25ozb4b@jlaupn67xvvz>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230815102202.565012-7-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2023 at 10:21:54AM +0000, Vasant Hegde wrote:
> Since AMD IOMMU page table is not used in passthrough mode, switching to
> v1 page table is not required.
> 
> Therefore, remove redundant amd_iommu_pgtable update and misleading
> warning message.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/init.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 852e40b13d20..2b01dfde6cab 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2134,9 +2134,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  		    !iommu_feature(iommu, FEATURE_GT)) {
>  			pr_warn("Cannot enable v2 page table for DMA-API. Fallback to v1.\n");
>  			amd_iommu_pgtable = AMD_IOMMU_V1;
> -		} else if (iommu_default_passthrough()) {
> -			pr_warn("V2 page table doesn't support passthrough mode. Fallback to v1.\n");
> -			amd_iommu_pgtable = AMD_IOMMU_V1;
>  		}
>  	}
>  
> -- 
> 2.31.1
> 

