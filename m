Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5036B0D
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aajbRa9v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701102920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=susxgUUvPMFkutjPWBrrSUKtFzx0kXy9jzHUt8UI4Uo=;
	b=aajbRa9v/KSrRwJuiEAdkrq9KL32eSHZVk6EZ6Itb7cScl/yG2mmc1Cei4MRy9WFyug1FN
	+GuxB8ClWKLYToJS+zcrPQ2ljVVJfMl2SPAW4e7MgONpofhBww2z6Gs+pwi+t5raY8Exc0
	PlbHlfSVA+JfeqPOiQ7vC1tlJHRuB+E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-ReYzlfavOlqa7mBrPiNERg-1; Mon, 27 Nov 2023 11:35:19 -0500
X-MC-Unique: ReYzlfavOlqa7mBrPiNERg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-679ceb85c6cso64059286d6.0
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 08:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102919; x=1701707719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=susxgUUvPMFkutjPWBrrSUKtFzx0kXy9jzHUt8UI4Uo=;
        b=ipzEPDLrHpgvdEqzKOBOzOqFfNxW7zaGD5kVnyEAWX4CayuYPjYDvfZllBJUWI3eTE
         JmEqF/hBxopInDg0j/zkWv2jU/A97gtK+rkvbdq+on97pyQ/RdZcQkysbpbHThbRBBYI
         kEtCNhreGkX78c5ZafELFfIgql4Avhlpj00PxCC2X0Em3USgv4i3OG8x1tEsfLAg2hET
         qmjKAGDj+X3Rtsw9qDP08KuGxZyqT/k3EsjzSNa1jzSGhsvvOVomJa4o5ahl07br0geP
         uyfOe/RNyrjk59AljRpUp9vdj0eA+qXppLGjFX5kUez/I9lByUH1gAAAj7PsfAvsLSFW
         mkxA==
X-Gm-Message-State: AOJu0YwGpB+EmHajDNehpb/Av949xZp16y20KXhbbyfdbfrx1oiF/MCx
	cM07ofXdD6CmriahiWGgqX9hGFAxEjHRnjSofubzMxArYWty8D4bohgWzYYnGAoZ0WUi/N/4986
	ohq1/FrGu0aatB80=
X-Received: by 2002:a05:6214:e62:b0:679:e2cb:2a30 with SMTP id jz2-20020a0562140e6200b00679e2cb2a30mr15109472qvb.52.1701102918939;
        Mon, 27 Nov 2023 08:35:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpcUvrZy7MUMrtsmfY5/NY1ufiYrppS50jGz4CSHhJceiWicX5v8fVoCq+ko4cKw0at/Uumw==
X-Received: by 2002:a05:6214:e62:b0:679:e2cb:2a30 with SMTP id jz2-20020a0562140e6200b00679e2cb2a30mr15109455qvb.52.1701102918692;
        Mon, 27 Nov 2023 08:35:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id gy4-20020a056214242400b0067a49af5ccfsm830912qvb.119.2023.11.27.08.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 08:35:18 -0800 (PST)
Message-ID: <08409d7b-369b-4696-97a4-29ce8e1ba549@redhat.com>
Date: Mon, 27 Nov 2023 17:35:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] iommu/arm-smmu-v3: Remove ARM_SMMU_DOMAIN_NESTED
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Cc: Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
References: <3-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <3-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/23 18:53, Jason Gunthorpe wrote:
> Currently this is exactly the same as ARM_SMMU_DOMAIN_S2, so just remove
> it. The ongoing work to add nesting support through iommufd will do
> something a little different.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9117e769a965e1..bf7218adbc2822 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1286,7 +1286,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			cd_table = &master->cd_table;
>  			break;
>  		case ARM_SMMU_DOMAIN_S2:
> -		case ARM_SMMU_DOMAIN_NESTED:
>  			s2_cfg = &smmu_domain->s2_cfg;
>  			break;
>  		default:
> @@ -2167,7 +2166,6 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>  		fmt = ARM_64_LPAE_S1;
>  		finalise_stage_fn = arm_smmu_domain_finalise_s1;
>  		break;
> -	case ARM_SMMU_DOMAIN_NESTED:
>  	case ARM_SMMU_DOMAIN_S2:
>  		ias = smmu->ias;
>  		oas = smmu->oas;
> @@ -2735,7 +2733,7 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
>  	if (smmu_domain->smmu)
>  		ret = -EPERM;
>  	else
> -		smmu_domain->stage = ARM_SMMU_DOMAIN_NESTED;
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
>  	mutex_unlock(&smmu_domain->init_mutex);
>  
>  	return ret;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 03f9e526cbd92f..27ddf1acd12cea 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -715,7 +715,6 @@ struct arm_smmu_master {
>  enum arm_smmu_domain_stage {
>  	ARM_SMMU_DOMAIN_S1 = 0,
>  	ARM_SMMU_DOMAIN_S2,
> -	ARM_SMMU_DOMAIN_NESTED,
>  	ARM_SMMU_DOMAIN_BYPASS,
>  };
>  

