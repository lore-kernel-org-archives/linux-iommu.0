From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 2/9] iommu/of: Consolidate device creation workarounds
Date: Fri, 01 Jul 2016 12:32:42 +0200
Message-ID: <611b2a77-e7e8-e1e2-85b5-4f469f3ebdf4@samsung.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
	<dc8ac0f397ea5c90937fb5c9974e4ab02e264bd8.1467123945.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <dc8ac0f397ea5c90937fb5c9974e4ab02e264bd8.1467123945.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,


On 2016-06-28 17:48, Robin Murphy wrote:
> So far, all the users of the generic of_xlate configuration mechanism
> are resorting to explicit platform device creation to ensure the IOMMU
> device is ready before anything tries to refer to it. As I'm about to
> convert two more drivers that will need exactly the same thing, let's
> nip that proliferation in the bud and move it to a single place.
>
> A neat solution is to make of_get_iommu_ops() ensure an IOMMU device is
> instantiated before giving out its associated ops, since it's a fairly
> safe assumption that the ops aren't going to be much use if the IOMMU
> can't or won't exist to back them up.
>
> CC: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> CC: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Frankly, I would avoid moving this workaround to the iommu core. IMHO the
best solution would be to let IOMMU controllers to be instantiated as normal
devices and implement proper support in the device core for waiting for the
iommu controller. Then the workaround can be removed from exynos and mtk
iommu drivers. What's the status of IOMMU deferred probe patches?

I've encountered a serious problems with current code (the one which
instantiates iommu controller devices from iommu driver) and its integration
with power domains, clocks and runtime pm, which were not possible to 
resolve
without iommu deferred probe.


> ---
>
> v3: New.
>
>   drivers/iommu/exynos-iommu.c | 20 +++++++-------------
>   drivers/iommu/mtk_iommu.c    |  8 +-------
>   drivers/iommu/of_iommu.c     |  6 +++++-
>   3 files changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 5ecc86cb74c8..97380ee56d71 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -665,6 +665,13 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   
>   	pm_runtime_enable(dev);
>   
> +	/*
> +	 * use the first registered sysmmu device for performing
> +	 * dma mapping operations on iommu page tables (cpu cache flush)
> +	 */
> +	if (!dma_dev)
> +		dma_dev = dev;
> +
>   	return 0;
>   }
>   
> @@ -1341,22 +1348,9 @@ err_reg_driver:
>   
>   static int __init exynos_iommu_of_setup(struct device_node *np)
>   {
> -	struct platform_device *pdev;
> -
>   	if (!init_done)
>   		exynos_iommu_init();
>   
> -	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> -
> -	/*
> -	 * use the first registered sysmmu device for performing
> -	 * dma mapping operations on iommu page tables (cpu cache flush)
> -	 */
> -	if (!dma_dev)
> -		dma_dev = &pdev->dev;
> -
>   	of_iommu_set_ops(np, &exynos_iommu_ops);
>   	return 0;
>   }
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c3043d8754e3..f7ae87abea99 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -724,14 +724,8 @@ static struct platform_driver mtk_iommu_driver = {
>   
>   static int mtk_iommu_init_fn(struct device_node *np)
>   {
> -	int ret;
> -	struct platform_device *pdev;
> +	int ret = platform_driver_register(&mtk_iommu_driver);
>   
> -	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> -	if (!pdev)
> -		return -ENOMEM;
> -
> -	ret = platform_driver_register(&mtk_iommu_driver);
>   	if (ret) {
>   		pr_err("%s: Failed to register driver\n", __func__);
>   		return ret;
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index af499aea0a1a..7e6369cffc95 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -22,6 +22,7 @@
>   #include <linux/limits.h>
>   #include <linux/of.h>
>   #include <linux/of_iommu.h>
> +#include <linux/of_platform.h>
>   #include <linux/slab.h>
>   
>   static const struct of_device_id __iommu_of_table_sentinel
> @@ -127,7 +128,10 @@ const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
>   	spin_lock(&of_iommu_lock);
>   	list_for_each_entry(node, &of_iommu_list, list)
>   		if (node->np == np) {
> -			ops = node->ops;
> +			if (of_node_check_flag(np, OF_POPULATED) ||
> +			    of_platform_device_create(np, NULL,
> +					    platform_bus_type.dev_root))
> +				ops = node->ops;
>   			break;
>   		}
>   	spin_unlock(&of_iommu_lock);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
