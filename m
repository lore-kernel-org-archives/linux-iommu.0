From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 1/7] iommu/arm-smmu-v3: Introduce smmu option
 PAGE0_REGS_ONLY for Silicon errata.
Date: Tue, 11 Apr 2017 16:42:06 +0100
Message-ID: <d89ecbd2-ed1b-b13b-a7e4-ff2478655203@arm.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-2-git-send-email-linucherian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1491921765-29475-2-git-send-email-linucherian@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linucherian@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, linu.cherian@cavium.com
List-Id: iommu@lists.linux-foundation.org

On 11/04/17 15:42, linucherian@gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium 99xx SMMU implementation doesn't support page 1 register space
> and PAGE0_REGS_ONLY option will be enabled as an errata workaround.

Ugh :(

> This option when turned on, replaces all page 1 offsets used for
> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.

I think it might be neater to have something like:

arm_smmu_page1(smmu) {
	if (smmu->quirk)
		return smmu->base;
	return smmu->base + 64k;
}

and use it as the base in the appropriate places, rather than override
the individual registers. Much like ARM_SMMU_GR0_NS in the SMMUv2 driver.

Robin.

> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 05b4592..df9f27b 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -176,15 +176,15 @@
>  #define ARM_SMMU_CMDQ_CONS		0x9c
>  
>  #define ARM_SMMU_EVTQ_BASE		0xa0
> -#define ARM_SMMU_EVTQ_PROD		0x100a8
> -#define ARM_SMMU_EVTQ_CONS		0x100ac
> +#define ARM_SMMU_EVTQ_PROD(s)	        (page1_offset_adjust(0x100a8, s))
> +#define ARM_SMMU_EVTQ_CONS(s)		(page1_offset_adjust(0x100ac, s))
>  #define ARM_SMMU_EVTQ_IRQ_CFG0		0xb0
>  #define ARM_SMMU_EVTQ_IRQ_CFG1		0xb8
>  #define ARM_SMMU_EVTQ_IRQ_CFG2		0xbc
>  
>  #define ARM_SMMU_PRIQ_BASE		0xc0
> -#define ARM_SMMU_PRIQ_PROD		0x100c8
> -#define ARM_SMMU_PRIQ_CONS		0x100cc
> +#define ARM_SMMU_PRIQ_PROD(s)		(page1_offset_adjust(0x100c8, s))
> +#define ARM_SMMU_PRIQ_CONS(s)		(page1_offset_adjust(0x100cc, s))
>  #define ARM_SMMU_PRIQ_IRQ_CFG0		0xd0
>  #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
>  #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
> @@ -412,6 +412,9 @@
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
>  
> +#define ARM_SMMU_PAGE0_REGS_ONLY(s)		\
> +	((s)->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
> +
>  static bool disable_bypass;
>  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>  MODULE_PARM_DESC(disable_bypass,
> @@ -597,6 +600,7 @@ struct arm_smmu_device {
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> +#define ARM_SMMU_OPT_PAGE0_REGS_ONLY    (1 << 1)
>  	u32				options;
>  
>  	struct arm_smmu_cmdq		cmdq;
> @@ -663,9 +667,19 @@ struct arm_smmu_option_prop {
>  
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> +	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium-cn99xx,broken-page1-regspace"},
>  	{ 0, NULL},
>  };
>  
> +static inline unsigned long page1_offset_adjust(
> +	unsigned long off, struct arm_smmu_device *smmu)
> +{
> +	if (!ARM_SMMU_PAGE0_REGS_ONLY(smmu))
> +		return off;
> +	else
> +		return (off - SZ_64K);
> +}
> +
>  static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>  {
>  	return container_of(dom, struct arm_smmu_domain, domain);
> @@ -1983,8 +1997,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  		return ret;
>  
>  	/* evtq */
> -	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, ARM_SMMU_EVTQ_PROD,
> -				      ARM_SMMU_EVTQ_CONS, EVTQ_ENT_DWORDS);
> +	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q,
> +				      ARM_SMMU_EVTQ_PROD(smmu),
> +				      ARM_SMMU_EVTQ_CONS(smmu),
> +				      EVTQ_ENT_DWORDS);
>  	if (ret)
>  		return ret;
>  
> @@ -1992,8 +2008,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
>  
> -	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
> -				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS);
> +	return arm_smmu_init_one_queue(smmu, &smmu->priq.q,
> +				       ARM_SMMU_PRIQ_PROD(smmu),
> +				       ARM_SMMU_PRIQ_CONS(smmu),
> +				       PRIQ_ENT_DWORDS);
>  }
>  
>  static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> @@ -2360,8 +2378,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  
>  	/* Event queue */
>  	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
> -	writel_relaxed(smmu->evtq.q.prod, smmu->base + ARM_SMMU_EVTQ_PROD);
> -	writel_relaxed(smmu->evtq.q.cons, smmu->base + ARM_SMMU_EVTQ_CONS);
> +	writel_relaxed(smmu->evtq.q.prod, smmu->base +
> +		       ARM_SMMU_EVTQ_PROD(smmu));
> +	writel_relaxed(smmu->evtq.q.cons, smmu->base +
> +		       ARM_SMMU_EVTQ_CONS(smmu));
>  
>  	enables |= CR0_EVTQEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> @@ -2376,9 +2396,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  		writeq_relaxed(smmu->priq.q.q_base,
>  			       smmu->base + ARM_SMMU_PRIQ_BASE);
>  		writel_relaxed(smmu->priq.q.prod,
> -			       smmu->base + ARM_SMMU_PRIQ_PROD);
> +			       smmu->base + ARM_SMMU_PRIQ_PROD(smmu));
>  		writel_relaxed(smmu->priq.q.cons,
> -			       smmu->base + ARM_SMMU_PRIQ_CONS);
> +			       smmu->base + ARM_SMMU_PRIQ_CONS(smmu));
>  
>  		enables |= CR0_PRIQEN;
>  		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> 

