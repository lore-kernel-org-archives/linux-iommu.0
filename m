Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C884BE6C
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 13:28:53 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a751d2e6ecso1635498b6e.0
        for <iommu@lists.linux.dev>; Fri, 04 Aug 2023 06:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691155732; x=1691760532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWxQHRWTyWs/VUTiNUl3bSKSezxZnAwXbfHnbXUxK8I=;
        b=LchXcDmb1p4mkNWSF2u7PTzC9Wcx5vck9ifNPdrLoTl0UVUVYgYLob9w3Y17nMlMlQ
         kkBqzxbytSafOEXafIbmCUlK+V43Lv4uE6bfHvRQQOCujuBsUlL9MQlIGkTZWi1NgREQ
         RrVanwHYrfVhkAevlYDJfTjIToa6fhcFPzDgOmlg+wAJgV321b2IxCJruLGzpRfjOzx6
         KMkHCIYUKPYVe8KkKzCAPtVQZ+U6pPtogUqwQdGwl+5rDHhp2XisJw0IBdDmsbKS0xzk
         L9XOBib9ttVV4Gqf95eo3tg/fkbfYNl4ZJ7ahG8X/ZCj0uVA70GGsguMAppQq5+ghsXD
         +nYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691155732; x=1691760532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWxQHRWTyWs/VUTiNUl3bSKSezxZnAwXbfHnbXUxK8I=;
        b=gADD227AjPbIAkgzpMnXNDI/PsPkbv6pvtNcgFzHVfu4LuWKhHamNhLVWcx5GjCdEV
         tkrLTSeafQNM4D0CDtdTMrTf/pOXnVi4w6B+yj7Y6ZKgGXQThlakQfIqWUHHwPtfnq3U
         +viGQlbZdkPoGW2XN7gkdIgc6TvGkcZTAnKEV+kNVwhUc/mU9Mf5Arv97k8lfO4HF8LQ
         Q7gKr8E/dBDiAE7Xh7HYl/PTeper/An9akzA0CrZIy2LU6NV516VdwroypH2XTGqAeWP
         kM1lBGPvrJkjaX59mp0oF2SKroL7C85FeSWxSEfZAkgWZtYYnK3gHt03aYuMw+/kysGz
         NIMg==
X-Gm-Message-State: AOJu0Yx2lt2g3Zen7ZtVbzIX/9vRciIrpvhF/p87hnmALUDqu/3uPsQy
	9O9MZnq8QI8bWRZa4H7N9mSzIg==
X-Google-Smtp-Source: AGHT+IFqaIVKt4DXOHqIBnzuytdCAeu7/OHKMYVqkCQw9CKLV9C2CM999vO9OLljQ++b6IzAjo9aSw==
X-Received: by 2002:a05:6358:280d:b0:130:afe8:43de with SMTP id k13-20020a056358280d00b00130afe843demr2097824rwb.30.1691155732354;
        Fri, 04 Aug 2023 06:28:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id n17-20020a0cdc91000000b006238b37fb05sm660907qvk.119.2023.08.04.06.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:28:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRurL-003ivN-5Y;
	Fri, 04 Aug 2023 10:28:51 -0300
Date: Fri, 4 Aug 2023 10:28:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 12/16] iommu/amd: Add support for different types of
 PPR handler
Message-ID: <ZMz9E41XgqzFub2g@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804064216.835544-13-vasant.hegde@amd.com>

On Fri, Aug 04, 2023 at 06:42:12AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
> PPR is enabled per PCI end-point device, and is configured by the PPR bit
> in the IOMMU device table entry (i.e DTE[PPR]).
> 
> Currently, PPR is enabled for a device when it is initialized for AMD
> IOMMU v2API. To support paging for IOPF, the DTE[PPR] bit needs to be
> updated when enable/disable IOPF feature.
> 
> Introducing struct iommu_dev_data.ppr and enum ppr_handlers to track PPR
> setting for each device.
> 
> Finally iommu_dev_data.ppr is set only when IOMMU supports PPR. Hence
> remove redundant feature support check in set_dte_entry().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
>  drivers/iommu/amd/iommu.c           | 10 ++++------
>  drivers/iommu/amd/iommu_v2.c        | 14 +++++++++++++-
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index b79c6e10684d..443b13b56235 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -803,6 +803,11 @@ struct devid_map {
>  	bool cmd_line;
>  };
>  
> +enum ppr_handlers {
> +	PPR_HANDLER_NONE,	/* No handler specified */
> +	PPR_HANDLER_V2API,	/* IOMMU v2 API ppr handler */
> +};
> +
>  /*
>   * This struct contains device specific data for the IOMMU
>   */
> @@ -820,6 +825,7 @@ struct iommu_dev_data {
>  	u8 ats_enabled  :1;		  /* ATS state */
>  	u8 pri_tlp      :1;		  /* PASID TLB required for
>  					     PPR completions */
> +	enum ppr_handlers ppr;
>  	bool use_vapic;			  /* Enable device to use vapic mode */
>  	bool defer_attach;
>  
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5968eb8d265c..888bce5abe56 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1634,10 +1634,8 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
>  	if (ats)
>  		flags |= DTE_FLAG_IOTLB;
>  
> -	if (ppr) {
> -		if (iommu_feature(iommu, FEATURE_EPHSUP))
> -			pte_root |= 1ULL << DEV_ENTRY_PPR;
> -	}
> +	if (ppr)
> +		pte_root |= 1ULL << DEV_ENTRY_PPR;
>  
>  	if (domain->flags & PD_IOMMUV2_MASK) {
>  		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
> @@ -1730,7 +1728,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
>  
>  	/* Update device table */
>  	set_dte_entry(iommu, dev_data->devid, domain,
> -		      ats, dev_data->iommu_v2);
> +		      ats, dev_data->ppr);

This is casting an enum to a bool, 

dev_data->ppr != PPR_HANDLER_NONE

?

And in other places

Or maybe just pass in the enum.

Jason
