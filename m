From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH 1/2] dma-mapping: add a kconfig symbol for
 arch_setup_dma_ops availability
Date: Mon, 11 Feb 2019 16:41:49 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146433294@US01WEMBX2.internal.synopsys.com>
References: <20190204081420.15083-1-hch@lst.de>
 <20190204081420.15083-2-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Burton <paul.burton@mips.com>
Cc: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

+CC Eugeniy=0A=
=0A=
As resident ARC DMA expert can you please this a quick spin.=0A=
=0A=
-Vineet=0A=
=0A=
On 2/4/19 12:14 AM, Christoph Hellwig wrote:=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  arch/arc/Kconfig                     |  1 +=0A=
>  arch/arc/include/asm/Kbuild          |  1 +=0A=
>  arch/arc/include/asm/dma-mapping.h   | 13 -------------=0A=
>  arch/arm/Kconfig                     |  1 +=0A=
>  arch/arm/include/asm/dma-mapping.h   |  4 ----=0A=
>  arch/arm64/Kconfig                   |  1 +=0A=
>  arch/arm64/include/asm/dma-mapping.h |  4 ----=0A=
>  arch/mips/Kconfig                    |  1 +=0A=
>  arch/mips/include/asm/dma-mapping.h  | 10 ----------=0A=
>  arch/mips/mm/dma-noncoherent.c       |  8 ++++++++=0A=
>  include/linux/dma-mapping.h          | 12 ++++++++----=0A=
>  kernel/dma/Kconfig                   |  3 +++=0A=
>  12 files changed, 24 insertions(+), 35 deletions(-)=0A=
>  delete mode 100644 arch/arc/include/asm/dma-mapping.h=0A=
>=0A=
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
> index 376366a7db81..2ab27d88eb1c 100644=0A=
> --- a/arch/arc/Kconfig=0A=
> +++ b/arch/arc/Kconfig=0A=
> @@ -11,6 +11,7 @@ config ARC=0A=
>  	select ARC_TIMERS=0A=
>  	select ARCH_HAS_DMA_COHERENT_TO_PFN=0A=
>  	select ARCH_HAS_PTE_SPECIAL=0A=
> +	select ARCH_HAS_SETUP_DMA_OPS=0A=
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU=0A=
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE=0A=
>  	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC=0A=
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild=0A=
> index caa270261521..b41f8881ecc8 100644=0A=
> --- a/arch/arc/include/asm/Kbuild=0A=
> +++ b/arch/arc/include/asm/Kbuild=0A=
> @@ -3,6 +3,7 @@ generic-y +=3D bugs.h=0A=
>  generic-y +=3D compat.h=0A=
>  generic-y +=3D device.h=0A=
>  generic-y +=3D div64.h=0A=
> +generic-y +=3D dma-mapping.h=0A=
>  generic-y +=3D emergency-restart.h=0A=
>  generic-y +=3D extable.h=0A=
>  generic-y +=3D ftrace.h=0A=
> diff --git a/arch/arc/include/asm/dma-mapping.h b/arch/arc/include/asm/dm=
a-mapping.h=0A=
> deleted file mode 100644=0A=
> index c946c0a83e76..000000000000=0A=
> --- a/arch/arc/include/asm/dma-mapping.h=0A=
> +++ /dev/null=0A=
> @@ -1,13 +0,0 @@=0A=
> -// SPDX-License-Identifier:  GPL-2.0=0A=
> -// (C) 2018 Synopsys, Inc. (www.synopsys.com)=0A=
> -=0A=
> -#ifndef ASM_ARC_DMA_MAPPING_H=0A=
> -#define ASM_ARC_DMA_MAPPING_H=0A=
> -=0A=
> -#include <asm-generic/dma-mapping.h>=0A=
> -=0A=
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> -			const struct iommu_ops *iommu, bool coherent);=0A=
> -#define arch_setup_dma_ops arch_setup_dma_ops=0A=
> -=0A=
> -#endif=0A=
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig=0A=
> index 664e918e2624..c1cf44f00870 100644=0A=
> --- a/arch/arm/Kconfig=0A=
> +++ b/arch/arm/Kconfig=0A=
> @@ -12,6 +12,7 @@ config ARM=0A=
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE=0A=
>  	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE=0A=
>  	select ARCH_HAS_PHYS_TO_DMA=0A=
> +	select ARCH_HAS_SETUP_DMA_OPS=0A=
>  	select ARCH_HAS_SET_MEMORY=0A=
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL=0A=
>  	select ARCH_HAS_STRICT_MODULE_RWX if MMU=0A=
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dm=
a-mapping.h=0A=
> index 31d3b96f0f4b..a224b6e39e58 100644=0A=
> --- a/arch/arm/include/asm/dma-mapping.h=0A=
> +++ b/arch/arm/include/asm/dma-mapping.h=0A=
> @@ -96,10 +96,6 @@ static inline unsigned long dma_max_pfn(struct device =
*dev)=0A=
>  }=0A=
>  #define dma_max_pfn(dev) dma_max_pfn(dev)=0A=
>  =0A=
> -#define arch_setup_dma_ops arch_setup_dma_ops=0A=
> -extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 siz=
e,=0A=
> -			       const struct iommu_ops *iommu, bool coherent);=0A=
> -=0A=
>  #ifdef CONFIG_MMU=0A=
>  #define arch_teardown_dma_ops arch_teardown_dma_ops=0A=
>  extern void arch_teardown_dma_ops(struct device *dev);=0A=
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig=0A=
> index a4168d366127..63909f318d56 100644=0A=
> --- a/arch/arm64/Kconfig=0A=
> +++ b/arch/arm64/Kconfig=0A=
> @@ -22,6 +22,7 @@ config ARM64=0A=
>  	select ARCH_HAS_KCOV=0A=
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE=0A=
>  	select ARCH_HAS_PTE_SPECIAL=0A=
> +	select ARCH_HAS_SETUP_DMA_OPS=0A=
>  	select ARCH_HAS_SET_MEMORY=0A=
>  	select ARCH_HAS_STRICT_KERNEL_RWX=0A=
>  	select ARCH_HAS_STRICT_MODULE_RWX=0A=
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/as=
m/dma-mapping.h=0A=
> index 95dbf3ef735a..de96507ee2c1 100644=0A=
> --- a/arch/arm64/include/asm/dma-mapping.h=0A=
> +++ b/arch/arm64/include/asm/dma-mapping.h=0A=
> @@ -29,10 +29,6 @@ static inline const struct dma_map_ops *get_arch_dma_o=
ps(struct bus_type *bus)=0A=
>  	return NULL;=0A=
>  }=0A=
>  =0A=
> -void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> -			const struct iommu_ops *iommu, bool coherent);=0A=
> -#define arch_setup_dma_ops	arch_setup_dma_ops=0A=
> -=0A=
>  #ifdef CONFIG_IOMMU_DMA=0A=
>  void arch_teardown_dma_ops(struct device *dev);=0A=
>  #define arch_teardown_dma_ops	arch_teardown_dma_ops=0A=
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig=0A=
> index 0d14f51d0002..dc5d70f674e0 100644=0A=
> --- a/arch/mips/Kconfig=0A=
> +++ b/arch/mips/Kconfig=0A=
> @@ -1118,6 +1118,7 @@ config DMA_MAYBE_COHERENT=0A=
>  =0A=
>  config DMA_PERDEV_COHERENT=0A=
>  	bool=0A=
> +	select ARCH_HAS_SETUP_DMA_OPS=0A=
>  	select DMA_NONCOHERENT=0A=
>  =0A=
>  config DMA_NONCOHERENT=0A=
> diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/=
dma-mapping.h=0A=
> index 20dfaad3a55d..34de7b17b41b 100644=0A=
> --- a/arch/mips/include/asm/dma-mapping.h=0A=
> +++ b/arch/mips/include/asm/dma-mapping.h=0A=
> @@ -15,14 +15,4 @@ static inline const struct dma_map_ops *get_arch_dma_o=
ps(struct bus_type *bus)=0A=
>  #endif=0A=
>  }=0A=
>  =0A=
> -#define arch_setup_dma_ops arch_setup_dma_ops=0A=
> -static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,=
=0A=
> -				      u64 size, const struct iommu_ops *iommu,=0A=
> -				      bool coherent)=0A=
> -{=0A=
> -#ifdef CONFIG_DMA_PERDEV_COHERENT=0A=
> -	dev->dma_coherent =3D coherent;=0A=
> -#endif=0A=
> -}=0A=
> -=0A=
>  #endif /* _ASM_DMA_MAPPING_H */=0A=
> diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoheren=
t.c=0A=
> index cb38461391cb..0606fc87b294 100644=0A=
> --- a/arch/mips/mm/dma-noncoherent.c=0A=
> +++ b/arch/mips/mm/dma-noncoherent.c=0A=
> @@ -159,3 +159,11 @@ void arch_dma_cache_sync(struct device *dev, void *v=
addr, size_t size,=0A=
>  =0A=
>  	dma_sync_virt(vaddr, size, direction);=0A=
>  }=0A=
> +=0A=
> +#ifdef CONFIG_DMA_PERDEV_COHERENT=0A=
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> +		const struct iommu_ops *iommu, bool coherent)=0A=
> +{=0A=
> +	dev->dma_coherent =3D coherent;=0A=
> +}=0A=
> +#endif=0A=
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h=0A=
> index b904d55247ab..2b20d60e6158 100644=0A=
> --- a/include/linux/dma-mapping.h=0A=
> +++ b/include/linux/dma-mapping.h=0A=
> @@ -671,11 +671,15 @@ static inline int dma_coerce_mask_and_coherent(stru=
ct device *dev, u64 mask)=0A=
>  	return dma_set_mask_and_coherent(dev, mask);=0A=
>  }=0A=
>  =0A=
> -#ifndef arch_setup_dma_ops=0A=
> +#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS=0A=
> +void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,=0A=
> +		const struct iommu_ops *iommu, bool coherent);=0A=
> +#else=0A=
>  static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,=
=0A=
> -				      u64 size, const struct iommu_ops *iommu,=0A=
> -				      bool coherent) { }=0A=
> -#endif=0A=
> +		u64 size, const struct iommu_ops *iommu, bool coherent)=0A=
> +{=0A=
> +}=0A=
> +#endif /* CONFIG_ARCH_HAS_SETUP_DMA_OPS */=0A=
>  =0A=
>  #ifndef arch_teardown_dma_ops=0A=
>  static inline void arch_teardown_dma_ops(struct device *dev) { }=0A=
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig=0A=
> index ca88b867e7fe..c44599d128e8 100644=0A=
> --- a/kernel/dma/Kconfig=0A=
> +++ b/kernel/dma/Kconfig=0A=
> @@ -19,6 +19,9 @@ config ARCH_HAS_DMA_COHERENCE_H=0A=
>  config HAVE_GENERIC_DMA_COHERENT=0A=
>  	bool=0A=
>  =0A=
> +config ARCH_HAS_SETUP_DMA_OPS=0A=
> +	bool=0A=
> +=0A=
>  config ARCH_HAS_SYNC_DMA_FOR_DEVICE=0A=
>  	bool=0A=
>  =0A=
=0A=
