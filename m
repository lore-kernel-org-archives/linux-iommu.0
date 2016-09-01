From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 06/19] iommu/arm-smmu: Support non-PCI devices with
	SMMUv3
Date: Thu, 1 Sep 2016 18:08:57 +0100
Message-ID: <20160901170857.GQ6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<207d0ae38c5b01b7cf7e48231a4d01bac453b57c.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <207d0ae38c5b01b7cf7e48231a4d01bac453b57c.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 23, 2016 at 08:05:17PM +0100, Robin Murphy wrote:
> With the device <-> stream ID relationship suitably abstracted and
> of_xlate() hooked up, the PCI dependency now looks, and is, entirely
> arbitrary. Any bus using the of_dma_configure() mechanism will work,
> so extend support to the platform and AMBA buses which do just that.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig       |  2 +-
>  drivers/iommu/arm-smmu-v3.c | 40 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d432ca828472..8ee54d71c7eb 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -309,7 +309,7 @@ config ARM_SMMU
>  
>  config ARM_SMMU_V3
>  	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> -	depends on ARM64 && PCI
> +	depends on ARM64
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select GENERIC_MSI_IRQ_DOMAIN
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 094babff64a6..e0384f7afb03 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -35,6 +35,8 @@
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  
> +#include <linux/amba/bus.h>
> +
>  #include "io-pgtable.h"
>  
>  /* MMIO registers */
> @@ -1830,6 +1832,23 @@ static void arm_smmu_remove_device(struct device *dev)
>  	iommu_fwspec_free(dev);
>  }
>  
> +static struct iommu_group *arm_smmu_device_group(struct device *dev)
> +{
> +	struct iommu_group *group;
> +
> +	/*
> +	 * We don't support devices sharing stream IDs other than PCI RID
> +	 * aliases, since the necessary ID-to-device lookup becomes rather
> +	 * impractical given a potential sparse 32-bit stream ID space.
> +	 */
> +	if (dev_is_pci(dev))
> +		group = pci_device_group(dev);
> +	else
> +		group = generic_device_group(dev);
> +
> +	return group;
> +}

It's a pity that this ends up in the driver(s), but I can live with it
for now.

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Will
