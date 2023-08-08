Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA4100B9
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:30:33 +0000 (UTC)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4055bc3cdd8so44126981cf.1
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691508633; x=1692113433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MeBO0TU+wywolPJy9LO8EvpcVAk7REABcY2ZWJ0oR2k=;
        b=ji2WA3V2wTjeZ6LDa1HNBYPVfvcUNu1EUqLOwfSu229e9GMSMifrbcGkoauKF9Hutp
         6gK02ZJKZDCrlXlGu+6guMeiLJQYXQ1jCmBc0rPZKMZLX8qWMKU31J7F3KI5cQ/ez1gM
         Mw75z8TLxFZxr91eZVM4mPvqcMZgrjmTUmQ7tMsFT73gYIl4yfHtbKGGQOJLFucfJ1r1
         6qLksf8Yb5CfyIXs6OIde7qCOw/h9B6REnlNEhqj6GgTR93bloGEJTZJVdO15Al69gK0
         OLmL9PiKGqo3x3C2xgPepLE9OUwilDCY0fUWSsqFvnDEsZTgp8q2IiQbY5rbb6uc019M
         EAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508633; x=1692113433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeBO0TU+wywolPJy9LO8EvpcVAk7REABcY2ZWJ0oR2k=;
        b=Ssyu16R4GleTI8F159rQ6FlRO96Qkxm8Va3I3xZZqNRoPSWqX9CEuZnyli1TWQjNMT
         lozg+qBjH16XUXipbXeQuOOA5w5Mc1l7DiiFYGSHzgBvCcM1R0SCChFE8doZI7sqt1Nc
         GQCuBV+61sKruTSDlanOt4DQ7oNur2J6uVUACZIu0KjyGq2h1DvjtwU9SWMu40qTfQrH
         PoV1oVxa9coBdA6CXkcKkUnSbmlXT/RqdKJqItDIeNUYF89+kQO5waE0ixRCx+qp4Y32
         5NxKTa+3BFLL8GmXzzqylT4/Z6i5Kve5LMz5Wcs83oD276tkq/d/4xvmJHdjDwROfpje
         f8tw==
X-Gm-Message-State: AOJu0YzFknOJBsu0y/zGTic6tdLBVhD1RXh4Uwv68shjY+DfTD8thzQ0
	67QCz+hN/9zCkqZcJCMFH3EQKQ==
X-Google-Smtp-Source: AGHT+IGJBCVvvsgYR+q7X0Sk7dXs03IUGDHaNzhG5YQ4qxrxUUqBv75jqofq5CvooNJVQKzWLIXDBg==
X-Received: by 2002:a05:622a:1cb:b0:405:4734:6913 with SMTP id t11-20020a05622a01cb00b0040547346913mr138020qtw.0.1691508632825;
        Tue, 08 Aug 2023 08:30:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id i24-20020ac871d8000000b0040324785e4csm3398941qtp.13.2023.08.08.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:30:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOfH-004dKy-Pw;
	Tue, 08 Aug 2023 12:30:31 -0300
Date: Tue, 8 Aug 2023 12:30:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 02/11] iommu/amd: Introduce struct
 protection_domain.pd_mode
Message-ID: <ZNJflxeIWtJLC896@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100232.5977-3-vasant.hegde@amd.com>

On Tue, Aug 08, 2023 at 10:02:23AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> This enum variable is used to track the type of page table used by the
> protection domain. It will replace the protection_domain.flags in
> subsequent series.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 7 +++++++
>  drivers/iommu/amd/iommu.c           | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 0d339e022572..5e89032b3dee 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -555,6 +555,12 @@ struct amd_io_pgtable {
>  	u64			*pgd;		/* v2 pgtable pgd pointer */
>  };
>  
> +enum protection_domain_mode {
> +	PD_MODE_PT = 0,
> +	PD_MODE_V1,
> +	PD_MODE_V2,
> +};

PD_MODE_PT is redundant because the domain->type ==
IOMMU_DOMAIN_IDENTITY already indicates identity. It is better not to
denormalize the data structures.

But right idea

Jason
