Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC18F53;
	Thu,  6 Apr 2023 15:58:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A1A169E;
	Thu,  6 Apr 2023 08:59:17 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 195823F6C4;
	Thu,  6 Apr 2023 08:58:29 -0700 (PDT)
Message-ID: <b1cb0567-5c60-22ce-220d-65302b9f36ad@arm.com>
Date: Thu, 6 Apr 2023 16:58:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 06/17] iommu: Replace __iommu_group_dma_first_attach()
 with set_domain
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <6-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <6-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2023 12:38 am, Jason Gunthorpe wrote:
> Prepare for removing the group->domain set from
> iommu_group_alloc_default_domain() by calling
> __iommu_group_set_domain_internal() to set the group->domain.
> 
> Add IOMMU_SET_DOMAIN_WITH_DEFERRED to allow it to do the attach_deferred
> logic.

This is way overcomplicated; if we evaluate iommu_is_attach_deferred() 
earlier in the probe_device path, then the rest of the handling at the 
point of attach should simply reduce to:

	if (dev->iommu->attach_deferred && iommu_is_dma_domain(domain))
		return 0;

No magical flags required, and especially not the confusing thing with 
group-owner because the thing that still says it's for attaching the 
default domain now might also be attaching a non-default domain.

Thanks,
Robin.

> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd75d7405a3051..af3af752c255e4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -102,6 +102,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>   
>   enum {
>   	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
> +	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
>   };
>   
>   static int __iommu_group_set_domain_internal(struct iommu_group *group,
> @@ -1855,12 +1856,6 @@ static void probe_alloc_default_domain(struct bus_type *bus,
>   
>   }
>   
> -static int __iommu_group_dma_first_attach(struct iommu_group *group)
> -{
> -	return __iommu_group_for_each_dev(group, group->default_domain,
> -					  iommu_group_do_dma_first_attach);
> -}
> -
>   static int iommu_group_do_probe_finalize(struct device *dev, void *data)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
> @@ -1923,7 +1918,10 @@ int bus_iommu_probe(struct bus_type *bus)
>   
>   		iommu_group_create_direct_mappings(group);
>   
> -		ret = __iommu_group_dma_first_attach(group);
> +		group->domain = NULL;
> +		ret = __iommu_group_set_domain_internal(
> +			group, group->default_domain,
> +			IOMMU_SET_DOMAIN_WITH_DEFERRED);
>   
>   		mutex_unlock(&group->mutex);
>   
> @@ -2218,6 +2216,12 @@ static int __iommu_device_set_domain(struct iommu_group *group,
>   {
>   	int ret;
>   
> +	if ((flags & IOMMU_SET_DOMAIN_WITH_DEFERRED) &&
> +	    iommu_is_attach_deferred(dev)) {
> +		dev->iommu->attach_deferred = 1;
> +		return 0;
> +	}
> +
>   	ret = __iommu_attach_device(new_domain, dev);
>   	if (ret) {
>   		/*
