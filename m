Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7C1527B9
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488713; cv=none; b=WXE4UIuz/sch04rJGsJ+P2nr8Y/PA2WyRd5nIcwG00DsCfCvp/k29hfyzMEJ/pAX+Dw+5rHol31WvnNwpmFI9FTC8P0KGDPxZvgJfpAXudT2+vVBGSHuSVs65WOAUDMCW09c71P0pVvFxAKLPIG7lh5my52F9fug2J3v427wHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488713; c=relaxed/simple;
	bh=jjCyZv2gRniIb5ocEroF962SSiQFwEKEObx86oNxAuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEW2/oXBuAFfM3b7peliy5cMb770uQTURc3YgGBcboWAoyd+0NdH3aiyGd2KLkDYjtv9nKBphD0/2xO1A3acJMgZSBcYPg2JmJeBHiAe7iLUSTxPiUwWykVGrAkzsaQZDkr+wl72QfYsf7pNOKq1Re6s6PAGv5Esuma54RCMkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 416102F4;
	Tue, 30 Apr 2024 07:52:17 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03CEB3F793;
	Tue, 30 Apr 2024 07:51:48 -0700 (PDT)
Message-ID: <763b6968-e659-41df-8f56-4eff141297ea@arm.com>
Date: Tue, 30 Apr 2024 15:51:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] iommu/io-pgtable-arm: Add read_and_clear_dirty()
 support
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com, nicolinc@nvidia.com, mshavit@google.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, jiangkunkun@huawei.com,
 zhukeqian1@huawei.com, linuxarm@huawei.com
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240430134308.1604-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 14:43, Shameer Kolothum wrote:
> .read_and_clear_dirty() IOMMU domain op takes care of reading the dirty
> bits (i.e. PTE has DBM set and AP[2] clear) and marshalling into a
> bitmap of a given page size.
> 
> While reading the dirty bits we also set the PTE AP[2] bit to mark it
> as writable-clean depending on read_and_clear_dirty() flags.
> 
> PTE states with respect to DBM bit:
> 
>                        DBM bit        AP[2]("RDONLY" bit)
> 1. writable_clean        1                 1
> 2. writable_dirty        1                 0
> 3. read-only             0                 1
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Couple of nits/comments, but regardless:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  drivers/iommu/io-pgtable-arm.c | 105 ++++++++++++++++++++++++++++++++-
>  1 file changed, 103 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f7828a7aad41..da6cc52859ba 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -75,6 +75,7 @@
>  
>  #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
>  #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
> +#define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
>  #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
>  #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
>  #define ARM_LPAE_PTE_SH_OS		(((arm_lpae_iopte)2) << 8)
> @@ -84,7 +85,7 @@
>  
>  #define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
>  /* Ignore the contiguous bit for block splitting */
> -#define ARM_LPAE_PTE_ATTR_HI_MASK	(((arm_lpae_iopte)6) << 52)
> +#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
>  #define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
>  					 ARM_LPAE_PTE_ATTR_HI_MASK)
>  /* Software bit for solving coherency races */
> @@ -92,7 +93,11 @@
>  
>  /* Stage-1 PTE */
>  #define ARM_LPAE_PTE_AP_UNPRIV		(((arm_lpae_iopte)1) << 6)
> -#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)2) << 6)
> +#define ARM_LPAE_PTE_AP_RDONLY_BIT	7
> +#define ARM_LPAE_PTE_AP_RDONLY		(((arm_lpae_iopte)1) << \
> +					   ARM_LPAE_PTE_AP_RDONLY_BIT)
> +#define ARM_LPAE_PTE_AP_WRITABLE_CLEAN	(ARM_LPAE_PTE_AP_RDONLY | \
> +					 ARM_LPAE_PTE_DBM)
>  #define ARM_LPAE_PTE_ATTRINDX_SHIFT	2
>  #define ARM_LPAE_PTE_nG			(((arm_lpae_iopte)1) << 11)
>  
> @@ -138,6 +143,9 @@
>  
>  #define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
>  
> +#define iopte_hw_dirty(pte)	(((pte) & ARM_LPAE_PTE_AP_WRITABLE_CLEAN) == \
> +				   ARM_LPAE_PTE_DBM)

Could this simply be called "iopte_dirty"? The hw and sw dirty concept only come
about in the arch code because we keep an additional sw bit to track dirty in
the pte, which you are not doing here.

> +
>  struct arm_lpae_io_pgtable {
>  	struct io_pgtable	iop;
>  
> @@ -729,6 +737,98 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>  	return iopte_to_paddr(pte, data) | iova;
>  }
>  
> +struct io_pgtable_walk_data {
> +	struct iommu_dirty_bitmap	*dirty;
> +	unsigned long			flags;
> +	u64				addr;
> +	const u64			end;
> +};
> +
> +static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
> +				       struct io_pgtable_walk_data *walk_data,
> +				       arm_lpae_iopte *ptep,
> +				       int lvl);
> +
> +static int io_pgtable_visit_dirty(struct arm_lpae_io_pgtable *data,
> +				  struct io_pgtable_walk_data *walk_data,
> +				  arm_lpae_iopte *ptep, int lvl)
> +{
> +	struct io_pgtable *iop = &data->iop;
> +	arm_lpae_iopte pte = READ_ONCE(*ptep);
> +
> +	if (WARN_ON(!pte))

Wouldn't it actually be better to check that the pte is valid (i.e. bit 0 is
set)? And do we really need the warn here? I'm guessing you never expect to be
walking over a hole? - if it is legitimately possible to walk over a hole, then
the WARN is definitely incorrect and you would want to continue walking rather
than return.

> +		return -EINVAL;
> +
> +	if (iopte_leaf(pte, lvl, iop->fmt)) {
> +		size_t size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +
> +		if (iopte_hw_dirty(pte)) {
> +			iommu_dirty_bitmap_record(walk_data->dirty,
> +						  walk_data->addr, size);
> +			if (!(walk_data->flags & IOMMU_DIRTY_NO_CLEAR))
> +				set_bit(ARM_LPAE_PTE_AP_RDONLY_BIT,
> +					(unsigned long *)ptep);

Just checking, set_bit() is atomic right? So safe against racing updates with
the HW. Pretty sure that's the case...

> +		}
> +		walk_data->addr += size;
> +		return 0;
> +	}
> +
> +	ptep = iopte_deref(pte, data);
> +	return __arm_lpae_iopte_walk_dirty(data, walk_data, ptep, lvl + 1);
> +}
> +
> +static int __arm_lpae_iopte_walk_dirty(struct arm_lpae_io_pgtable *data,
> +				       struct io_pgtable_walk_data *walk_data,
> +				       arm_lpae_iopte *ptep,
> +				       int lvl)
> +{
> +	u32 idx;
> +	int max_entries, ret;
> +
> +	if (WARN_ON(lvl == ARM_LPAE_MAX_LEVELS))
> +		return -EINVAL;
> +
> +	if (lvl == data->start_level)
> +		max_entries = ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte);
> +	else
> +		max_entries = ARM_LPAE_PTES_PER_TABLE(data);
> +
> +	for (idx = ARM_LPAE_LVL_IDX(walk_data->addr, lvl, data);
> +	     (idx < max_entries) && (walk_data->addr < walk_data->end); ++idx) {
> +		ret = io_pgtable_visit_dirty(data, walk_data, ptep + idx, lvl);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
> +					 unsigned long iova, size_t size,
> +					 unsigned long flags,
> +					 struct iommu_dirty_bitmap *dirty)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	struct io_pgtable_walk_data walk_data = {
> +		.dirty = dirty,
> +		.flags = flags,
> +		.addr = iova,
> +		.end = iova + size,
> +	};
> +	arm_lpae_iopte *ptep = data->pgd;
> +	int lvl = data->start_level;
> +
> +	if (WARN_ON(!size))
> +		return -EINVAL;
> +	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
> +		return -EINVAL;
> +	if (data->iop.fmt != ARM_64_LPAE_S1)
> +		return -EINVAL;
> +
> +	return __arm_lpae_iopte_walk_dirty(data, &walk_data, ptep, lvl);
> +}
> +
>  static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
>  {
>  	unsigned long granule, page_sizes;
> @@ -807,6 +907,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>  		.map_pages	= arm_lpae_map_pages,
>  		.unmap_pages	= arm_lpae_unmap_pages,
>  		.iova_to_phys	= arm_lpae_iova_to_phys,
> +		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
>  	};
>  
>  	return data;

