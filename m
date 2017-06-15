From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 2/2] acpi/iort: numa: Add numa node mapping for smmuv3
 devices
Date: Thu, 15 Jun 2017 14:46:03 +0100
Message-ID: <20170615134603.GA16292@red-moon>
References: <1496897059-8272-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1496897059-8272-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496897059-8272-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, lv.zheng@intel.com, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, Will.Deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, joro@8bytes.org, lenb@kernel.org, jnair@caviumnetworks.com, gpkulkarni@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi,

On Thu, Jun 08, 2017 at 10:14:19AM +0530, Ganapatrao Kulkarni wrote:
> Add code to parse proximity domain in SMMUv3 IORT table to
> set numa node mapping for smmuv3 devices.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/acpi/arm64/iort.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)

I am happy to take this but I want to know what we shall do with
patch 1 and related ACPICA changes first.

Thanks,
Lorenzo

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index bba2b59..e804386 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -882,6 +882,23 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
>  	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
>  }
>  
> +/*
> + * set numa proximity domain for smmuv3 device
> + */
> +static void  __init arm_smmu_v3_set_proximity(struct acpi_iort_node *node,
> +		struct device *dev)
> +{
> +	struct acpi_iort_smmu_v3 *smmu;
> +
> +	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> +	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
> +		set_dev_node(dev, acpi_map_pxm_to_node(smmu->pxm));
> +		pr_info("SMMUV3[%llx] Mapped to Proximity domain %d\n",
> +			smmu->base_address,
> +			smmu->pxm);
> +	}
> +}
> +
>  static int __init arm_smmu_count_resources(struct acpi_iort_node *node)
>  {
>  	struct acpi_iort_smmu *smmu;
> @@ -951,20 +968,24 @@ struct iort_iommu_config {
>  	int (*iommu_count_resources)(struct acpi_iort_node *node);
>  	void (*iommu_init_resources)(struct resource *res,
>  				     struct acpi_iort_node *node);
> +	void (*iommu_set_proximity)(struct acpi_iort_node *node,
> +				     struct device *dev);
>  };
>  
>  static const struct iort_iommu_config iort_arm_smmu_v3_cfg __initconst = {
>  	.name = "arm-smmu-v3",
>  	.iommu_is_coherent = arm_smmu_v3_is_coherent,
>  	.iommu_count_resources = arm_smmu_v3_count_resources,
> -	.iommu_init_resources = arm_smmu_v3_init_resources
> +	.iommu_init_resources = arm_smmu_v3_init_resources,
> +	.iommu_set_proximity = arm_smmu_v3_set_proximity
>  };
>  
>  static const struct iort_iommu_config iort_arm_smmu_cfg __initconst = {
>  	.name = "arm-smmu",
>  	.iommu_is_coherent = arm_smmu_is_coherent,
>  	.iommu_count_resources = arm_smmu_count_resources,
> -	.iommu_init_resources = arm_smmu_init_resources
> +	.iommu_init_resources = arm_smmu_init_resources,
> +	.iommu_set_proximity = NULL
>  };
>  
>  static __init
> @@ -1002,6 +1023,9 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
>  	if (!pdev)
>  		return -ENOMEM;
>  
> +	if (ops->iommu_set_proximity)
> +		ops->iommu_set_proximity(node, &pdev->dev);
> +
>  	count = ops->iommu_count_resources(node);
>  
>  	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
> -- 
> 1.8.1.4
> 
