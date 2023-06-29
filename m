Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC310E7
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688056554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHaUqKpDrcRiZ9xi8spHMBxgHeoFA1KrXoXbm4sThVM=;
	b=FK+WFbVqUdwB2QMjex8PbBWOFMqj4Aph9jgGtRBXlPQ2TzVPUJ/nn7zSzMCgeh4kXp4gbj
	aaFmv8Y70lusSM9OR1zVRGx9NCf6G90xeUw0KmkuXidBSkSehR8CSgaWYspQzkr4WohVJp
	WKoWCPUPf0PHzNe0bFIFpiG3vHxAVCM=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-IHasD0kSPHO4gw64HypQUQ-1; Thu, 29 Jun 2023 12:35:50 -0400
X-MC-Unique: IHasD0kSPHO4gw64HypQUQ-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-78f1e2e7f7aso227231241.1
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 09:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688056550; x=1690648550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHaUqKpDrcRiZ9xi8spHMBxgHeoFA1KrXoXbm4sThVM=;
        b=EFmT1DaE3CScLqmNlm6qWV873eYGQZbslRPE1Rdx6DXrJxL/UXje+aWhsS9jem8q+E
         SChrf4Jvgf8wRxPImP753Lt4UNfpqc9pbXlRjC62xwRGbsgg2Eu6CsLWWIXhFj/0g++w
         uuWLPf34ixra3eRiol8u7R9EltEGan7yEPJKKflBKE/OdsEBbwaeipeILvaU0Tz/Jcro
         WeQk1bfuQJcdJrQCeqID9SVG2vwbgvuMwxjvsApl0kq+ZXEkfrc9XNcnkob7vOuIkF4Q
         j8DgIZRr9sv4JWryEdbmNGohyVhlUpxrL6Pk0PgpVDBLUNGUerbbzSZPX41m10IzWsyg
         bOCA==
X-Gm-Message-State: ABy/qLZ7XJNUVAdLxdA78I+lgCxM+E5GgUsOsRKovVYcAUoLLBGCd2Jw
	Gop/4WFLKNXhL8Jf6sLvN4PgL0lM7ADd7kR++OG4Okddu6LCMsOY8mvMMkHk1fn1zy2goN0/pIJ
	M9POeNNDSmMnEdSk=
X-Received: by 2002:a67:fe5a:0:b0:43f:58a1:b22c with SMTP id m26-20020a67fe5a000000b0043f58a1b22cmr246106vsr.16.1688056550094;
        Thu, 29 Jun 2023 09:35:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE8lVxy3gVHm2mOtPHFvUgnSjqfKm+DL7GLbNhWSQh5MK9G7+X0yoPOudosJ4zXHcK5bZYc8Q==
X-Received: by 2002:a67:fe5a:0:b0:43f:58a1:b22c with SMTP id m26-20020a67fe5a000000b0043f58a1b22cmr246087vsr.16.1688056549801;
        Thu, 29 Jun 2023 09:35:49 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id mi11-20020a056214558b00b00634b6585b21sm7054199qvb.17.2023.06.29.09.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:35:49 -0700 (PDT)
Date: Thu, 29 Jun 2023 09:35:47 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	joao.m.martins@oracle.com, Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v3 2/2] iommu/amd: Enable separate interrupt for PPR and
 GA log
Message-ID: <mykzkhftijxskpcq6rrmeu5gq23ordvx26o2qxusqb63e46h3w@4x6nkylyudhx>
References: <20230628053222.5962-1-vasant.hegde@amd.com>
 <20230628053222.5962-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230628053222.5962-3-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 05:32:22AM +0000, Vasant Hegde wrote:
> AMD IOMMU has three log buffers (i.e. Event, PPR, and GA). These logs can
> be configured to generate different interrupts when an entry is inserted
> into a log buffer.
> 
> However, current implementation share single interrupt to handle all three
> logs. With increasing usages of the GA (for IOMMU AVIC) and PPR logs (for
> IOMMUv2 APIs and SVA), interrupt sharing could potentially become
> performance bottleneck.
> 
> Hence, separate IOMMU interrupt into use three separate vectors and irq
> threads with corresponding name, which will be displayed in the
> /proc/interrupts as "AMD-Vi<x>-[Evt/PPR/GA]", where "x" is an IOMMU id.
> 
> Note that this patch changes interrupt handling only in IOMMU x2apic mode
> (MMIO 0x18[IntCapXTEn]=1). In legacy mode it will continue to use single
> MSI interrupt.
> 
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> Reviewed-by: Alexey Kardashevskiy<aik@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/amd_iommu_types.h |  9 ++++++
>  drivers/iommu/amd/init.c            | 50 ++++++++++++++++++++++-------
>  2 files changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 2266badc6d0a..7011b746d38e 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -705,12 +705,21 @@ struct amd_iommu {
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
> index e78d7c4f41bd..30f09e786f7b 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2335,6 +2335,7 @@ static int intcapxt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq
>  		struct irq_data *irqd = irq_domain_get_irq_data(domain, i);
>  
>  		irqd->chip = &intcapxt_controller;
> +		irqd->hwirq = info->hwirq;
>  		irqd->chip_data = info->data;
>  		__irq_set_handler(i, handle_edge_irq, 0, "edge");
>  	}
> @@ -2361,22 +2362,14 @@ static void intcapxt_unmask_irq(struct irq_data *irqd)
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
> @@ -2439,7 +2432,8 @@ static struct irq_domain *iommu_get_irqdomain(void)
>  	return iommu_irqdomain;
>  }
>  
> -static int iommu_setup_intcapxt(struct amd_iommu *iommu)
> +static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
> +				  int hwirq, irq_handler_t thread_fn)
>  {
>  	struct irq_domain *domain;
>  	struct irq_alloc_info info;
> @@ -2453,6 +2447,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
>  	init_irq_alloc_info(&info, NULL);
>  	info.type = X86_IRQ_ALLOC_TYPE_AMDVI;
>  	info.data = iommu;
> +	info.hwirq = hwirq;
>  
>  	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
>  	if (irq < 0) {
> @@ -2461,7 +2456,7 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
>  	}
>  
>  	ret = request_threaded_irq(irq, amd_iommu_int_handler,
> -				   amd_iommu_int_thread, 0, "AMD-Vi", iommu);
> +				   thread_fn, 0, devname, iommu);
>  	if (ret) {
>  		irq_domain_free_irqs(irq, 1);
>  		irq_domain_remove(domain);
> @@ -2471,6 +2466,37 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
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
> +#ifdef CONFIG_IRQ_REMAP
> +	snprintf(iommu->ga_irq_name, sizeof(iommu->ga_irq_name),
> +		 "AMD-Vi%d-GA", iommu->index);
> +	ret = __iommu_setup_intcapxt(iommu, iommu->ga_irq_name,
> +				     MMIO_INTCAPXT_GALOG_OFFSET,
> +				     amd_iommu_int_thread_galog);
> +#endif
> +
> +	return ret;
> +}
> +
>  static int iommu_init_irq(struct amd_iommu *iommu)
>  {
>  	int ret;
> -- 
> 2.31.1
> 

