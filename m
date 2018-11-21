From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv4 2/2] iommu/arm-smmu: Get clock config from device tree
Date: Wed, 21 Nov 2018 17:48:55 +0000
Message-ID: <20181121174843.GD9801@arm.com>
References: <1538773020-27784-1-git-send-email-thor.thayer@linux.intel.com>
 <1538773020-27784-3-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1538773020-27784-3-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thor.thayer@linux.intel.com
Cc: dinguyen@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com, joro@8bytes.org, aisheng.dong@nxp.com, sboyd@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, vivek.gautam@codeaurora.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Thor,

On Fri, Oct 05, 2018 at 03:57:00PM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Currently the clocks are specified in a structure as well as
> in the device tree. Since all the information about clocks can be
> pulled from the device tree, parse the device tree for the clock
> information if specified.
> 
> This patch is dependent upon the following patch series that
> adds clocks to the driver.
> "[v16,0/5] iommu/arm-smmu: Add runtime pm/sleep support"
> https://patchwork.kernel.org/cover/10581891/
> 
> particularly this patch which adds the clocks:
> "[v16,1/5] iommu/arm-smmu: Add pm_runtime/sleep ops"
> https://patchwork.kernel.org/patch/10581899/
> 
> Request testing on different platforms for verification.
> This patch was tested on a Stratix10 SOCFPGA.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v4  Change dependency on pending patch series that adds clocks.
>     Add code for parsing device tree for the clocks.
> v3  Change dependency on device tree bulk clock patches.
> v2  Add structure for SOCFPGA and add dependency on clock patch.
> ---
>  drivers/iommu/arm-smmu.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index d315ca637097..3dd10663b09c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -44,6 +44,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_clk.h>
>  #include <linux/of_device.h>
>  #include <linux/of_iommu.h>
>  #include <linux/pci.h>
> @@ -2139,6 +2140,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	const struct arm_smmu_match_data *data;
>  	struct device *dev = &pdev->dev;
>  	bool legacy_binding;
> +	const char **parent_names;
>  
>  	if (of_property_read_u32(dev->of_node, "#global-interrupts",
>  				 &smmu->num_global_irqs)) {
> @@ -2149,9 +2151,25 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	data = of_device_get_match_data(dev);
>  	smmu->version = data->version;
>  	smmu->model = data->model;
> -	smmu->num_clks = data->num_clks;
> -
> -	arm_smmu_fill_clk_data(smmu, data->clks);
> +	smmu->num_clks = of_clk_get_parent_count(dev->of_node);
> +	/* check to see if clocks were specified in DT */
> +	if (smmu->num_clks) {
> +		unsigned int i;
> +
> +		parent_names = kmalloc_array(smmu->num_clks,
> +					     sizeof(*parent_names),
> +					     GFP_KERNEL);
> +		if (!parent_names)
> +			goto fail_clk_name;
> +
> +		for (i = 0; i < smmu->num_clks; i++) {
> +			if (of_property_read_string_index(dev->of_node,
> +							  "clock-names", i,
> +							  &parent_names[i]))
> +				goto fail_clk_name;
> +		}
> +		arm_smmu_fill_clk_data(smmu, parent_names);
> +	}
>  
>  	parse_driver_options(smmu);
>  
> @@ -2171,6 +2189,12 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
>  
>  	return 0;
> +
> +fail_clk_name:
> +	kfree(parent_names);
> +	/* clock-names required for clocks in devm_clk_bulk_get() */
> +	dev_err(dev, "Error: clock-name required in device tree\n");

I think you can drop the "Error: " prefix here, but the rest of the patch
looks sensible to me. We just need to work out how this co-exists with
Vivek's approach of using match_data (see the other thread).

Will
