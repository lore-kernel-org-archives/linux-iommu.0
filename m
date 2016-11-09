From: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 13/16] drivers: iommu: arm-smmu: add IORT configuration
Date: Wed, 9 Nov 2016 14:24:49 +0100
Message-ID: <f8ec1ef0-9fbd-7dd6-822a-ca91aafe986a@semihalf.com>
References: <20161018160414.1228-1-lorenzo.pieralisi@arm.com>
	<20161018160414.1228-14-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161018160414.1228-14-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

On 18.10.2016 18:04, Lorenzo Pieralisi wrote:
> In ACPI bases systems, in order to be able to create platform
> devices and initialize them for ARM SMMU components, the IORT
> kernel implementation requires a set of static functions to be
> used by the IORT kernel layer to configure platform devices for
> ARM SMMU components.
>
> Add static configuration functions to the IORT kernel layer for
> the ARM SMMU components, so that the ARM SMMU driver can
> initialize its respective platform device by relying on the IORT
> kernel infrastructure and by adding a corresponding ACPI device
> early probe section entry.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c  | 84 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/acpi_iort.h |  3 ++
>  3 files changed, 167 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ea90bc8..04cc5f7 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -548,6 +548,78 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
>  	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
>  }
>
[...]
> +
> +static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> +				      struct arm_smmu_device *smmu)
> +{
> +	struct device *dev = smmu->dev;
> +	struct acpi_iort_node *node =
> +		*(struct acpi_iort_node **)dev_get_platdata(dev);
> +	struct acpi_iort_smmu *iort_smmu;
> +	u64 *glb_irq;
> +	int ret;
> +
> +	/* Retrieve SMMU1/2 specific data */
> +	iort_smmu = (struct acpi_iort_smmu *)node->node_data;
> +
> +	ret = acpi_smmu_get_data(iort_smmu->model, &smmu->version,
> +						   &smmu->model);
> +	if (ret < 0)
> +		return ret;
> +
> +	glb_irq = ACPI_ADD_PTR(u64, iort_smmu,
> +			iort_smmu->global_interrupt_offset);

One bug that I found:

-	glb_irq = ACPI_ADD_PTR(u64, iort_smmu,
-			iort_smmu->global_interrupt_offset);
+	glb_irq = ACPI_ADD_PTR(u64, node,
+			iort_smmu->global_interrupt_offset);

With this fix, I run VM with several PCI devices (NIC, SATA) in 
passthrough mode successfully on ACPI host using ThunderX 1-socket board.

Also, for my tests I used Eric's patches:
https://github.com/eauger/linux/commits/v4.9-rc3-reserved-rfc-v2

Including bug fix above:
Tested-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org> for all series.

> +
> +	if (!IORT_IRQ_MASK(glb_irq[1]))	/* 0 means not implemented */
> +		smmu->num_global_irqs = 1;
> +	else
> +		smmu->num_global_irqs = 2;
> +
> +	if (iort_smmu->flags & ACPI_IORT_SMMU_COHERENT_WALK)
> +		smmu->features |= ARM_SMMU_FEAT_COHERENT_WALK;
> +
> +	return 0;
> +}
> +#else
> +static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> +					     struct arm_smmu_device *smmu)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +

Thanks,
Tomasz
