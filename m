From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/7 v5] iommu: arm-smmu: Add support for the fsl-mc bus
Date: Tue, 3 Jul 2018 17:01:49 +0100
Message-ID: <83174f21-50f3-2ed2-bf04-6136af591567@arm.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
	<1526824191-7000-5-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1526824191-7000-5-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, laurentiu.tudor-3arQi8VN3Tc@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 20/05/18 14:49, Nipun Gupta wrote:
> Implement bus specific support for the fsl-mc bus including
> registering arm_smmu_ops and bus specific device add operations.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu.c |  7 +++++++
>   drivers/iommu/iommu.c    | 21 +++++++++++++++++++++
>   include/linux/fsl/mc.h   |  8 ++++++++
>   include/linux/iommu.h    |  2 ++
>   4 files changed, 38 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 69e7c60..e1d5090 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -52,6 +52,7 @@
>   #include <linux/spinlock.h>
>   
>   #include <linux/amba/bus.h>
> +#include <linux/fsl/mc.h>
>   
>   #include "io-pgtable.h"
>   #include "arm-smmu-regs.h"
> @@ -1459,6 +1460,8 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>   
>   	if (dev_is_pci(dev))
>   		group = pci_device_group(dev);
> +	else if (dev_is_fsl_mc(dev))
> +		group = fsl_mc_device_group(dev);
>   	else
>   		group = generic_device_group(dev);
>   
> @@ -2037,6 +2040,10 @@ static void arm_smmu_bus_init(void)
>   		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>   	}
>   #endif
> +#ifdef CONFIG_FSL_MC_BUS
> +	if (!iommu_present(&fsl_mc_bus_type))
> +		bus_set_iommu(&fsl_mc_bus_type, &arm_smmu_ops);
> +#endif
>   }
>   
>   static int arm_smmu_device_probe(struct platform_device *pdev)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d2aa2320..6d4ce35 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -32,6 +32,7 @@
>   #include <linux/pci.h>
>   #include <linux/bitops.h>
>   #include <linux/property.h>
> +#include <linux/fsl/mc.h>
>   #include <trace/events/iommu.h>
>   
>   static struct kset *iommu_group_kset;
> @@ -987,6 +988,26 @@ struct iommu_group *pci_device_group(struct device *dev)
>   	return iommu_group_alloc();
>   }
>   
> +/* Get the IOMMU group for device on fsl-mc bus */
> +struct iommu_group *fsl_mc_device_group(struct device *dev)
> +{
> +	struct device *cont_dev = fsl_mc_cont_dev(dev);
> +	struct iommu_group *group;
> +
> +	/* Container device is responsible for creating the iommu group */
> +	if (fsl_mc_is_cont_dev(dev)) {

Why duplicate what fsl_mc_cont_dev() has already figured out?

AFAICS the overall operation here boils down to something like:

	cont_dev = fsl_mc_cont_dev(dev);
	group = iommu_group_get(cont_dev);
	if (!group)
		group = iommu_group_alloc();
	return group;

> +		group = iommu_group_alloc();
> +		if (IS_ERR(group))
> +			return NULL;

iommu_group_get_for_dev() expects a PTR_ERR, so I don't think munging 
the return here is the right thing to do.

> +	} else {
> +		get_device(cont_dev);

If races are a concern, isn't this a bit late? Maybe in that case you 
want {get,put}_fsl_mc_cont_dev() routines instead of the simple macro 
below. But on the other hand if dev already has cont_dev as its parent, 
wouldn't the reference taken in device_add() be sufficient to prevent it 
from vanishing unexpectedly in this timescale?

Robin.

> +		group = iommu_group_get(cont_dev);
> +		put_device(cont_dev);
> +	}
> +
> +	return group;
> +}
> +
>   /**
>    * iommu_group_get_for_dev - Find or create the IOMMU group for a device
>    * @dev: target device
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index f27cb14..dddaca1 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -351,6 +351,14 @@ struct fsl_mc_io {
>   #define dev_is_fsl_mc(_dev) (0)
>   #endif
>   
> +/* Macro to check if a device is a container device */
> +#define fsl_mc_is_cont_dev(_dev) (to_fsl_mc_device(_dev)->flags & \
> +	FSL_MC_IS_DPRC)
> +
> +/* Macro to get the container device of a MC device */
> +#define fsl_mc_cont_dev(_dev) (fsl_mc_is_cont_dev(_dev) ? \
> +	(_dev) : (_dev)->parent)
> +
>   /*
>    * module_fsl_mc_driver() - Helper macro for drivers that don't do
>    * anything special in module init/exit.  This eliminates a lot of
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19938ee..2981200 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -389,6 +389,8 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
>   extern struct iommu_group *pci_device_group(struct device *dev);
>   /* Generic device grouping function */
>   extern struct iommu_group *generic_device_group(struct device *dev);
> +/* FSL-MC device grouping function */
> +struct iommu_group *fsl_mc_device_group(struct device *dev);
>   
>   /**
>    * struct iommu_fwspec - per-device IOMMU instance data
> 
