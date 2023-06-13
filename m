Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D97136A
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686688179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jB9k2lmRqdf20Dr728jPEg2gHGj47Otozz5QCdEFJJ4=;
	b=PzCZK/Dfn1LGms1VagAtShUNQbtITXZVLZLg1DU03oDcPplz90+AoczQZxith2gGh8ZkLs
	tIXd2PJKeK6dv3Q6HMpTO71SPrunAGGAuIXTBmkXruYt3OR4TKcTRtq5y5u6pUBbiNXLcA
	eP0dfiiGyuRC34kSV3Ol8Kk6xazBq2U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-CUyH9ttuMBeHtHpScDWLVw-1; Tue, 13 Jun 2023 16:29:38 -0400
X-MC-Unique: CUyH9ttuMBeHtHpScDWLVw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-621257e86daso17080356d6.1
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 13:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688161; x=1689280161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB9k2lmRqdf20Dr728jPEg2gHGj47Otozz5QCdEFJJ4=;
        b=jMePdv29tHXVfBMzIRD2Mf2d5m0TlA5WznVZN0XVnbuNgKApiJ0HWSItcHJsfA+pBB
         7Jder1hF7bzhgeuYwZgTtg28n0QGbfKEnSdSczzO6jNIKlBJM3Mw/a64KLLpDcAWOwFT
         lEhjgWh/x2ZmGrY3seO+ZzZBGxAfOOIQed8gZ8KPoeE/+xCx0txo3D8YXdkmeQQNzXwB
         7tmS/YEAKuu/xGHSj+e1nfrxYi3LmkeLJm5RNmtQTuGpqG9UMqolPpgZvKMgePJ7XLd3
         tO5NUKs+y4k+QYuBwtFuzlkj8p/5FYC+WJv5631H5peC+w4t/xk1FBhkU+7iLxI6M9zJ
         JfqA==
X-Gm-Message-State: AC+VfDzsYuvU3N6tJwWad/voqZ7fhv/3RKnF+1KH1RuVZIj+8s3NvEvx
	oT/F/7NKdlXr6agXFcmiOp0OGBpoRi7HlbYs1/aeXU5/9uQgUVwA1sqpXcQnZtWEnhdgHaAt2T0
	/ddMi2zNuJaSw75k=
X-Received: by 2002:a05:6214:f26:b0:62d:e946:5187 with SMTP id iw6-20020a0562140f2600b0062de9465187mr9481068qvb.13.1686688161550;
        Tue, 13 Jun 2023 13:29:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Lwp8D8RhamKOGXc5F/5rYVMBeTtbZC7c1txwXlahzS2lPGZeIkB8eGEIpg4eJ/f2MGJWCnQ==
X-Received: by 2002:a05:6214:f26:b0:62d:e946:5187 with SMTP id iw6-20020a0562140f2600b0062de9465187mr9481052qvb.13.1686688161322;
        Tue, 13 Jun 2023 13:29:21 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id w10-20020a0ce10a000000b006261c80d76dsm4208759qvk.71.2023.06.13.13.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:29:20 -0700 (PDT)
Date: Tue, 13 Jun 2023 13:29:19 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	joao.m.martins@oracle.com
Subject: Re: [PATCH 2/2] iommu/amd: Handle PPR log overflow
Message-ID: <6rz75f6nq3ia2bymqjv5alxauqqdk5ea3emfew7nkdjvxtv5ks@qwyzsbg3ckxr>
References: <20230609101746.6412-1-vasant.hegde@amd.com>
 <20230609101746.6412-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230609101746.6412-3-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 10:17:46AM +0000, Vasant Hegde wrote:
> Some ATS-capable peripherals can issue requests to the processor to service
> peripheral page requests using PCIe PRI (the Page Request Interface). IOMMU
> supports PRI using PPR log buffer. IOMMU writes PRI request to PPR log
> buffer and sends PPR interrupt to host. When there is no space in the
> PPR log buffer (PPR log overflow) it will set PprOverflow bit in 'MMIO
> Offset 2020h IOMMU Status Register'. When this happens PPR log needs to be
> restarted as specified in IOMMU spec [1] section 2.6.2.
> 
> When handling the event it just resumes the PPR log without resizing
> (similar to the way event and GA log overflow is handled).
> 
> Failing to handle PPR overflow means device may not work properly as
> IOMMU stops processing new PPR events from device.
> 
> [1] https://www.amd.com/system/files/TechDocs/48882_3.07_PUB.pdf
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Will the code re-org you are doing move the event log overflow check
next to the event log processing check, like is done with the ga log
and ppr log?

Regards,
Jerry

> ---
>  drivers/iommu/amd/amd_iommu.h       |  1 +
>  drivers/iommu/amd/amd_iommu_types.h |  2 ++
>  drivers/iommu/amd/init.c            | 11 +++++++++++
>  drivers/iommu/amd/iommu.c           |  9 ++++++++-
>  4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 317d5c26c614..156f57b4f78c 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -16,6 +16,7 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data);
>  void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
>  void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
>  void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
> +void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
>  void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
>  
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 318b84cf47f6..a993e1bdb70b 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -124,7 +124,9 @@
>  #define MMIO_STATUS_EVT_INT_MASK		BIT(1)
>  #define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
>  #define MMIO_STATUS_EVT_RUN_MASK		BIT(3)
> +#define MMIO_STATUS_PPR_OVERFLOW_MASK		BIT(5)
>  #define MMIO_STATUS_PPR_INT_MASK		BIT(6)
> +#define MMIO_STATUS_PPR_RUN_MASK		BIT(7)
>  #define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
>  #define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
>  #define MMIO_STATUS_GALOG_INT_MASK		BIT(10)
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 3c21e9333899..9908cd4f1c31 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -795,6 +795,17 @@ void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
>  			      MMIO_STATUS_GALOG_OVERFLOW_MASK);
>  }
>  
> +/*
> + * This function restarts ppr logging in case the IOMMU experienced
> + * PPR log overflow.
> + */
> +void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
> +{
> +	amd_iommu_restart_log(iommu, "PPR", CONTROL_PPRINT_EN,
> +			      CONTROL_PPRLOG_EN, MMIO_STATUS_PPR_RUN_MASK,
> +			      MMIO_STATUS_PPR_OVERFLOW_MASK);
> +}
> +
>  /*
>   * This function resets the command buffer if the IOMMU stopped fetching
>   * commands from it.
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a29548d98b6a..3c179d548ecd 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -844,6 +844,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
>  #define AMD_IOMMU_INT_MASK	\
>  	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
>  	 MMIO_STATUS_EVT_INT_MASK | \
> +	 MMIO_STATUS_PPR_OVERFLOW_MASK | \
>  	 MMIO_STATUS_PPR_INT_MASK | \
>  	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
>  	 MMIO_STATUS_GALOG_INT_MASK)
> @@ -863,11 +864,17 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>  			iommu_poll_events(iommu);
>  		}
>  
> -		if (status & MMIO_STATUS_PPR_INT_MASK) {
> +		if (status & (MMIO_STATUS_PPR_INT_MASK |
> +			      MMIO_STATUS_PPR_OVERFLOW_MASK)) {
>  			pr_devel("Processing IOMMU PPR Log\n");
>  			iommu_poll_ppr_log(iommu);
>  		}
>  
> +		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
> +			pr_info_ratelimited("IOMMU PPR log overflow\n");
> +			amd_iommu_restart_ppr_log(iommu);
> +		}
> +
>  #ifdef CONFIG_IRQ_REMAP
>  		if (status & (MMIO_STATUS_GALOG_INT_MASK |
>  			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
> -- 
> 2.31.1
> 

