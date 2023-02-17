Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A236AA0
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 12:38:15 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id a27so679029qto.4
        for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 04:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXtuGkzR+JrRja0E+rl1l5tuGF2Z0Yu1hrejb4EpiA8=;
        b=QwZzgzuga/HryaWIQDSLfYELxKE4I9XlWmV5KGJ9yP3UREaZh4OblRO6wOWX2nB6Um
         jenl2N80wF3QzUYKohv0TcFQTk0qS3fHlTffqzIRrO5OBdANKTCBOrFUfz3FAjV6yN/S
         pVYmhnc+J26rNQGa+hlmW7s/7vt1Xbwqp9lbY+sBCD8d0QK/TK53+YeVKY9+kWyPxy4x
         PGQjnFBXsPvuVP7YvCskjfA1/HC1/fx9XES1gCneBRctwFmkGfw0tDpm3tH5A6nQI4Zt
         zHwmwq0eFoEpjrlXJBctfkp8a22M66mDe973BeVGNmeAYJFCSpTCeZRfqWyzxwY+SCDo
         3heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXtuGkzR+JrRja0E+rl1l5tuGF2Z0Yu1hrejb4EpiA8=;
        b=dNpiAmtYdlpNjfC9730Y7biZazKqPBz5vAgxnmhHp02hSZzIgBTbrOOU6PPfFnETTZ
         syfn2bwV+4u28MQEjyzXbnU+EPbmmJsC5REiQnO4qDioK09O/bXFc3iriNRoxT7lC/jK
         cz8hAOIj9pLD3BEyy+nVoUVgrDodYYGCRMOFrqM4VMbXAq2GETUfLRSaLYEFUVWj9AK8
         QC2knkDgKAGNYdAvE5Z8jKkRHXF7qP1cft0Dc/n+IZkDewKUSeMRlOoOw28jbp7Na50y
         l4jgl65YoKmZDg8TcK//f9lpEE3kwbUv55z8SIaIzcN0mcg0yN9rXmPTr+CKBg5ZmFi9
         bHqA==
X-Gm-Message-State: AO0yUKXHZMS+12ynTyd6BKJSxvBy4HtDKFOvTg/DhiFvkYn9Q0xoI4+2
	l9q9IvGVognOsSKE2K5G3bP/AkSQNiPKLEFJ
X-Google-Smtp-Source: AK7set8UHFE9aSovD0L7Sm6Qhv6876HsjBNJkIt73AgIaLzsbfLNA9Sqt50XljzH2u63hgCHJ4a/CQ==
X-Received: by 2002:a05:622a:1116:b0:3bd:12d:d488 with SMTP id e22-20020a05622a111600b003bd012dd488mr1296087qty.27.1676637494670;
        Fri, 17 Feb 2023 04:38:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id bn3-20020a05622a1dc300b003b80a69d353sm3164357qtb.49.2023.02.17.04.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:38:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pT00D-00364I-Ka;
	Fri, 17 Feb 2023 08:38:13 -0400
Date: Fri, 17 Feb 2023 08:38:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	lim Akhtar <alim.akhtar@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/exynos: Fix set_platform_dma_ops() callback
Message-ID: <Y+91NRv4KOvttHBr@ziepe.ca>
References: <CGME20230217112140eucas1p1703b82cfcdb933f07baa154183845986@eucas1p1.samsung.com>
 <20230217112129.18879-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217112129.18879-1-m.szyprowski@samsung.com>

On Fri, Feb 17, 2023 at 12:21:29PM +0100, Marek Szyprowski wrote:
> There are some subtle differences between release_device() and
> set_platform_dma_ops() callbacks, so separate those two callbacks. Device
> links should be removed only in release_device(), because they were
> created in probe_device(). While fixing this, remove the conditional code
> as it is not really needed.
> 
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 189d496b48b1 ("iommu/exynos: Add missing set_platform_dma_ops callback")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 483aaaeb6dae..4141625542ef 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1415,23 +1415,26 @@ static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
>  	return &data->iommu;
>  }
>  
> -static void exynos_iommu_release_device(struct device *dev)
> +static void exynos_iommu_set_platform_dma(struct device *dev)
>  {
>  	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
> -	struct sysmmu_drvdata *data;
>  
>  	if (owner->domain) {
>  		struct iommu_group *group = iommu_group_get(dev);
>  
>  		if (group) {
> -#ifndef CONFIG_ARM
> -			WARN_ON(owner->domain !=
> -				iommu_group_default_domain(group));
> -#endif
>  			exynos_iommu_detach_device(owner->domain, dev);
>  			iommu_group_put(group);
>  		}
>  	}

See, this is my confusion from the other email, all this does is
"detach_device" but it really should restore the arm_iommu's
mapping->domain.

> @@ -1478,11 +1481,9 @@ static int exynos_iommu_of_xlate(struct device *dev,
>  static const struct iommu_ops exynos_iommu_ops = {
>  	.domain_alloc = exynos_iommu_domain_alloc,
>  	.device_group = generic_device_group,
> -#ifdef CONFIG_ARM
> -	.set_platform_dma_ops = exynos_iommu_release_device,
> -#endif
>  	.probe_device = exynos_iommu_probe_device,
>  	.release_device = exynos_iommu_release_device,
> +	.set_platform_dma_ops = exynos_iommu_set_platform_dma,

The ifdef is still needed, when using default domains this op should
not be set at all.

Jason
