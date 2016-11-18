From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 10/16] drivers: iommu: arm-smmu-v3: split probe
	functions into DT/generic portions
Date: Fri, 18 Nov 2016 15:44:13 +0000
Message-ID: <20161118154413.GU13470@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
	<20161116152936.22955-11-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161116152936.22955-11-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 16, 2016 at 03:29:30PM +0000, Lorenzo Pieralisi wrote:
> Current ARM SMMUv3 probe functions intermingle HW and DT probing in the
> initialization functions to detect and programme the ARM SMMU v3 driver
> features. In order to allow probing the ARM SMMUv3 with other firmwares
> than DT, this patch splits the ARM SMMUv3 init functions into DT and HW
> specific portions so that other FW interfaces (ie ACPI) can reuse the HW
> probing functions and skip the DT portion accordingly.
> 
> This patch implements no functional change, only code reshuffling.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Reviewed-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 46 +++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index e6e1c87..ed563307 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2381,10 +2381,10 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	return 0;
>  }
>  
> -static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
> +static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  {
>  	u32 reg;
> -	bool coherent;
> +	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
>  
>  	/* IDR0 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
> @@ -2436,13 +2436,9 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
>  		smmu->features |= ARM_SMMU_FEAT_HYP;
>  
>  	/*
> -	 * The dma-coherent property is used in preference to the ID
> +	 * The coherency feature as set by FW is used in preference to the ID
>  	 * register, but warn on mismatch.
>  	 */
> -	coherent = of_dma_is_coherent(smmu->dev->of_node);
> -	if (coherent)
> -		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
> -
>  	if (!!(reg & IDR0_COHACC) != coherent)
>  		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-coherent property (%s)\n",
>  			 coherent ? "true" : "false");
> @@ -2563,21 +2559,37 @@ static int arm_smmu_device_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> -static int arm_smmu_device_dt_probe(struct platform_device *pdev)
> +static int arm_smmu_device_dt_probe(struct platform_device *pdev,
> +				    struct arm_smmu_device *smmu,
> +				    bool *bypass)
>  {
> -	int irq, ret;
> -	struct resource *res;
> -	struct arm_smmu_device *smmu;
>  	struct device *dev = &pdev->dev;
> -	bool bypass = true;
>  	u32 cells;
>  
> +	*bypass = true;
> +
>  	if (of_property_read_u32(dev->of_node, "#iommu-cells", &cells))
>  		dev_err(dev, "missing #iommu-cells property\n");
>  	else if (cells != 1)
>  		dev_err(dev, "invalid #iommu-cells value (%d)\n", cells);
>  	else
> -		bypass = false;
> +		*bypass = false;
> +
> +	parse_driver_options(smmu);
> +
> +	if (of_dma_is_coherent(dev->of_node))
> +		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
> +
> +	return 0;

I know you're only moving code here, but the *bypass output parameter
now seems to be redundant with the unconditional return 0. Given that
we only set bypass to true if something went wrong, why don't we return
-ENODEV in those cases, kill the bypass parameter and rework the return
value check in the caller so that, rather than fail the probe, we pass
bypass=true to the reset function?

Will
