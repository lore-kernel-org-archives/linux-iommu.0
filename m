From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 03/04] iommu/ipmmu-vmsa: Break out 32-bit ARM mapping
 code
Date: Thu, 17 Mar 2016 19:38:48 +0000
Message-ID: <56EB07C8.2030006@arm.com>
References: <20160315042136.22103.26570.sendpatchset@little-apple>
 <20160315042204.22103.88238.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20160315042204.22103.88238.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, horms+renesas@verge.net.au
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

On 15/03/16 04:22, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Make the driver compile on more than just 32-bit ARM
> by breaking out and wrapping ARM specific functions
> in #ifdefs. Not pretty, but needed to be able to use
> the driver on other architectures like ARM64.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>   Changes since V1:
>   - Rebased to work without patch 2 and 3 from V1 series
>
>   drivers/iommu/ipmmu-vmsa.c |   94 +++++++++++++++++++++++++++++---------------
>   1 file changed, 62 insertions(+), 32 deletions(-)
>
> --- 0004/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-03-15 12:25:45.040513000 +0900
> @@ -22,8 +22,10 @@
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>
> +#ifdef CONFIG_ARM
>   #include <asm/dma-iommu.h>
>   #include <asm/pgalloc.h>
> +#endif
>
>   #include "io-pgtable.h"
>
> @@ -38,7 +40,9 @@ struct ipmmu_vmsa_device {
>   	DECLARE_BITMAP(ctx, IPMMU_CTX_MAX);
>   	struct ipmmu_vmsa_domain *domains[IPMMU_CTX_MAX];
>
> +#ifdef CONFIG_ARM
>   	struct dma_iommu_mapping *mapping;
> +#endif
>   };
>
>   struct ipmmu_vmsa_domain {
> @@ -615,6 +619,60 @@ static int ipmmu_find_utlbs(struct ipmmu
>   	return 0;
>   }
>
> +#ifdef CONFIG_ARM
> +static int ipmmu_map_attach(struct device *dev, struct ipmmu_vmsa_device *mmu)
> +{
> +	int ret;
> +
> +	/*
> +	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
> +	 * VAs. This will allocate a corresponding IOMMU domain.
> +	 *
> +	 * TODO:
> +	 * - Create one mapping per context (TLB).
> +	 * - Make the mapping size configurable ? We currently use a 2GB mapping
> +	 *   at a 1GB offset to ensure that NULL VAs will fault.
> +	 */
> +	if (!mmu->mapping) {
> +		struct dma_iommu_mapping *mapping;
> +
> +		mapping = arm_iommu_create_mapping(&platform_bus_type,
> +						   SZ_1G, SZ_2G);
> +		if (IS_ERR(mapping)) {
> +			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
> +			return PTR_ERR(mapping);
> +		}
> +
> +		mmu->mapping = mapping;
> +	}
> +
> +	/* Attach the ARM VA mapping to the device. */
> +	ret = arm_iommu_attach_device(dev, mmu->mapping);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to attach device to VA mapping\n");
> +		arm_iommu_release_mapping(mmu->mapping);
> +	}
> +
> +	return ret;
> +}

This looks an awful lot like what the IOMMU core code now does 
automatically via the (relatively new) default domain mechanism. I 
suspect things might end up a fair bit simpler if you create the ARM 
mapping in domain_alloc when asked for an IOMMU_DOMAIN_DMA domain. While 
you're still using a single context, sticking all the client devices in 
the same group will then keep everything together automatically (see 
mtk_iommu.c in -next for an example) to retain the existing behaviour.

Since those mechanisms are all architecture-independent, that should 
help minimise the mess when accommodating arm64 later.

Robin.

> +static inline void ipmmu_detach(struct device *dev)
> +{
> +	arm_iommu_detach_device(dev);
> +}
> +static inline void ipmmu_release_mapping(struct ipmmu_vmsa_device *mmu)
> +{
> +	arm_iommu_release_mapping(mmu->mapping);
> +}
> +#else
> +static inline int ipmmu_map_attach(struct device *dev,
> +				   struct ipmmu_vmsa_device *mmu)
> +{
> +	return 0;
> +}
> +static inline void ipmmu_detach(struct device *dev) {}
> +static inline void ipmmu_release_mapping(struct ipmmu_vmsa_device *mmu) {}
> +#endif
> +
>   static int ipmmu_add_device(struct device *dev)
>   {
>   	struct ipmmu_vmsa_archdata *archdata;
> @@ -695,41 +753,13 @@ static int ipmmu_add_device(struct devic
>   	archdata->num_utlbs = num_utlbs;
>   	dev->archdata.iommu = archdata;
>
> -	/*
> -	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
> -	 * VAs. This will allocate a corresponding IOMMU domain.
> -	 *
> -	 * TODO:
> -	 * - Create one mapping per context (TLB).
> -	 * - Make the mapping size configurable ? We currently use a 2GB mapping
> -	 *   at a 1GB offset to ensure that NULL VAs will fault.
> -	 */
> -	if (!mmu->mapping) {
> -		struct dma_iommu_mapping *mapping;
> -
> -		mapping = arm_iommu_create_mapping(&platform_bus_type,
> -						   SZ_1G, SZ_2G);
> -		if (IS_ERR(mapping)) {
> -			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
> -			ret = PTR_ERR(mapping);
> -			goto error;
> -		}
> -
> -		mmu->mapping = mapping;
> -	}
> -
> -	/* Attach the ARM VA mapping to the device. */
> -	ret = arm_iommu_attach_device(dev, mmu->mapping);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to attach device to VA mapping\n");
> +	ret = ipmmu_map_attach(dev, mmu);
> +	if (ret < 0)
>   		goto error;
> -	}
>
>   	return 0;
>
>   error:
> -	arm_iommu_release_mapping(mmu->mapping);
> -
>   	kfree(dev->archdata.iommu);
>   	kfree(utlbs);
>
> @@ -745,7 +775,7 @@ static void ipmmu_remove_device(struct d
>   {
>   	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
>
> -	arm_iommu_detach_device(dev);
> +	ipmmu_detach(dev);
>   	iommu_group_remove_device(dev);
>
>   	kfree(archdata->utlbs);
> @@ -856,7 +886,7 @@ static int ipmmu_remove(struct platform_
>   	list_del(&mmu->list);
>   	spin_unlock(&ipmmu_devices_lock);
>
> -	arm_iommu_release_mapping(mmu->mapping);
> +	ipmmu_release_mapping(mmu);
>
>   	ipmmu_device_reset(mmu);
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

