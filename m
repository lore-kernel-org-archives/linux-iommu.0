From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/21] dma-iommu: cleanup dma-iommu.h
Date: Fri, 5 Apr 2019 18:42:57 +0100
Message-ID: <7d7efc03-75b2-58c7-f744-d7bc3de6a771@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-5-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> No need for a __KERNEL__ guard outside uapi and add a missing comment
> describing the #else cpp statement.  Last but not least include
> <linux/errno.h> instead of the asm version, which is frowned upon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-iommu.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index e760dc5d1fa8..3e206f4ee173 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -16,14 +16,14 @@
>   #ifndef __DMA_IOMMU_H
>   #define __DMA_IOMMU_H
>   
> -#ifdef __KERNEL__
> +#include <linux/errno.h>
>   #include <linux/types.h>
> -#include <asm/errno.h>
>   
>   #ifdef CONFIG_IOMMU_DMA
>   #include <linux/dma-mapping.h>
>   #include <linux/iommu.h>
>   #include <linux/msi.h>
> +#include <linux/types.h>

Other than introducing this unnecessary dupe,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   int iommu_dma_init(void);
>   
> @@ -74,7 +74,7 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
>   void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> -#else
> +#else /* CONFIG_IOMMU_DMA */
>   
>   struct iommu_domain;
>   struct msi_msg;
> @@ -108,5 +108,4 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   }
>   
>   #endif	/* CONFIG_IOMMU_DMA */
> -#endif	/* __KERNEL__ */
>   #endif	/* __DMA_IOMMU_H */
> 
