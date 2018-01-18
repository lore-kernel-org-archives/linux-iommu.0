From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 13/13] iommu/rockchip: Support sharing IOMMU between
	masters
Date: Thu, 18 Jan 2018 12:49:46 +0000
Message-ID: <50529cf2-72ed-e991-7639-79b5d74c7853@arm.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
	<20180118115251.5542-14-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180118115251.5542-14-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
> There would be some masters sharing the same IOMMU device. Put them in
> the same iommu group and share the same iommu domain.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v4: None
> Changes in v3:
> Remove rk_iommudata->domain.
> 
> Changes in v2: None
> 
>   drivers/iommu/rockchip-iommu.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index e2e7acc3039d..e07929bbcc2a 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -97,6 +97,7 @@ struct rk_iommu {
>   	struct iommu_device iommu;
>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
>   	struct iommu_domain *domain; /* domain to which iommu is attached */
> +	struct iommu_group *group;
>   };
>   
>   struct rk_iommudata {
> @@ -1157,6 +1158,15 @@ static void rk_iommu_remove_device(struct device *dev)
>   	iommu_group_remove_device(dev);
>   }
>   
> +static struct iommu_group *rk_iommu_device_group(struct device *dev)
> +{
> +	struct rk_iommu *iommu;
> +
> +	iommu = rk_iommu_from_dev(dev);
> +
> +	return iommu->group;
> +}
> +
>   static int rk_iommu_of_xlate(struct device *dev,
>   			     struct of_phandle_args *args)
>   {
> @@ -1192,7 +1202,7 @@ static const struct iommu_ops rk_iommu_ops = {
>   	.add_device = rk_iommu_add_device,
>   	.remove_device = rk_iommu_remove_device,
>   	.iova_to_phys = rk_iommu_iova_to_phys,
> -	.device_group = generic_device_group,
> +	.device_group = rk_iommu_device_group,
>   	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
>   	.of_xlate = rk_iommu_of_xlate,
>   };
> @@ -1248,9 +1258,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	iommu->reset_disabled = device_property_read_bool(dev,
>   					"rockchip,disable-mmu-reset");
>   
> +	iommu->group = iommu_group_alloc();
> +	if (IS_ERR(iommu->group)) {
> +		err = PTR_ERR(iommu->group);
> +		goto err_put_clocks;
> +	}
> +
>   	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
>   	if (err)
> -		goto err_put_clocks;
> +		goto err_put_group;
>   
>   	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
>   	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
> @@ -1274,6 +1290,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	return 0;
>   err_remove_sysfs:
>   	iommu_device_sysfs_remove(&iommu->iommu);
> +err_put_group:
> +	iommu_group_put(iommu->group);
>   err_put_clocks:
>   	rk_iommu_put_clocks(iommu);
>   	return err;
> 
