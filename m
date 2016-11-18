From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 11/16] drivers: iommu: arm-smmu-v3: add IORT
	configuration
Date: Fri, 18 Nov 2016 15:55:43 +0000
Message-ID: <20161118155543.GV13470@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
	<20161116152936.22955-12-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161116152936.22955-12-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
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

On Wed, Nov 16, 2016 at 03:29:31PM +0000, Lorenzo Pieralisi wrote:
> In ACPI bases systems, in order to be able to create platform
> devices and initialize them for ARM SMMU v3 components, the IORT
> kernel implementation requires a set of static functions to be
> used by the IORT kernel layer to configure platform devices for
> ARM SMMU v3 components.
> 
> Add static configuration functions to the IORT kernel layer for
> the ARM SMMU v3 components, so that the ARM SMMU v3 driver can
> initialize its respective platform device by relying on the IORT
> kernel infrastructure and by adding a corresponding ACPI device
> early probe section entry.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Reviewed-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c   | 103 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/iommu/arm-smmu-v3.c |  49 ++++++++++++++++++++-
>  2 files changed, 150 insertions(+), 2 deletions(-)

[...]

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index ed563307..9315bf3 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -20,6 +20,8 @@
>   * This driver is powered by bad coffee and bombay mix.
>   */
>  
> +#include <linux/acpi.h>
> +#include <linux/acpi_iort.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/err.h>
> @@ -2559,6 +2561,36 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> +				      struct arm_smmu_device *smmu,
> +				      bool *bypass)
> +{
> +	struct acpi_iort_smmu_v3 *iort_smmu;
> +	struct device *dev = smmu->dev;
> +	struct acpi_iort_node *node;
> +
> +	node = *(struct acpi_iort_node **)dev_get_platdata(dev);
> +
> +	/* Retrieve SMMUv3 specific data */
> +	iort_smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> +
> +	if (iort_smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE)
> +		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
> +
> +	*bypass = false;
> +
> +	return 0;
> +}
> +#else
> +static inline int arm_smmu_device_acpi_probe(struct platform_device *pdev,
> +					     struct arm_smmu_device *smmu,
> +					     bool *bypass)
> +{
> +	return -ENODEV;
> +}
> +#endif

Same bypass comments as before, but you'll probably need to do something
so that you *can* abort the probe if !ACPI, perhaps by allocating two
error codes to distinguish the "I no nothing about this SMMU" from "I know
enough to put it into bypass, but nothing more".

Will
