Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39B1549B
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 17:25:54 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-668730696a4so1479760b3a.1
        for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689355553; x=1691947553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTb7seKMJ6vPdWddy2z/FIaJQZuhNBvcmu5EN+MPlvw=;
        b=DSowpnLlggSBeFtLqteCvaYSKu2km5Ebp+KGLNKBf/fX2YuCEmMWPfQBXW9KRA8qA+
         9MTvRpiApVWInSF9bLjEgHB4H6wuEui6vC08iqfwLBrAcdC72HHFfBl9LZ5Tz0Je60aY
         u/8YTDHlRfA4I2p1N6VzZdapg7jbdeVZHvvp4YFy0AM35uESGlpJJArPHszpyI7hw8NA
         AYcG3vzHHYk9j7pZYuexneiP4jg1ANBxwPK9o5abJyn62rhgmIWSn7jSIAHqn54wecNa
         HxQIiEYY1t+T3pT5cyj4y0AAsgv8C4sSdo6u1kiz1OmAc8/dIY0oAt/aMVFTWfEAfKXY
         XgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355553; x=1691947553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTb7seKMJ6vPdWddy2z/FIaJQZuhNBvcmu5EN+MPlvw=;
        b=WNGezmpGqP9DXOTXWB3Qa5zdWiKiTyXimxjEPzwK+Q91/8/mb7PA6mDKPiFzW1zyuv
         dDo4eCJ5QyUqVpP/K+2eRUpsraCoAUC+EfNyHiSKqt8wIv3GXfcoTDxU9486LJibW2My
         09yb6nd3liMhmXXN7F8tL9YOofD3m2v4zgECu/sxI7vQ3qvApwFeJEGySGtY7WstU020
         Vw5EpOoet385QXWHCvzKXR3pemrUuvpaqmwbfzIEku0vfN/AaGsRm/TL6IdydqAPPWs8
         mGI3ZgqUW1L3N6AIhUf1R/sKOwf+a9Iqm3FqAzOljMEs1pwQEXZ2F+KdH3ib/lMWYnKH
         Is3g==
X-Gm-Message-State: ABy/qLZ0MPnG17KDwY4IJVT2YvZrcMi/zvnVAZbWzFLYz7vC/vCVhWRO
	zwJLaGYFcg8JUfNJ4IZJcFQI6w==
X-Google-Smtp-Source: APBJJlFVxUgAAuni6AEDelxs/oN+k05ej2M1g3FaO1aNgNNl3B5az1jMCHRDmM+boUudMwUcmIUeQw==
X-Received: by 2002:a05:6a00:1694:b0:67a:c810:3cb0 with SMTP id k20-20020a056a00169400b0067ac8103cb0mr5883147pfc.3.1689355553505;
        Fri, 14 Jul 2023 10:25:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id a23-20020a637f17000000b0055b3af821d5sm7758146pgd.25.2023.07.14.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:25:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qKMYB-0018TN-9b;
	Fri, 14 Jul 2023 14:25:51 -0300
Date: Fri, 14 Jul 2023 14:25:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 11/21] iommu/amd: Clean up and enhance protection domain
 flags
Message-ID: <ZLGFH6qERiRbD6cd@ziepe.ca>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
 <20230712141516.154144-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712141516.154144-12-vasant.hegde@amd.com>

On Wed, Jul 12, 2023 at 02:15:06PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> With IOMMU v1 and v2 page tables per domain, and the v2 table can
> be used in various modes, keeping track of how a particular domain
> is configured becoming cumbersome.
> 
> Enhance protection_domain.flags to keep track of how a domain is
> configured. Also Remove unused flags, and rename them accordingly.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 14 +++++---------
>  drivers/iommu/amd/io_pgtable_v2.c   |  2 +-
>  drivers/iommu/amd/iommu.c           | 21 ++++++++++++---------
>  3 files changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 346c32343417..907af6e41ae9 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -443,13 +443,11 @@
>  #define MAX_DOMAIN_ID 65536
>  
>  /* Protection domain flags */
> -#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
> -#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
> -					      domain for an IOMMU */
> -#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
> -					      translation */
> -#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
> -#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */

> +#define PD_FLAG_V1DMA		BIT(1) /* DMA-API mode w/ v1 page table */
> +#define PD_FLAG_V2DMA		BIT(2) /* DMA-API mode w/ v2 page table */

"DMA-API" should not be part of the driver vocabulary. Does this have
anything to do with DMA-API?

Only "paging" domains should have IO page tables and an IO page table
type.

Maybe this is just misnamed?

Also, shouldn't it be an enum not flags?

> +#define PD_FLAG_PT		BIT(0) /* Passthrough mode */
> +#define PD_FLAG_GCR3		BIT(3) /* domain has gcr3 table */

These seem redundant with the domain type?

Maybe a few helpers?

> +#define PD_FLAG_GIOV		BIT(4) /* domain enable GIOV support */

This really shouldn't be a iommu_domain flag, this should be computed
based on what domains are attached where

Eg this seems like it should be triggered by attaching identity to the
RID with PASID enabled or something like that.

Why do you need to set it for the legacy GPU path?

Jason
