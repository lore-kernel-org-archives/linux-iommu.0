From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
Date: Mon, 29 Apr 2019 16:19:02 +0100
Message-ID: <74a6c2e6-126c-57f0-af5c-ab1130130eba@arm.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-8-julien.grall@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429144428.29254-8-julien.grall@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 29/04/2019 15:44, Julien Grall wrote:
> A recent change split iommu_dma_map_msi_msg() in two new functions. The
> function was still implemented to avoid modifying all the callers at
> once.
> 
> Now that all the callers have been reworked, iommu_dma_map_msi_msg() can
> be removed.

Yay! The end of my horrible bodge :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
>      Changes in v2:
>          - Rework the commit message
> ---
>   drivers/iommu/dma-iommu.c | 20 --------------------
>   include/linux/dma-iommu.h |  5 -----
>   2 files changed, 25 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2309f59cefa4..12f4464828a4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -936,23 +936,3 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
>   	msg->address_lo += lower_32_bits(msi_page->iova);
>   }
> -
> -void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> -{
> -	struct msi_desc *desc = irq_get_msi_desc(irq);
> -	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
> -
> -	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
> -		/*
> -		 * We're called from a void callback, so the best we can do is
> -		 * 'fail' by filling the message with obviously bogus values.
> -		 * Since we got this far due to an IOMMU being present, it's
> -		 * not like the existing address would have worked anyway...
> -		 */
> -		msg->address_hi = ~0U;
> -		msg->address_lo = ~0U;
> -		msg->data = ~0U;
> -	} else {
> -		iommu_dma_compose_msi_msg(desc, msg);
> -	}
> -}
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 3fc48fbd6f63..ddd217c197df 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -82,7 +82,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
>   void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   			       struct msi_msg *msg);
>   
> -void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
>   #else
> @@ -122,10 +121,6 @@ static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   {
>   }
>   
> -static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
> -{
> -}
> -
>   static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   {
>   }
> 
