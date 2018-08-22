From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 5/5] iommu/arm-smmu-v3: add bootup option
 "iommu.non_strict"
Date: Wed, 22 Aug 2018 18:02:00 +0100
Message-ID: <29330cf7-d269-c4db-2f5a-632509058987@arm.com>
References: <1534296510-12888-1-git-send-email-thunder.leizhen@huawei.com>
 <1534296510-12888-6-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534296510-12888-6-git-send-email-thunder.leizhen@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Zhen Lei <thunder.leizhen@huawei.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: LinuxArm <linuxarm@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>, John Garry <john.garry@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On 15/08/18 02:28, Zhen Lei wrote:
> Add a bootup option to make the system manager can choose which mode to
> be used. The default mode is strict.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
>   drivers/iommu/arm-smmu-v3.c                     | 22 +++++++++++++++++++++-
>   2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 5cde1ff..cb9d043e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1720,6 +1720,19 @@
>   		nobypass	[PPC/POWERNV]
>   			Disable IOMMU bypass, using IOMMU for PCI devices.
> 
> +	iommu.non_strict=	[ARM64]
> +			Format: { "0" | "1" }
> +			0 - strict mode, default.
> +			    Release IOVAs after the related TLBs are invalid
> +			    completely.
> +			1 - non-strict mode.
> +			    Put off TLBs invalidation and release memory first.
> +			    It's good for scatter-gather performance but lacks
> +			    full isolation, an untrusted device can access the
> +			    reused memory because the TLBs may still valid.
> +			    Please take	full consideration before choosing this
> +			    mode. Note that, VFIO will always use strict mode.
> +
>   	iommu.passthrough=
>   			[ARM64] Configure DMA to bypass the IOMMU by default.
>   			Format: { "0" | "1" }
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 61eb7ec..0eda90e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -631,6 +631,26 @@ struct arm_smmu_option_prop {
>   	{ 0, NULL},
>   };
> 
> +static bool smmu_non_strict __read_mostly;
> +
> +static int __init arm_smmu_setup(char *str)
> +{
> +	int ret;
> +
> +	ret = kstrtobool(str, &smmu_non_strict);
> +	if (ret)
> +		return ret;
> +
> +	if (smmu_non_strict) {
> +		pr_warn("WARNING: iommu non-strict mode is chosen.\n"
> +			"It's good for scatter-gather performance but lacks full isolation\n");
> +		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
> +	}
> +
> +	return 0;
> +}
> +early_param("iommu.non_strict", arm_smmu_setup);

As I said on v3, the option should be parsed by iommu-dma, since that's 
where it takes effect, and I'm sure SMMUv2 users will be interested in 
trying it out too.

In other words, if iommu_dma_init_domain() does something like:

	if (iommu_dma_non_strict && domain->ops->flush_iotlb_all) {
		domain->non_strict = true;
		cookie->domain = domain;
		init_iova_flush_queue(...);
	}

> +
>   static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
>   						 struct arm_smmu_device *smmu)
>   {
> @@ -1622,7 +1642,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> 
> -	if (domain->type == IOMMU_DOMAIN_DMA) {
> +	if ((domain->type == IOMMU_DOMAIN_DMA) && smmu_non_strict) {
>   		domain->non_strict = true;
>   		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>   	}

...then all the driver should need to do is:

	if (domain->non_strict)
		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;


Now, that would make it possible to request non-strict mode even with 
drivers which *don't* understand it, but I think that's not actually 
harmful, just means that some TLBIs will still get issued synchronously 
and the flush queue might not do much. If you wanted to avoid even that, 
you could replace domain->non_strict with an iommu_domain_set_attr() 
call, so iommu_dma could tell up-front whether the driver understands 
non-strict mode and it's worth setting the queue up or not.

Robin.
