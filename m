From: Robert Richter <robert.richter@cavium.com>
Subject: Re: [PATCH v3 2/7] iommu/arm-smmu-v3: Do resource size checks based
 on SMMU
Date: Sat, 6 May 2017 00:18:44 +0200
Message-ID: <20170505221844.GW16981@rric.localdomain>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-3-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493986091-30521-3-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On 05.05.17 17:38:06, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> With implementations supporting only page 0 register space,
> resource size can be 64k as well and hence perform size checks
> based on SMMU option PAGE0_REGS_ONLY.
> 
> For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
> platform_get_resource call, so that SMMU options are set beforehand.
> 
> Signed-off-by:  Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by:  Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 107b4a6..f027676 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2672,6 +2672,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static unsigned long arm_smmu_resource_size(struct arm_smmu_device *smmu)
> +{
> +	if (ARM_SMMU_PAGE0_REGS_ONLY(smmu))
> +		return SZ_64K;
> +	else
> +		return SZ_128K;
> +}
> +

I think this can be dropped. See below.

>  static int arm_smmu_device_probe(struct platform_device *pdev)
>  {
>  	int irq, ret;
> @@ -2688,9 +2696,17 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	}
>  	smmu->dev = dev;
>  
> +	if (dev->of_node) {
> +		ret = arm_smmu_device_dt_probe(pdev, smmu);
> +	} else {
> +		ret = arm_smmu_device_acpi_probe(pdev, smmu);
> +		if (ret == -ENODEV)
> +			return ret;
> +	}
> +
>  	/* Base address */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (resource_size(res) + 1 < SZ_128K) {
> +	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
>  		dev_err(dev, "MMIO region too small (%pr)\n", res);
>  		return -EINVAL;
>  	}

Why not just do the follwoing here:

 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
 	ioaddr = res->start;

+	/*
+	 * Override the size, for Cavium ThunderX2 implementation
+	 * which doesn't support the page 1 SMMU register space.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)
+		res->end = res->size + SZ_64K -1;
+
 	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);

Since we can drop patch #5 then, the fix would be isolated to this
file only. And we can use smmu->options as the onle check for this.

-Robert

> @@ -2717,14 +2733,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (irq > 0)
>  		smmu->gerr_irq = irq;
>  
> -	if (dev->of_node) {
> -		ret = arm_smmu_device_dt_probe(pdev, smmu);
> -	} else {
> -		ret = arm_smmu_device_acpi_probe(pdev, smmu);
> -		if (ret == -ENODEV)
> -			return ret;
> -	}
> -
>  	/* Set bypass mode according to firmware probing result */
>  	bypass = !!ret;
>  
> -- 
> 1.8.3.1
> 
