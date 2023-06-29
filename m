Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF182572
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 16:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688056577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qQABGfu4GhESm9Fnfn4ECsdQLOcSfLnT4UgCpSPTRUo=;
	b=gY8nS6vUn45U2WWXfG18cVOAsivCwl0Cvh2NkyxR3nUNk86Ii/hnJhZvADYQT1djw4RhBM
	9I4Kx3TGq64PUGxTQU3wSjWqW49Iw2xXUr5shDEY0g8mljfDUo1CoOoCEM2jSYHBDKnv8B
	bol2hA+fofllDb2ua1lX3Atr/iaYUbQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-DweJ90LfN_-aIXHhuv6Slw-1; Thu, 29 Jun 2023 12:36:13 -0400
X-MC-Unique: DweJ90LfN_-aIXHhuv6Slw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403242da2faso9981041cf.3
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 09:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056572; x=1690648572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQABGfu4GhESm9Fnfn4ECsdQLOcSfLnT4UgCpSPTRUo=;
        b=L1xBf/p2UPjjU8MEabmAQCr7lkmnp5YEb4lc0sJU7Vl4xpGbIZ8gHwcg/aQtFb/gN0
         bldaRs24tBBTJG8u8lIywL8Cp0SfSWlqtUeKGRkMv9WTebyrnNlOe4xQXzNuXAroNZX5
         LoZ6h0VyccLoPYeqzjyy/HgxpPadpMb2Fsfw+hqchTMYVzEekRk3IB342lcgYi+kAGT/
         +nDliZCEgrCEVFQW+dhy5zWWRO5p2SssmEGBnbSkKHyK9UHolzP0Qji9RU/2riDLTQ7v
         lag4xgNh4cfDO0/oHvnklOnMMVUoYkRKQwQZRXj1KEspDMuLuIjZ1LQXshDbMpDqz1IB
         acpw==
X-Gm-Message-State: AC+VfDx8ugaMqQBHXlzssErk4Q/DQJKjrFYHTmiZpAU9mtV5cSkGGt7N
	pL5s0hC2OHlBnJBXt26ss9QryOFJEsCNbho3XPgd+YfFhBwfTqw7QQ/E8xohxGSYpIaQ3dNt6ff
	scd0nvbEmtqSTA2D4C9ycJao=
X-Received: by 2002:a05:622a:d0:b0:402:a9b2:b4f4 with SMTP id p16-20020a05622a00d000b00402a9b2b4f4mr66713qtw.1.1688056571890;
        Thu, 29 Jun 2023 09:36:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47wlwUQltEbfxuOFujUha9ZrYXClPFq84hck9j+L+I05sJEoyHxx93IaGI3FeBxix0crbvNQ==
X-Received: by 2002:a05:622a:d0:b0:402:a9b2:b4f4 with SMTP id p16-20020a05622a00d000b00402a9b2b4f4mr66701qtw.1.1688056571634;
        Thu, 29 Jun 2023 09:36:11 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bx13-20020a05622a090d00b003f4e18bfa06sm4717509qtb.60.2023.06.29.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:36:11 -0700 (PDT)
Date: Thu, 29 Jun 2023 09:36:09 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	joao.m.martins@oracle.com
Subject: Re: [PATCH v3 1/2] iommu/amd: Refactor IOMMU interrupt handling
 logic for Event, PPR, and GA logs
Message-ID: <ihfmo5zd7x2ks3irbjis24lpfxujs3v4356tlho5wiasekjoky@rxeiomxkjctj>
References: <20230628053222.5962-1-vasant.hegde@amd.com>
 <20230628053222.5962-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230628053222.5962-2-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 05:32:21AM +0000, Vasant Hegde wrote:
> The AMD IOMMU has three log buffers (i.e. Event, PPR, and GA). The IOMMU
> driver processes these log entries when it receive an IOMMU interrupt.
> Then, it needs to clear the corresponding interrupt status bits. Also, when
> an overflow occurs, it needs to handle the log overflow by clearing the
> specific overflow status bit and restart the log.
> 
> Since, logic for handling these logs is the same, refactor the code into a
> helper function called amd_iommu_handle_irq(), which handles the steps
> described. Then, reuse it for all types of log.
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu.h |  3 ++
>  drivers/iommu/amd/iommu.c     | 93 +++++++++++++++++++----------------
>  2 files changed, 53 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 8c61c19dabc4..f23ad6043f04 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -12,6 +12,9 @@
>  #include "amd_iommu_types.h"
>  
>  irqreturn_t amd_iommu_int_thread(int irq, void *data);
> +irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
> +irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
> +irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
>  irqreturn_t amd_iommu_int_handler(int irq, void *data);
>  void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
>  void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 8f299bb0f3ed..5e9c287b10e0 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -841,57 +841,27 @@ static inline void
>  amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
>  #endif /* !CONFIG_IRQ_REMAP */
>  
> -#define AMD_IOMMU_INT_MASK	\
> -	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
> -	 MMIO_STATUS_EVT_INT_MASK | \
> -	 MMIO_STATUS_PPR_OVERFLOW_MASK | \
> -	 MMIO_STATUS_PPR_INT_MASK | \
> -	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
> -	 MMIO_STATUS_GALOG_INT_MASK)
> -
> -irqreturn_t amd_iommu_int_thread(int irq, void *data)
> +static void amd_iommu_handle_irq(void *data, const char *evt_type,
> +				 u32 int_mask, u32 overflow_mask,
> +				 void (*int_handler)(struct amd_iommu *),
> +				 void (*overflow_handler)(struct amd_iommu *))
>  {
>  	struct amd_iommu *iommu = (struct amd_iommu *) data;
>  	u32 status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> +	u32 mask = int_mask | overflow_mask;
>  
> -	while (status & AMD_IOMMU_INT_MASK) {
> +	while (status & mask) {
>  		/* Enable interrupt sources again */
> -		writel(AMD_IOMMU_INT_MASK,
> -			iommu->mmio_base + MMIO_STATUS_OFFSET);
> -
> -		if (status & MMIO_STATUS_EVT_INT_MASK) {
> -			pr_devel("Processing IOMMU Event Log\n");
> -			iommu_poll_events(iommu);
> -		}
> -
> -		if (status & (MMIO_STATUS_PPR_INT_MASK |
> -			      MMIO_STATUS_PPR_OVERFLOW_MASK)) {
> -			pr_devel("Processing IOMMU PPR Log\n");
> -			iommu_poll_ppr_log(iommu);
> -		}
> -
> -		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU PPR log overflow\n");
> -			amd_iommu_restart_ppr_log(iommu);
> -		}
> -
> -#ifdef CONFIG_IRQ_REMAP
> -		if (status & (MMIO_STATUS_GALOG_INT_MASK |
> -			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
> -			pr_devel("Processing IOMMU GA Log\n");
> -			iommu_poll_ga_log(iommu);
> -		}
> +		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
>  
> -		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU GA Log overflow\n");
> -			amd_iommu_restart_ga_log(iommu);
> +		if (int_handler) {
> +			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
> +				 iommu->index, evt_type);
> +			int_handler(iommu);
>  		}
> -#endif
>  
> -		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU event log overflow\n");
> -			amd_iommu_restart_event_logging(iommu);
> -		}
> +		if ((status & overflow_mask) && overflow_handler)
> +			overflow_handler(iommu);
>  
>  		/*
>  		 * Hardware bug: ERBT1312
> @@ -908,6 +878,43 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>  		 */
>  		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>  	}
> +}
> +
> +irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data)
> +{
> +	amd_iommu_handle_irq(data, "Evt", MMIO_STATUS_EVT_INT_MASK,
> +			     MMIO_STATUS_EVT_OVERFLOW_MASK,
> +			     iommu_poll_events, amd_iommu_restart_event_logging);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
> +{
> +	amd_iommu_handle_irq(data, "PPR", MMIO_STATUS_PPR_INT_MASK,
> +			     MMIO_STATUS_PPR_OVERFLOW_MASK,
> +			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t amd_iommu_int_thread_galog(int irq, void *data)
> +{
> +#ifdef CONFIG_IRQ_REMAP
> +	amd_iommu_handle_irq(data, "GA", MMIO_STATUS_GALOG_INT_MASK,
> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK,
> +			     iommu_poll_ga_log, amd_iommu_restart_ga_log);
> +#endif
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t amd_iommu_int_thread(int irq, void *data)
> +{
> +	amd_iommu_int_thread_evtlog(irq, data);
> +	amd_iommu_int_thread_pprlog(irq, data);
> +	amd_iommu_int_thread_galog(irq, data);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.31.1
> 

