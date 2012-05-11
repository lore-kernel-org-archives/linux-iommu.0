From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/exynos: fix runtime pm support
Date: Sat, 12 May 2012 06:31:59 +0900
Message-ID: <4FAD854F.7040403@samsung.com>
References: <1334154871-4756-1-git-send-email-m.szyprowski@samsung.com>
	<1334154871-4756-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1334154871-4756-2-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, KyongHo Cho <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/11/12 23:34, Marek Szyprowski wrote:
> Fix registration to runtime pw and add missing resume callback.
>
> Signed-off-by: Marek Szyprowski<m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Acked-by: Kyungmin Park<kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/iommu/exynos-iommu.c |   20 ++++++++++++++++++--
>   1 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b8daf7c..eef924d 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -651,8 +651,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>
>   	__set_fault_handler(data,&default_fault_handler);
>
> -	if (dev->parent)
> -		pm_runtime_enable(dev);
> +	pm_runtime_enable(dev);
>
>   	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
>   	return 0;
> @@ -674,11 +673,28 @@ err_alloc:
>   	return ret;
>   }
>
> +static int exynos_pm_resume(struct device *dev)
> +{
> +	struct sysmmu_drvdata *data;
> +
> +	data = dev_get_drvdata(dev);
> +
> +	if (is_sysmmu_active(data))
> +		__exynos_sysmmu_enable(data, data->pgtable, NULL);
> +
> +	return 0;
> +}
> +
> +const struct dev_pm_ops exynos_pm_ops = {
> +	.resume =&exynos_pm_resume,
> +};
> +
>   static struct platform_driver exynos_sysmmu_driver = {
>   	.probe		= exynos_sysmmu_probe,
>   	.driver		= {
>   		.owner		= THIS_MODULE,
>   		.name		= "exynos-sysmmu",
> +		.pm		=&exynos_pm_ops,
>   	}
>   };
>

Joerg,

This patch is needed to correct run-time pm for EXYNOS SoCs with System 
MMU after KyongHo's iommu/exynos patch. So if you're ok on this, let me 
apply this in samsung tree.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
