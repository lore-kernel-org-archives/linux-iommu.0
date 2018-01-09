From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iommu/exynos: Don't unconditionally steal bus ops
Date: Tue, 09 Jan 2018 10:59:19 +0100
Message-ID: <878c7791-ef37-adc7-8186-27455f2ef67f@samsung.com>
References: <CGME20180108192758epcas4p196b256cafeb8fce0359223c7f2aa960c@epcas4p1.samsung.com>
	<1432caf4ecfb077bb54f0115cb5e12b6620e8bfa.1515439558.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1432caf4ecfb077bb54f0115cb5e12b6620e8bfa.1515439558.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Content-language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 2018-01-08 20:27, Robin Murphy wrote:
> Removing the early device registration hook overlooked the fact that
> it only ran conditionally on a compatible device being present in the
> DT. With exynos_iommu_init() now running as an unconditional initcall,
> problems arise on non-Exynos systems when other IOMMU drivers find
> themselves unable to install their ops on the platform bus, or at worst
> the Exynos ops get called with someone else's domain and all hell breaks
> loose.
>
> Fix this by delaying the setting of bus ops until an Exynos IOMMU is
> actually found, to replicate the previous order of events.
>
> Fixes: 928055a01b3f ("iommu/exynos: Remove custom platform device registration code")
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Right, my fault. However I will prefer to resurrect code added initially
by commit a7b67cd5d9af "iommu/exynos: Play nice in multi-platform builds".
There is no need to do all the things done in the exynos_iommu_init on
non-Exynos platforms.

> ---
>   drivers/iommu/exynos-iommu.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 6a96a4c42153..e9e756156429 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -574,6 +574,12 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   	struct sysmmu_drvdata *data;
>   	struct resource *res;
>   
> +	if (platform_bus_type->iommu_ops != &exynos_iommu_ops) {
> +		ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
> @@ -1367,16 +1373,8 @@ static int __init exynos_iommu_init(void)
>   		goto err_zero_lv2;
>   	}
>   
> -	ret = bus_set_iommu(&platform_bus_type, &exynos_iommu_ops);
> -	if (ret) {
> -		pr_err("%s: Failed to register exynos-iommu driver.\n",
> -								__func__);
> -		goto err_set_iommu;
> -	}
> -
>   	return 0;
> -err_set_iommu:
> -	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
> +
>   err_zero_lv2:
>   	platform_driver_unregister(&exynos_sysmmu_driver);
>   err_reg_driver:

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
