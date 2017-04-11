From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 3/7] iommu/arm-smmu-v3: Introduce smmu option
 USE_SHARED_IRQS for Silicon errata
Date: Tue, 11 Apr 2017 16:54:26 +0100
Message-ID: <b84e2383-1a65-3c5a-8e2c-28eafdb20adc@arm.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
 <1491921765-29475-4-git-send-email-linucherian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1491921765-29475-4-git-send-email-linucherian@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linucherian@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com
Cc: rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, linu.cherian@cavium.com, Geetha <gakula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On 11/04/17 15:42, linucherian@gmail.com wrote:
> From: Geetha <gakula@cavium.com>
> 
> Cavium 99xx SMMU implementation doesn't not support unique irq lines for
> gerror, eventq and cmdq-sync. USE_SHARED_IRQS option enables to use single
> irq line for all three interrupts.

AFAICS, there's nothing actually wrong with using shared wired IRQs -
the architecture spec doesn't appear to say anything about it. I think
it might suffice to simply add IRQF_SHARED if we can see the SMMU
doesn't support MSIs anyway - it doesn't really seem like something we
need to treat as a specific quirk.

> Signed-off-by: Geetha Sowjanya <gakula@cavium.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index b326195..1475ad8 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -415,6 +415,9 @@
>  #define ARM_SMMU_PAGE0_REGS_ONLY(s)		\
>  	((s)->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
>  
> +#define ARM_SMMU_USE_SHARED_IRQS(s)		\
> +	((s)->options & ARM_SMMU_OPT_USE_SHARED_IRQS)
> +
>  static bool disable_bypass;
>  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>  MODULE_PARM_DESC(disable_bypass,
> @@ -601,6 +604,7 @@ struct arm_smmu_device {
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
>  #define ARM_SMMU_OPT_PAGE0_REGS_ONLY    (1 << 1)
> +#define ARM_SMMU_OPT_USE_SHARED_IRQS    (1 << 2)
>  	u32				options;
>  
>  	struct arm_smmu_cmdq		cmdq;
> @@ -668,6 +672,7 @@ struct arm_smmu_option_prop {
>  static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
>  	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium-cn99xx,broken-page1-regspace"},
> +	{ ARM_SMMU_OPT_USE_SHARED_IRQS, "cavium-cn99xx,broken-unique-irqlines"},
>  	{ 0, NULL},
>  };
>  
> @@ -2237,6 +2242,7 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  {
>  	int ret, irq;
>  	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> +	u32 irqflags = IRQF_ONESHOT | IRQF_SHARED;

Either way, this is a really ugly way to go about it - I'd much rather
initialise the common base value:

	u32 irqflags = (definitely not an MSI) ? IRQF_SHARED : 0;

>  
>  	/* Disable IRQs first */
>  	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> @@ -2251,9 +2257,11 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  	/* Request interrupt lines */
>  	irq = smmu->evtq.q.irq;
>  	if (irq) {
> +		if (!ARM_SMMU_USE_SHARED_IRQS(smmu))
> +			irqflags = IRQF_ONESHOT;
>  		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
>  						arm_smmu_evtq_thread,
> -						IRQF_ONESHOT,

...and just pass irqflags | IRQF_ONESHOT here (and irqflags elsewhere),
without all the horrible copy-paste conditions.

Robin.

> +						irqflags,
>  						"arm-smmu-v3-evtq", smmu);
>  		if (ret < 0)
>  			dev_warn(smmu->dev, "failed to enable evtq irq\n");
> @@ -2261,8 +2269,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  
>  	irq = smmu->cmdq.q.irq;
>  	if (irq) {
> +		if (!ARM_SMMU_USE_SHARED_IRQS(smmu))
> +			irqflags = 0;
>  		ret = devm_request_irq(smmu->dev, irq,
> -				       arm_smmu_cmdq_sync_handler, 0,
> +				       arm_smmu_cmdq_sync_handler, irqflags,
>  				       "arm-smmu-v3-cmdq-sync", smmu);
>  		if (ret < 0)
>  			dev_warn(smmu->dev, "failed to enable cmdq-sync irq\n");
> @@ -2270,8 +2280,10 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  
>  	irq = smmu->gerr_irq;
>  	if (irq) {
> +		if (!ARM_SMMU_USE_SHARED_IRQS(smmu))
> +			irqflags = 0;
>  		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
> -				       0, "arm-smmu-v3-gerror", smmu);
> +				       irqflags, "arm-smmu-v3-gerror", smmu);
>  		if (ret < 0)
>  			dev_warn(smmu->dev, "failed to enable gerror irq\n");
>  	}
> 

