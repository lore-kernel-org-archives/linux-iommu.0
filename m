From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/4] arm-nommu: don't define arch_teardown_dma_ops
Date: Thu, 6 Sep 2018 13:11:46 +0100
Message-ID: <f40b7384-293d-5bad-77c3-7e0391e530fe@arm.com>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827084711.23407-2-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/08/18 09:47, Christoph Hellwig wrote:
> We can just use the default implementation.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm/include/asm/dma-mapping.h | 2 ++
>   arch/arm/mm/dma-mapping-nommu.c    | 4 ----
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 8436f6ade57d..965b7c846ecb 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -100,8 +100,10 @@ static inline unsigned long dma_max_pfn(struct device *dev)
>   extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   			       const struct iommu_ops *iommu, bool coherent);
>   
> +#ifdef CONFIG_MMU
>   #define arch_teardown_dma_ops arch_teardown_dma_ops
>   extern void arch_teardown_dma_ops(struct device *dev);
> +#endif
>   
>   /* do not use this function in a driver */
>   static inline bool is_device_dma_coherent(struct device *dev)
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index f448a0663b10..aa7aba302e76 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -237,7 +237,3 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   
>   	set_dma_ops(dev, dma_ops);
>   }
> -
> -void arch_teardown_dma_ops(struct device *dev)
> -{
> -}
> 
