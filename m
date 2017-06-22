From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v9 3/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #126
Date: Thu, 22 Jun 2017 19:22:26 +0100
Message-ID: <20170622182226.GH15336@arm.com>
References: <1498133138-20244-1-git-send-email-gakula@caviumnetworks.com>
 <1498133138-20244-4-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498133138-20244-4-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, robert.moore@intel.com, lv.zheng@intel.com, rjw@rjwysocki.net, jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, devel@acpica.org, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, robh@kernel.org, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

Hi Geetha,

On Thu, Jun 22, 2017 at 05:35:38PM +0530, Geetha sowjanya wrote:
> From: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> 
> Cavium ThunderX2 SMMU doesn't support MSI and also doesn't have unique irq
> lines for gerror, eventq and cmdq-sync.
> 
> New named irq "combined" is set as a errata workaround, which allows to
> share the irq line by register single irq handler for all the interrupts.
> 
> Signed-off-by: Geetha sowjanya <gakula@caviumnetworks.com>
> ---
>  Documentation/arm64/silicon-errata.txt             |    1 +
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    1 +
>  drivers/acpi/arm64/iort.c                          |   54 +++++++----
>  drivers/iommu/arm-smmu-v3.c                        |  105 +++++++++++++++-----
>  4 files changed, 116 insertions(+), 45 deletions(-)

Thanks, this looks much better. Two things to change below, and I'd like to
see Lorenzo ack the iort changes.

> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 4693a32..42422f6 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -63,6 +63,7 @@ stable kernels.
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
>  | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
> +| Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
>  |                |                 |                 |                             |
>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>  |                |                 |                 |                             |
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index 6ecc48c..a5a1ca4 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -26,6 +26,7 @@ the PCIe specification.
>                        * "priq"      - PRI Queue not empty
>                        * "cmdq-sync" - CMD_SYNC complete
>                        * "gerror"    - Global Error activated
> +                      * "combined"  - Handles above all 4 interrupts.

Please make it clear that:

  * The combined interrupt is optional, and should only be provided if
    the hardware supports just a single, combined interrupt line.

  * If provided, then the combined interrupt will be used in preference
    to any others.

>  - #iommu-cells      : See the generic IOMMU binding described in
>                          devicetree/bindings/pci/pci-iommu.txt
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c166f3e..43e1f13 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -828,6 +828,18 @@ static int __init arm_smmu_v3_count_resources(struct acpi_iort_node *node)
>  	return num_res;
>  }
>  
> +static bool arm_smmu_v3_is_combined_irq(struct acpi_iort_smmu_v3 *smmu)
> +{
> +	/*
> +	 * Cavium ThunderX2 implementation doesn't not support unique
> +	 * irq line. Use single irq line for all the SMMUv3 interrupts.
> +	 */
> +	if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
> +		return true;
> +
> +	return false;
> +}
> +
>  static unsigned long arm_smmu_v3_resource_size(struct acpi_iort_smmu_v3 *smmu)
>  {
>  	/*
> @@ -855,26 +867,32 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
>  	res[num_res].flags = IORESOURCE_MEM;
>  
>  	num_res++;
> -
> -	if (smmu->event_gsiv)
> -		acpi_iort_register_irq(smmu->event_gsiv, "eventq",
> -				       ACPI_EDGE_SENSITIVE,
> -				       &res[num_res++]);
> -
> -	if (smmu->pri_gsiv)
> -		acpi_iort_register_irq(smmu->pri_gsiv, "priq",
> -				       ACPI_EDGE_SENSITIVE,
> -				       &res[num_res++]);
> -
> -	if (smmu->gerr_gsiv)
> -		acpi_iort_register_irq(smmu->gerr_gsiv, "gerror",
> -				       ACPI_EDGE_SENSITIVE,
> -				       &res[num_res++]);
> -
> -	if (smmu->sync_gsiv)
> -		acpi_iort_register_irq(smmu->sync_gsiv, "cmdq-sync",
> +	if (arm_smmu_v3_is_combined_irq(smmu))
> +		acpi_iort_register_irq(smmu->event_gsiv, "combined",
>  				       ACPI_EDGE_SENSITIVE,
>  				       &res[num_res++]);
> +	else {
> +
> +		if (smmu->event_gsiv)
> +			acpi_iort_register_irq(smmu->event_gsiv, "eventq",
> +					       ACPI_EDGE_SENSITIVE,
> +					       &res[num_res++]);
> +
> +		if (smmu->pri_gsiv)
> +			acpi_iort_register_irq(smmu->pri_gsiv, "priq",
> +					       ACPI_EDGE_SENSITIVE,
> +					       &res[num_res++]);
> +
> +		if (smmu->gerr_gsiv)
> +			acpi_iort_register_irq(smmu->gerr_gsiv, "gerror",
> +					       ACPI_EDGE_SENSITIVE,
> +					       &res[num_res++]);
> +
> +		if (smmu->sync_gsiv)
> +			acpi_iort_register_irq(smmu->sync_gsiv, "cmdq-sync",
> +					       ACPI_EDGE_SENSITIVE,
> +					       &res[num_res++]);
> +	}
>  }
>  
>  static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2dea4a9..0f83f7d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -605,6 +605,7 @@ struct arm_smmu_device {
>  	struct arm_smmu_priq		priq;
>  
>  	int				gerr_irq;
> +	int				combined_irq;
>  
>  	unsigned long			ias; /* IPA */
>  	unsigned long			oas; /* PA */
> @@ -1314,6 +1315,29 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
> +{
> +	struct arm_smmu_device *smmu = dev;
> +
> +	arm_smmu_evtq_thread(irq, dev);
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		arm_smmu_priq_thread(irq, dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
> +{
> +	irqreturn_t ret;
> +
> +	ret = arm_smmu_gerror_handler(irq, dev);
> +	if (ret == IRQ_NONE) {

I don't think you can play that trick if the irq is an edge-triggered
interrupt, since you could lose an interrupt that fired whilst we were
in the handler.

The easiest thing is to always run the gerror and cmdq_sync handlers, and
then always return IRQ_WAKE_THREAD.

Will
