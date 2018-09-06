From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
Date: Thu, 6 Sep 2018 13:20:14 +0100
Message-ID: <b2161b3e-6dbe-3e83-baaa-185e8679bc7d@arm.com>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180827084711.23407-5-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/08/18 09:47, Christoph Hellwig wrote:
> There is no reason to leave the per-device dma_ops around when
> deconfiguring a device, so move this code from arm64 into the
> common code.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/include/asm/dma-mapping.h | 5 -----
>   arch/arm64/mm/dma-mapping.c          | 5 -----
>   include/linux/dma-mapping.h          | 5 ++++-
>   3 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index b7847eb8a7bb..0a2d13332545 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -39,11 +39,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   			const struct iommu_ops *iommu, bool coherent);
>   #define arch_setup_dma_ops	arch_setup_dma_ops
>   
> -#ifdef CONFIG_IOMMU_DMA
> -void arch_teardown_dma_ops(struct device *dev);
> -#define arch_teardown_dma_ops	arch_teardown_dma_ops
> -#endif
> -
>   /* do not use this function in a driver */
>   static inline bool is_device_dma_coherent(struct device *dev)
>   {
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 072c51fb07d7..cdcb73db9ea2 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -862,11 +862,6 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   		 dev_name(dev));
>   }
>   
> -void arch_teardown_dma_ops(struct device *dev)
> -{
> -	dev->dma_ops = NULL;
> -}
> -
>   #else
>   
>   static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 1423b69f3cc9..eafd6f318e78 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -664,7 +664,10 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
>   #endif
>   
>   #ifndef arch_teardown_dma_ops
> -static inline void arch_teardown_dma_ops(struct device *dev) { }
> +static inline void arch_teardown_dma_ops(struct device *dev)
> +{
> +	dev->dma_ops = NULL;
> +}
>   #endif
>   
>   static inline unsigned int dma_get_max_seg_size(struct device *dev)
> 
