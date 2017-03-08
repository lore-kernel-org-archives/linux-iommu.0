From: Aleksey Makarov <aleksey.makarov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Report smmu type in dmesg
Date: Wed, 8 Mar 2017 16:25:24 +0100
Message-ID: <4a991323-1059-5f3c-0aa3-0ab0cb7bd3f1@linaro.org>
References: <20170306135833.21455-1-rrichter@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170306135833.21455-1-rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 03/06/2017 02:58 PM, Robert Richter wrote:
> The ARM SMMU detection especially depends from system firmware. For
> better diagnostic, log the detected type in dmesg.
>
> The smmu type's name is now stored in struct arm_smmu_type and ACPI
> code is modified to use that struct too. Rename ARM_SMMU_MATCH_DATA()
> macro to ARM_SMMU_TYPE() for better readability.
>
> Signed-off-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 61 ++++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index abf6496843a6..5c793b3d3173 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -366,6 +366,7 @@ struct arm_smmu_device {
>  	u32				options;
>  	enum arm_smmu_arch_version	version;
>  	enum arm_smmu_implementation	model;
> +	const char			*name;
>
>  	u32				num_context_banks;
>  	u32				num_s2_context_banks;
> @@ -1955,19 +1956,20 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>
> -struct arm_smmu_match_data {
> +struct arm_smmu_type {
>  	enum arm_smmu_arch_version version;
>  	enum arm_smmu_implementation model;
> +	const char *name;
>  };
>
> -#define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
> -static struct arm_smmu_match_data name = { .version = ver, .model = imp }
> +#define ARM_SMMU_TYPE(var, ver, imp, _name)	\
> +static struct arm_smmu_type var = { .version = ver, .model = imp, .name = _name }

Can we infer the _name from the name of var?

#define ARM_SMMU_TYPE(var, ver, imp)	\
static struct arm_smmu_type var = { .version = ver, .model = imp, .name = #var }

> -ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
> -ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> -ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> -ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> -ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> +ARM_SMMU_TYPE(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU, "smmu-generic-v1");
> +ARM_SMMU_TYPE(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU, "smmu-generic-v2");
> +ARM_SMMU_TYPE(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU, "arm-mmu401");
> +ARM_SMMU_TYPE(arm_mmu500, ARM_SMMU_V2, ARM_MMU500, "arm-mmu500");
> +ARM_SMMU_TYPE(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2, "cavium-smmuv2");

So that this change will not be required?

Thank you
Aleksey Makarov

>  static const struct of_device_id arm_smmu_of_match[] = {
>  	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
> @@ -1981,29 +1983,19 @@ static const struct of_device_id arm_smmu_of_match[] = {
>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>
>  #ifdef CONFIG_ACPI
> -static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
> +static struct arm_smmu_type *acpi_smmu_get_type(u32 model)
>  {
> -	int ret = 0;
> -
>  	switch (model) {
>  	case ACPI_IORT_SMMU_V1:
>  	case ACPI_IORT_SMMU_CORELINK_MMU400:
> -		smmu->version = ARM_SMMU_V1;
> -		smmu->model = GENERIC_SMMU;
> -		break;
> +		return &smmu_generic_v1;
>  	case ACPI_IORT_SMMU_V2:
> -		smmu->version = ARM_SMMU_V2;
> -		smmu->model = GENERIC_SMMU;
> -		break;
> +		return &smmu_generic_v2;
>  	case ACPI_IORT_SMMU_CORELINK_MMU500:
> -		smmu->version = ARM_SMMU_V2;
> -		smmu->model = ARM_MMU500;
> -		break;
> -	default:
> -		ret = -ENODEV;
> +		return &arm_mmu500;
>  	}
>
> -	return ret;
> +	return NULL;
>  }
>
>  static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> @@ -2013,14 +2005,18 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
>  	struct acpi_iort_node *node =
>  		*(struct acpi_iort_node **)dev_get_platdata(dev);
>  	struct acpi_iort_smmu *iort_smmu;
> -	int ret;
> +	struct arm_smmu_type *type;
>
>  	/* Retrieve SMMU1/2 specific data */
>  	iort_smmu = (struct acpi_iort_smmu *)node->node_data;
>
> -	ret = acpi_smmu_get_data(iort_smmu->model, smmu);
> -	if (ret < 0)
> -		return ret;
> +	type = acpi_smmu_get_type(iort_smmu->model);
> +	if (!type)
> +		return -ENODEV;
> +
> +	smmu->version	= type->version;
> +	smmu->model	= type->model;
> +	smmu->name	= type->name;
>
>  	/* Ignore the configuration access interrupt */
>  	smmu->num_global_irqs = 1;
> @@ -2041,8 +2037,8 @@ static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
>  static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  				    struct arm_smmu_device *smmu)
>  {
> -	const struct arm_smmu_match_data *data;
>  	struct device *dev = &pdev->dev;
> +	const struct arm_smmu_type *type;
>  	bool legacy_binding;
>
>  	if (of_property_read_u32(dev->of_node, "#global-interrupts",
> @@ -2051,9 +2047,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  		return -ENODEV;
>  	}
>
> -	data = of_device_get_match_data(dev);
> -	smmu->version = data->version;
> -	smmu->model = data->model;
> +	type = of_device_get_match_data(dev);
> +	smmu->version	= type->version;
> +	smmu->model	= type->model;
> +	smmu->name	= type->name;
>
>  	parse_driver_options(smmu);
>
> @@ -2098,6 +2095,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>
> +	dev_notice(dev, "%s detected", smmu->name);
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	ioaddr = res->start;
>  	smmu->base = devm_ioremap_resource(dev, res);
>
