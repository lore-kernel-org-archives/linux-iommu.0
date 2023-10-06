Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7182F58
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 923ED11FB;
	Fri,  6 Oct 2023 05:06:49 -0700 (PDT)
Received: from [10.57.66.230] (unknown [10.57.66.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 612863F762;
	Fri,  6 Oct 2023 05:06:08 -0700 (PDT)
Message-ID: <b496eab7-c0fe-4dcb-adf9-f5460e4a8a28@arm.com>
Date: Fri, 6 Oct 2023 13:06:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] iommu: Restore SMMU "disable_bypass"
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <jroedel@suse.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Steven Price <steven.price@arm.com>
References: <7-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7-v1-cf5846854f51+6db3f-smmu_newapi_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-10-05 19:28, Jason Gunthorpe wrote:
> The module parameter "disable_bypass" changes the IOMMU configuration when
> using CONFIG_ARM_DMA_USE_IOMMU to establish a faulting/blocked domain when
> the ARM DMA ops are not being used.

Nothing to do with ARM DMA ops, it is purely about the behaviour for 
StreamIDs not attached to domains. This includes known StreamIDs during 
the window between SMMU initialisation and those devices first being 
probed and attached to something, but these days is mostly concerned 
with unknown StreamIDs that would never be attached either way.

If the driver *has* knowingly and willingly attached a device to an 
identity domain, that's fine.

Also we're now tantalisingly close to having ARM use regular default 
domains anyway - the full conversion to iommu-dma still depends on 
significant changes to the IOVA allocator, but I'm 99% sure I've got a 
viable intermediate step which at least gets it out of the way from the 
rest of the core API's PoV (probe/release shenanigans etc.). 
Furthermore I'd imagine that frankly the number of users of arm-smmu 
with 32-bit mainline kernels is, to within experimental error, 0, so 
honestly it's not worth complicating core code with this.

Thanks,
Robin.

> SMMU does this by defaulting the device configuration to faulting during
> probe. This keeps things faulting up until the ARM DMA ops first attach,
> then the faulting is lost.
> 
> Since we removed NULL domains and immediately attach an IDENTIY domain
> during probe this now doesn't work properly on either driver.
> 
> Reflect the SMMU module option to the core code and have it request a
> BLOCKED or IDENTITY domain directly, only for CONFIG_ARM_DMA_USE_IOMMU.
> 
> Fixes: 98ac73f99bc4 ("iommu: Require a default_domain for all iommu drivers")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c |  1 +
>   drivers/iommu/iommu.c                 | 23 ++++++++++++++++++++++-
>   include/linux/iommu.h                 |  2 ++
>   3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 4d69bb63ba1a3e..e164477a224dac 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2211,6 +2211,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   		return err;
>   	}
>   
> +	iommu_arm_disable_bypass |= disable_bypass;
>   	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>   	if (err) {
>   		dev_err(dev, "Failed to register iommu\n");
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index efa65b3d1bd405..e2798d8318b7bb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -46,6 +46,13 @@ static unsigned int iommu_def_domain_type __read_mostly;
>   static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
>   static u32 iommu_cmd_line __read_mostly;
>   
> +/*
> + * This supports the module option "disable_bypass" that ARM SMMU and SMMUv3
> + * drivers supported. It causes the default domain to be BLOCKED when
> + * CONFIG_ARM_DMA_USE_IOMMU.
> + */
> +bool iommu_arm_disable_bypass = false;
> +
>   struct iommu_group {
>   	struct kobject kobj;
>   	struct kobject *devices_kobj;
> @@ -1914,7 +1921,13 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>   	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
>   		static_assert(!(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) &&
>   				IS_ENABLED(CONFIG_IOMMU_DMA)));
> -		driver_type = IOMMU_DOMAIN_IDENTITY;
> +		if (!iommu_arm_disable_bypass ||
> +		    !group_iommu_ops(group)->blocked_domain)
> +			driver_type = IOMMU_DOMAIN_IDENTITY;
> +		else
> +			for_each_group_device(group, gdev)
> +				if (gdev->dev->iommu->require_direct)
> +					driver_type = IOMMU_DOMAIN_IDENTITY;
>   	}
>   
>   	for_each_group_device(group, gdev) {
> @@ -1932,6 +1945,14 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>   		}
>   	}
>   
> +	/*
> +	 * For iommu_arm_disable_bypass mode the driver is allowed to force
> +	 * IDENTITY, otherwise returning 0 from def_domain_type will mean
> +	 * BLOCKED.
> +	 */
> +	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU) && driver_type == 0)
> +		driver_type = IOMMU_DOMAIN_BLOCKED;
> +
>   	if (untrusted) {
>   		if (driver_type && driver_type != IOMMU_DOMAIN_DMA) {
>   			dev_err_ratelimited(
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e27d2e67e48ef7..c88150300bff71 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -42,6 +42,8 @@ struct iommu_sva;
>   struct iommu_fault_event;
>   struct iommu_dma_cookie;
>   
> +extern bool iommu_arm_disable_bypass;
> +
>   /* iommu fault flags */
>   #define IOMMU_FAULT_READ	0x0
>   #define IOMMU_FAULT_WRITE	0x1
