Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B3333993
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883297; cv=none; b=EivB9tHazEooGvAUzYZJySAIpTVOpdsFNXlUnb7n0deaKiIceOvpppB2XpcT8APb8e2JLGWMVLl51xNqcD5IaLoG4NYAT8N6W6w6+0uiG2HL40pUNRa+WGM2q02z57FxgzgYkX1qjJswven16+QaYsMHYfPEwahIYQIHMMMJqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883297; c=relaxed/simple;
	bh=DocuAMvwyGGvfPytQrZOEeSJjFxS/MQqyrIdWeU3k8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X89Wbxl7sKV+kAT9v7PKpa7hIbFZQhgf2rC+F4kNj2oDGaT2f89zZMX7nDiIP9JQ1auzqwkTnO6Cmet3APRqb7rxwjstvTtQeKP2DBTAYe3X9tvZwTauo0+32ZXkm4nhSJUyL24vOamq8RPQVUNzDLS6ufKvImCgotu2ipqXySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13A02339;
	Tue, 23 Apr 2024 07:42:02 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E04F3F73F;
	Tue, 23 Apr 2024 07:41:32 -0700 (PDT)
Message-ID: <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
Date: Tue, 23 Apr 2024 15:41:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
 nicolinc@nvidia.com, mshavit@google.com, robin.murphy@arm.com,
 will@kernel.org, joao.m.martins@oracle.com, jiangkunkun@huawei.com,
 zhukeqian1@huawei.com, linuxarm@huawei.com
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm aiming to (slowly) get more involved with SMMU activities, although I'm sure
it will take a while to get up to speed and provide useful input. It was
suggested that this series would be a useful starting point to dip my toe in.
Please bear with me while I ask stupid questions...


On 22/02/2024 09:49, Shameer Kolothum wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> If the SMMU supports it and the kernel was built with HTTU support,
> Probe support for Hardware Translation Table Update (HTTU) which is
> essentially to enable hardware update of access and dirty flags.
> 
> Probe and set the smmu::features for Hardware Dirty and Hardware Access
> bits. This is in preparation, to enable it on the context descriptors of
> stage 1 format.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Except for the nit (feel free to ignore it), LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 ++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0606166a8781..bd30739e3588 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4196,6 +4196,28 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
>  	}
>  }
>  
> +static void arm_smmu_get_httu(struct arm_smmu_device *smmu, u32 reg)
> +{
> +	u32 fw_features = smmu->features & (ARM_SMMU_FEAT_HA | ARM_SMMU_FEAT_HD);
> +	u32 features = 0;
> +
> +	switch (FIELD_GET(IDR0_HTTU, reg)) {
> +	case IDR0_HTTU_ACCESS_DIRTY:
> +		features |= ARM_SMMU_FEAT_HD;
> +		fallthrough;
> +	case IDR0_HTTU_ACCESS:
> +		features |= ARM_SMMU_FEAT_HA;
> +	}
> +
> +	if (smmu->dev->of_node)
> +		smmu->features |= features;
> +	else if (features != fw_features)
> +		/* ACPI IORT sets the HTTU bits */
> +		dev_warn(smmu->dev,
> +			 "IDR0.HTTU overridden by FW configuration (0x%x)\n",
> +			 fw_features);
> +}
> +
>  static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  {
>  	u32 reg;
> @@ -4256,6 +4278,8 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  			smmu->features |= ARM_SMMU_FEAT_E2H;
>  	}
>  
> +	arm_smmu_get_httu(smmu, reg);
> +
>  	/*
>  	 * The coherency feature as set by FW is used in preference to the ID
>  	 * register, but warn on mismatch.
> @@ -4448,6 +4472,14 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
>  	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
>  		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>  
> +	switch (FIELD_GET(ACPI_IORT_SMMU_V3_HTTU_OVERRIDE, iort_smmu->flags)) {
> +	case IDR0_HTTU_ACCESS_DIRTY:
> +		smmu->features |= ARM_SMMU_FEAT_HD;
> +		fallthrough;
> +	case IDR0_HTTU_ACCESS:
> +		smmu->features |= ARM_SMMU_FEAT_HA;
> +	}
> +
>  	return 0;
>  }
>  #else
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 45bcd72fcda4..5e51a6c1d55f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -33,6 +33,9 @@
>  #define IDR0_ASID16			(1 << 12)
>  #define IDR0_ATS			(1 << 10)
>  #define IDR0_HYP			(1 << 9)
> +#define IDR0_HTTU			GENMASK(7, 6)
> +#define IDR0_HTTU_ACCESS		1
> +#define IDR0_HTTU_ACCESS_DIRTY		2
>  #define IDR0_COHACC			(1 << 4)
>  #define IDR0_TTF			GENMASK(3, 2)
>  #define IDR0_TTF_AARCH64		2
> @@ -668,6 +671,8 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_SVA		(1 << 17)
>  #define ARM_SMMU_FEAT_E2H		(1 << 18)
>  #define ARM_SMMU_FEAT_NESTING		(1 << 19)
> +#define ARM_SMMU_FEAT_HA		(1 << 20)
> +#define ARM_SMMU_FEAT_HD		(1 << 21)

nit: HA and HD are a bit opaque, at least to me. I guess they are HW Access and
HW Dirty? Perhaps ARM_SMMU_FEAT_HW_ACCESS and ARM_SMMU_FEAT_HW_DIRTY are more
expressive?

>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)

