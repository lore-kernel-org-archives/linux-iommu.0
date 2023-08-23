Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461BE156E6;
	Wed, 23 Aug 2023 19:22:21 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99c47ef365cso812733866b.0;
        Wed, 23 Aug 2023 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692818539; x=1693423339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A7rqXZuJfU1yZs94XUAoV6PyvGVYswx1v0VPnHlBMo=;
        b=gABV0oZ48L/j5GWCIeTrExYiZi91ng21hl5xespzr8NB3S4D/8ftCqCb9FGv/K2afQ
         ArY+l6UCMD6gpiNzOX76C49BNHZlaVvwNz4QSSYAqxFtnH8PVkEBo0kfXRDoHKtHEK+T
         FynUDmVpnbZ5U4/SKWlUzkz3di/XO0oHHZQmgkk9wbopDuQsHvi0ko5qTL9BAomQkpJD
         8WAd6Neg4HzJ9SzKVoOlRMbblIRxX37RdOaWfPWyoBQOxhBb6ooBanHlud/zE7ql/74B
         GvCHfsDsKPKnVWXTnluLxnbqN0GYFfPQ9klsbR1I/RqmZuMePgFQ+Fuq1Wh+qi9cRwgB
         24JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692818539; x=1693423339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A7rqXZuJfU1yZs94XUAoV6PyvGVYswx1v0VPnHlBMo=;
        b=XmZvNZk3c2evtsyUVlvj3umLM42J9PvhDNdJUa0n0RX4s6QBn6GjmXQWGWwPW0IA3m
         ncNUkQH7pfFYp3wXyHhiuQS46TlZZMBz1QAX+snw/hBU2UDsXxHbuaNWVoO/OPKsUkOL
         X0x2rYt4nfkNDt4CARL7ocin7xAFSTPAYkjtqWJJD95nyDrILDlKLeGb9Xx6zey+UYZG
         yxAONNRxlv1Y56lssMzTiF98CJHXCQiC3KKN4u2Y18mcfPUF2mHiCUDwW1fUGEbS1mV2
         DX8UsH8TWXl3+Uu93iUiCuNhmtUamyeBEItvSCPk7sMCAov5i0WW00Biz/QuYNGaEehM
         IBNA==
X-Gm-Message-State: AOJu0Yybaf2cjCTeWmJoqBWBfNz7V06XiNqrAVQQcNxhYbu65fWoaZ/W
	HpdYBt/SIowkw4CPqGGqmvY=
X-Google-Smtp-Source: AGHT+IHmo+7tkL57NnW1/dVyRTs/Uwxxxaw5Ytu+u/iQ6yK9cxjIxAGx4nZFFqWG6KJlM+8tYnkyww==
X-Received: by 2002:a17:906:5356:b0:9a1:abf8:76ad with SMTP id j22-20020a170906535600b009a1abf876admr6243155ejo.34.1692818538741;
        Wed, 23 Aug 2023 12:22:18 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906264600b0099bd1ce18fesm10171343ejc.10.2023.08.23.12.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:22:17 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
 Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject:
 Re: [PATCH 3/7] iommu/sun50i: Convert to generic_single_device_group()
Date: Wed, 23 Aug 2023 21:22:15 +0200
Message-ID: <2152915.irdbgypaU6@jernej-laptop>
In-Reply-To: <3-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
References: <3-v1-c869a95191f2+5e8-iommu_single_grp_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 22. avgust 2023 ob 18:15:58 CEST je Jason Gunthorpe napisal(a):
> Use the new helper.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/iommu/sun50i-iommu.c | 29 ++++++-----------------------
>  1 file changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index 74c5cb93e90027..b8df655185ab2a 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -107,7 +107,6 @@ struct sun50i_iommu {
>  	struct clk *clk;
> 
>  	struct iommu_domain *domain;
> -	struct iommu_group *group;
>  	struct kmem_cache *pt_pool;
>  };
> 
> @@ -808,13 +807,6 @@ static struct iommu_device
> *sun50i_iommu_probe_device(struct device *dev) return &iommu->iommu;
>  }
> 
> -static struct iommu_group *sun50i_iommu_device_group(struct device *dev)
> -{
> -	struct sun50i_iommu *iommu = sun50i_iommu_from_dev(dev);
> -
> -	return iommu_group_ref_get(iommu->group);
> -}
> -
>  static int sun50i_iommu_of_xlate(struct device *dev,
>  				 struct of_phandle_args *args)
>  {
> @@ -828,7 +820,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
> 
>  static const struct iommu_ops sun50i_iommu_ops = {
>  	.pgsize_bitmap	= SZ_4K,
> -	.device_group	= sun50i_iommu_device_group,
> +	.device_group	= generic_single_device_group,
>  	.domain_alloc	= sun50i_iommu_domain_alloc,
>  	.of_xlate	= sun50i_iommu_of_xlate,
>  	.probe_device	= sun50i_iommu_probe_device,
> @@ -995,42 +987,36 @@ static int sun50i_iommu_probe(struct platform_device
> *pdev) if (!iommu->pt_pool)
>  		return -ENOMEM;
> 
> -	iommu->group = iommu_group_alloc();
> -	if (IS_ERR(iommu->group)) {
> -		ret = PTR_ERR(iommu->group);
> -		goto err_free_cache;
> -	}
> -
>  	iommu->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(iommu->base)) {
>  		ret = PTR_ERR(iommu->base);
> -		goto err_free_group;
> +		goto err_free_cache;
>  	}
> 
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		ret = irq;
> -		goto err_free_group;
> +		goto err_free_cache;
>  	}
> 
>  	iommu->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(iommu->clk)) {
>  		dev_err(&pdev->dev, "Couldn't get our clock.\n");
>  		ret = PTR_ERR(iommu->clk);
> -		goto err_free_group;
> +		goto err_free_cache;
>  	}
> 
>  	iommu->reset = devm_reset_control_get(&pdev->dev, NULL);
>  	if (IS_ERR(iommu->reset)) {
>  		dev_err(&pdev->dev, "Couldn't get our reset line.\n");
>  		ret = PTR_ERR(iommu->reset);
> -		goto err_free_group;
> +		goto err_free_cache;
>  	}
> 
>  	ret = iommu_device_sysfs_add(&iommu->iommu, &pdev->dev,
>  				     NULL, dev_name(&pdev->dev));
>  	if (ret)
> -		goto err_free_group;
> +		goto err_free_cache;
> 
>  	ret = iommu_device_register(&iommu->iommu, &sun50i_iommu_ops, 
&pdev->dev);
> if (ret)
> @@ -1049,9 +1035,6 @@ static int sun50i_iommu_probe(struct platform_device
> *pdev) err_remove_sysfs:
>  	iommu_device_sysfs_remove(&iommu->iommu);
> 
> -err_free_group:
> -	iommu_group_put(iommu->group);
> -
>  err_free_cache:
>  	kmem_cache_destroy(iommu->pt_pool);




