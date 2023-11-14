Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111941232
	for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-77896da2118so366232085a.1
        for <iommu@lists.linux.dev>; Tue, 14 Nov 2023 07:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699975034; x=1700579834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAzdt6JVu+8zpjX2fxJm6GnOJWLExS4LrswxE8RUMVM=;
        b=g+LPYp3E7tecObcMkA5XLP2cFlt/VOS0cpE9u5tBx154bZXZVUZdvz7HjMQeE0w0Y7
         egfizkArEbp9QnvArxslyhke9mUouRpPZ0TEwOGA8bTzW0kGnNFk3nYUa8iksz5Q04y3
         QkqEqXGIikkEWJGrmWVutgwuDPLVMFZ/OCv2zRE4X8OBck+ntGAvKHUMcodLXgouDUCf
         0LkDw6+1I1rvqNunIlID7GLDifSw2YWCG55IeLDNTWmVk3yCGAkwtCtVHW2oz4qIxStm
         5yeI2dMLb9YX8tM3/k4l3jFajbeiFNUKDbgFaNkVkPIGTKMTtSnB/U7iThb0nWgB9fEA
         123w==
X-Gm-Message-State: AOJu0YzstGQ65Ni47A3EQWmC1u8WY+ZEQjPry6ymmMeV6BCsl0QKCq9x
	wzOQukLg7QsBWTfxjHwV3QY=
X-Google-Smtp-Source: AGHT+IG7dg4d3lJHK2Z5QjydOqHp8/wiUSYvuoaII+i9nEC0HtfUy3PfbdN71yq06958YUaUrTDE8A==
X-Received: by 2002:a05:620a:3985:b0:778:9183:621b with SMTP id ro5-20020a05620a398500b007789183621bmr2024486qkn.28.1699975034504;
        Tue, 14 Nov 2023 07:17:14 -0800 (PST)
Received: from localhost ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id m12-20020ae9e70c000000b00775bb02893esm2733476qka.96.2023.11.14.07.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:17:14 -0800 (PST)
Date: Tue, 14 Nov 2023 07:17:12 -0800
From: Moritz Fischer <mdf@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 02/19] iommu/arm-smmu-v3: Master cannot be NULL in
 arm_smmu_write_strtab_ent()
Message-ID: <ZVOPeLOmRO9zd2hv@archbook>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <2-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>

On Mon, Nov 13, 2023 at 01:53:09PM -0400, Jason Gunthorpe wrote:
> The only caller is arm_smmu_install_ste_for_dev() which never has a NULL
> master. Remove the confusing if.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 519749d15fbda0..9117e769a965e1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1269,10 +1269,10 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  	 */
>  	u64 val = le64_to_cpu(dst->data[0]);
>  	bool ste_live = false;
> -	struct arm_smmu_device *smmu = NULL;
> +	struct arm_smmu_device *smmu = master->smmu;
>  	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
>  	struct arm_smmu_s2_cfg *s2_cfg = NULL;
> -	struct arm_smmu_domain *smmu_domain = NULL;
> +	struct arm_smmu_domain *smmu_domain = master->domain;
>  	struct arm_smmu_cmdq_ent prefetch_cmd = {
>  		.opcode		= CMDQ_OP_PREFETCH_CFG,
>  		.prefetch	= {
> @@ -1280,11 +1280,6 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  		},
>  	};
>  
> -	if (master) {
> -		smmu_domain = master->domain;
> -		smmu = master->smmu;
> -	}
> -
>  	if (smmu_domain) {
>  		switch (smmu_domain->stage) {
>  		case ARM_SMMU_DOMAIN_S1:
> -- 
> 2.42.0
> 
