Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DF13AC8
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688057506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5KsOnQoZvswj3VQDBTKDoFAPdITTQlWiJNxTJ0iZ5Ss=;
	b=iXYzkJi1G5DfbxlUuegkKADklBhnuHQLrzcb+Nl90eopYNxJSr2zNOaiDUFp508ezoTFaN
	0Y7NqL7hkhZNF4HhhoDedhpnwGQUc/SO+c+maM+A/DmFJm91zYafz7MH3WDDqtOscNfCKq
	BxLrNVDqpNrk8Hqd/PRJbROJ1/+xW8s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-FDDQ4kgsO6mt_i_7-BOAJg-1; Thu, 29 Jun 2023 12:51:44 -0400
X-MC-Unique: FDDQ4kgsO6mt_i_7-BOAJg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-635e244d063so9751306d6.1
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 09:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057504; x=1690649504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KsOnQoZvswj3VQDBTKDoFAPdITTQlWiJNxTJ0iZ5Ss=;
        b=eYTEUxx2dlpqHg+n5ojSSTzDwjhNFXfxBl+F8HvvqdosFnkj5xGtdiJ+IaHvWYo675
         K+3794/xvfEGquvx+Ov27W8p+lyNTmlGq1nY+0UZfut4opdYGtNjsVesQwFiHYfCeyq9
         OEtczPT6x6YTces+sikLVS0JWgc4+YpFQSlRjbQVDKTQYsSplIiLWzDugybg4PswqzcV
         +LpkuYDO5XtuvOVQGRvdoJKCO7jD2LcKO+oZ2MojrLSq0boKiqfoN68oGyPIHDu8ad5X
         XLV3BDnd3gRDNMN8ydzSWSy/1NVioRNhMXHEO0KLSrsnfAlF0nL4+9ghLpHRW298G6bp
         y+BQ==
X-Gm-Message-State: ABy/qLYzhxaFFZRratYYF/cUy0DCMNOalIvxuonL+6NerRufbV3FB9vS
	3jlSUVA9+xrnwdbvChsFM/e88GuxSQI6Mnmc8JvPOh1D9aC7ca8Syy2QK0uhBEU68xhRvyd0COs
	mwPa20X3mwofhLqxRrh1dXwo=
X-Received: by 2002:a05:6214:262c:b0:631:f9ad:1d43 with SMTP id gv12-20020a056214262c00b00631f9ad1d43mr333209qvb.14.1688057503904;
        Thu, 29 Jun 2023 09:51:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTATbz8TWi3fEjN0SSekGlOLw2IOJg0QcW47vt/qE9YyWwVn+Mj9CRsIPrBbuFWXSMD9TCJw==
X-Received: by 2002:a05:6214:262c:b0:631:f9ad:1d43 with SMTP id gv12-20020a056214262c00b00631f9ad1d43mr333197qvb.14.1688057503667;
        Thu, 29 Jun 2023 09:51:43 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id jy19-20020a0562142b5300b00635e9db359bsm4205932qvb.82.2023.06.29.09.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:51:43 -0700 (PDT)
Date: Thu, 29 Jun 2023 09:51:42 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 2/3] iommu/amd: Consolidate PPR log enablement
Message-ID: <onnivjamaslzunpad4gckmbah5jn5rhftohpesuqzm4quzuhqc@nkjnyo2p3tpa>
References: <20230628054554.6131-1-vasant.hegde@amd.com>
 <20230628054554.6131-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230628054554.6131-3-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 05:45:53AM +0000, Vasant Hegde wrote:
> Move PPR log interrupt bit setting to iommu_enable_ppr_log(). Also
> rearrange iommu_enable_ppr_log() such that PPREn bit is enabled
> before enabling PPRLog and PPRInt bits. So that when PPRLog bit is
> set it will clear the PPRLogOverflow bit and sets the PPRLogRun bit
> in the IOMMU Status Register [MMIO Offset 2020h].
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 94c91b6ee603..f26c077eb9ea 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -934,6 +934,8 @@ static void iommu_enable_ppr_log(struct amd_iommu *iommu)
>  	if (iommu->ppr_log == NULL)
>  		return;
>  
> +	iommu_feature_enable(iommu, CONTROL_PPR_EN);
> +
>  	entry = iommu_virt_to_phys(iommu->ppr_log) | PPR_LOG_SIZE_512;
>  
>  	memcpy_toio(iommu->mmio_base + MMIO_PPR_LOG_OFFSET,
> @@ -944,7 +946,7 @@ static void iommu_enable_ppr_log(struct amd_iommu *iommu)
>  	writel(0x00, iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
>  
>  	iommu_feature_enable(iommu, CONTROL_PPRLOG_EN);
> -	iommu_feature_enable(iommu, CONTROL_PPR_EN);
> +	iommu_feature_enable(iommu, CONTROL_PPRINT_EN);
>  }
>  
>  static void __init free_ppr_log(struct amd_iommu *iommu)
> @@ -2526,8 +2528,6 @@ static int iommu_init_irq(struct amd_iommu *iommu)
>  
>  	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
>  
> -	if (iommu->ppr_log != NULL)
> -		iommu_feature_enable(iommu, CONTROL_PPRINT_EN);
>  	return 0;
>  }
>  
> -- 
> 2.31.1
> 

