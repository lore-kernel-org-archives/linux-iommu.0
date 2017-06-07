From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 2/2] acpi/iort: numa: Add numa node mapping for smmuv3
 devices
Date: Wed, 7 Jun 2017 17:38:42 +0100
Message-ID: <20170607163842.GA7937@red-moon>
References: <1496746065-11082-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1496746065-11082-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496746065-11082-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, Will.Deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, lv.zheng@intel.com, joro@8bytes.org, rjw@rjwysocki.net, lenb@kernel.org, jnair@caviumnetworks.com, gpkulkarni@gmail.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 06, 2017 at 04:17:45PM +0530, Ganapatrao Kulkarni wrote:
> Add code to parse proximity domain in SMMUv3 IORT table to
> set numa node mapping for smmuv3 devices.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  drivers/acpi/arm64/iort.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index bba2b59..b4f328f 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -882,6 +882,23 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
>  	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
>  }
>  
> +/*
> + * set numa proximity domain for smmv3 device
> + */
> +static void  __init iort_set_proximity(struct acpi_iort_node *node,
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
> @@ -1002,6 +1019,9 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
>  	if (!pdev)
>  		return -ENOMEM;
>  
> +	if (node->type == ACPI_IORT_NODE_SMMU_V3)
> +		iort_set_proximity(node, &pdev->dev);

Nit: while at it you may add an ops hook to set the proximity
(NULL for SMMU v2) and call it if present, it is just to make
the code adding devices more uniform.

Who is queueing these patches ? I am asking to make sure we sort
the ACPICA dependency (there are other IORT/ACPICA patches to consider
too).

Thanks,
Lorenzo

>  	count = ops->iommu_count_resources(node);
>  
>  	r = kcalloc(count, sizeof(*r), GFP_KERNEL);
> -- 
> 1.8.1.4
> 
