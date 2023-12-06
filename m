Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3FA1BDDC
	for <iommu@lists.linux.dev>; Wed,  6 Dec 2023 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyOeyAXb"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b397793aaso3695435e9.0
        for <iommu@lists.linux.dev>; Wed, 06 Dec 2023 01:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701856629; x=1702461429; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WOufZeE4P5YrzNvJiHEpQChOUhjcC+wU9d3XJlhAto=;
        b=YyOeyAXbnokpE/B+J6iF97+f7U2E7d4YljYWF96A0PrtKJrS4867TWNck5lYo88h56
         TxSnja/vukTRFUa4eC0wd3hWraZJpUZqics2fSsZLdUV8kW7cRshaWHATzfXsNesYR6h
         SKu8NDpTaY2tVQyQQYkMDkCqMqRUwntsE7+/6YqorxHk6hh5UnsNlCZ1aU2lo+7i2JUu
         Qb7fwhp5UPZ9Lhbirovg1GBIHF7vbft3fIjywKq6YXWONq7KhENXoBqLaKEfZy4BfazW
         JAdIDfggaY+x/aE13MTOtpw/a1JLfSYPSZfcfFt/M9uuAECMuEoLeqY6zStWYVRGOISY
         J+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701856629; x=1702461429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WOufZeE4P5YrzNvJiHEpQChOUhjcC+wU9d3XJlhAto=;
        b=RfVszff27t1ful/1RyYHTNdT1tXrr5rjFbFk8Ne9UavGaSrVv38fuz3CyTMBVZNPng
         pHKwuJ7qNbmxPI/oF/4uG3Ca/sugIQQfZPXU+NNky5Svu/5rEar0LnkVnvVIabIM8jD7
         qgXhUErCKCFF6iod0sc/894js8VJ3+cqsZjSg+5VkRWSL2LOxOqcYG7agT7ViF1ZB/Tw
         m5bpwdfJxa2om7Gc2e966OwCzH8yP3DerOWBWKD5LZ7EBHTVcKJUgDYrUM61yZDSewy1
         SvUrpboxpsH/uNDPQ9hs1cJrNUX8GjhJfxHc2dVNH9BOHzrKTKKDa0U4Mmiqusu3hUFI
         5uiA==
X-Gm-Message-State: AOJu0Yw9Z+pWuUALiHAYuc0mVTFCRI89qW80CWsvzvfil+f9ZXCXLvPO
	CBZdB/Z14n9PrPd+9wVOlm+/dA==
X-Google-Smtp-Source: AGHT+IFsH8K0hxbQzyVbZh44+ZBYduzN3cYJsMNckKn76oaG9oDcMavmkJSmuqzOJjocAnEZClHfhw==
X-Received: by 2002:a05:600c:4d8f:b0:40b:5e56:7b42 with SMTP id v15-20020a05600c4d8f00b0040b5e567b42mr1439954wmp.139.1701856629051;
        Wed, 06 Dec 2023 01:57:09 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d64cd000000b003334898aafasm8182940wri.11.2023.12.06.01.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:57:08 -0800 (PST)
Date: Wed, 6 Dec 2023 09:57:17 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, Wenkai Lin <linwenkai6@hisilicon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: disable stall for quiet_cd
Message-ID: <20231206095717.GA2643771@myrica>
References: <20231206005727.46150-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206005727.46150-1-zhangfei.gao@linaro.org>

On Wed, Dec 06, 2023 at 08:57:27AM +0800, Zhangfei Gao wrote:
> From: Wenkai Lin <linwenkai6@hisilicon.com>
> 
> In the stall model, invalid transactions were expected to be
> stalled and aborted by the IOPF handler.
> 
> However, when killing a test case with a huge amount of data, the
> accelerator streamline can not stop until all data is consumed
> even if the page fault handler reports errors. As a result, the
> kill may take a long time, about 10 seconds with numerous iopf
> interrupts.
> 
> So disable stall for quiet_cd in the non-force stall model, since
> force stall model (STALL_MODEL==0b10) requires CD.S must be 1.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7445454c2af2..7086e5fa41ff 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1063,6 +1063,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  	bool cd_live;
>  	__le64 *cdptr;
>  	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
> +	struct arm_smmu_device *smmu = master->smmu;
>  
>  	if (WARN_ON(ssid >= (1 << cd_table->s1cdmax)))
>  		return -E2BIG;
> @@ -1077,6 +1078,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>  	if (!cd) { /* (5) */
>  		val = 0;
>  	} else if (cd == &quiet_cd) { /* (4) */
> +		if (!(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
> +			val &= ~(CTXDESC_CD_0_S | CTXDESC_CD_0_R);
>  		val |= CTXDESC_CD_0_TCR_EPD0;
>  	} else if (cd_live) { /* (3) */
>  		val &= ~CTXDESC_CD_0_ASID;
> -- 
> 2.39.3 (Apple Git-145)
> 
