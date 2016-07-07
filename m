From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH -next v2] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
Date: Thu, 07 Jul 2016 13:25:08 +0900
Message-ID: <20160707042508.GG23620@samsunx.samsung>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
 <CGME20160707030024epcas1p1454a6e40f68fbdcf0a103ce56d24ca22@epcas1p1.samsung.com>
 <1467860372-6940-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <1467860372-6940-1-git-send-email-weiyj_lk@163.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: weiyj_lk@163.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Wei,

On Thu, Jul 07, 2016 at 02:59:32AM +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function of_platform_device_create() returns
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>

Thanks,
Andi

> ---
> v1 -> v2: chenge the error code to -ENODEV
> ---
>  drivers/iommu/exynos-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 33dcc29..9b23059 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1345,8 +1345,8 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
>  		exynos_iommu_init();
>  
>  	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> -	if (IS_ERR(pdev))
> -		return PTR_ERR(pdev);
> +	if (!pdev)
> +		return -ENODEV;
>  
>  	/*
>  	 * use the first registered sysmmu device for performing
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
