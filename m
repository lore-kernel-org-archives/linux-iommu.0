Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D06FA2
	for <iommu@lists.linux.dev>; Tue, 22 Aug 2023 09:19:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 031D911FB;
	Tue, 22 Aug 2023 02:20:09 -0700 (PDT)
Received: from [10.57.5.95] (unknown [10.57.5.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3EC3F64C;
	Tue, 22 Aug 2023 02:19:26 -0700 (PDT)
Message-ID: <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
Date: Tue, 22 Aug 2023 10:19:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in struct
 io_pgtable_cfg
Content-Language: en-GB
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: joro@8bytes.org, jean-philippe@linaro.org, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <cover.1692693557.git.nicolinc@nvidia.com>
 <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0fe68babdb3a07adf024ed471fead4e3eb7e703f.1692693557.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-08-22 09:45, Nicolin Chen wrote:
> Add a new nents_per_pgtable in struct io_pgtable_cfg to store the number
> of entries per IO pagetable, so it can be passed back to an IOMMU driver.
> It will be used by one of the following changes to set the maximum number
> of TLBI operations in the arm-smmu-v3 driver.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/io-pgtable-arm.c | 3 +++
>   include/linux/io-pgtable.h     | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 72dcdd468cf3..7583d9ecca2b 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -891,6 +891,7 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>   
>   	/* TTBR */
>   	cfg->arm_lpae_s1_cfg.ttbr = virt_to_phys(data->pgd);
> +	cfg->nents_per_pgtable = 1 << data->bits_per_level;
>   	return &data->iop;
>   
>   out_free_data:
> @@ -993,6 +994,7 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
>   
>   	/* VTTBR */
>   	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd);
> +	cfg->nents_per_pgtable = 1 << data->bits_per_level;
>   	return &data->iop;
>   
>   out_free_data:
> @@ -1071,6 +1073,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>   					  ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
>   	if (cfg->coherent_walk)
>   		cfg->arm_mali_lpae_cfg.transtab |= ARM_MALI_LPAE_TTBR_SHARE_OUTER;
> +	cfg->nents_per_pgtable = 1 << data->bits_per_level;

The result of this highly complex and expensive calculation is clearly 
redundant with the existing bits_per_level field, so why do we need to 
waste space storing when the driver could simply use bits_per_level?

Thanks,
Robin.

>   	return &data->iop;
>   
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 1b7a44b35616..4b55a327abc1 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -55,6 +55,7 @@ struct iommu_flush_ops {
>    *                 tables.
>    * @ias:           Input address (iova) size, in bits.
>    * @oas:           Output address (paddr) size, in bits.
> + * @nents_per_pgtable: Number of entries per page table.
>    * @coherent_walk  A flag to indicate whether or not page table walks made
>    *                 by the IOMMU are coherent with the CPU caches.
>    * @tlb:           TLB management callbacks for this set of tables.
> @@ -96,6 +97,7 @@ struct io_pgtable_cfg {
>   	unsigned long			pgsize_bitmap;
>   	unsigned int			ias;
>   	unsigned int			oas;
> +	unsigned int			nents_per_pgtable;
>   	bool				coherent_walk;
>   	const struct iommu_flush_ops	*tlb;
>   	struct device			*iommu_dev;
