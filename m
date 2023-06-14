Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A057F
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686763116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JYbbfAwzrm7fNx4SpxOjFRzKTJgaeJsZgEwkf5qae8g=;
	b=WL7dyU5n/bx3pkzVyPBIkceTSHuRvjB5+R47ypdb5Hcptd1q+ozmAYQGK4kGD/FlycFH1H
	u7o11Tn3Ps6/UrJu78efUiOGeCYI9LrkC6LW9fy6JmrWGI8zQh64sAVH+CiqgVd8Uooau3
	eVrC8jZ67db/rLinFvKAJK9XuAmkkA4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-ogvyfgHyOs6TSA0NLgnZVg-1; Wed, 14 Jun 2023 13:18:34 -0400
X-MC-Unique: ogvyfgHyOs6TSA0NLgnZVg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-3f93baa42aaso27187261cf.0
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 10:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686763108; x=1689355108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYbbfAwzrm7fNx4SpxOjFRzKTJgaeJsZgEwkf5qae8g=;
        b=AIf9XkEZEmL/HZABLG8we488fsXuvV96HuVvU74oIzMAd8j0XZmUdR/wnoQVpSFHwe
         wbF3VAuLRpzKDNSaywnhjU3DWO7X+K78mBWzvn5/QC7964244YU08N7OmdN0PoH9MOFo
         reVsDzR6WsdS7mRPZo/rjhJUz+eJ5ebJ4nXV7sXohmr9qwMTM68vd2zCAAQgyalH9XrW
         P7E0k21XY1DFPce4LXsKkeJMgvbZ9O6FUcEjOU9d+IG+ylGB/v8Q3xYMo/OMVWF6PcY0
         4n1rQvZnmnLQTLlT9WPHcoSm+EZyLqZbi9WYcFAS5n/8u6Hso55RhANaLVLBkM3FcqLz
         rFgg==
X-Gm-Message-State: AC+VfDxHOjlGCtiCb772QmX2gPXoUBnOY+SRt53waONMmMexDadb4h20
	BgOato5sw/5EMh9S6YJB9/4nwEmawMFDluPyB9LrZF5qTAT8gmC9Dmj4y03GmEU7bbynjBir5Fa
	g6g8MP7m+hHNO5fs=
X-Received: by 2002:a05:622a:c2:b0:3f9:aa3b:3d82 with SMTP id p2-20020a05622a00c200b003f9aa3b3d82mr2766901qtw.30.1686763108517;
        Wed, 14 Jun 2023 10:18:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lCeWGtzRjN23zJ2UyZZgbv2yKd27du2tV4OZmt2hvrQ8oaLwzsdkz1rKIbUuzDI4OqHF3BQ==
X-Received: by 2002:a05:622a:c2:b0:3f9:aa3b:3d82 with SMTP id p2-20020a05622a00c200b003f9aa3b3d82mr2766887qtw.30.1686763108251;
        Wed, 14 Jun 2023 10:18:28 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id cr17-20020a05622a429100b003f0a79e6a8bsm5185097qtb.28.2023.06.14.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:18:27 -0700 (PDT)
Date: Wed, 14 Jun 2023 10:18:26 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	joao.m.martins@oracle.com, Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Enable separate interrupt for PPR and GA
 log
Message-ID: <6efnbi2x5stp6npyx54ced2uykwq2nvx6qs2ldgboru4bi4dwm@zivxbrdtnxoy>
References: <20230609102025.6498-1-vasant.hegde@amd.com>
 <20230609102025.6498-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230609102025.6498-3-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 10:20:25AM +0000, Vasant Hegde wrote:
> AMD IOMMU supports separate interrupt for event, ppr and ga log. It has
> separate interrupt control register for same. So far we were using
> single interrupt to handle all three interrupts.
> 
> Add separate interrupt for event, ppr and ga log. `hwirq` is
> set to INTCAPXT register offset. We will use hwirq to [un]mask irqs.
> 
> Also add support for irq naming. It will display proper name for irq
> (AMD-Vi<X>-[Evt/PPR/GA]) instead of generic name (AMD-Vi).
> 
> Note that this patch changes interrupt handling only in IOMMU x2apic mode
> (MMIO 0x18[IntCapXTEn]=1). In legacy mode it will continue to use single
> MSI interrupt.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  9 ++++++
>  drivers/iommu/amd/init.c            | 48 +++++++++++++++++++++--------
>  2 files changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index a993e1bdb70b..65e18b590a54 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -704,12 +704,21 @@ struct amd_iommu {
>  	/* event buffer virtual address */
>  	u8 *evt_buf;
>  
> +	/* Name for event log interrupt */
> +	unsigned char evt_irq_name[16];
> +
>  	/* Base of the PPR log, if present */
>  	u8 *ppr_log;
>  
> +	/* Name for PPR log interrupt */
> +	unsigned char ppr_irq_name[16];
> +
>  	/* Base of the GA log, if present */
>  	u8 *ga_log;
>  
> +	/* Name for GA log interrupt */
> +	unsigned char ga_irq_name[16];
> +
>  	/* Tail of the GA log, if present */
>  	u8 *ga_log_tail;
>  
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 9908cd4f1c31..a174426da088 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2331,6 +2331,7 @@ static int intcapxt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq
>  		struct irq_data *irqd = irq_domain_get_irq_data(domain, i);
>  
>  		irqd->chip = &intcapxt_controller;
> +		irqd->hwirq = info->hwirq;
>  		irqd->chip_data = info->data;
>  		__irq_set_handler(i, handle_edge_irq, 0, "edge");
>  	}
> @@ -2357,22 +2358,14 @@ static void intcapxt_unmask_irq(struct irq_data *irqd)
>  	xt.destid_0_23 = cfg->dest_apicid & GENMASK(23, 0);
>  	xt.destid_24_31 = cfg->dest_apicid >> 24;
>  
> -	/**
> -	 * Current IOMMU implementation uses the same IRQ for all
> -	 * 3 IOMMU interrupts.
> -	 */
> -	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
> -	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
> -	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
> +	writeq(xt.capxt, iommu->mmio_base + irqd->hwirq);
>  }
>  
>  static void intcapxt_mask_irq(struct irq_data *irqd)
>  {
>  	struct amd_iommu *iommu = irqd->chip_data;
>  
> -	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
> -	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
> -	writeq(0, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
> +	writeq(0, iommu->mmio_base + irqd->hwirq);
>  }
>  
>  
> @@ -2435,7 +2428,8 @@ static struct irq_domain *iommu_get_irqdomain(void)
>  	return iommu_irqdomain;
>  }
>  
> -static int iommu_setup_intcapxt(struct amd_iommu *iommu)
> +static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
> +				  int hwirq, irq_handler_t thread_fn)
>  {
>  	struct irq_domain *domain;
>  	struct irq_alloc_info info;
> @@ -2449,6 +2443,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
>  	init_irq_alloc_info(&info, NULL);
>  	info.type = X86_IRQ_ALLOC_TYPE_AMDVI;
>  	info.data = iommu;
> +	info.hwirq = hwirq;
>  
>  	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
>  	if (irq < 0) {
> @@ -2457,7 +2452,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
>  	}
>  
>  	ret = request_threaded_irq(irq, amd_iommu_int_handler,
> -				   amd_iommu_int_thread, 0, "AMD-Vi", iommu);
> +				   thread_fn, 0, devname, iommu);
>  	if (ret) {
>  		irq_domain_free_irqs(irq, 1);
>  		irq_domain_remove(domain);
> @@ -2467,6 +2462,35 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
>  	return 0;
>  }
>  
> +static int iommu_setup_intcapxt(struct amd_iommu *iommu)
> +{
> +	int ret;
> +
> +	snprintf(iommu->evt_irq_name, sizeof(iommu->evt_irq_name),
> +		 "AMD-Vi%d-Evt", iommu->index);
> +	ret = __iommu_setup_intcapxt(iommu, iommu->evt_irq_name,
> +				     MMIO_INTCAPXT_EVT_OFFSET,
> +				     amd_iommu_int_thread_evtlog);
> +	if (ret)
> +		return ret;
> +
> +	snprintf(iommu->ppr_irq_name, sizeof(iommu->ppr_irq_name),
> +		 "AMD-Vi%d-PPR", iommu->index);
> +	ret = __iommu_setup_intcapxt(iommu, iommu->ppr_irq_name,
> +				     MMIO_INTCAPXT_PPR_OFFSET,
> +				     amd_iommu_int_thread_pprlog);
> +	if (ret)
> +		return ret;
> +
> +	snprintf(iommu->ga_irq_name, sizeof(iommu->ga_irq_name),
> +		 "AMD-Vi%d-GA", iommu->index);
> +	ret = __iommu_setup_intcapxt(iommu, iommu->ga_irq_name,
> +				     MMIO_INTCAPXT_GALOG_OFFSET,
> +				     amd_iommu_int_thread_galog);
> +

Related to the question with the first patch, should this only
get set up if CONFIG_IRQ_REMAP is enabled?


> +	return ret;
> +}
> +
>  static int iommu_init_irq(struct amd_iommu *iommu)
>  {
>  	int ret;
> -- 
> 2.31.1
> 

