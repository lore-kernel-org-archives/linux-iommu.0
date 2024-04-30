Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E71527A3
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489530; cv=none; b=LFw5v4hGvtvWMuNNEYemFdcSPEz/WmOOVjjtRIH7ZSGBzvKoNCEC/V93OTA/7ZXP38A6qM5J40MiOJSnOmVDZXXRi7IyU98MrTsRSQWcXqsKWs/fPQshHAcLmKz3Uhko6Y7fz6fhycJjVPUepQFPK29ezB3WN3ix09fgcqrealk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489530; c=relaxed/simple;
	bh=zMFXbBi92uAugoF6aK7u2rpaLNepV6uvKnYll4Ww00E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnuFfNV9JjsB73w85DJ6XVjHKqCekPkHE+gdTOjf05oFtJXJFTjOMRzeWOapOcvDprU0quaz8cvYyFrfFZkpbHWmaiO6wpNBKqaBrpSzPRKMl1sMw0BMYDLzlJ504CPN40fUKyIN1XLtjQhX3BuoZmLcdUC9p4rNUOYPiTUe5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F9AE2F4;
	Tue, 30 Apr 2024 08:05:53 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06C1E3F793;
	Tue, 30 Apr 2024 08:05:24 -0700 (PDT)
Message-ID: <9ef76f06-9538-473c-9785-520350b1cee6@arm.com>
Date: Tue, 30 Apr 2024 16:05:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com, nicolinc@nvidia.com, mshavit@google.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, jiangkunkun@huawei.com,
 zhukeqian1@huawei.com, linuxarm@huawei.com
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 14:43, Shameer Kolothum wrote:
> From: Joao Martins <joao.m.martins@oracle.com>
> 
> This provides all the infrastructure to enable dirty tracking if the
> hardware has the capability and domain alloc request for it.
> 
> Please note, we still report no support for IOMMU_CAP_DIRTY_TRACKING
> as it will finally be enabled in a subsequent patch.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++++++++------
>  include/linux/io-pgtable.h                  |  4 +
>  2 files changed, 63 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index bed0183ba809..ad18436c5f7f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -38,6 +38,7 @@ MODULE_PARM_DESC(disable_msipolling,
>  	"Disable MSI-based polling for CMD_SYNC completion.");
>  
>  static struct iommu_ops arm_smmu_ops;
> +static struct iommu_dirty_ops arm_smmu_dirty_ops;
>  
>  enum arm_smmu_msi_index {
>  	EVTQ_MSI_INDEX,
> @@ -80,7 +81,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>  };
>  
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> -				    struct arm_smmu_device *smmu);
> +				    struct arm_smmu_device *smmu,
> +				    u32 flags);
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>  static void arm_smmu_tlb_inv_all_s2(struct arm_smmu_domain *smmu_domain);
>  
> @@ -2335,7 +2337,7 @@ static struct iommu_domain *arm_smmu_domain_alloc_paging(struct device *dev)
>  		struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  		int ret;
>  
> -		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
> +		ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, 0);
>  		if (ret) {
>  			kfree(smmu_domain);
>  			return ERR_PTR(ret);
> @@ -2408,13 +2410,14 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
>  }
>  
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> -				    struct arm_smmu_device *smmu)
> +				    struct arm_smmu_device *smmu,
> +				    u32 flags)
>  {
>  	int ret;
> -	unsigned long ias, oas;
>  	enum io_pgtable_fmt fmt;
>  	struct io_pgtable_cfg pgtbl_cfg;
>  	struct io_pgtable_ops *pgtbl_ops;
> +	bool enable_dirty = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>  
>  	/* Restrict the stage to what we can actually support */
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> @@ -2422,31 +2425,32 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>  		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>  
> +	pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	= smmu->pgsize_bitmap,
> +		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> +		.tlb		= &arm_smmu_flush_ops,
> +		.iommu_dev	= smmu->dev,
> +	};
> +
>  	switch (smmu_domain->stage) {
>  	case ARM_SMMU_DOMAIN_S1:
> -		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> -		ias = min_t(unsigned long, ias, VA_BITS);
> -		oas = smmu->ias;
> +		unsigned long ias = (smmu->features &
> +				     ARM_SMMU_FEAT_VAX) ? 52 : 48;
> +		pgtbl_cfg.ias = min_t(unsigned long, ias, VA_BITS);
> +		pgtbl_cfg.oas = smmu->ias;
> +		if (enable_dirty)
> +			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_HD;
>  		fmt = ARM_64_LPAE_S1;
>  		break;
>  	case ARM_SMMU_DOMAIN_S2:
> -		ias = smmu->ias;
> -		oas = smmu->oas;
> +		pgtbl_cfg.ias = smmu->ias;
> +		pgtbl_cfg.oas = smmu->oas;
>  		fmt = ARM_64_LPAE_S2;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	pgtbl_cfg = (struct io_pgtable_cfg) {
> -		.pgsize_bitmap	= smmu->pgsize_bitmap,
> -		.ias		= ias,
> -		.oas		= oas,
> -		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> -		.tlb		= &arm_smmu_flush_ops,
> -		.iommu_dev	= smmu->dev,
> -	};
> -
>  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>  	if (!pgtbl_ops)
>  		return -ENOMEM;
> @@ -2454,7 +2458,8 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	smmu_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>  	smmu_domain->domain.geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
>  	smmu_domain->domain.geometry.force_aperture = true;
> -
> +	if (enable_dirty && smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
> +		smmu_domain->domain.dirty_ops = &arm_smmu_dirty_ops;
>  	ret = arm_smmu_domain_alloc_id(smmu, smmu_domain);
>  	if (ret < 0) {
>  		free_io_pgtable_ops(pgtbl_ops);
> @@ -2777,7 +2782,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	mutex_lock(&smmu_domain->init_mutex);
>  
>  	if (!smmu_domain->smmu) {
> -		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
> +		ret = arm_smmu_domain_finalise(smmu_domain, smmu, 0);
>  	} else if (smmu_domain->smmu != smmu)
>  		ret = -EINVAL;
>  
> @@ -2842,7 +2847,7 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
>  
>  	mutex_lock(&smmu_domain->init_mutex);
>  	if (!smmu_domain->smmu)
> -		ret = arm_smmu_domain_finalise(smmu_domain, smmu);
> +		ret = arm_smmu_domain_finalise(smmu_domain, smmu, 0);
>  	else if (smmu_domain->smmu != smmu)
>  		ret = -EINVAL;
>  	mutex_unlock(&smmu_domain->init_mutex);
> @@ -3175,7 +3180,8 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  			   const struct iommu_user_data *user_data)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_NEST_PARENT;
> +	const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_NEST_PARENT |
> +				 IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>  	struct arm_smmu_domain *smmu_domain;
>  	int ret;
>  
> @@ -3188,6 +3194,10 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  	if (user_data)
>  		return ERR_PTR(-EINVAL);
>  
> +	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
> +	    !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	smmu_domain = arm_smmu_domain_alloc();
>  	if (!smmu_domain)
>  		return ERR_PTR(-ENOMEM);
> @@ -3203,7 +3213,7 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  
>  	smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>  	smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
> -	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu);
> +	ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, flags);
>  	if (ret)
>  		goto err_free;
>  	return &smmu_domain->domain;
> @@ -3479,6 +3489,27 @@ static void arm_smmu_release_device(struct device *dev)
>  	kfree(master);
>  }
>  
> +static int arm_smmu_read_and_clear_dirty(struct iommu_domain *domain,
> +					 unsigned long iova, size_t size,
> +					 unsigned long flags,
> +					 struct iommu_dirty_bitmap *dirty)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
> +
> +	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
> +}
> +
> +static int arm_smmu_set_dirty_tracking(struct iommu_domain *domain,
> +				       bool enabled)
> +{
> +	/*
> +	 * Always enabled and the dirty bitmap is cleared prior to
> +	 * set_dirty_tracking().
> +	 */
> +	return 0;
> +}
> +
>  static struct iommu_group *arm_smmu_device_group(struct device *dev)
>  {
>  	struct iommu_group *group;
> @@ -3622,6 +3653,11 @@ static struct iommu_ops arm_smmu_ops = {
>  	}
>  };
>  
> +static struct iommu_dirty_ops arm_smmu_dirty_ops = {
> +	.read_and_clear_dirty	= arm_smmu_read_and_clear_dirty,
> +	.set_dirty_tracking     = arm_smmu_set_dirty_tracking,
> +};
> +
>  /* Probing and initialisation functions */
>  static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
>  				   struct arm_smmu_queue *q,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 86cf1f7ae389..8e75f944f07a 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -85,6 +85,8 @@ struct io_pgtable_cfg {
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the outer-cacheability
>  	 *	attributes set in the TCR for a non-coherent page-table walker.
> +	 *
> +	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
>  	 */
>  	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
>  	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
> @@ -92,6 +94,8 @@ struct io_pgtable_cfg {
>  	#define IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT	BIT(4)
>  	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
>  	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
> +	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
> +
>  	unsigned long			quirks;
>  	unsigned long			pgsize_bitmap;
>  	unsigned int			ias;

