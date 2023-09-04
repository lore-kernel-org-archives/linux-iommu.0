Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469FC13A
	for <iommu@lists.linux.dev>; Mon,  4 Sep 2023 15:34:00 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so16958045e9.1
        for <iommu@lists.linux.dev>; Mon, 04 Sep 2023 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693841638; x=1694446438; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8mKB1k2ZE2G/ciLlCDtCzQ5wGQ8xRQbZHnxa2+q17Z8=;
        b=PrYwclXHSm8v/iN3DxjMqdJ1SuqVjU7UKN2Ng8ZyoUvWORz38i2NM5DUCaFWwR5M/r
         NwpYb5DBw3+bACoEI2DsugsTlsJBwxfCJC9+Y25Uht7EX/uMu60TBBceNEN29O5bIoeH
         nhO8QqHTssENVgCQs5AY0evwVAKphp1kR1yDxoANClFvbM20+WLwmPN8f0UOEvVsCgVG
         0gx9HEHDjf8X/ERrZcXBY0Fgjk1S1Exg5YDfPU+UNuO7a3xBN6KD8b7fuhScN6wMRxvl
         2+jTZJAo6XmTX1UlmqvHefUPm4PLrLzJ10azst8vo24v7iemA4v3KTYp+w9/rkDnRdLR
         E0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693841638; x=1694446438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mKB1k2ZE2G/ciLlCDtCzQ5wGQ8xRQbZHnxa2+q17Z8=;
        b=lkjL2m6bdQdCeRFPdPFT5Uus/SasCmcc9wF4m41S/5oqZRuA8QyGmRAFu/U8ZBQfmH
         G68JttRF0a2rxVQSFRzr2UcO3B0LDkKzQSPfsD5BXZdfn6eBllbsgl4JSXRDdeiSK1/r
         ij815A/HNcQ3PnRTJI1H8q5lwWQTCbTYN+FJIccDY6ZuBZCJHtD8Epcxt4UXDSq56ZW5
         W7xHMGcnYKLChzXugxZPhn0Ch8hxEbFJ8JitReyoT10qFxRHUBGk2aaV3OYPoJCGWXzZ
         pradkzerhwJfXGRrj845WXwZhiT0a5awsOTxjBSKCnsxQkHjx5lzt2FQlq+jv3B3b+gC
         mtyw==
X-Gm-Message-State: AOJu0YwUnj0KtgVX+/JfoVlXnhiwmHtWQBOz8QAB8NQTaUuBN67eO6Pr
	VwClqon9xSFw82VozA2N+wUb5EUvYuDDop660K4=
X-Google-Smtp-Source: AGHT+IGhYh7h7UosmsP+axnCskrqTn/m5wl+B+KT+YE2nQBzRYMTV/Fur6gSkA0GnBJj6rv+rEUuzA==
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id n5-20020a05600c294500b003fe89be0cd3mr7728851wmd.22.1693841638575;
        Mon, 04 Sep 2023 08:33:58 -0700 (PDT)
Received: from myrica ([2.220.83.24])
        by smtp.gmail.com with ESMTPSA id o24-20020a05600c379800b003fed70fb09dsm14379467wmr.26.2023.09.04.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:33:58 -0700 (PDT)
Date: Mon, 4 Sep 2023 16:34:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Message-ID: <20230904153403.GB815284@myrica>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>

On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> dma-iommu deferred flush scheme. This results inn a significant increase

in

> in performance in exchange for a window in which devices can still
> access previously IOMMU mapped memory. To get back to the prior behavior
> iommu.strict=1 may be set on the kernel command line.

Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
well, because I've seen kernel configs that enable either.

> 
> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index fb73dec5b953..1b7526494490 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>  	return viommu_sync_req(vdomain->viommu);
>  }
>  
> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	if (!vdomain->nr_endpoints)
> +		return;

As for patch 1, a NULL check in viommu_sync_req() would allow dropping
this one

Thanks,
Jean

> +	viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
>  		.map_pages		= viommu_map_pages,
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>  		.iotlb_sync		= viommu_iotlb_sync,
>  		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
> 
> -- 
> 2.39.2
> 
