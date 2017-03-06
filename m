From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Report smmu type in dmesg
Date: Mon, 6 Mar 2017 18:22:08 +0000
Message-ID: <d055d4c2-4d06-caba-4d84-21c22718fe76@arm.com>
References: <20170306135833.21455-1-rrichter@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
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
To: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/03/17 13:58, Robert Richter wrote:
> The ARM SMMU detection especially depends from system firmware. For
> better diagnostic, log the detected type in dmesg.

This paragraph especially depends from grammar. I think.

> The smmu type's name is now stored in struct arm_smmu_type and ACPI
> code is modified to use that struct too. Rename ARM_SMMU_MATCH_DATA()
> macro to ARM_SMMU_TYPE() for better readability.
> =

> Signed-off-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 61 ++++++++++++++++++++++++------------------=
------
>  1 file changed, 30 insertions(+), 31 deletions(-)

That seems a relatively invasive diffstat for the sake of printing a
string once at boot time to what I can only assume is a small audience
of firmware developers who find "cat
/sys/firmware/devicetree/base/iommu*/compatible" (or the ACPI
equivalent) too hard ;)

Assuming there is a really good reason somewhere to justify this, I
still wonder if a simple self-contained "smmu->model to string" function
wouldn't do, if we really want to do this? Maybe it's not quite that
simple if the generic case needs to key off smmu->version as well, but
still. Arguably, just searching the of_match_table by model/version and
printing the corresponding DT compatible would do the job (given an
MMU-400 model to disambiguate those).

Either way it ought to be replacing the "SMMUv%d with:" message in
arm_smmu_device_cfg_probe() - this driver is noisy enough already
without starting to repeat itself.

> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index abf6496843a6..5c793b3d3173 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -366,6 +366,7 @@ struct arm_smmu_device {
>  	u32				options;
>  	enum arm_smmu_arch_version	version;
>  	enum arm_smmu_implementation	model;
> +	const char			*name;

If we are going to add a pointer to static implementation data, it may
as well be a "const arm_smmu_type *type" pointer to subsume version and
model as well.

>  =

>  	u32				num_context_banks;
>  	u32				num_s2_context_banks;
> @@ -1955,19 +1956,20 @@ static int arm_smmu_device_cfg_probe(struct arm_s=
mmu_device *smmu)
>  	return 0;
>  }
>  =

> -struct arm_smmu_match_data {
> +struct arm_smmu_type {
>  	enum arm_smmu_arch_version version;
>  	enum arm_smmu_implementation model;
> +	const char *name;
>  };
>  =

> -#define ARM_SMMU_MATCH_DATA(name, ver, imp)	\
> -static struct arm_smmu_match_data name =3D { .version =3D ver, .model =
=3D imp }
> +#define ARM_SMMU_TYPE(var, ver, imp, _name)	\
> +static struct arm_smmu_type var =3D { .version =3D ver, .model =3D imp, =
.name =3D _name }
>  =

> -ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
> -ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
> -ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
> -ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
> -ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
> +ARM_SMMU_TYPE(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU, "smmu-generic-=
v1");
> +ARM_SMMU_TYPE(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU, "smmu-generic-=
v2");
> +ARM_SMMU_TYPE(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU, "arm-mmu401");

Strictly, I think you mean "ARM=AE CoreLink=99 MMU-401". Printing the name
of a driver-internal structure looks like someone left a debugging hack in.

> +ARM_SMMU_TYPE(arm_mmu500, ARM_SMMU_V2, ARM_MMU500, "arm-mmu500");

And similarly. Of course, I'm not actually suggesting that using the
full marketing names of things is a great idea, but then again if we do
go naming specific IPs, and anyone gets sniffy about using the names
"properly", then guess what's going to get removed again? You'll always
find me firmly in the "easier not to go there" camp.

Robin.

> +ARM_SMMU_TYPE(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2, "cavium-smmuv2"=
);
>  =

>  static const struct of_device_id arm_smmu_of_match[] =3D {
>  	{ .compatible =3D "arm,smmu-v1", .data =3D &smmu_generic_v1 },
> @@ -1981,29 +1983,19 @@ static const struct of_device_id arm_smmu_of_matc=
h[] =3D {
>  MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
>  =

>  #ifdef CONFIG_ACPI
> -static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
> +static struct arm_smmu_type *acpi_smmu_get_type(u32 model)
>  {
> -	int ret =3D 0;
> -
>  	switch (model) {
>  	case ACPI_IORT_SMMU_V1:
>  	case ACPI_IORT_SMMU_CORELINK_MMU400:
> -		smmu->version =3D ARM_SMMU_V1;
> -		smmu->model =3D GENERIC_SMMU;
> -		break;
> +		return &smmu_generic_v1;
>  	case ACPI_IORT_SMMU_V2:
> -		smmu->version =3D ARM_SMMU_V2;
> -		smmu->model =3D GENERIC_SMMU;
> -		break;
> +		return &smmu_generic_v2;
>  	case ACPI_IORT_SMMU_CORELINK_MMU500:
> -		smmu->version =3D ARM_SMMU_V2;
> -		smmu->model =3D ARM_MMU500;
> -		break;
> -	default:
> -		ret =3D -ENODEV;
> +		return &arm_mmu500;
>  	}
>  =

> -	return ret;
> +	return NULL;
>  }
>  =

>  static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> @@ -2013,14 +2005,18 @@ static int arm_smmu_device_acpi_probe(struct plat=
form_device *pdev,
>  	struct acpi_iort_node *node =3D
>  		*(struct acpi_iort_node **)dev_get_platdata(dev);
>  	struct acpi_iort_smmu *iort_smmu;
> -	int ret;
> +	struct arm_smmu_type *type;
>  =

>  	/* Retrieve SMMU1/2 specific data */
>  	iort_smmu =3D (struct acpi_iort_smmu *)node->node_data;
>  =

> -	ret =3D acpi_smmu_get_data(iort_smmu->model, smmu);
> -	if (ret < 0)
> -		return ret;
> +	type =3D acpi_smmu_get_type(iort_smmu->model);
> +	if (!type)
> +		return -ENODEV;
> +
> +	smmu->version	=3D type->version;
> +	smmu->model	=3D type->model;
> +	smmu->name	=3D type->name;
>  =

>  	/* Ignore the configuration access interrupt */
>  	smmu->num_global_irqs =3D 1;
> @@ -2041,8 +2037,8 @@ static inline int arm_smmu_device_acpi_probe(struct=
 platform_device *pdev,
>  static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  				    struct arm_smmu_device *smmu)
>  {
> -	const struct arm_smmu_match_data *data;
>  	struct device *dev =3D &pdev->dev;
> +	const struct arm_smmu_type *type;
>  	bool legacy_binding;
>  =

>  	if (of_property_read_u32(dev->of_node, "#global-interrupts",
> @@ -2051,9 +2047,10 @@ static int arm_smmu_device_dt_probe(struct platfor=
m_device *pdev,
>  		return -ENODEV;
>  	}
>  =

> -	data =3D of_device_get_match_data(dev);
> -	smmu->version =3D data->version;
> -	smmu->model =3D data->model;
> +	type =3D of_device_get_match_data(dev);
> +	smmu->version	=3D type->version;
> +	smmu->model	=3D type->model;
> +	smmu->name	=3D type->name;
>  =

>  	parse_driver_options(smmu);
>  =

> @@ -2098,6 +2095,8 @@ static int arm_smmu_device_probe(struct platform_de=
vice *pdev)
>  	if (err)
>  		return err;
>  =

> +	dev_notice(dev, "%s detected", smmu->name);
> +
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	ioaddr =3D res->start;
>  	smmu->base =3D devm_ioremap_resource(dev, res);
> =
