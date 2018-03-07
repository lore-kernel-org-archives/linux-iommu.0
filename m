From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 01/14] iommu/rockchip: Prohibit unbind and remove
Date: Wed, 7 Mar 2018 12:55:54 +0000
Message-ID: <713e01c9-4850-dd03-841f-060c1eec1cbd@arm.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306030252.3197-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306030252.3197-2-jeffy.chen@rock-chips.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 06/03/18 03:02, Jeffy Chen wrote:
> Removal of IOMMUs cannot be done reliably.
> 
> This is similar to exynos iommu driver.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4:
> Rewrite commit message.
> 
> Changes in v3:
> Also remove remove() and module_exit() as Tomasz suggested.
> 
> Changes in v2: None
> 
>   drivers/iommu/rockchip-iommu.c | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 9d991c2d8767..16cd8780c289 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1197,18 +1197,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	return err;
>   }
>   
> -static int rk_iommu_remove(struct platform_device *pdev)
> -{
> -	struct rk_iommu *iommu = platform_get_drvdata(pdev);
> -
> -	if (iommu) {
> -		iommu_device_sysfs_remove(&iommu->iommu);
> -		iommu_device_unregister(&iommu->iommu);
> -	}
> -
> -	return 0;
> -}
> -
>   static const struct of_device_id rk_iommu_dt_ids[] = {
>   	{ .compatible = "rockchip,iommu" },
>   	{ /* sentinel */ }
> @@ -1217,10 +1205,10 @@ MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
>   
>   static struct platform_driver rk_iommu_driver = {
>   	.probe = rk_iommu_probe,
> -	.remove = rk_iommu_remove,
>   	.driver = {
>   		   .name = "rk_iommu",
>   		   .of_match_table = rk_iommu_dt_ids,
> +		   .suppress_bind_attrs = true,
>   	},
>   };
>   
> @@ -1248,14 +1236,7 @@ static int __init rk_iommu_init(void)
>   		platform_driver_unregister(&rk_iommu_domain_driver);
>   	return ret;
>   }
> -static void __exit rk_iommu_exit(void)
> -{
> -	platform_driver_unregister(&rk_iommu_driver);
> -	platform_driver_unregister(&rk_iommu_domain_driver);
> -}
> -
>   subsys_initcall(rk_iommu_init);
> -module_exit(rk_iommu_exit);
>   
>   MODULE_DESCRIPTION("IOMMU API for Rockchip");
>   MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
> 
