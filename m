Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93DCC139
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 16:42:25 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-76d7bcefe8bso380015885a.1
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 09:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692808944; x=1693413744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfBDD1PmTnnvcURuc5daPszooEHHsodIfUZSukSvxYo=;
        b=YhxzYwcs0WtVvmHA2Lb1kW3Y1NLU45rxRLVM0PeMxozugGNEcTeOwbitt2tqhieo3Y
         KNdcQL9djlO0shwvBbwsjcdOxZoUgX+o1vR9pRqyMDkL/5z5TJbeQHrOGtjdCxDEbLKc
         jVEydTG/i+O0QY39qAWZZV9CndGtSlXFcoz+iX6ixgWzm43wTO97muOyUSVJtVx7ffku
         byR7C23nQ01MB1TFD8iLV0OY3ViXWjSNHh8HdpMOhIPkf4qT+9AY4VffuF5WnzmuENj7
         X9flxeN7Gm2va975hHrLe9SLbaYhk3HorM4jIDpdKoTQ1JiXB5erxLl8sfrmkBSrKkGM
         2y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692808944; x=1693413744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfBDD1PmTnnvcURuc5daPszooEHHsodIfUZSukSvxYo=;
        b=MEZDgiJEuDIP4aawaZcfI/cGLMSALZZWecz66gDI0tQo2TbOhjJCP26lOosG0RaEqk
         4j3AbknvftIpP+kqcowQy2yOkxZ8aHRLuRTqI+YO4GL2iMK8Y4/814/a+PuBnO2Fwtzt
         Uh8LGrRRL4vtrfVOoGkmRt9+/yLXwJURT0nw6PqtIs3chaz4s1g9XTb9ATAlG3WBkmh9
         wus8gjVbtKW0ksA2cS/tRf1ukvShyaZU2i9QRiMXOJ0FXeme/gfnW5MuvR1GXtlP2Ys9
         Wlluw6V+8P6w9OTycrkCYIrrprh9ydrXwKt52NlLf1C89OdQjrLX5pI321N9sg7aoqIp
         x3CQ==
X-Gm-Message-State: AOJu0YxD1W6wS6XhQoLK0ctuEEgmJ847kqn/wua/H6t5C489PXtY/x5s
	/MOclmJ20YZ9APFIjh5veJIA3wFvuMh/J7JqDk0=
X-Google-Smtp-Source: AGHT+IFgSdZEi8kbkfjMbgCJ3Z6HIgLUQbI/F9Co+fvjOM7SRaAnxq64wcMZaSQm67qfKmfQUpbflQ==
X-Received: by 2002:a05:622a:1049:b0:400:9390:d129 with SMTP id f9-20020a05622a104900b004009390d129mr18002664qte.36.1692808943976;
        Wed, 23 Aug 2023 09:42:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w23-20020ac843d7000000b004054db6da1bsm3828047qtn.53.2023.08.23.09.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 09:42:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qYqw2-00HWzL-Cy;
	Wed, 23 Aug 2023 13:42:22 -0300
Date: Wed, 23 Aug 2023 13:42:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 01/10] iommu/amd: Use struct protection_domain in
 helper functions
Message-ID: <ZOY27tt9lBFPLlHB@ziepe.ca>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816174031.634453-2-vasant.hegde@amd.com>

On Wed, Aug 16, 2023 at 05:40:22PM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To simplify the unnecessary use of container_of() on the struct
> iommu_domain to get the container structure.
> 
> No functional changes intended.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h     | 13 +++++++++----
>  drivers/iommu/amd/io_pgtable_v2.c |  8 ++++----
>  drivers/iommu/amd/iommu.c         | 18 ++++--------------
>  3 files changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 8b586effbefc..87739d95ea8b 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -55,15 +55,15 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
>  int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
>  void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
>  
> -int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
> +int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address);
>  void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
>  void amd_iommu_domain_update(struct protection_domain *domain);
>  void amd_iommu_domain_flush_complete(struct protection_domain *domain);
>  void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
> -int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
> -int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
> +int amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid);
> +int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
>  			      unsigned long cr3);
> -int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
> +int amd_iommu_domain_clear_gcr3(struct protection_domain *domain, u32 pasid);
>  
>  #ifdef CONFIG_IRQ_REMAP
>  int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
> @@ -147,6 +147,11 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
>  	return page ? page_address(page) : NULL;
>  }
>  
> +static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct protection_domain, domain);
> +}
> +

The change looks fine, but why did this patch move this into a header?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
