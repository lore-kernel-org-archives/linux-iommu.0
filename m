From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/7 v5] iommu: support iommu configuration for fsl-mc
	devices
Date: Tue, 3 Jul 2018 16:30:35 +0100
Message-ID: <947a6e16-98ff-9389-b15c-d3025b7be4be@arm.com>
References: <1526824191-7000-1-git-send-email-nipun.gupta@nxp.com>
	<1526824191-7000-4-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1526824191-7000-4-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
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
To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, laurentiu.tudor-3arQi8VN3Tc@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 20/05/18 14:49, Nipun Gupta wrote:
> With of_pci_map_rid available for all the busses, use the function
> for configuration of devices on fsl-mc bus

FWIW I had a quick hack at factoring out the commonality with 
of_pci_iommu_init(), at which point I reckon this change is easier to 
follow as-is for the moment, so:

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> ---
>   drivers/iommu/of_iommu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 811e160..284474d 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -24,6 +24,7 @@
>   #include <linux/of_iommu.h>
>   #include <linux/of_pci.h>
>   #include <linux/slab.h>
> +#include <linux/fsl/mc.h>
>   
>   #define NO_IOMMU	1
>   
> @@ -159,6 +160,23 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>   	return err;
>   }
>   
> +static int of_fsl_mc_iommu_init(struct fsl_mc_device *mc_dev,
> +				struct device_node *master_np)
> +{
> +	struct of_phandle_args iommu_spec = { .args_count = 1 };
> +	int err;
> +
> +	err = of_map_rid(master_np, mc_dev->icid, "iommu-map",
> +			 "iommu-map-mask", &iommu_spec.np,
> +			 iommu_spec.args);
> +	if (err)
> +		return err == -ENODEV ? NO_IOMMU : err;
> +
> +	err = of_iommu_xlate(&mc_dev->dev, &iommu_spec);
> +	of_node_put(iommu_spec.np);
> +	return err;
> +}
> +
>   const struct iommu_ops *of_iommu_configure(struct device *dev,
>   					   struct device_node *master_np)
>   {
> @@ -190,6 +208,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     of_pci_iommu_init, &info);
> +	} else if (dev_is_fsl_mc(dev)) {
> +		err = of_fsl_mc_iommu_init(to_fsl_mc_device(dev), master_np);
>   	} else {
>   		struct of_phandle_args iommu_spec;
>   		int idx = 0;
> 
