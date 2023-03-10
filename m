Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3F8493
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678466367;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2rMsg6t2gpViRN6bqN88ZiiAOU5boBM+zQvjcM7TMo=;
	b=Bz+rXBjPhg+S3sugJcJWVIsad5znj4PrQfUTFF6ly6I1k762IhIvYIEhwmZKdQ24bfvNCQ
	K/nanyVNuACBqtvjS7EwSTUARgNEHQ1FIGowNc3562+MndaOVh9X2yv2LD9bBmG1eYsPS7
	0rlJjKb11vFcV5OOMXQUzq1BtJC1aZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-dIjSMT3qP_CJIjSyok_PwA-1; Fri, 10 Mar 2023 11:39:26 -0500
X-MC-Unique: dIjSMT3qP_CJIjSyok_PwA-1
Received: by mail-wm1-f70.google.com with SMTP id az12-20020a05600c600c00b003e8910ec2fdso2028234wmb.6
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 08:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2rMsg6t2gpViRN6bqN88ZiiAOU5boBM+zQvjcM7TMo=;
        b=58xU+LyqJ8i8LeLlLgE6E/zdULG398r9iTSjiZSttFA8kLUmMEPNxrX9d0aX/Ai2dK
         vGb/cqHRvg1kzXwDAA3UumC3nwBq9AIU5zpJRJ0dj1RISQoGsdogmSFPsTWJEdRjX8HM
         IkvqaBaWGlsuQBZqlG7gB6QzKCWs2+JL2OaKLm0Xvjz1QXSd2QhKSlIOKT5e8GHfEK15
         oHsQeOMFZlSjg98nh4grqabfugn5ZsGg2fDzfBHXlV6K16l/X1OqhB6ciQtnrH9rOOMT
         5GclBULS6OVNKsuhEXtBDexe+RpcDLEaCXXSZbEPgTN96fy+4xBqmo/KCy9YOp1+8u+1
         0v9g==
X-Gm-Message-State: AO0yUKUHlfbdjkW8FCy568apRzHYbd60cPoaiu+ZJ/zg6q/6iVCGQyw9
	RjhitVtKzC/393eCuR7fr4q0p9+uGwEM29g21jgQJ1L0FEnICEHjLpwhbanLdgpRMNmKeBHGUGz
	L0XP0M/6epjXdFB0=
X-Received: by 2002:a05:600c:ccf:b0:3eb:36fa:b78d with SMTP id fk15-20020a05600c0ccf00b003eb36fab78dmr3280359wmb.23.1678466364783;
        Fri, 10 Mar 2023 08:39:24 -0800 (PST)
X-Google-Smtp-Source: AK7set83LJfy7UcSeciFVaK0LlOXd8mOfJpZCllpxwIk2za7QGb9MdB56MsPoQHTRXi3GIMHfwS0rA==
X-Received: by 2002:a05:600c:ccf:b0:3eb:36fa:b78d with SMTP id fk15-20020a05600c0ccf00b003eb36fab78dmr3280348wmb.23.1678466364527;
        Fri, 10 Mar 2023 08:39:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bcb0a000000b003e11ad0750csm305406wmj.47.2023.03.10.08.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:39:24 -0800 (PST)
Message-ID: <1c18d68c-a20d-0f6d-4bf7-56f40557d151@redhat.com>
Date: Fri, 10 Mar 2023 17:39:22 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 05/14] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, robin.murphy@arm.com,
 will@kernel.org
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <c62c9405ff31ab3c97a9165ff710dce68217fe22.1678348754.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <c62c9405ff31ab3c97a9165ff710dce68217fe22.1678348754.git.nicolinc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolin,

On 3/9/23 11:53, Nicolin Chen wrote:
> IOMMUFD designs two iommu_domain pointers to represent two stages. The S1
s/designs/uses?
> iommu_domain (IOMMU_DOMAIN_NESTED type) represents the Context Descriptor
> table in the user space. The S2 iommu_domain (IOMMU_DOMAIN_UNMANAGED type)
> represents the translation table in the kernel, owned by a hypervisor.
>
> So there comes to no use case of the ARM_SMMU_DOMAIN_NESTED. Drop it, and
> use the type IOMMU_DOMAIN_NESTED instead.
last sentence may be rephrased as this patch does not use
IOMMU_DOMAIN_NESTED anywhere:
Generic IOMMU_DOMAIN_NESTED type will be used in nested SMMU
implementation instead.
>
> Also drop the unused arm_smmu_enable_nesting(). One following patche will
> configure the correct smmu_domain->stage.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 ------------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 -
If you go this way you may also remove it from arm/arm-smmu/arm-smmu.c.
Then if I am not wrong no other driver does implement enable_nesting cb.
Shouldn't we also remove it and fellow iommu_enable_nesting()?

Thanks

Eric
>  2 files changed, 19 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index c1aac695ae0d..c5616145e2a3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1279,7 +1279,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			s1_cfg = &smmu_domain->s1_cfg;
>  			break;
>  		case ARM_SMMU_DOMAIN_S2:
> -		case ARM_SMMU_DOMAIN_NESTED:
>  			s2_cfg = &smmu_domain->s2_cfg;
>  			break;
>  		default:
> @@ -2220,7 +2219,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>  		fmt = ARM_64_LPAE_S1;
>  		finalise_stage_fn = arm_smmu_domain_finalise_s1;
>  		break;
> -	case ARM_SMMU_DOMAIN_NESTED:
>  	case ARM_SMMU_DOMAIN_S2:
>  		ias = smmu->ias;
>  		oas = smmu->oas;
> @@ -2747,21 +2745,6 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>  	return group;
>  }
>  
> -static int arm_smmu_enable_nesting(struct iommu_domain *domain)
> -{
> -	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> -	int ret = 0;
> -
> -	mutex_lock(&smmu_domain->init_mutex);
> -	if (smmu_domain->smmu)
> -		ret = -EPERM;
> -	else
> -		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
> -	mutex_unlock(&smmu_domain->init_mutex);
> -
> -	return ret;
> -}
> -
>  static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  {
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
> @@ -2890,7 +2873,6 @@ static struct iommu_ops arm_smmu_ops = {
>  		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
>  		.iotlb_sync		= arm_smmu_iotlb_sync,
>  		.iova_to_phys		= arm_smmu_iova_to_phys,
> -		.enable_nesting		= arm_smmu_enable_nesting,
>  		.free			= arm_smmu_domain_free,
>  	}
>  };
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index ba2b4562f4b2..233bfc377267 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -704,7 +704,6 @@ struct arm_smmu_master {
>  enum arm_smmu_domain_stage {
>  	ARM_SMMU_DOMAIN_S1 = 0,
>  	ARM_SMMU_DOMAIN_S2,
> -	ARM_SMMU_DOMAIN_NESTED,
>  	ARM_SMMU_DOMAIN_BYPASS,
>  };
>  

