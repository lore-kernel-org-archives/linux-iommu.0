Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E23C0A7
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 21:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686692303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ocqA59eryQuYsThBBu1yEOTLXb11mDkVXEpGNmOVXyY=;
	b=TFi43WyuONBfnuRBb4TV+TABQb7m9CHqhGuVmqw3M+xgz6eoE6dlLTcEm8Jek0+JPtX3tj
	GV0+bLxsPA61eA4+9CJOrSEvlHRMBeh5wxnExU1OOQXs8mR+GdLw7rDMMmXpq1msmjL8W+
	jp3tZOPoppJ4MyuNhHi5CK8GPCUFCT4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-7tpGKROMPliRLj14Kc9jXQ-1; Tue, 13 Jun 2023 17:38:18 -0400
X-MC-Unique: 7tpGKROMPliRLj14Kc9jXQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f9a9df0b85so13684371cf.1
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 14:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686692297; x=1689284297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocqA59eryQuYsThBBu1yEOTLXb11mDkVXEpGNmOVXyY=;
        b=i8hdxp29/j69ydDk8sXf1NLOA6XnLbTDp6Ir0gkIHW/kIy9oUxplgyFV6aLgl6NAkt
         79K5oVJKizLNhjA9HBQmOcnbf7AFX68v+hnJFMJ6dpmcblTzKAwqyQ5tv/7CMln4435E
         AFoYehjPjfiAwohr8y1t5MkbfGxctsIx1aPBpHWdeEwAqv78mHuaEh1K6xaFBTxWt+9h
         RLC8zChEcXcTgT1unQsApSxh5+Cvl457NBjspnxieJ9K/c6HDIpOH5d/4mHWSEmpbF45
         JRdpvYSdwvudYrR/zc46XaTLPEcMuW0VJPnsa1fbQ5xVcnafiYC57OefN40S+vaZLvcp
         Su6w==
X-Gm-Message-State: AC+VfDzfi5yj7d/+S8YcHIAeM/TnWaA5ox3+NQGc1ymlp12giGs4hWVG
	/KR73L9YMMVIFCsyshzZ9RD+g833HE6CR6JNbp0F9P2SFlL2NYaR1s6ywkUQPOF0Ph2fygdXlTr
	lYm+4iJJ9G/rZOi0=
X-Received: by 2002:ac8:5a8b:0:b0:3f4:ec9f:95e4 with SMTP id c11-20020ac85a8b000000b003f4ec9f95e4mr129377qtc.6.1686692297493;
        Tue, 13 Jun 2023 14:38:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IpR6MxXmUDManLlmKYb1f8HDzGl9vlif9Pw/T9tvaU2ffIjq/9NIjVOFaADOJ+MNtJc6rVQ==
X-Received: by 2002:ac8:5a8b:0:b0:3f4:ec9f:95e4 with SMTP id c11-20020ac85a8b000000b003f4ec9f95e4mr129354qtc.6.1686692297214;
        Tue, 13 Jun 2023 14:38:17 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a24-20020ac84d98000000b003f9c26069aesm4470698qtw.34.2023.06.13.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:38:16 -0700 (PDT)
Date: Tue, 13 Jun 2023 14:38:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	joao.m.martins@oracle.com
Subject: Re: [PATCH 1/2] iommu/amd: Add separate interrupt handler for PPR
 and GA log
Message-ID: <nm5ndwb7flwfa7tmgekubndrtmrd6brnjz77n2ub3iuoyyzcmv@msgzwfm3r4q5>
References: <20230609102025.6498-1-vasant.hegde@amd.com>
 <20230609102025.6498-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230609102025.6498-2-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 10:20:24AM +0000, Vasant Hegde wrote:
> The AMD IOMMU has three different logs (Event, PPR and GA) and it can be
> configured to send separate interrupt for each log type.
>   - Event log is used whenever IOMMU reports events like IO_PAGE_FAULT,
>     TLB_INV_TIMEOUT, etc,. During normal system operation this log is not
>     used actively.
> 
>   - GA log is used to record device interrupt requests that could not be
>     immediately delivered to the target virtual processor due the fact the
>     target was not running. This is actively used when we do device
>     passthrough to AVIC enabled guest.
> 
>   - PPR log is used to service the page fault request from device in Shared
>     Virtual Addressing (SVA) mode where page table is shared by CPU and
>     device. In this mode it will generate PPR interrupt frequently.
> 
> Currently we have single interrupt to handle all three logs. GA log and
> PPR log usage is increasing. Hence, split interrupt handler thread
> into three separate interrupt handler function. Following patch enables
> separate interrupt for PPR and GA Log.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  3 ++
>  drivers/iommu/amd/iommu.c     | 98 +++++++++++++++++++----------------
>  2 files changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 156f57b4f78c..e2857109e966 100644
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
> index 3c179d548ecd..d427f7e3b869 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -841,57 +841,23 @@ static inline void
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
> +static void amd_iommu_handle_irq(void *data, u32 int_mask, u32 overflow_mask,
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
> +		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
>  
> -		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU PPR log overflow\n");
> -			amd_iommu_restart_ppr_log(iommu);
> -		}
> +		if (int_handler)
> +			int_handler(iommu);
>  
> -#ifdef CONFIG_IRQ_REMAP
> -		if (status & (MMIO_STATUS_GALOG_INT_MASK |
> -			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
> -			pr_devel("Processing IOMMU GA Log\n");
> -			iommu_poll_ga_log(iommu);
> -		}
> -
> -		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU GA Log overflow\n");
> -			amd_iommu_restart_ga_log(iommu);
> -		}
> -#endif
> -
> -		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU event log overflow\n");
> -			amd_iommu_restart_event_logging(iommu);
> -		}
> +		if ((status & overflow_mask) && overflow_handler)
> +			overflow_handler(iommu);
>  
>  		/*
>  		 * Hardware bug: ERBT1312
> @@ -908,6 +874,50 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>  		 */
>  		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>  	}
> +}
> +
> +irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data)
> +{
> +	pr_devel("Processing IOMMU Event Log\n");
> +	amd_iommu_handle_irq(data, MMIO_STATUS_EVT_INT_MASK,
> +			     MMIO_STATUS_EVT_OVERFLOW_MASK,
> +			     iommu_poll_events, amd_iommu_restart_event_logging);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
> +{
> +	pr_devel("Processing IOMMU PPR Log\n");
> +	amd_iommu_handle_irq(data, MMIO_STATUS_PPR_INT_MASK,
> +			     MMIO_STATUS_PPR_OVERFLOW_MASK,
> +			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t amd_iommu_int_thread_galog(int irq, void *data)
> +{
> +
> +	pr_devel("Processing IOMMU GA Log\n");
> +#ifdef CONFIG_IRQ_REMAP
> +	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK,
> +			     iommu_poll_ga_log, amd_iommu_restart_ga_log);
> +#else
> +	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK, NULL, NULL);
> +#endif

Is the else needed here, since GAEn will only get set if CONFIG_IRQ_REMAP is enabled?

Regards,
Jerry

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

