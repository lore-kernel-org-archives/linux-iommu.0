From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Date: Fri, 29 Mar 2019 14:50:34 +0000
Message-ID: <b747c418-a495-56e0-c106-a8ec8e82ccb9@arm.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
 <20190329140014.8126-3-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329140014.8126-3-laurentiu.tudor@nxp.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: laurentiu.tudor@nxp.com, netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 29/03/2019 14:00, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Add a one-to-one iommu mapping for bman private data memory (FBPR).
> This is required for BMAN to work without faults behind an iommu.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index 7c3cc968053c..b209c79511bb 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -29,6 +29,7 @@
>    */
>   
>   #include "bman_priv.h"
> +#include <linux/iommu.h>
>   
>   u16 bman_ip_rev;
>   EXPORT_SYMBOL(bman_ip_rev);
> @@ -178,6 +179,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>   	int ret, err_irq;
>   	struct device *dev = &pdev->dev;
>   	struct device_node *node = dev->of_node;
> +	struct iommu_domain *domain;
>   	struct resource *res;
>   	u16 id, bm_pool_cnt;
>   	u8 major, minor;
> @@ -225,6 +227,15 @@ static int fsl_bman_probe(struct platform_device *pdev)
>   
>   	dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
>   
> +	/* Create an 1-to-1 iommu mapping for FBPR area */
> +	domain = iommu_get_domain_for_dev(dev);

If that's expected to be the default domain that you're grabbing, then 
this is *incredibly* fragile. There's nothing to stop the IOVA that you 
forcibly map from being automatically allocated later and causing some 
other DMA mapping to fail noisily and unexpectedly. Furthermore, have 
you tried this with "iommu.passthrough=1"?

That said, I really don't understand what's going on here anyway :/

As far as I can tell from qbman_init_private_mem(), fbpr_a comes from 
dma_alloc_coherent() and thus would already be a mapped IOVA - isn't 
this the stuff that Roy converted to nicely use shared-dma-pool regions 
a while ago?

Robin.

> +	if (domain) {
> +		ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> +		if (ret)
> +			dev_warn(dev, "failed to iommu_map() %d\n", ret);
> +	}
> +
>   	bm_set_memory(fbpr_a, fbpr_sz);
>   
>   	err_irq = platform_get_irq(pdev, 0);
> 
