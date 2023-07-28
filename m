Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CB154B6
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 14:31:21 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1bb2468257fso12738825ad.0
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690554681; x=1691159481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BHC6lNwEFZLQG0BJntw+b/CcpyY4AmaZYmwsotbY5k=;
        b=m5ZrrAfRxug3hyFnEpDGxjxr8OJaX2f2FMcWFXbgCEjtvFTwR9pCKcT0pnJCQxy+/J
         NBak4a86Lyl42xI4ws671JXamdh9Jhyznn8l54Ez5frwPrcaQw3LiQZcqrdb1uBeOeSX
         t1Wa/rKDTwDQIchzrf0YH80dlXr1qkd3qk8sYHlD+x50AWM+kiEsdjbFcA3weOJkV0PB
         /Aavs3ZHhrQrKsRsI8Pc6IHpHCQgUBRMhSpZ1dinSHxC5LzX/1zKoO7ldWYBIxtcbDa1
         OGQ8jr/unP/yaXjPCspCba2fNa2TeJE+1WwCgLKmobubaEPGq5r3kKAgJ/Pk2cunLRqV
         Xe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690554681; x=1691159481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BHC6lNwEFZLQG0BJntw+b/CcpyY4AmaZYmwsotbY5k=;
        b=XmXIjBWHJOYxySKl3BN5lNpYH8rzAIUoE3LAVdSMJ3WY0IQWdbbP5lWvcnA4GhU0Nb
         6/iktIdwAhX6GDzudUcIYMV1q5D8achCVZf3Sl58x17UiesbZPsVz+35w9jW14+v8HNp
         lBoAN0GlxMCq48vPxx71Ww6SejzMgHTf+LvUKqhADboFqXMlqNWajDrSjZngEsUxbYT3
         TBnKhz22KFpDcRMbhoBhFMCoJ0hZXgIw9IXTlS6f805WcdLbZGLNs5wAvCRHRLWevury
         bCi4BNo3lCybnOmRMybbkddOiDP/iRAlwRbosKknICPZwzoFbNHy8jncpqhDRFjaM+R3
         gldg==
X-Gm-Message-State: ABy/qLbWNPmBw0AOLOfnXbBU5O+3OppuEz/CJnekMU+5JuQTCyki+9OG
	LFc4kFz3zPT/TbYpsHaN87gdgQ==
X-Google-Smtp-Source: APBJJlGPOEujuMYBNL8XJ7YYrHMJV9YY2HMmm4zZOf0/y6kLCPlq45ZIQvTKhFZBeAVDm2H+XnnfZA==
X-Received: by 2002:a17:902:8f97:b0:1bb:a122:4886 with SMTP id z23-20020a1709028f9700b001bba1224886mr1326258plo.64.1690554681209;
        Fri, 28 Jul 2023 07:31:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b001bbb7af4963sm3668586plh.68.2023.07.28.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:31:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qPOUx-001boM-BF;
	Fri, 28 Jul 2023 11:31:19 -0300
Date: Fri, 28 Jul 2023 11:31:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 12/16] iommu/amd: Add support for different types of
 PPR handler
Message-ID: <ZMPRN6Gz/dsbBnqe@ziepe.ca>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-13-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728053609.165183-13-vasant.hegde@amd.com>

On Fri, Jul 28, 2023 at 05:36:05AM +0000, Vasant Hegde wrote:
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
>  drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>  drivers/iommu/amd/iommu.c           | 10 ++++------
>  drivers/iommu/amd/iommu_v2.c        | 14 +++++++++++++-
>  3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index a066f375ba87..321d361dfb60 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -803,6 +803,12 @@ struct devid_map {
>  	bool cmd_line;
>  };
>  
> +enum ppr_handlers {
> +	PPR_HANDLER_NONE,	/* No handler specified */
> +	PPR_HANDLER_V2API,	/* IOMMU v2 API ppr handler */
> +	PPR_HANDLER_IOPF,	/* IOPF ppr handler */

This constant is never used, move it to the patch that uses it.

Why are you doing this? It would be much better to hook the GPU driver
into the standard API, what prevents that?

Jason
