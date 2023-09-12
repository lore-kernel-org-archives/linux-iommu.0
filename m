Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B31FD8
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:57:43 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-76ef6d98d7eso316333785a.0
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694537863; x=1695142663; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/YvkPW06LkiFvIbGDp7AirlZPOSr0orhv1lH3c3+I8=;
        b=PYpgjDbeRd2dcPfvAXoKe/JW7IU2t+FtWxuACNc+CVX6LRDodziL/gW34axlEwE0HV
         jZYHt13cJGnpRfomfE066nMr1CxX6pu6i7+5bHkbfuivbgcr4HyBizqDFE6IyU4WuN5o
         nubH3TCsyk4MgiBNGK9i1BM4KyCCs3OqCtccdemSlPIQjj2g/ZBnhOjIh+J73t24t9Dh
         INKnW3tW41Bu6fVqFNyftK1dQl9bGb/HcAAN8inbBsk7c8rEHAfv1kDTuHWmZ7i7boGG
         BLCkEfbJusMb708n+XcCVzswPbatXBqtwsYq2SIAbYOe4BJzFoOLrmnJMmQtNG3s3hvK
         Vnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537863; x=1695142663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/YvkPW06LkiFvIbGDp7AirlZPOSr0orhv1lH3c3+I8=;
        b=qhEJlBeHNVyFy4WZtwiYJ0vYllbkYVDhzqTu+RvmEndTUmmC/veDSnpr1xtaeFuvPf
         FB6HNpT6uTvnpahe9lr8gdzfWxQunNFx5lEfQVswgZ3MuAHX/+hzAMDC5uRIeR4JlUfq
         hPD7f/f0s9KWHGK3ONEvc/Ab8Af4sbiC1HTlUC6fkD0Gafz+IC8qU9J8bYYV4U5DT0bH
         cWRqDm+wwyXtanGuOK/92aFQGUT5MPa0R8Fu/QGS+4IYpTbvpzKC64rVMkKIUC01+71y
         SJsD5yBANQec87DWHodbGoQkDK0LCR4FkX3M+bf0iREAmBQ2LuEiJAmNWL8dDkIr7uvq
         UamQ==
X-Gm-Message-State: AOJu0YyQJ+jWj10HEO0CNUaTe/3K/jpp9DND06EQo3pZ+86+09wcbqBe
	34zJ8utnhq3o9Xm5RwIXtOO5Bw==
X-Google-Smtp-Source: AGHT+IGvS5fSpNU4MN0z4XWyd+knu/iwH5fO4bltctp/B2x41Q3zjjkjmUpJPOHX0hcIEFpqbTouxw==
X-Received: by 2002:a05:620a:2556:b0:76c:e932:bf7c with SMTP id s22-20020a05620a255600b0076ce932bf7cmr5008qko.8.1694537862930;
        Tue, 12 Sep 2023 09:57:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id i7-20020a05620a144700b00767b7375eadsm3315039qkl.39.2023.09.12.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:57:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qg6hp-002Ffo-Jl;
	Tue, 12 Sep 2023 13:57:41 -0300
Date: Tue, 12 Sep 2023 13:57:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 05/11] iommu/amd: Add support to enable/disable PASID
 feature
Message-ID: <ZQCYhVD+rudRtnFl@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911121046.1025732-6-vasant.hegde@amd.com>

On Mon, Sep 11, 2023 at 12:10:40PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> It seems iommu_dev_enable_feature(SVA) will be deprecated soon. Hence in
> this path we just return success.
> 
> Instead we add necessary check during pasid bind to device. IN this path
> it checks whether device GCR3 table is setup or not. If not it will try
> to setup the GCR3.

Yes, though be mindful that switching from IDENTITY v1 to IDENTITY v2
on the RID (eg switching the DTE to/from GCR3 mode) should be atomic.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 94eec3dac8f6..5a9749cfe14e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2162,6 +2162,50 @@ static void protection_domain_free(struct protection_domain *domain)
>  	kfree(domain);
>  }
>  
> +/*******************************
> + * PASID setup related helper functions
> + */
> +static inline bool pdom_is_pt_mode(struct protection_domain *pdom)
> +{
> +	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
> +}
> +
> +static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
> +{
> +	return (pdom->iop.pgd != NULL);
> +}
> +
> +int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, int pasids)
> +{
> +	struct protection_domain *pdom = dev_data->domain;
> +	int ret = 0;
> +
> +	lockdep_assert_held(&dev_data->lock);
> +
> +	/*
> +	 * We cannot support PASID w/ existing v1 page table in the same domain
> +	 * since it will be nested. However, existing domain w/ v2 page table
> +	 * can be used for PASID.
> +	 */
> +	if (pdom->pd_mode == PD_MODE_V1)
> +		return -EOPNOTSUPP;
> +
> +	/* Allocate GCR3 table */
> +	if (pdom_is_pt_mode(dev_data->domain))

It seems obfuscating to put this test for IOMMU_DOMAIN_IDENTITY in a
function..

> +		ret = setup_gcr3_table(dev_data, pasids);

This is the DTE change that should be atomic

Jason
