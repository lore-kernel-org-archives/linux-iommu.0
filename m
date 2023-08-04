Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D32BA51
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 13:19:39 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-40ff57072f2so2852551cf.1
        for <iommu@lists.linux.dev>; Fri, 04 Aug 2023 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691155178; x=1691759978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eylqlzfs+xwe9IfbFF6cxMiwWDB44xTSInzQ2TjJzw8=;
        b=nSF/0B7ASJKmSALUtgL5VymCQJ2NhqltVUb97ogbQEXJjdnNztPJ2i2UjPX5jjB9Ue
         Rfg6A2x2NdlGK/YdfMqAfmBpeWMUdEkpCsERCycsJ5bjqKWPCM1IgDahzkhs4n5hSPep
         jHHuUQioKRdxZBi9QRx1R9KXXtjAD8T5aLN9Bkhk/Qq9KX8dWyhnj1/BuZHR/hEy/AYY
         GGHIxV8SOkNrbMUPrMV45CjLNZArZPH5akI489W+Y5eK5TxtTeWPdoqvXmtmJKM4eGH3
         Yfqxx/8ldRRGVPqAu8T1B8WcI2kMVs3VvGxbnLlNhAQ11IVOe7bmUdkR5Ld8ep1ZulTZ
         Id+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691155178; x=1691759978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eylqlzfs+xwe9IfbFF6cxMiwWDB44xTSInzQ2TjJzw8=;
        b=U9inWcTOV+soOfopcJhpn/NXDT0wK6jM/EhiOC4b/h7N04NEHlVr4mgoeSDGPL4ppg
         Wfih7xpTOfnX4joCFolJjSbJlTJwlfSTtFgIrgLJJriz9Mr8RBQY0X92CZmpTGbcLFY/
         pX5WbDjVQ+3ZUcCo9dwKlBqezFOXATPHK6T42PYoNbnMajk+T++U9DHMmSR+7QaKcUIR
         RJSx5yE7JUMj5hyNnoIRwMSrtr/9grSFS1QN2DmKOoBM0HPCy9tZw79rhkUMZzVImMWq
         3EvcDtOTPpRD7vQ6+/TLgTAjTlSlwr/u6wppbTfdcf7tMa/1m+BS8uiv8Mo5ZFnGitGH
         twMw==
X-Gm-Message-State: AOJu0YyuKzN1YmZfVihU+d1cS6OwP7JM72RmQaysv8HbG4ZfNvduQTjk
	x5yMKlQoJSg2eQ13uxYERixFAw==
X-Google-Smtp-Source: AGHT+IGp1EfzWas5DOq8MPvwCqHWAFQWFNXYJDOVEj6YlpvsCRMheGOIgDc1uNdzGPuYksAGqNGK+Q==
X-Received: by 2002:ac8:7dcb:0:b0:407:c2e2:2a06 with SMTP id c11-20020ac87dcb000000b00407c2e22a06mr1773548qte.8.1691155178380;
        Fri, 04 Aug 2023 06:19:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a16a100b007676f3859fasm638710qkj.30.2023.08.04.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:19:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRuiP-003ih2-3V;
	Fri, 04 Aug 2023 10:19:37 -0300
Date: Fri, 4 Aug 2023 10:19:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 10/16] iommu/amd: Modify logic for checking GT and PPR
 features
Message-ID: <ZMz66cV24yQV9Byn@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-11-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804064216.835544-11-vasant.hegde@amd.com>

On Fri, Aug 04, 2023 at 06:42:10AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> In order to support v2 page table, IOMMU driver need to check if the
> hardware can support Guest Translation (GT) and Peripheral Page Requet
> (PPR) features. Currently, IOMMU driver uses global (amd_iommu_v2_present)
> and per-iommu (struct amd_iommu.is_iommu_v2) variables to track the
> features. There variables area redundant since we could simply just check
> the global EFR mask.
> 
> Therefore, replace it with a helper function with appropriate name.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       | 11 +++++++++++
>  drivers/iommu/amd/amd_iommu_types.h |  9 ++++-----
>  drivers/iommu/amd/init.c            | 14 +-------------
>  drivers/iommu/amd/iommu.c           |  2 +-
>  4 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index a5a350ee36fe..0605f02fa711 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -95,6 +95,17 @@ static inline bool iommu_feature(struct amd_iommu *iommu, u64 mask)
>  	return !!(iommu->features & mask);
>  }
>  
> +static inline bool check_feature_on_all_iommus(u64 mask)
> +{
> +	return !!(amd_iommu_efr & mask);
> +}
> +
> +static inline bool amd_iommu_gt_ppr_supported(void)
> +{
> +	return (check_feature_on_all_iommus(FEATURE_GT) &&
> +		check_feature_on_all_iommus(FEATURE_PPR));
> +}
> +

I'm still against adding more globals, the iommu struct was available,
just use it directly in this patch.

Jason
