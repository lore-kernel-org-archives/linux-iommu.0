From: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [v3 1/1] iommu/tegra: smmu: bus_notifier registers platform IOMMU
 devices
Date: Wed, 05 Dec 2012 14:29:42 +0800
Message-ID: <50BEE9D6.2080107@gmail.com>
References: <1354646264-12126-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354646264-12126-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/05/2012 02:37 AM, Hiroshi Doyu wrote:
> Most of platform devices are IOMMU'able in Tegra30 SoC. Registering
> all IOMMU'able devices manually isn't nice. This patch allows
> platform bus_notifier to register IOMMU devices. Map info can be
> passed from DT. Info format is:
> 
>   dma-window = <0 0x40000000>;
> 
> TODO:
> A map can be shared with mutiple devices. This info also could be
> passed from DT or default map can be set in advance.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v3: Added bus_unregister_notifier
> ---
>  drivers/iommu/tegra-smmu.c |   48 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 25c1210..8fec9be 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -38,6 +38,7 @@
>  
>  #include <asm/page.h>
>  #include <asm/cacheflush.h>
> +#include <asm/dma-iommu.h>
>  
>  enum smmu_hwgrp {
>  	HWGRP_AFI,
> @@ -1273,13 +1274,58 @@ static struct platform_driver tegra_smmu_driver = {
>  	},
>  };
>  
> +static int tegra_smmu_device_notifier(struct notifier_block *nb,
> +				      unsigned long event, void *_dev)
> +{
> +	struct dma_iommu_mapping *map = NULL;
> +	struct device *dev = _dev;
> +	dma_addr_t base;
> +	size_t size;
> +	int err;
> +
> +	switch (event) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		err = of_get_dma_window(dev->of_node, NULL, 0, NULL, &base,
> +					&size);
> +		if (!err)
> +			map = arm_iommu_create_mapping(&platform_bus_type,
> +						       base, size, 0);
> +		if (IS_ERR_OR_NULL(map))
> +			break;
> +		if (arm_iommu_attach_device(dev, map)) {
> +			arm_iommu_release_mapping(map);
> +			dev_err(dev, "Failed to attach %s\n", dev_name(dev));
> +		}
> +		dev_dbg(dev, "Attached %s to map %p\n", dev_name(dev), map);

If "arm_iommu_attach_device" fails, the "dev_err" and "dev_dbg" will all
be called.

> +		break;
> +	default:
> +		break;
> +	}
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block tegra_smmu_device_nb = {
> +	.notifier_call = tegra_smmu_device_notifier,
> +};
> +
>  static int __devinit tegra_smmu_init(void)
>  {
> -	return platform_driver_register(&tegra_smmu_driver);
> +	int err;
> +
> +	err = platform_driver_register(&tegra_smmu_driver);
> +	if (err)
> +		return err;
> +	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
> +		bus_register_notifier(&platform_bus_type,
> +				      &tegra_smmu_device_nb);
> +	return 0;
>  }
>  
>  static void __exit tegra_smmu_exit(void)
>  {
> +	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU))
> +		bus_unregister_notifier(&platform_bus_type,
> +					&tegra_smmu_device_nb);

Okay. Here unregister the notifier, but where is the
"arm_iommu_release_mapping" for every IOMMU'able devices?

>  	platform_driver_unregister(&tegra_smmu_driver);
>  }
>  
> 
