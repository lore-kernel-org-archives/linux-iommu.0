From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 3/3] dma-mapping: clear dma_parms on teardown, too
Date: Fri, 14 Sep 2018 14:23:51 +0100
Message-ID: <874f7cd9-ac51-5968-de40-14a0addf9c96@arm.com>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
 <20180913151716.6333-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913151716.6333-4-wsa+renesas@sang-engineering.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
Cc: linux-renesas-soc@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 13/09/18 16:17, Wolfram Sang wrote:
> While sanitizig the pointer for dma_ops on teardown, do the same for
> dma_parms, too. Rename the function to have a more generic name.

Upon closer inspection, it looks like there are some cases (at least PCI 
and MFD) where dma_parms is installed by the parent/bus at device 
creation, and therefore remains valid and *would* be expected to persist 
across the child device's driver unbinding and rebinding - seems this is 
more complex than I first thought, sorry.

Robin.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   arch/arm/mm/dma-mapping.c   | 2 +-
>   include/linux/dma-mapping.h | 5 +++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 466b0242e8af..bcf77bc0423f 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2399,5 +2399,5 @@ void arch_teardown_dma_ops(struct device *dev)
>   	if (dev->archdata.dma_ops_setup)
>   		arm_teardown_iommu_dma_ops(dev);
>   
> -	generic_teardown_dma_ops(dev);
> +	generic_teardown_dma(dev);
>   }
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 020512cb7f0e..6a2d8779b1d8 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -663,12 +663,13 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
>   				      bool coherent) { }
>   #endif
>   
> -static inline void generic_teardown_dma_ops(struct device *dev)
> +static inline void generic_teardown_dma(struct device *dev)
>   {
>   	dev->dma_ops = NULL;
> +	dev->dma_parms = NULL;
>   }
>   #ifndef arch_teardown_dma_ops
> -#define arch_teardown_dma_ops generic_teardown_dma_ops
> +#define arch_teardown_dma_ops generic_teardown_dma
>   #endif
>   
>   static inline unsigned int dma_get_max_seg_size(struct device *dev)
> 
