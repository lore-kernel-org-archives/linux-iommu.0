From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/21] dma-mapping: add a Kconfig symbol to indicated
 arch_dma_prep_coherent presence
Date: Fri, 5 Apr 2019 18:41:02 +0100
Message-ID: <7c464875-b23a-9da4-afe7-93d7879ca3b8@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
 <20190327080448.5500-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327080448.5500-4-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Add a Kconfig symbol that indicates an architecture provides a
> arch_dma_prep_coherent implementation, and provide a stub otherwise.
> 
> This will allow the generic dma-iommu code to it while still allowing

I think you accidentally a word there.

> to be built for cache coherent architectures.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig              | 1 +
>   arch/csky/Kconfig               | 1 +
>   include/linux/dma-noncoherent.h | 6 ++++++
>   kernel/dma/Kconfig              | 3 +++
>   4 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7e34b9eba5de..adda078d6df7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -13,6 +13,7 @@ config ARM64
>   	select ARCH_HAS_DEVMEM_IS_ALLOWED
>   	select ARCH_HAS_DMA_COHERENT_TO_PFN
>   	select ARCH_HAS_DMA_MMAP_PGPROT
> +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
>   	select ARCH_HAS_ELF_RANDOMIZE
>   	select ARCH_HAS_FAST_MULTIPLIER
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 725a115759c9..2c3178848b7d 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -1,6 +1,7 @@
>   config CSKY
>   	def_bool y
>   	select ARCH_32BIT_OFF_T
> +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index 69b36ed31a99..9741767e400f 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -72,6 +72,12 @@ static inline void arch_sync_dma_for_cpu_all(struct device *dev)
>   }
>   #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
>   
> +#ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
>   void arch_dma_prep_coherent(struct page *page, size_t size);
> +#else
> +static inline void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +}
> +#endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
>   
>   #endif /* _LINUX_DMA_NONCOHERENT_H */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index a06ba3013b3b..feff2d21d8ee 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -38,6 +38,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
>   config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
>   	bool
>   
> +config ARCH_HAS_DMA_PREP_COHERENT
> +	bool
> +

I guess the sorting in this whole Kconfig is already more or less 
"randomly-perturbed semi-alphabetical" :(

Anyway,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   config ARCH_HAS_DMA_COHERENT_TO_PFN
>   	bool
>   
> 
