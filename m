Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058F7471
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679672705;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRC1/VdP8QTnH2Qzmn0A62aZq5RTC7SBPX5Sc2dfmw4=;
	b=i6xjc0AhWLvO3O8EWnlq/asIKdbZNpRECVtuP6NrecNFs/+smdYLbBx0NimJz2U6wfpjZv
	n7NSUspFFs3aOl4KBhZ/pmZiV8SdQhTgR98V2F0Rcd9gSl9Xeug8/DgOe4LJpZPFl5web+
	b4tayk0w9UJPpqcrdsTJMz5QACsfVZE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-x5F0oHmyPRuoV3Tl3ByaxQ-1; Fri, 24 Mar 2023 11:45:04 -0400
X-MC-Unique: x5F0oHmyPRuoV3Tl3ByaxQ-1
Received: by mail-qt1-f200.google.com with SMTP id w13-20020ac857cd000000b003e37d3e6de2so1252440qta.16
        for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 08:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRC1/VdP8QTnH2Qzmn0A62aZq5RTC7SBPX5Sc2dfmw4=;
        b=IlcQ/yYgfYQd6P8Ni4o/jVNcEZtiwIoPYOv0Jwyf3TVpaLkKUzSAQm53XwnQDGdRrO
         +B8R2X8qkh5YhNL+slrxsnYL/YuTuqj1fVTcSLXzQ2T+1e2Uy0lRsbaC7gHSdcdvgcZ+
         l9X7aChuZxWNPZhJ2tgRbw5i1RqKxNf+0n+1g9HAdtWiyzItmWzS7zwmJISxqHodpzlz
         YkOOZKqNE4GNLPJbommEcGp7Y14KmUEshLqEjYAOTqmCgobWyxxAJJg5K5W9qHgeYV/j
         fxON96jMF9H3SmgjxWNTphtI0Mhb263Xm3JARwq6jbN9FalrQmQza6xy+WyZUWp0Zm9b
         PaYA==
X-Gm-Message-State: AO0yUKXBBZpKIgIvxcmkCqB4/DyGbMtTZ4TrRuSubtZbwZo1sHdHteFV
	zW+pZwk4Gg5gMiIEBwN9MKi2qrOar1EfAtIY0lp61wsgJ6u1zom82u/FhDVsCKKqO/ykiwraQCX
	CLlRLfLcp2TFVZCc=
X-Received: by 2002:a05:622a:1a98:b0:3dc:a4e5:aef0 with SMTP id s24-20020a05622a1a9800b003dca4e5aef0mr5984971qtc.9.1679672703938;
        Fri, 24 Mar 2023 08:45:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YoDFgTJsdfo1CEzGHeBcuvWj1BI5zKHFdIUbVT2L0Ym7GunFU5QXEIokCQtmR0rSAjY4mzZg==
X-Received: by 2002:a05:622a:1a98:b0:3dc:a4e5:aef0 with SMTP id s24-20020a05622a1a9800b003dca4e5aef0mr5984944qtc.9.1679672703630;
        Fri, 24 Mar 2023 08:45:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id m124-20020a375882000000b0073b8745fd39sm14290433qkb.110.2023.03.24.08.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 08:45:02 -0700 (PDT)
Message-ID: <b870ec68-623c-df0c-3ea5-7fe6a95e2ef6@redhat.com>
Date: Fri, 24 Mar 2023 16:44:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
 type of allocations
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, robin.murphy@arm.com,
 will@kernel.org
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolin,

On 3/9/23 11:53, Nicolin Chen wrote:
> Add domain allocation support for IOMMU_DOMAIN_NESTED type. This includes
> the "finalise" part to log in the user space Stream Table Entry info.

Please explain the domain ops specialization.
>
> Co-developed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5ff74edfbd68..1f318b5e0921 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2214,6 +2214,19 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>  		return 0;
>  	}
>  
> +	if (domain->type == IOMMU_DOMAIN_NESTED) {
> +		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1) ||
> +		    !(smmu->features & ARM_SMMU_FEAT_TRANS_S2)) {
> +			dev_dbg(smmu->dev, "does not implement two stages\n");
> +			return -EINVAL;
> +		}
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
> +		smmu_domain->s1_cfg.s1fmt = user_cfg->s1fmt;
> +		smmu_domain->s1_cfg.s1cdmax = user_cfg->s1cdmax;
> +		smmu_domain->s1_cfg.cdcfg.cdtab_dma = user_cfg->s1ctxptr;
> +		return 0;
> +	}
> +
>  	if (user_cfg_s2 && !(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>  		return -EINVAL;
>  	if (user_cfg_s2)
> @@ -2863,6 +2876,11 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
>  }
>  
> +static const struct iommu_domain_ops arm_smmu_nested_domain_ops = {
> +	.attach_dev		= arm_smmu_attach_dev,
> +	.free			= arm_smmu_domain_free,
> +};
> +
>  static struct iommu_domain *
>  __arm_smmu_domain_alloc(unsigned type,
>  			struct arm_smmu_domain *s2,
> @@ -2877,11 +2895,15 @@ __arm_smmu_domain_alloc(unsigned type,
>  		return arm_smmu_sva_domain_alloc();
>  
>  	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_NESTED &&
>  	    type != IOMMU_DOMAIN_DMA &&
>  	    type != IOMMU_DOMAIN_DMA_FQ &&
>  	    type != IOMMU_DOMAIN_IDENTITY)
>  		return NULL;
>  
> +	if (s2 && s2->stage != ARM_SMMU_DOMAIN_S2)
> +		return NULL;
> +
>  	/*
>  	 * Allocate the domain and initialise some of its data structures.
>  	 * We can't really finalise the domain unless a master is given.
> @@ -2889,10 +2911,14 @@ __arm_smmu_domain_alloc(unsigned type,
>  	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
>  	if (!smmu_domain)
>  		return NULL;
> +	smmu_domain->s2 = s2;
>  	domain = &smmu_domain->domain;
>  
>  	domain->type = type;
> -	domain->ops = arm_smmu_ops.default_domain_ops;
> +	if (s2)
> +		domain->ops = &arm_smmu_nested_domain_ops;
> +	else
> +		domain->ops = arm_smmu_ops.default_domain_ops;
>  
>  	mutex_init(&smmu_domain->init_mutex);
>  	INIT_LIST_HEAD(&smmu_domain->devices);
> @@ -2923,8 +2949,16 @@ arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
>  	const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	unsigned type = IOMMU_DOMAIN_UNMANAGED;
> +	struct arm_smmu_domain *s2 = NULL;
> +
> +	if (parent) {
> +		if (parent->ops != arm_smmu_ops.default_domain_ops)
> +			return NULL;
> +		type = IOMMU_DOMAIN_NESTED;
> +		s2 = to_smmu_domain(parent);
> +	}
Please can you explain the (use) case where !parent. This creates an
unmanaged S1?

Thanks

Eric
>  
> -	return __arm_smmu_domain_alloc(type, NULL, master, user_cfg);
> +	return __arm_smmu_domain_alloc(type, s2, master, user_cfg);
>  }
>  
>  static struct iommu_ops arm_smmu_ops = {

