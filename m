From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/04] iommu/ipmmu-vmsa: Add new IOMMU_DOMAIN_DMA ops
Date: Thu, 17 Mar 2016 20:02:40 +0000
Message-ID: <56EB0D60.8050104@arm.com>
References: <20160315170431.20615.30333.sendpatchset@little-apple>
 <20160315170510.20615.16557.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160315170510.20615.16557.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>, iommu@lists.linux-foundation.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au
List-Id: iommu@lists.linux-foundation.org

On 15/03/16 17:05, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Introduce a new set of iommu_ops suitable for 64-bit ARM
> as well as 32-bit ARM when CONFIG_IOMMU_DMA=y. The ->of_xlate()
> callback is needed by the code exported by of_iommu.h and
> it is wrapped in #ifdefs to also compile of x86_64.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>   drivers/iommu/ipmmu-vmsa.c |   94 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 92 insertions(+), 2 deletions(-)
>
> --- 0011/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-03-16 01:35:06.990513000 +0900
> @@ -10,6 +10,7 @@
>
>   #include <linux/bitmap.h>
>   #include <linux/delay.h>
> +#include <linux/dma-iommu.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/err.h>
>   #include <linux/export.h>
> @@ -804,7 +805,7 @@ static void ipmmu_remove_device(struct d
>   	dev->archdata.iommu = NULL;
>   }
>
> -static const struct iommu_ops ipmmu_ops = {
> +static const struct iommu_ops __maybe_unused ipmmu_ops = {
>   	.domain_alloc = ipmmu_domain_alloc,
>   	.domain_free = ipmmu_domain_free,
>   	.attach_dev = ipmmu_attach_device,
> @@ -818,6 +819,92 @@ static const struct iommu_ops ipmmu_ops
>   	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
>   };
>
> +static struct iommu_domain *ipmmu_domain_alloc_dma(unsigned type)
> +{
> +	struct iommu_domain *io_domain;
> +
> +	if (type != IOMMU_DOMAIN_DMA)
> +		return NULL;
> +
> +	io_domain = __ipmmu_domain_alloc(type);
> +	if (io_domain)
> +		iommu_get_dma_cookie(io_domain);
> +
> +	return io_domain;
> +}
> +
> +static void ipmmu_domain_free_dma(struct iommu_domain *io_domain)
> +{
> +	iommu_put_dma_cookie(io_domain);
> +	ipmmu_domain_free(io_domain);
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

It seems a bit weird to deliberately ignore the information of_xlate 
gives you, only to go off poking the DT to dredge it up manually later. 
Why not use of_xlate to create the archdata, then simply check for it 
here? (Ideally that should also be common with ARM, but I think you 
still get called in the wrong order there)

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
> +	ret = ipmmu_init_platform_device(dev, group);
> +	if (ret) {
> +		iommu_group_put(group);
> +		group = ERR_PTR(ret);
> +	}
> +
> +	return group;
> +}
> +
> +#ifdef CONFIG_OF_IOMMU
> +static int ipmmu_of_xlate_dma(struct device *dev,
> +			      struct of_phandle_args *spec)
> +{
> +	/* dummy callback to satisfy of_iommu_configure() */
> +	return 0;
> +}
> +#endif
> +
> +static const struct iommu_ops __maybe_unused ipmmu_ops_dma = {
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
> +#ifdef CONFIG_OF_IOMMU
> +	.of_xlate = ipmmu_of_xlate_dma,
> +#endif

Yup, I definitely think Arnd is right about eradicating these #ifdefs[1].

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel/2177390

> +};
> +
>   /* -----------------------------------------------------------------------------
>    * Probe/remove and init
>    */
> @@ -929,14 +1016,17 @@ static struct platform_driver ipmmu_driv
>
>   static int __init ipmmu_init(void)
>   {
> +	const struct iommu_ops *ops;
>   	int ret;
>
>   	ret = platform_driver_register(&ipmmu_driver);
>   	if (ret < 0)
>   		return ret;
>
> +	ops = IS_ENABLED(CONFIG_IOMMU_DMA) ? &ipmmu_ops_dma : &ipmmu_ops;
> +
>   	if (!iommu_present(&platform_bus_type))
> -		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
> +		bus_set_iommu(&platform_bus_type, ops);
>
>   	return 0;
>   }
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
