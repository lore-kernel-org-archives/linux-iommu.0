From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 10/13] iommu/rockchip: Use OF_IOMMU to attach devices
	automatically
Date: Thu, 18 Jan 2018 12:46:30 +0000
Message-ID: <45265d6e-6b1a-57b8-11c4-6f1973702715@arm.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
	<20180118115251.5542-11-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180118115251.5542-11-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 18/01/18 11:52, Jeffy Chen wrote:
> Converts the rockchip-iommu driver to use the OF_IOMMU infrastructure,
> which allows attaching master devices to their IOMMUs automatically
> according to DT properties.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v4: None
> Changes in v3:
> Add struct rk_iommudata.
> Squash iommu/rockchip: Use iommu_group_get_for_dev() for add_device
> 
> Changes in v2: None
> 
>   drivers/iommu/rockchip-iommu.c | 139 +++++++++++++----------------------------
>   1 file changed, 44 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index bdb7c5de6fc2..b1f177ae03c7 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -19,6 +19,7 @@
>   #include <linux/mm.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_iommu.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
> @@ -97,6 +98,10 @@ struct rk_iommu {
>   	struct iommu_domain *domain; /* domain to which iommu is attached */
>   };
>   
> +struct rk_iommudata {
> +	struct rk_iommu *iommu;
> +};
> +
>   static struct device *dma_dev;
>   
>   static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
> @@ -872,18 +877,9 @@ static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _iova,
>   
>   static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
>   {
> -	struct iommu_group *group;
> -	struct device *iommu_dev;
> -	struct rk_iommu *rk_iommu;
> +	struct rk_iommudata *data = dev->archdata.iommu;
>   
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return NULL;
> -	iommu_dev = iommu_group_get_iommudata(group);
> -	rk_iommu = dev_get_drvdata(iommu_dev);
> -	iommu_group_put(group);
> -
> -	return rk_iommu;
> +	return data ? data->iommu : NULL;
>   }
>   
>   static int rk_iommu_attach_device(struct iommu_domain *domain,
> @@ -1060,110 +1056,57 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
>   		iommu_put_dma_cookie(&rk_domain->domain);
>   }
>   
> -static bool rk_iommu_is_dev_iommu_master(struct device *dev)
> -{
> -	struct device_node *np = dev->of_node;
> -	int ret;
> -
> -	/*
> -	 * An iommu master has an iommus property containing a list of phandles
> -	 * to iommu nodes, each with an #iommu-cells property with value 0.
> -	 */
> -	ret = of_count_phandle_with_args(np, "iommus", "#iommu-cells");
> -	return (ret > 0);
> -}
> -
> -static int rk_iommu_group_set_iommudata(struct iommu_group *group,
> -					struct device *dev)
> +static int rk_iommu_add_device(struct device *dev)
>   {
> -	struct device_node *np = dev->of_node;
> -	struct platform_device *pd;
> -	int ret;
> -	struct of_phandle_args args;
> +	struct iommu_group *group;
> +	struct rk_iommu *iommu;
>   
> -	/*
> -	 * An iommu master has an iommus property containing a list of phandles
> -	 * to iommu nodes, each with an #iommu-cells property with value 0.
> -	 */
> -	ret = of_parse_phandle_with_args(np, "iommus", "#iommu-cells", 0,
> -					 &args);
> -	if (ret) {
> -		dev_err(dev, "of_parse_phandle_with_args(%pOF) => %d\n",
> -			np, ret);
> -		return ret;
> -	}
> -	if (args.args_count != 0) {
> -		dev_err(dev, "incorrect number of iommu params found for %pOF (found %d, expected 0)\n",
> -			args.np, args.args_count);
> -		return -EINVAL;
> -	}
> +	iommu = rk_iommu_from_dev(dev);
> +	if (!iommu)
> +		return -ENODEV;
>   
> -	pd = of_find_device_by_node(args.np);
> -	of_node_put(args.np);
> -	if (!pd) {
> -		dev_err(dev, "iommu %pOF not found\n", args.np);
> -		return -EPROBE_DEFER;
> -	}
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +	iommu_group_put(group);
>   
> -	/* TODO(djkurtz): handle multiple slave iommus for a single master */
> -	iommu_group_set_iommudata(group, &pd->dev, NULL);
> +	iommu_device_link(&iommu->iommu, dev);
>   
>   	return 0;
>   }
>   
> -static int rk_iommu_add_device(struct device *dev)
> +static void rk_iommu_remove_device(struct device *dev)
>   {
> -	struct iommu_group *group;
>   	struct rk_iommu *iommu;
> -	int ret;
> -
> -	if (!rk_iommu_is_dev_iommu_master(dev))
> -		return -ENODEV;
> -
> -	group = iommu_group_get(dev);
> -	if (!group) {
> -		group = iommu_group_alloc();
> -		if (IS_ERR(group)) {
> -			dev_err(dev, "Failed to allocate IOMMU group\n");
> -			return PTR_ERR(group);
> -		}
> -	}
> -
> -	ret = iommu_group_add_device(group, dev);
> -	if (ret)
> -		goto err_put_group;
> -
> -	ret = rk_iommu_group_set_iommudata(group, dev);
> -	if (ret)
> -		goto err_remove_device;
>   
>   	iommu = rk_iommu_from_dev(dev);
> -	if (iommu)
> -		iommu_device_link(&iommu->iommu, dev);
> -
> -	iommu_group_put(group);
> -
> -	return 0;
>   
> -err_remove_device:
> +	iommu_device_unlink(&iommu->iommu, dev);
>   	iommu_group_remove_device(dev);
> -err_put_group:
> -	iommu_group_put(group);
> -	return ret;
>   }
>   
> -static void rk_iommu_remove_device(struct device *dev)
> +static int rk_iommu_of_xlate(struct device *dev,
> +			     struct of_phandle_args *args)
>   {
> -	struct rk_iommu *iommu;
> +	struct platform_device *iommu_dev;
> +	struct rk_iommudata *data;
>   
> -	if (!rk_iommu_is_dev_iommu_master(dev))
> -		return;
> +	data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
>   
> -	iommu = rk_iommu_from_dev(dev);
> -	if (iommu)
> -		iommu_device_unlink(&iommu->iommu, dev);
> +	iommu_dev = of_find_device_by_node(args->np);
> +	if (!iommu_dev) {
> +		dev_err(dev, "iommu %pOF not found\n", args->np);
> +		return -ENODEV;

Nit: I think this could only happen if the IOMMU device managed to probe 
successfully enough to call iommu_device_register(), but then somehow 
disappeared from the platform bus - given patch #1, that now seems 
impossible enough that it's probably not worth checking for.

Either way, this looks pretty tidy now;

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> +	}
>   
> -	iommu_group_remove_device(dev);
> +	data->iommu = platform_get_drvdata(iommu_dev);
> +	dev->archdata.iommu = data;
> +
> +	of_dev_put(iommu_dev);
> +
> +	return 0;
>   }
>   
>   static const struct iommu_ops rk_iommu_ops = {
> @@ -1177,7 +1120,9 @@ static const struct iommu_ops rk_iommu_ops = {
>   	.add_device = rk_iommu_add_device,
>   	.remove_device = rk_iommu_remove_device,
>   	.iova_to_phys = rk_iommu_iova_to_phys,
> +	.device_group = generic_device_group,
>   	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
> +	.of_xlate = rk_iommu_of_xlate,
>   };
>   
>   static int rk_iommu_probe(struct platform_device *pdev)
> @@ -1236,6 +1181,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   		goto err_put_clocks;
>   
>   	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
> +	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
> +
>   	err = iommu_device_register(&iommu->iommu);
>   	if (err)
>   		goto err_remove_sysfs;
> @@ -1290,6 +1237,8 @@ static int __init rk_iommu_init(void)
>   }
>   subsys_initcall(rk_iommu_init);
>   
> +IOMMU_OF_DECLARE(rk_iommu_of, "rockchip,iommu", NULL);
> +
>   MODULE_DESCRIPTION("IOMMU API for Rockchip");
>   MODULE_AUTHOR("Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org> and Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>");
>   MODULE_ALIAS("platform:rockchip-iommu");
> 
