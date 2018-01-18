From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 11/13] iommu/rockchip: Fix error handling in init
Date: Thu, 18 Jan 2018 12:47:33 +0000
Message-ID: <ebf1b740-5f64-e8fe-fdcf-86dfc532388d@arm.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
 <20180118115251.5542-12-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180118115251.5542-12-jeffy.chen@rock-chips.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, xxm@rock-chips.com, tfiga@chromium.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 18/01/18 11:52, Jeffy Chen wrote:
> It's hard to undo bus_set_iommu() in the error path, so move it to the
> end of rk_iommu_probe().

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> ---
> 
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> Move bus_set_iommu() to rk_iommu_probe().
> 
>   drivers/iommu/rockchip-iommu.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index b1f177ae03c7..2c095f96c033 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1195,6 +1195,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	if (!dma_dev)
>   		dma_dev = &pdev->dev;
>   
> +	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
> +
>   	return 0;
>   err_remove_sysfs:
>   	iommu_device_sysfs_remove(&iommu->iommu);
> @@ -1220,19 +1222,6 @@ static struct platform_driver rk_iommu_driver = {
>   
>   static int __init rk_iommu_init(void)
>   {
> -	struct device_node *np;
> -	int ret;
> -
> -	np = of_find_matching_node(NULL, rk_iommu_dt_ids);
> -	if (!np)
> -		return 0;
> -
> -	of_node_put(np);
> -
> -	ret = bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
> -	if (ret)
> -		return ret;
> -
>   	return platform_driver_register(&rk_iommu_driver);
>   }
>   subsys_initcall(rk_iommu_init);
> 
