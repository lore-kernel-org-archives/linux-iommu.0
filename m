Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB110957
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692200369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eF8OUw3ojAqwYqizIVdMBO0yoIqw79GFXUxruozmyhU=;
	b=Dus39cdDsIAe//fq81gUvsNnI5oSsrKnFxoHblx/f5g/YgZf0dIYJpMVhhCk8K6ef85iia
	Zh3cNZMA5pmf/nUhXlbHFEzisgC470JcsLOiAMo7dgaT3N6Tte/gw47lmUC2Bb3B7oAvNJ
	xbPtwlVaM8QTvNh1zt5O3XeSYMAoa2c=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-6f32g8EnO5SJ-riAQQ89cg-1; Wed, 16 Aug 2023 11:39:28 -0400
X-MC-Unique: 6f32g8EnO5SJ-riAQQ89cg-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-43fa9a00625so2028111e0c.2
        for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 08:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692200367; x=1692805167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eF8OUw3ojAqwYqizIVdMBO0yoIqw79GFXUxruozmyhU=;
        b=CNnqmGe0Qbb8royEnWvbuhRACYXPtE5kg0Eggja3oyVSIs5mgG3BU81U1G2vH82KbX
         WB3SAW5p/RXQ4NanpiuU7M7SVaT/BJyH0WCQtmykucI016aD4/tJh/bnHb+QtQz3g/Lv
         Bz2fNEmgRxm8ESHuYTMS/yzSzR+N3vWdoa3qokhAvPnmrbxopmNw7jy9P6J+3cZxSGRX
         xhqjE0YdmEgN/fZuno5l8lhl34eOA0q472oPyGvLbL+v7CItfDzneJLICukhYmQf4ky0
         MSR5JBrZgi341kBY4lc6+wloujNh2S63Yl01k9aH63j9HHQnsr/3vbQM+9CrgnO/qr+A
         p/vw==
X-Gm-Message-State: AOJu0Yx/21jl8mysLGpjCI0wSJCpcMJO6zxzyrq3LmB093ikNWQVORT0
	R1niF3Gb+EN2+s8aWftOGsbIq+1kIbmP3H2TTaSF2NSX3tdAF8jkHVKYxk6GyoV6DLx8vKP2cKA
	yLnS0Hl08sK65m5k=
X-Received: by 2002:a05:6102:34c8:b0:443:8034:be4b with SMTP id a8-20020a05610234c800b004438034be4bmr1216402vst.35.1692200367742;
        Wed, 16 Aug 2023 08:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHElABL0CMx3381uEGrjSv5cqHNfUbNbWxu047T18HavpAQXzutIuUvOOVAemuSWmtf0TIh+A==
X-Received: by 2002:a05:6102:34c8:b0:443:8034:be4b with SMTP id a8-20020a05610234c800b004438034be4bmr1216384vst.35.1692200367509;
        Wed, 16 Aug 2023 08:39:27 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id pi42-20020a05620a37aa00b007677347e20asm4469542qkn.129.2023.08.16.08.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:39:27 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:39:25 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	wei.huang2@amd.com, jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 02/14] iommu/amd: Consolidate timeout pre-define to
 amd_iommu_type.h
Message-ID: <uoydw2swrx65fg3zcfjjatjqeurrc2wevsvnv24pvakelux7ve@xwmu6zic3sn2>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
 <20230815102202.565012-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230815102202.565012-3-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2023 at 10:21:50AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To allow inclusion in other files in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  4 ++++
>  drivers/iommu/amd/init.c            | 10 ++++------
>  drivers/iommu/amd/iommu.c           |  2 --
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 081d8d0f29d5..a8d264026f7f 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -451,6 +451,10 @@
>  #define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
>  #define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
>  
> +/* Timeout stuff */
> +#define LOOP_TIMEOUT		100000
> +#define MMIO_STATUS_TIMEOUT	2000000
> +
>  extern bool amd_iommu_dump;
>  #define DUMP_printk(format, arg...)				\
>  	do {							\
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 45efb7e5d725..852e40b13d20 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -83,8 +83,6 @@
>  #define ACPI_DEVFLAG_LINT1              0x80
>  #define ACPI_DEVFLAG_ATSDIS             0x10000000
>  
> -#define LOOP_TIMEOUT	2000000
> -
>  #define IVRS_GET_SBDF_ID(seg, bus, dev, fn)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
>  						 | ((dev & 0x1f) << 3) | (fn & 0x7))
>  
> @@ -985,14 +983,14 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
>  	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
>  	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
>  
> -	for (i = 0; i < LOOP_TIMEOUT; ++i) {
> +	for (i = 0; i < MMIO_STATUS_TIMEOUT; ++i) {
>  		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>  		if (status & (MMIO_STATUS_GALOG_RUN_MASK))
>  			break;
>  		udelay(10);
>  	}
>  
> -	if (WARN_ON(i >= LOOP_TIMEOUT))
> +	if (WARN_ON(i >= MMIO_STATUS_TIMEOUT))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -2900,14 +2898,14 @@ static void enable_iommus_vapic(void)
>  		 * Need to set and poll check the GALOGRun bit to zero before
>  		 * we can set/ modify GA Log registers safely.
>  		 */
> -		for (i = 0; i < LOOP_TIMEOUT; ++i) {
> +		for (i = 0; i < MMIO_STATUS_TIMEOUT; ++i) {
>  			status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>  			if (!(status & MMIO_STATUS_GALOG_RUN_MASK))
>  				break;
>  			udelay(10);
>  		}
>  
> -		if (WARN_ON(i >= LOOP_TIMEOUT))
> +		if (WARN_ON(i >= MMIO_STATUS_TIMEOUT))
>  			return;
>  	}
>  
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 56b6cf8bf03f..dd586f69a9d8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -44,8 +44,6 @@
>  
>  #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
>  
> -#define LOOP_TIMEOUT	100000
> -
>  /* IO virtual address start page frame number */
>  #define IOVA_START_PFN		(1)
>  #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
> -- 
> 2.31.1
> 

