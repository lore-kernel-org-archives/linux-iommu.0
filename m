From: Dennis Chen <dennis.chen@arm.com>
Subject: Re: [PATCH -next] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
Date: Wed, 6 Jul 2016 20:47:07 +0800
Message-ID: <20160706124705.GA18172@arm.com>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: weiyj_lk@163.com
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 06, 2016 at 12:15:54PM +0000, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> In case of error, the function of_platform_device_create() returns
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/iommu/exynos-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 33dcc29..9b23059 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1345,8 +1345,8 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
>               exynos_iommu_init();
>
>       pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> -     if (IS_ERR(pdev))
> -             return PTR_ERR(pdev);
> +     if (!pdev)
> +             return -ENOMEM;
>
Indeed!If of_platform_device_create only returns NULL in case of failure, then IS_ERR() will be
false, so
Reviewed-by: Dennis Chen <dennis.chen@arm.com>

Thanks,
Dennis
>
>       /*
>        * use the first registered sysmmu device for performing
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
