From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 01/13] iommu/rockchip: Request irqs in rk_iommu_probe()
Date: Wed, 17 Jan 2018 12:18:21 +0000
Message-ID: <0b341bbd-6823-a041-9cac-e35bdc9e9bdc@arm.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180116132540.18939-2-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

On 16/01/18 13:25, Jeffy Chen wrote:
> Suggested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v2: None
> 
>   drivers/iommu/rockchip-iommu.c | 38 +++++++++++---------------------------
>   1 file changed, 11 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 9d991c2d8767..4a12d4746095 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -18,6 +18,7 @@
>   #include <linux/mm.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_irq.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
> @@ -91,7 +92,6 @@ struct rk_iommu {
>   	void __iomem **bases;
>   	int num_mmu;
>   	int *irq;

Nit: irq seems to be redundant now as well.

> -	int num_irq;
>   	bool reset_disabled;
>   	struct iommu_device iommu;
>   	struct list_head node; /* entry in rk_iommu_domain.iommus */
> @@ -830,13 +830,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	iommu->domain = domain;
>   
> -	for (i = 0; i < iommu->num_irq; i++) {
> -		ret = devm_request_irq(iommu->dev, iommu->irq[i], rk_iommu_irq,
> -				       IRQF_SHARED, dev_name(dev), iommu);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	for (i = 0; i < iommu->num_mmu; i++) {
>   		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>   			       rk_domain->dt_dma);
> @@ -885,9 +878,6 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>   	}
>   	rk_iommu_disable_stall(iommu);
>   
> -	for (i = 0; i < iommu->num_irq; i++)
> -		devm_free_irq(iommu->dev, iommu->irq[i], iommu);
> -
>   	iommu->domain = NULL;
>   
>   	dev_dbg(dev, "Detached from iommu domain\n");
> @@ -1138,7 +1128,7 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	struct rk_iommu *iommu;
>   	struct resource *res;
>   	int num_res = pdev->num_resources;
> -	int err, i;
> +	int err, i, irq, num_irq;
>   
>   	iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>   	if (!iommu)
> @@ -1165,23 +1155,17 @@ static int rk_iommu_probe(struct platform_device *pdev)
>   	if (iommu->num_mmu == 0)
>   		return PTR_ERR(iommu->bases[0]);
>   
> -	iommu->num_irq = platform_irq_count(pdev);
> -	if (iommu->num_irq < 0)
> -		return iommu->num_irq;
> -	if (iommu->num_irq == 0)
> -		return -ENXIO;
> -
> -	iommu->irq = devm_kcalloc(dev, iommu->num_irq, sizeof(*iommu->irq),
> -				  GFP_KERNEL);
> -	if (!iommu->irq)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < iommu->num_irq; i++) {
> -		iommu->irq[i] = platform_get_irq(pdev, i);
> -		if (iommu->irq[i] < 0) {
> -			dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq[i]);
> +	num_irq = of_irq_count(dev->of_node);

To follow up on the other reply, I'm not sure you really need to count 
the IRQs beforehand at all - you're going to be looping through 
platform_get_irq() and handling errors anyway, so you may as well just 
start at 0 and keep going until -ENOENT (or use platform_get_resource() 
to double-check whether an index should be valid, as we do in arm_smmu).

Otherwise, it looks like everything that the IRQ handler needs in the 
iommu struct (dev, num_mmu and bases) is already initialised by this 
point, so we should be OK with respect to races.

Robin.

> +	for (i = 0; i < num_irq; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			dev_err(dev, "Failed to get IRQ, %d\n", irq);
>   			return -ENXIO;
>   		}
> +		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
> +				       IRQF_SHARED, dev_name(dev), iommu);
> +		if (err)
> +			return err;
>   	}
>   
>   	iommu->reset_disabled = device_property_read_bool(dev,
> 
