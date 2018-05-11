From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v1 6/9] iommu/tegra: gart: Ignore devices without IOMMU
	phandle in DT
Date: Fri, 11 May 2018 12:34:08 +0100
Message-ID: <a3293da9-b750-6c5c-6f84-53b1aafc5e53@arm.com>
References: <20180508181700.5169-1-digetx@gmail.com>
	<20180508181700.5169-7-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180508181700.5169-7-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Dmitry,

On 08/05/18 19:16, Dmitry Osipenko wrote:
> GART can't handle all devices, ignore devices that aren't related to GART.
> Device tree must explicitly assign GART IOMMU to the devices.
> 
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/iommu/tegra-gart.c | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 39305224c48d..5b2d27620350 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -366,6 +366,26 @@ static void gart_iommu_remove_device(struct device *dev)
>   	iommu_device_unlink(&gart_handle->iommu, dev);
>   }
>   
> +static int gart_iommu_check_device(struct gart_device *gart,
> +				   struct device *dev);
> +
> +struct iommu_group *gart_iommu_device_group(struct device *dev)
> +{
> +	int err;
> +
> +	err = gart_iommu_check_device(gart_handle, dev);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return generic_device_group(dev);
> +}
> +
> +static int gart_iommu_of_xlate(struct device *dev,
> +			       struct of_phandle_args *args)
> +{
> +	return 0;
> +}
> +
>   static const struct iommu_ops gart_iommu_ops = {
>   	.capable	= gart_iommu_capable,
>   	.domain_alloc	= gart_iommu_domain_alloc,
> @@ -374,14 +394,24 @@ static const struct iommu_ops gart_iommu_ops = {
>   	.detach_dev	= gart_iommu_detach_dev,
>   	.add_device	= gart_iommu_add_device,
>   	.remove_device	= gart_iommu_remove_device,
> -	.device_group	= generic_device_group,
> +	.device_group	= gart_iommu_device_group,
>   	.map		= gart_iommu_map,
>   	.map_sg		= default_iommu_map_sg,
>   	.unmap		= gart_iommu_unmap,
>   	.iova_to_phys	= gart_iommu_iova_to_phys,
>   	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
> +	.of_xlate	= gart_iommu_of_xlate,
>   };
>   
> +static int gart_iommu_check_device(struct gart_device *gart,
> +				   struct device *dev)
> +{
> +	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &gart_iommu_ops)
> +		return -ENODEV;

Conceptually, it would be better to verify this in .add_device *before* 
calling iommu_group_get_for_dev(). That would also align with what other 
drivers do, and let you save introducing the .device_group callback 
until the real implementation in the later patch.

Robin.

> +
> +	return 0;
> +}
> +
>   static int tegra_gart_suspend(struct device *dev)
>   {
>   	struct gart_device *gart = dev_get_drvdata(dev);
> @@ -462,6 +492,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
>   	}
>   
>   	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
> +	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
>   
>   	ret = iommu_device_register(&gart->iommu);
>   	if (ret) {
> 
