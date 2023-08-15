Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4B13ADD
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 18:33:08 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1bdaeb0f29aso30323765ad.2
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692124388; x=1692729188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/vBP+8HhRip3+9kTcLIMModJTfoZ5OkaFrov6bJX/0=;
        b=ObqUvGkP7znE2FtsP+dCwpI9q/PeNXftpc08uRnKSGSKZ/lpx9ZM6QQkf0ISNEdLd2
         skKki1DdK19JGLRrGwHOn5siVAPN2kbKTLx7eDOwKlHDNiU6PqG1WuAek/qEZGyyi3qM
         A0BCMGhYvv4vgGFDSFc4tNf5xrRCG3HP7ku18Rq6GqBHfLsJR42l0Rc9uFbF74F2E3n+
         6tkea4WQg2o+eQGyJ2Cp2xxbwToY2WM5lPYw3Kb3nCkjq4lwxKTVtrH7mqjHyeX+8hYY
         36ryZAo3M+6qeWy8VF3ZvairYvRcIwLjtWkC2snKJtCGov1pEv65pVO1/LGi53PDiy0G
         0vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124388; x=1692729188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/vBP+8HhRip3+9kTcLIMModJTfoZ5OkaFrov6bJX/0=;
        b=JoBjFYVBDPEBxn4Ije76vYpIz59uxzUHZswirgBXMUlVEy7Y7tnksFcsxfHkd0Vac9
         NKoLxCBNE9YRgp1BnJEK+iUynDXrzi8WR10F+/GaK6zc0RoI//mYJQEI5zuvFFkxUYEb
         kSZs3uVvqvQymZIXzm6Om/UiVZdnhAxQFXW1k9rKFZDmbW21mkeSaIBLd37aMKdmAAcz
         8Z34sAebnJavOuNYBRbgAdQNw6ppg/Mrh9FbR+sgea+NU2OAHyLJdp1crB373wG5nTEn
         l2dCH+c08jYhNnnEzBYFt+bzPDjjdwJFeOhnLCSJazAR2nUBHgwNZdy02MsuQA5cWEc7
         fn4Q==
X-Gm-Message-State: AOJu0YzYpaklq+h/RYi7lWgvfT2AQxvdxUmgCH0odLCVhYGDbym5dE+2
	MJ1RQkgCk/kgczwBel8IFUoWpOUpp5rLRcOhYdA=
X-Google-Smtp-Source: AGHT+IEvKx5LhEvmtNOPEzTwKA/8YwI0tCZHiwkJ5fu2Y1raSwx96SnNDgZ7Z1jeCHRxU1P9ZPVRNw==
X-Received: by 2002:a17:902:db06:b0:1b8:9b17:f63d with SMTP id m6-20020a170902db0600b001b89b17f63dmr14136720plx.23.1692124388252;
        Tue, 15 Aug 2023 11:33:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001b8c689060dsm11334102plg.28.2023.08.15.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:33:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qVyqo-007hjf-AW;
	Tue, 15 Aug 2023 15:33:06 -0300
Date: Tue, 15 Aug 2023 15:33:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 11/14] iommu/amd: Introduce iommu_dev_data.ppr
Message-ID: <ZNvE4r/NOSM5N6Z/@ziepe.ca>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-12-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815102202.565012-12-vasant.hegde@amd.com>

On Tue, Aug 15, 2023 at 10:21:59AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
> PPR is enabled per PCI end-point device, and is configured by the PPR bit
> in the IOMMU device table entry (i.e DTE[PPR]).
> 
> Introducing struct iommu_dev_data.ppr track PPR setting for each device.
> 
> Also iommu_dev_data.ppr will be set only when IOMMU supports PPR. Hence
> remove redundant feature support check in set_dte_entry().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/iommu.c           | 10 ++++------
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 1c61dca63824..c9027119ab35 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -816,6 +816,7 @@ struct iommu_dev_data {
>  	u8 ats_enabled  :1;		  /* ATS state */
>  	u8 pri_tlp      :1;		  /* PASID TLB required for
>  					     PPR completions */
> +	bool ppr;			  /* Enable device PPR support */
>  	bool use_vapic;			  /* Enable device to use vapic mode */
>  	bool defer_attach;

Linus would not like this if he saw it, continue using the u8 :1
bitfield..

Otherwise looks fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
