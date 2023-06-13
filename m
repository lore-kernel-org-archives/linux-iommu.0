Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE5136A
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686687761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5B1pzjowp/tCmf2O0tPlj/RNUeX3QXYEhwB/uqSf4Q=;
	b=TUwvtlc4iHnJrXrhu/8AvaV9IdxogciXIMeetX2BX3UbHt19oFi7m4XVl2t4hSeq6cr/0d
	i4oz1YQHBgMCEL2XEw8pBfvKANT9K5cVAxvSE/c53M1TJYoEL79h9zC+2O+NZ0z6KJelRi
	63QN2xtzXFrkGCgyjXJDoqTDcKdjlUk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-k1VPsMw4N6GLgiz8oUJ2Lg-1; Tue, 13 Jun 2023 16:22:38 -0400
X-MC-Unique: k1VPsMw4N6GLgiz8oUJ2Lg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f9f1f27b13so17965391cf.1
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 13:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687758; x=1689279758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5B1pzjowp/tCmf2O0tPlj/RNUeX3QXYEhwB/uqSf4Q=;
        b=WiFWlPRSUEaubAqyPBY0+lpR8OgKKFccDZqBFmdQYbXrbVJwDct+9jYO7HYD5zUtHl
         tFeO2NWKByVbP+ybmtsWrOTVgl9RlxSlp0NsRkmcybnVgX3dyVVpSqKRpi3EayBIXLJU
         G3UQEvo1ZEDzwfQcbXga8N1VZweitfmxrUZEIKp4S8BzGsm+hQzt+fhA+gOxTVp8JTdH
         vGvWy6oPtj7+PsP72Mqd+0gwkB/vyxdre/MqLh6AADh7dCI1NnjsIB9+kI/XCFVwy/Xi
         2zuwNwdktxHpOPRQdkWVkUnm4jeBhI+8/Uw2O4ggit51sVqWYjIJUyih22zSSk5iS7oe
         NJuQ==
X-Gm-Message-State: AC+VfDyigqd61W/Tg/IOG2fRhSX6zuA/4giuaPtH1vIE6R5BEJpOo4Dm
	dIqsv+b5zvh7KfZ3560VbMmdosB/pP1/Z8CBw6gvZ7YeYL4BWSadf7f+5jYB4u43GcC0sRSg5Mp
	NWfzfHoFHjrMe0yo=
X-Received: by 2002:a05:622a:214:b0:3f9:f789:2af0 with SMTP id b20-20020a05622a021400b003f9f7892af0mr8783576qtx.64.1686687758176;
        Tue, 13 Jun 2023 13:22:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ44tTpgGsRnGmo5FNWUShXLNsElOlLiVxG97fV4zlgPFSQVAohMXLpZg3/cWMvP4g6jqOEQ1Q==
X-Received: by 2002:a05:622a:214:b0:3f9:f789:2af0 with SMTP id b20-20020a05622a021400b003f9f7892af0mr8783566qtx.64.1686687757891;
        Tue, 13 Jun 2023 13:22:37 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id m13-20020ac85b0d000000b003f3c9754e1dsm4444936qtw.17.2023.06.13.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:22:37 -0700 (PDT)
Date: Tue, 13 Jun 2023 13:22:35 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	joao.m.martins@oracle.com
Subject: Re: [PATCH 1/2] iommu/amd: Generalize log overflow handling
Message-ID: <isd7bdakea24udn4baqy5g6ibcjn4gyflqosnsio4tm4tqigww@z4mlflbl5bdp>
References: <20230609101746.6412-1-vasant.hegde@amd.com>
 <20230609101746.6412-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230609101746.6412-2-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 10:17:45AM +0000, Vasant Hegde wrote:
> IOMMU has three different logs (Event, GA and PPR log) and each uses
> different buffer for logging. Once buffer becomes full IOMMU generates
> overflow interrupt and we have to restart the logs. Log restart procedure
> is same for all three logs except it uses different bits in 'MMIO Offset
> 2020h IOMMU Status Register'. Hence lets move common code to generic
> function and individual log overflow handler will call generic function
> with appropriate parameters.
> 
> Also rename MMIO_STATUS_EVT_OVERFLOW_INT_MASK as
> MMIO_STATUS_EVT_OVERFLOW_MASK.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  3 +-
>  drivers/iommu/amd/init.c            | 51 ++++++++++++++++++-----------
>  drivers/iommu/amd/iommu.c           |  4 +--
>  3 files changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 364fdaa52e74..318b84cf47f6 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -120,9 +120,10 @@
>  #define PASID_MASK		0x0000ffff
>  
>  /* MMIO status bits */
> -#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	BIT(0)
> +#define MMIO_STATUS_EVT_OVERFLOW_MASK		BIT(0)
>  #define MMIO_STATUS_EVT_INT_MASK		BIT(1)
>  #define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
> +#define MMIO_STATUS_EVT_RUN_MASK		BIT(3)
>  #define MMIO_STATUS_PPR_INT_MASK		BIT(6)
>  #define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
>  #define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c2d80a4e5fb0..3c21e9333899 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -748,38 +748,51 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
>  	return iommu->cmd_buf ? 0 : -ENOMEM;
>  }
>  
> +/*
> + * Interrupt handler has processed all pending events and adjusted head
> + * and tail pointer. Reset overflow mask and restart logging again.
> + */
> +static void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
> +				  u8 cntrl_intr, u8 cntrl_log,
> +				  u32 status_run_mask, u32 status_overflow_mask)
> +{
> +	u32 status;
> +
> +	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> +	if (status & status_run_mask)
> +		return;
> +
> +	pr_info_ratelimited("IOMMU %s log restarting\n", evt_type);
> +
> +	iommu_feature_disable(iommu, cntrl_log);
> +	iommu_feature_disable(iommu, cntrl_intr);
> +
> +	writel(status_overflow_mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
> +
> +	iommu_feature_enable(iommu, cntrl_intr);
> +	iommu_feature_enable(iommu, cntrl_log);
> +}
> +
>  /*
>   * This function restarts event logging in case the IOMMU experienced
>   * an event log buffer overflow.
>   */
>  void amd_iommu_restart_event_logging(struct amd_iommu *iommu)
>  {
> -	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
> -	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
> +	amd_iommu_restart_log(iommu, "Event", CONTROL_EVT_INT_EN,
> +			      CONTROL_EVT_LOG_EN, MMIO_STATUS_EVT_RUN_MASK,
> +			      MMIO_STATUS_EVT_OVERFLOW_MASK);
>  }
>  
>  /*
>   * This function restarts event logging in case the IOMMU experienced
> - * an GA log overflow.
> + * GA log overflow.
>   */
>  void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
>  {
> -	u32 status;
> -
> -	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> -	if (status & MMIO_STATUS_GALOG_RUN_MASK)
> -		return;
> -
> -	pr_info_ratelimited("IOMMU GA Log restarting\n");
> -
> -	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
> -	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
> -
> -	writel(MMIO_STATUS_GALOG_OVERFLOW_MASK,
> -	       iommu->mmio_base + MMIO_STATUS_OFFSET);
> -
> -	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
> -	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
> +	amd_iommu_restart_log(iommu, "GA", CONTROL_GAINT_EN,
> +			      CONTROL_GALOG_EN, MMIO_STATUS_GALOG_RUN_MASK,
> +			      MMIO_STATUS_GALOG_OVERFLOW_MASK);
>  }
>  
>  /*
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ad501944d77c..a29548d98b6a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -842,7 +842,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
>  #endif /* !CONFIG_IRQ_REMAP */
>  
>  #define AMD_IOMMU_INT_MASK	\
> -	(MMIO_STATUS_EVT_OVERFLOW_INT_MASK | \
> +	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
>  	 MMIO_STATUS_EVT_INT_MASK | \
>  	 MMIO_STATUS_PPR_INT_MASK | \
>  	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
> @@ -881,7 +881,7 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>  		}
>  #endif
>  
> -		if (status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK) {
> +		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
>  			pr_info_ratelimited("IOMMU event log overflow\n");
>  			amd_iommu_restart_event_logging(iommu);
>  		}
> -- 
> 2.31.1
> 

