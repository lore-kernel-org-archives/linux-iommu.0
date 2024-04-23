Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFC413B78A
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890722; cv=none; b=EEAh0iLYg/HYgfJWVsbG0YYRrvfMOyyvqcBMbdeDfuFXcWR/JEC9xmCFqWugHMNK/igFNTIlHH6MgbFiWlXRD1yRzOGkyV5YFdDb+4UIN8HcuXIeXm/FVSlcDPxW2zOeJ6Y72mEf1Tw6hbdfD192wsjlaefJdKiRVuAzTFQofxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890722; c=relaxed/simple;
	bh=F2c+j1eFb264T5jaXNxWKM1GSxYlUDY4grVbUBkFPpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CF4GbLHItCbKq0xFvs1LU8gxSxHQfnI0woTORyjDQUJ0+XbbKYNUvuRe/5X8LncuMxivqMLpSJvtWckWZ/nbwqo/3V0U+ggBRex2GANQEBNtJFCN9ijXXxDEbdNNNnhPElT5JZowuimM6fw5WANeoyYgdfvd+6FwgQ9Fy8iC9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B420339;
	Tue, 23 Apr 2024 09:45:47 -0700 (PDT)
Received: from [10.57.74.127] (unknown [10.57.74.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B556D3F7BD;
	Tue, 23 Apr 2024 09:45:17 -0700 (PDT)
Message-ID: <364b6a6f-048c-426c-a9c4-aabef551e0c0@arm.com>
Date: Tue, 23 Apr 2024 17:45:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
 nicolinc@nvidia.com, mshavit@google.com, robin.murphy@arm.com,
 will@kernel.org, joao.m.martins@oracle.com, jiangkunkun@huawei.com,
 zhukeqian1@huawei.com, linuxarm@huawei.com
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240222094923.33104-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/02/2024 09:49, Shameer Kolothum wrote:
> From: Kunkun Jiang <jiangkunkun@huawei.com>
> 
> If io-pgtable quirk flag indicates support for hardware update of
> dirty state, enable HA/HD bits in the SMMU CD and also set the DBM
> bit in the page descriptor.
> 
> And now report the dirty page tracking capability of SMMUv3.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Section 3.13 of the spec states: "Where translation tables are shared between
CDs that contain the same ASID (within a translation regime), the CD HA and HD
fields must be identical."

I don't think the way that smmu domains work, its possible to end up with a
single pgtable shared between multiple CDs? So the driver should be able to
guarantee this constraint is met?

Assuming yes:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 +++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
>  drivers/iommu/io-pgtable-arm.c              |  5 ++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 058bbb0dbe2e..4423cc7e48cf 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1271,6 +1271,12 @@ void arm_smmu_make_s1_cd(struct arm_smmu_cd *target,
>  		CTXDESC_CD_0_ASET |
>  		FIELD_PREP(CTXDESC_CD_0_ASID, smmu_domain->asid)
>  		);
> +
> +	/* To enable dirty flag update, set both Access flag and dirty state update */
> +	if (pgtbl_cfg->quirks & IO_PGTABLE_QUIRK_ARM_HD)
> +		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA |
> +					       CTXDESC_CD_0_TCR_HD);
> +
>  	target->data[1] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.ttbr &
>  				      CTXDESC_CD_1_TTB0_MASK);
>  	target->data[3] = cpu_to_le64(pgtbl_cfg->arm_lpae_s1_cfg.mair);
> @@ -2307,6 +2313,13 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
>  	.tlb_add_page	= arm_smmu_tlb_inv_page_nosync,
>  };
>  
> +static bool arm_smmu_dbm_capable(struct arm_smmu_device *smmu)
> +{
> +	u32 features = (ARM_SMMU_FEAT_HD | ARM_SMMU_FEAT_COHERENCY);
> +
> +	return (smmu->features & features) == features;
> +}
> +
>  /* IOMMU API */
>  static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  {
> @@ -2319,6 +2332,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>  	case IOMMU_CAP_NOEXEC:
>  	case IOMMU_CAP_DEFERRED_FLUSH:
>  		return true;
> +	case IOMMU_CAP_DIRTY_TRACKING:
> +		return arm_smmu_dbm_capable(master->smmu);
>  	default:
>  		return false;
>  	}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 5e51a6c1d55f..a9cd805e5a1b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -313,6 +313,9 @@ struct arm_smmu_cd {
>  #define CTXDESC_CD_0_TCR_IPS		GENMASK_ULL(34, 32)
>  #define CTXDESC_CD_0_TCR_TBI0		(1ULL << 38)
>  
> +#define CTXDESC_CD_0_TCR_HA            (1UL << 43)
> +#define CTXDESC_CD_0_TCR_HD            (1UL << 42)
> +
>  #define CTXDESC_CD_0_AA64		(1UL << 41)
>  #define CTXDESC_CD_0_S			(1UL << 44)
>  #define CTXDESC_CD_0_R			(1UL << 45)
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 1ce7b7a3c1e8..56e88e555fc7 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -429,6 +429,8 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  		pte = ARM_LPAE_PTE_nG;
>  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>  			pte |= ARM_LPAE_PTE_AP_RDONLY;
> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
> +			pte |= ARM_LPAE_PTE_AP_WRITABLE;
>  		if (!(prot & IOMMU_PRIV))
>  			pte |= ARM_LPAE_PTE_AP_UNPRIV;
>  	} else {
> @@ -948,7 +950,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>  
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
>  			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
> -			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
> +			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
> +			    IO_PGTABLE_QUIRK_ARM_HD))
>  		return NULL;
>  
>  	data = arm_lpae_alloc_pgtable(cfg);

