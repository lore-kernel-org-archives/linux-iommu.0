Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE7EA8
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 08:06:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AC6A11FB;
	Tue, 22 Aug 2023 01:07:26 -0700 (PDT)
Received: from [10.57.5.95] (unknown [10.57.5.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3833D3F64C;
	Tue, 22 Aug 2023 01:06:44 -0700 (PDT)
Message-ID: <4e785061-b35b-774b-be06-2f2529de7774@arm.com>
Date: Tue, 22 Aug 2023 09:06:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 04/14] iommu/amd: Refactor protection domain allocation
 code
Content-Language: en-GB
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com,
 jgg@ziepe.ca, Jason Gunthorpe <jgg@nvidia.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
 <20230821104227.706997-5-vasant.hegde@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230821104227.706997-5-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-08-21 11:42, Vasant Hegde wrote:
> To replace if-else with switch-case statement due to increasing number of
> domain types.
> 
> No functional changes intended.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>   drivers/iommu/amd/iommu.c | 45 +++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c2cb541b0553..d5569eec0fe9 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2078,24 +2078,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>   	struct io_pgtable_ops *pgtbl_ops;
>   	struct protection_domain *domain;
>   	int pgtable;
> -	int mode = DEFAULT_PGTABLE_LEVEL;
>   	int ret;
>   
> -	/*
> -	 * Force IOMMU v1 page table when iommu=pt and
> -	 * when allocating domain for pass-through devices.
> -	 */
> -	if (type == IOMMU_DOMAIN_IDENTITY) {
> -		pgtable = AMD_IOMMU_V1;
> -		mode = PAGE_MODE_NONE;
> -	} else if (type == IOMMU_DOMAIN_UNMANAGED) {
> -		pgtable = AMD_IOMMU_V1;
> -	} else if (type == IOMMU_DOMAIN_DMA || type == IOMMU_DOMAIN_DMA_FQ) {
> -		pgtable = amd_iommu_pgtable;
> -	} else {
> -		return NULL;
> -	}
> -
>   	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>   	if (!domain)
>   		return NULL;
> @@ -2106,27 +2090,42 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>   
>   	spin_lock_init(&domain->lock);
>   	INIT_LIST_HEAD(&domain->dev_list);
> +	domain->nid = NUMA_NO_NODE;
> +
> +	switch (type) {
> +	/* No need to allocate io pgtable ops in passthrough mode */
> +	case IOMMU_DOMAIN_IDENTITY:
> +		return domain;
> +	case IOMMU_DOMAIN_DMA:
> +	case IOMMU_DOMAIN_DMA_FQ:

Nit: drivers won't see DMA_FQ any more, so you don't need it here (looks 
like the addition of the original line above crossed over with me 
removing it from other drivers).

Thanks,
Robin.

> +		pgtable = amd_iommu_pgtable;
> +		break;
> +	/*
> +	 * Force IOMMU v1 page table when allocating
> +	 * domain for pass-through devices.
> +	 */
> +	case IOMMU_DOMAIN_UNMANAGED:
> +		pgtable = AMD_IOMMU_V1;
> +		break;
> +	default:
> +		goto out_err;
> +	}
>   
>   	switch (pgtable) {
>   	case AMD_IOMMU_V1:
> -		ret = protection_domain_init_v1(domain, mode);
> +		ret = protection_domain_init_v1(domain, DEFAULT_PGTABLE_LEVEL);
>   		break;
>   	case AMD_IOMMU_V2:
>   		ret = protection_domain_init_v2(domain);
>   		break;
>   	default:
>   		ret = -EINVAL;
> +		break;
>   	}
>   
>   	if (ret)
>   		goto out_err;
>   
> -	/* No need to allocate io pgtable ops in passthrough mode */
> -	if (type == IOMMU_DOMAIN_IDENTITY)
> -		return domain;
> -
> -	domain->nid = NUMA_NO_NODE;
> -
>   	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
>   	if (!pgtbl_ops) {
>   		domain_id_free(domain->id);
