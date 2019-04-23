From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in two
 parts
Date: Tue, 23 Apr 2019 11:54:41 +0100
Message-ID: <86a75dce-e1dc-c57c-d80f-0cefd3c5a5dd@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
 <20190418172611.21561-3-julien.grall@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418172611.21561-3-julien.grall@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 18/04/2019 18:26, Julien Grall wrote:
> On RT, the function iommu_dma_map_msi_msg may be called from
> non-preemptible context. This will lead to a splat with
> CONFIG_DEBUG_ATOMIC_SLEEP as the function is using spin_lock
> (they can sleep on RT).
> 
> The function iommu_dma_map_msi_msg is used to map the MSI page in the
> IOMMU PT and update the MSI message with the IOVA.
> 
> Only the part to lookup for the MSI page requires to be called in
> preemptible context. As the MSI page cannot change over the lifecycle
> of the MSI interrupt, the lookup can be cached and re-used later on.
> 
> This patch split the function iommu_dma_map_msi_msg in two new
> functions:
>     - iommu_dma_prepare_msi: This function will prepare the mapping in
>     the IOMMU and store the cookie in the structure msi_desc. This
>     function should be called in preemptible context.
>     - iommu_dma_compose_msi_msg: This function will update the MSI
>     message with the IOVA when the device is behind an IOMMU.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 43 ++++++++++++++++++++++++++++++++-----------
>  include/linux/dma-iommu.h | 21 +++++++++++++++++++++
>  2 files changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 77aabe637a60..f5c1f1685095 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -888,17 +888,17 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	return NULL;
>  }
>  
> -void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)

I quite like the idea of moving from having an irq to having an msi_desc
passed to the IOMMU layer...

>  {
> -	struct device *dev = msi_desc_to_dev(irq_get_msi_desc(irq));
> +	struct device *dev = msi_desc_to_dev(desc);
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  	struct iommu_dma_cookie *cookie;
> -	struct iommu_dma_msi_page *msi_page;
> -	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
>  	unsigned long flags;
>  
> -	if (!domain || !domain->iova_cookie)
> -		return;
> +	if (!domain || !domain->iova_cookie) {
> +		desc->iommu_cookie = NULL;
> +		return 0;
> +	}
>  
>  	cookie = domain->iova_cookie;
>  
> @@ -908,10 +908,33 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  	 * of an MSI from within an IPI handler.
>  	 */
>  	spin_lock_irqsave(&cookie->msi_lock, flags);
> -	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
> +	desc->iommu_cookie = iommu_dma_get_msi_page(dev, msi_addr, domain);
>  	spin_unlock_irqrestore(&cookie->msi_lock, flags);
>  
> -	if (WARN_ON(!msi_page)) {
> +	return (desc->iommu_cookie) ? 0 : -ENOMEM;
> +}
> +
> +void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg)

... but I'd like it even better if it was uniform. Can you please move
the irq_get_msi_desc() to the callers of iommu_dma_compose_msi_msg(),
and make both functions take a msi_desc?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
