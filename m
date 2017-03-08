From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Wed, 8 Mar 2017 13:38:42 +0000
Message-ID: <db1545e3-9851-47d2-e08b-4abaf619906b@arm.com>
References: <148885660307.28553.995847796823338863.sendpatchset@little-apple>
 <148885665352.28553.13907030016954382230.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <148885665352.28553.13907030016954382230.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>, joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

On 07/03/17 03:17, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Introduce an alternative set of iommu_ops suitable for 64-bit ARM
> as well as 32-bit ARM when CONFIG_IOMMU_DMA=y. Also adjust the
> Kconfig to depend on ARM or IOMMU_DMA. Initialize the device
> from ->xlate() when CONFIG_IOMMU_DMA=y.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Changes since V6:
>  - Rolled in the following patches from "r8a7795 support V2":
>    [PATCH v2 04/11] iommu/ipmmu-vmsa: Reuse iommu groups
>    [PATCH v2 06/11] iommu/ipmmu-vmsa: Teach xlate() to skip disabled iommus
>  - Moved find_group() implementation to prevent warning on 32-bit ARM
>  - Rolled in the following patch from "IPMMU slave device whitelist V2":
>    [PATCH/RFC v2 3/4] iommu/ipmmu-vmsa: Check devices in xlate()
> 
>  drivers/iommu/Kconfig      |    1 
>  drivers/iommu/ipmmu-vmsa.c |  164 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 157 insertions(+), 8 deletions(-)
> 
> --- 0001/drivers/iommu/Kconfig
> +++ work/drivers/iommu/Kconfig	2017-03-06 18:42:42.000000000 +0900
> @@ -274,6 +274,7 @@ config EXYNOS_IOMMU_DEBUG
>  
>  config IPMMU_VMSA
>  	bool "Renesas VMSA-compatible IPMMU"
> +	depends on ARM || IOMMU_DMA
>  	depends on ARM_LPAE
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	select IOMMU_API
> --- 0009/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2017-03-06 19:22:27.700607110 +0900
> @@ -10,6 +10,7 @@
>  
>  #include <linux/bitmap.h>
>  #include <linux/delay.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> @@ -22,8 +23,10 @@
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  
> +#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
>  #include <asm/dma-iommu.h>
>  #include <asm/pgalloc.h>
> +#endif
>  
>  #include "io-pgtable.h"
>  
> @@ -57,6 +60,8 @@ struct ipmmu_vmsa_archdata {
>  	struct ipmmu_vmsa_device *mmu;
>  	unsigned int *utlbs;
>  	unsigned int num_utlbs;
> +	struct device *dev;
> +	struct list_head list;
>  };
>  
>  static DEFINE_SPINLOCK(ipmmu_devices_lock);
> @@ -522,14 +527,6 @@ static struct iommu_domain *__ipmmu_doma
>  	return &domain->io_domain;
>  }
>  
> -static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> -{
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> -		return NULL;
> -
> -	return __ipmmu_domain_alloc(type);
> -}
> -
>  static void ipmmu_domain_free(struct iommu_domain *io_domain)
>  {
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
> @@ -572,6 +569,9 @@ static int ipmmu_attach_device(struct io
>  		dev_err(dev, "Can't attach IPMMU %s to domain on IPMMU %s\n",
>  			dev_name(mmu->dev), dev_name(domain->mmu->dev));
>  		ret = -EINVAL;
> +	} else {
> +			dev_info(dev, "Reusing IPMMU context %u\n",
> +				 domain->context_id);

Indentation?

>  	}
>  
>  	spin_unlock_irqrestore(&domain->lock, flags);
> @@ -708,6 +708,7 @@ static int ipmmu_init_platform_device(st
>  	archdata->mmu = mmu;
>  	archdata->utlbs = utlbs;
>  	archdata->num_utlbs = num_utlbs;
> +	archdata->dev = dev;
>  	dev->archdata.iommu = archdata;
>  	return 0;
>  
> @@ -716,6 +717,16 @@ error:
>  	return ret;
>  }
>  
> +#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
> +
> +static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> +{
> +	if (type != IOMMU_DOMAIN_UNMANAGED)
> +		return NULL;
> +
> +	return __ipmmu_domain_alloc(type);
> +}
> +
>  static int ipmmu_add_device(struct device *dev)
>  {
>  	struct ipmmu_vmsa_archdata *archdata;
> @@ -823,6 +834,141 @@ static const struct iommu_ops ipmmu_ops
>  	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
>  };
>  
> +#endif /* !CONFIG_ARM && CONFIG_IOMMU_DMA */
> +
> +#ifdef CONFIG_IOMMU_DMA
> +
> +static DEFINE_SPINLOCK(ipmmu_slave_devices_lock);
> +static LIST_HEAD(ipmmu_slave_devices);
> +
> +static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)
> +{
> +	struct iommu_domain *io_domain = NULL;
> +
> +	switch (type) {
> +	case IOMMU_DOMAIN_UNMANAGED:
> +		io_domain = __ipmmu_domain_alloc(type);
> +		break;
> +
> +	case IOMMU_DOMAIN_DMA:
> +		io_domain = __ipmmu_domain_alloc(type);
> +		if (io_domain)
> +			iommu_get_dma_cookie(io_domain);
> +		break;
> +	}
> +
> +	return io_domain;
> +}

I still think it would be tidier to put this logic straight into
__ipmmu_domain_alloc(), and use that directly as the callback for this
case. The ipmmu_domain_alloc() wrapper ensures that IOMMU_DOMAIN_DMA
can't be passed through in the legacy 32-bit case, and the cookie calls
are stubbed for !CONFIG_IOMMU_DMA so there are no build concerns.

> +static void ipmmu_domain_free_dma(struct iommu_domain *io_domain)
> +{
> +	switch (io_domain->type) {
> +	case IOMMU_DOMAIN_DMA:
> +		iommu_put_dma_cookie(io_domain);
> +		/* fall-through */
> +	default:
> +		ipmmu_domain_free(io_domain);
> +		break;
> +	}
> +}

And similarly. The day when 32-bit ARM gets cleaned up to use groups and
default domains properly creeps ever closer (the probe deferral series
looks on-track to finally get in this cycle), so the less fragmentation
and #ifdeffery to untangle at that point the better.

> +static int ipmmu_add_device_dma(struct device *dev)
> +{
> +	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct iommu_group *group;
> +
> +	/* The device has been verified in xlate() */
> +	if (!archdata)
> +		return -ENODEV;
> +
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +
> +	spin_lock(&ipmmu_slave_devices_lock);
> +	list_add(&archdata->list, &ipmmu_slave_devices);
> +	spin_unlock(&ipmmu_slave_devices_lock);
> +	return 0;
> +}
> +
> +static void ipmmu_remove_device_dma(struct device *dev)
> +{
> +	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +
> +	spin_lock(&ipmmu_slave_devices_lock);
> +	list_del(&archdata->list);
> +	spin_unlock(&ipmmu_slave_devices_lock);
> +
> +	iommu_group_remove_device(dev);
> +}
> +
> +static struct device *ipmmu_find_sibling_device(struct device *dev)
> +{
> +	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
> +	struct ipmmu_vmsa_archdata *sibling_archdata = NULL;
> +	bool found = false;
> +
> +	spin_lock(&ipmmu_slave_devices_lock);
> +
> +	list_for_each_entry(sibling_archdata, &ipmmu_slave_devices, list) {
> +		if (archdata == sibling_archdata)
> +			continue;
> +		if (sibling_archdata->mmu == archdata->mmu) {

So every master behind the same IPMMU gets put in the same group? In
that case, you don't need any of this machinery - you can simply keep
track of a group per IPMMU instance directly. See mtk_iommu.c for an
example.

> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	spin_unlock(&ipmmu_slave_devices_lock);
> +
> +	return found ? sibling_archdata->dev : NULL;
> +}
> +
> +static struct iommu_group *ipmmu_find_group_dma(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	struct device *sibling;
> +
> +	sibling = ipmmu_find_sibling_device(dev);
> +	if (sibling)
> +		group = iommu_group_get(sibling);
> +	if (!sibling || IS_ERR(group))
> +		group = generic_device_group(dev);
> +
> +	return group;
> +}
> +
> +static int ipmmu_of_xlate_dma(struct device *dev,
> +			      struct of_phandle_args *spec)
> +{
> +	/* If the IPMMU device is disabled in DT then return error
> +	 * to make sure the of_iommu code does not install ops
> +	 * even though the iommu device is disabled
> +	 */

If you're only calling iommu_device_register() from ipmmu_probe(), you
should never see that problem in the first place (because a disabled
node won't even get its platform device created, let alone probe a
driver). I guess this a leftover from when the init_fn once called
of_iommu_set_ops()?

Robin.

> +	if (!of_device_is_available(spec->np))
> +		return -ENODEV;
> +
> +	return ipmmu_init_platform_device(dev);
> +}
> +
> +static const struct iommu_ops ipmmu_ops = {
> +	.domain_alloc = ipmmu_domain_alloc_dma,
> +	.domain_free = ipmmu_domain_free_dma,
> +	.attach_dev = ipmmu_attach_device,
> +	.detach_dev = ipmmu_detach_device,
> +	.map = ipmmu_map,
> +	.unmap = ipmmu_unmap,
> +	.map_sg = default_iommu_map_sg,
> +	.iova_to_phys = ipmmu_iova_to_phys,
> +	.add_device = ipmmu_add_device_dma,
> +	.remove_device = ipmmu_remove_device_dma,
> +	.device_group = ipmmu_find_group_dma,
> +	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
> +	.of_xlate = ipmmu_of_xlate_dma,
> +};
> +
> +#endif /* CONFIG_IOMMU_DMA */
> +
>  /* -----------------------------------------------------------------------------
>   * Probe/remove and init
>   */
> @@ -912,7 +1058,9 @@ static int ipmmu_remove(struct platform_
>  	list_del(&mmu->list);
>  	spin_unlock(&ipmmu_devices_lock);
>  
> +#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
>  	arm_iommu_release_mapping(mmu->mapping);
> +#endif
>  
>  	ipmmu_device_reset(mmu);
>  
> 
