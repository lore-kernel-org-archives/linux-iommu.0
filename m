From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 05/07] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Fri, 21 Oct 2016 18:52:53 +0100
Message-ID: <941ff264-8f9f-e0e6-2b50-bdd3e19946e5@arm.com>
References: <20161019233533.10506.16810.sendpatchset@little-apple>
	<20161019233623.10506.49016.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161019233623.10506.49016.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 20/10/16 00:36, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Introduce an alternative set of iommu_ops suitable for 64-bit ARM
> as well as 32-bit ARM when CONFIG_IOMMU_DMA=y. Also adjust the
> Kconfig to depend on ARM or IOMMU_DMA.
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
> 
>  Changes since V5:
>  - Made domain allocation/free code more consistent - thanks Joerg!
> 
>  Changes since V4:
>  - Added Kconfig hunk to depend on ARM or IOMMU_DMA
> 
>  Changes since V3:
>  - Removed group parameter from ipmmu_init_platform_device()
> 
>  Changes since V2:
>  - Included this new patch from the following series:
>    [PATCH 00/04] iommu/ipmmu-vmsa: IPMMU CONFIG_IOMMU_DMA update
>  - Use only a single iommu_ops structure with #ifdef CONFIG_IOMMU_DMA
>  - Folded in #ifdefs to handle CONFIG_ARM and CONFIG_IOMMU_DMA
>  - of_xlate() is now used without #ifdefs
>  - Made sure code compiles on both 32-bit and 64-bit ARM.
> 
>  drivers/iommu/Kconfig      |    1 
>  drivers/iommu/ipmmu-vmsa.c |  122 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 115 insertions(+), 8 deletions(-)
> 
> --- 0001/drivers/iommu/Kconfig
> +++ work/drivers/iommu/Kconfig	2016-10-20 08:16:40.980607110 +0900
> @@ -274,6 +274,7 @@ config EXYNOS_IOMMU_DEBUG
>  
>  config IPMMU_VMSA
>  	bool "Renesas VMSA-compatible IPMMU"
> +	depends on ARM || IOMMU_DMA
>  	depends on ARM_LPAE
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	select IOMMU_API
> --- 0006/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-10-20 08:16:48.440607110 +0900
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
> @@ -520,14 +523,6 @@ static struct iommu_domain *__ipmmu_doma
>  	return &domain->io_domain;
>  }
>  
> -static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> -{
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> -		return NULL;

I *think* that if we did the initial check thus:

	if (type != IOMMU_DOMAIN_UNMANAGED ||
	    (IS_ENABLED(CONFIG_IOMMU_DMA) && type != IOMMU_DOMAIN_DMA))
		return NULL;

it shouldn't be necessary to split the function at all - we then just
wrap the {get,put}_cookie() bits in "if (type ==  IOMMU_DOMAIN_DMA)" and
in the 32-bit ARM case they just don't run as that can never be true.

> -
> -	return __ipmmu_domain_alloc(type);
> -}
> -
>  static void ipmmu_domain_free(struct iommu_domain *io_domain)
>  {
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
> @@ -714,6 +709,8 @@ error:
>  	return ret;
>  }
>  
> +#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
> +
>  static int ipmmu_add_device(struct device *dev)
>  {
>  	struct ipmmu_vmsa_archdata *archdata;
> @@ -807,6 +804,14 @@ static void ipmmu_remove_device(struct d
>  	dev->archdata.iommu = NULL;
>  }
>  
> +static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> +{
> +	if (type != IOMMU_DOMAIN_UNMANAGED)
> +		return NULL;
> +
> +	return __ipmmu_domain_alloc(type);
> +}
> +
>  static const struct iommu_ops ipmmu_ops = {
>  	.domain_alloc = ipmmu_domain_alloc,
>  	.domain_free = ipmmu_domain_free,
> @@ -821,6 +826,105 @@ static const struct iommu_ops ipmmu_ops
>  	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
>  };
>  
> +#endif /* !CONFIG_ARM && CONFIG_IOMMU_DMA */
> +
> +#ifdef CONFIG_IOMMU_DMA
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

Either way, this can fail (in fact if !CONFIG_IOMMU_DMA it can be relied
upon to).

Robin.

> +		break;
> +	}
> +
> +	return io_domain;
> +}
> +
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
> +
> +static int ipmmu_add_device_dma(struct device *dev)
> +{
> +	struct iommu_group *group;
> +
> +	/* only accept devices with iommus property */
> +	if (of_count_phandle_with_args(dev->of_node, "iommus",
> +				       "#iommu-cells") < 0)
> +		return -ENODEV;
> +
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +
> +	return 0;
> +}
> +
> +static void ipmmu_remove_device_dma(struct device *dev)
> +{
> +	iommu_group_remove_device(dev);
> +}
> +
> +static struct iommu_group *ipmmu_device_group_dma(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int ret;
> +
> +	group = generic_device_group(dev);
> +	if (IS_ERR(group))
> +		return group;
> +
> +	ret = ipmmu_init_platform_device(dev);
> +	if (ret) {
> +		iommu_group_put(group);
> +		group = ERR_PTR(ret);
> +	}
> +
> +	return group;
> +}
> +
> +static int ipmmu_of_xlate_dma(struct device *dev,
> +			      struct of_phandle_args *spec)
> +{
> +	/* dummy callback to satisfy of_iommu_configure() */
> +	return 0;
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
> +	.device_group = ipmmu_device_group_dma,
> +	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
> +	.of_xlate = ipmmu_of_xlate_dma,
> +};
> +
> +#endif /* CONFIG_IOMMU_DMA */
> +
>  /* -----------------------------------------------------------------------------
>   * Probe/remove and init
>   */
> @@ -910,7 +1014,9 @@ static int ipmmu_remove(struct platform_
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
