Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB41134CA
	for <iommu@lists.linux.dev>; Wed,  4 Oct 2023 12:03:46 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-327be5fe4beso1852988f8f.3
        for <iommu@lists.linux.dev>; Wed, 04 Oct 2023 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696421024; x=1697025824; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65W8uf8mEUn8sriwfwBo4wI4eDNf6ZVIMZR+WVbB4uk=;
        b=Vn7bYBNXJbvFgYNM5vLoT9dcf9LKuTKF57W92WmRb40ezKJQLt0zFqsmfn1cHXe1Ca
         GapgpSbt8FxjL1P0EX3zHfdmZ9amT6i1EwfZ130RhAH45KbkYYP89sYBZ841je8IKY5+
         Ka35/SC4e5mW60pEIjV1CtYALUOZBTs6SAGI4wb9WCvfVxbbpk4MAJH/FXg/lwA8Kmk6
         dUzq3V3w+HongoyiXfwzeComML5Drb2sVgk+gipNUon/qyr4PsM3LO973jP1jaR1tjD0
         olmWbVdcnnG29EAdyZgk/vkuQSHUTr2o32UnmbCeZkWLcDTGsDNh7aREMl/3vwICmS+O
         OElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696421024; x=1697025824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65W8uf8mEUn8sriwfwBo4wI4eDNf6ZVIMZR+WVbB4uk=;
        b=MIe0czYHWWidgTVFFOwIccRPoIl5ujhVNlWfP3C5+LmY/aZT+5pu9ZmwDjeVNVpOKa
         tY47xDMJzVTbrcYU/sfHwWx5xXiXTYAcPTW06fSmTyBgFSQPm59HLm7sudlnCHcghvg4
         Jj1UvEO/yg0IrbaHFGdXj2Gt2e7x81xqsW1i9KP9zkfU+ESlxHBcHSmXuzo1GvqovkC1
         8BY+H5XKxsqvUcC0rGCQ4dpyfjONRUAiEqtHlNEUspPWaAezpUXhi0onSyhYSuAmoWT7
         wOIIq7LHogPrcEmm1P1tXsIOtMd7uv9EhMUJZkhLVA3kQJxo2K2hNsjOicUr0VmL/wE3
         azLg==
X-Gm-Message-State: AOJu0YxTXFCu12TE4j9WPBG0qktPsTSHI50mwKgyjJ8RgrCFXlNfhUQk
	oJevL9HY2ugjHbHYdr0Q3CKGJQ==
X-Google-Smtp-Source: AGHT+IH3uaDBmFw4N2b7YyfIDVbbV9756ka94EaVsYOxSqkQNVwG0iUEpYcrp5ymfuRmaj7tf8NxLA==
X-Received: by 2002:a5d:5191:0:b0:31f:b364:a6ba with SMTP id k17-20020a5d5191000000b0031fb364a6bamr1983017wrv.52.1696421024423;
        Wed, 04 Oct 2023 05:03:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k1-20020adfe3c1000000b003259b068ba6sm3919493wrm.7.2023.10.04.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:03:43 -0700 (PDT)
Date: Wed, 4 Oct 2023 15:03:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] iommu: Fix return code in
 iommu_group_alloc_default_domain()
Message-ID: <39c620e7-86fb-4372-ab0e-9f772cdc60aa@kadam.mountain>
References: <0-v1-e4bb9f78c084+202-iommu_ga_err_ptr_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-e4bb9f78c084+202-iommu_ga_err_ptr_jgg@nvidia.com>

On Wed, Oct 04, 2023 at 08:59:43AM -0300, Jason Gunthorpe wrote:
> This function returns NULL on errors, not ERR_PTR.
> 
> Fixes: 1c68cbc64fe6 ("iommu: Add IOMMU_DOMAIN_PLATFORM")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/r/8fb75157-6c81-4a9c-9992-d73d49902fa8@moroto.mountain
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 13b911e4323d06..f9f315d58a3a14 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1787,7 +1787,7 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>  	 */
>  	if (ops->default_domain) {
>  		if (req_type)
> -			return -EINVAL;
> +			return NULL;

This looks like a merge conflict?  -EINVAL is an int and NULL is a
pointer.  #strange

regards,
dan carpenter

