From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 7/7] iommu/arm-smmu: Support non-PCI devices with SMMUv3
Date: Tue, 14 Jun 2016 16:16:42 +0100
Message-ID: <20160614151642.GC16531@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
	<42a8a71932f766d70ea9dcae5d11d5f33dcc3652.1464966939.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <42a8a71932f766d70ea9dcae5d11d5f33dcc3652.1464966939.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[adding ThunderTown, since he might be able to test this for us]

On Fri, Jun 03, 2016 at 06:15:42PM +0100, Robin Murphy wrote:
> With the device <-> stream ID relationship suitably abstracted and
> of_xlate() hooked up, we no longer have any PCI-specifics in play,
> so adding support for the simpler kinds of platform device (a single
> unique stream ID each) becomes trivial; let's do it!
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v2: New. Consider this one "extra bonus material" as I'm not sure there
>     are even any suitable devices on our model to test it with (it
>     _should_ be OK, given that I know the basic infrastructure on either
>     side works...)
> 
>  drivers/iommu/Kconfig       |  2 +-
>  drivers/iommu/arm-smmu-v3.c | 36 ++++++++++++++++++++++++++++++------
>  2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index ad0860383cb3..d1c66afefeed 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -308,7 +308,7 @@ config ARM_SMMU
>  
>  config ARM_SMMU_V3
>  	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> -	depends on ARM64 && PCI
> +	depends on ARM64
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	select GENERIC_MSI_IRQ_DOMAIN
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 28dcc5ca237e..6379f0ab24fc 100644
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
> @@ -1773,6 +1775,22 @@ static void arm_smmu_remove_device(struct device *dev)
>  	iommu_group_remove_device(dev);
>  }
>  
> +static struct iommu_group *arm_smmu_device_group(struct device *dev)
> +{
> +	struct iommu_group *group;
> +
> +	/*
> +	 * We've currently no means of grouping non-PCI masters, so
> +	 * there'd better not be any non-unique stream IDs in the DT...
> +	 */

Worse: what if a SID in the DT aliases with a PCI master? It might be
nice to have some basic snity checking, at least.

Will
