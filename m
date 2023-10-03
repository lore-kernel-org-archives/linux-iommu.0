Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9610D2EB
	for <iommu@lists.linux.dev>; Tue,  3 Oct 2023 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696355113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrMFZHrqySBTzbsQH1+BjU2pYRDAvFkmodCgFlgj2lg=;
	b=buv4RAAmMdLHynpDBhFjDOVhIWeRjvQ8mJi+clOngy6bWaHMLnxEJmvDCQ4L7YzqjnqS5a
	dqTv/nOLic27TGzcWoRBdDwao4bush62fLLAwSU9ybp1WR3bu/cNa7UWT7vxc7IA7xVe/z
	Mb9gYkI2RYwG4AS+oGt8w97IBqFrstE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-uFjRNijsO36rdDLBeU2xKw-1; Tue, 03 Oct 2023 13:45:09 -0400
X-MC-Unique: uFjRNijsO36rdDLBeU2xKw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65b0af1b0e2so15272166d6.0
        for <iommu@lists.linux.dev>; Tue, 03 Oct 2023 10:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696355109; x=1696959909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrMFZHrqySBTzbsQH1+BjU2pYRDAvFkmodCgFlgj2lg=;
        b=tv7G50D5ToVwPEaS841FoUyXER7dGBteOTs99LNB3NcGofsFKY7F66waAAr8bvCg9J
         w+AcCREC8/i4hsu9BIu0OkoCqQFVo83SEra8qZ/c1dOsYFJ8qK1bwvcbLOUcpZN+XxDo
         LuJNy6TyTigcJxl8r1PnomCbPiRa81B2f2xdpM8LGFjE2IRHETnpm3FDe+Rv/9eoc2Gc
         eLMZQIto0sqlKw1Q8b3g2EFCcroZWLnCBnPpq9AwtiM/v9icUzx5ZHDS9fvE6n38YwGi
         JT7/JbmvoE4MBjHyCSqVTB9zTzDQc27Ve1FKPDyjxqTEylcsyNIco+3z4lBxKG89LIIf
         DsZA==
X-Gm-Message-State: AOJu0YzZIq40zQR+c70rQxsOaxXdF/hzyh/SViO5FnjX+N7FHu2/DOh3
	C9pw4Ge1rAjubZYnBoAckjO2FEjFLe5428DPzZ0ENXX7avxaYV4uIGx6MeQLROuXIrJWHI9cV8b
	X3R2oKCznOze/oFw=
X-Received: by 2002:a0c:9cc6:0:b0:65d:b9b:f327 with SMTP id j6-20020a0c9cc6000000b0065d0b9bf327mr28755qvf.63.1696355109478;
        Tue, 03 Oct 2023 10:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzlthIMpOGLpVBeL/n4hILpSTGvamQONZhA3IdVXkHoBhYrgDc3/2qEZ+/my8fpUZsNa14cw==
X-Received: by 2002:a0c:9cc6:0:b0:65d:b9b:f327 with SMTP id j6-20020a0c9cc6000000b0065d0b9bf327mr28745qvf.63.1696355109198;
        Tue, 03 Oct 2023 10:45:09 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j4-20020a0ce004000000b006360931c12fsm647512qvk.96.2023.10.03.10.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:45:08 -0700 (PDT)
Date: Tue, 3 Oct 2023 10:45:07 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <jroedel@suse.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] iommu: Do not use IOMMU_DOMAIN_DMA if CONFIG_IOMMU_DMA
 is not enabled
Message-ID: <nmvwfe6fydfk5j5xs67te7xgdcbdd3474i65ds5bo2b2zokvma@ioxvos33wayk>
References: <0-v1-20700abdf239+19c-iommu_no_dma_iommu_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <0-v1-20700abdf239+19c-iommu_no_dma_iommu_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 03, 2023 at 01:52:36PM -0300, Jason Gunthorpe wrote:
> msm_iommu platforms do not select either CONFIG_IOMMU_DMA or
> CONFIG_ARM_DMA_USE_IOMMU so they create a IOMMU_DOMAIN_DMA domain by
> default and never populate it. This acts like a BLOCKED domain and breaks
> the GPU driver on the platform.
> 
> Detect this and force use of IDENTITY instead.
> 
> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Link: https://lore.kernel.org/linux-iommu/CAA8EJprz7VVmBG68U9zLuqPd0UdSRHYoLDJSP6tCj6H6qanuTQ@mail.gmail.com/
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> Dmitry, I changed the patch from what I got you to test, probably best if you
> can confirm this is OK too. This should fix any other drivers beyond msm that are
> doing the same thing. Thanks
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1ecac2b5c54f4a..21d45e6a5931a1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1920,6 +1920,18 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>  		}
>  	}
>  
> +	/*
> +	 * If the common dma ops are not selected in kconfig then we cannot use
> +	 * IOMMU_DOMAIN_DMA at all. Force IDENTITY if nothing else has been
> +	 * selected.
> +	 */
> +	if (!IS_ENABLED(CONFIG_IOMMU_DMA)) {
> +		if (WARN_ON(driver_type == IOMMU_DOMAIN_DMA))
> +			return -1;
> +		if (!driver_type)
> +			driver_type = IOMMU_DOMAIN_IDENTITY;
> +	}
> +
>  	if (untrusted) {
>  		if (driver_type && driver_type != IOMMU_DOMAIN_DMA) {
>  			dev_err_ratelimited(
> 
> base-commit: dd5c4a1fe62738b4494deaf387d9a63a7c9f9519
> -- 
> 2.42.0
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

