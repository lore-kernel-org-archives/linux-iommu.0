From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 2/5] dma-mapping: move the dma_coherent flag to struct
 device
Date: Fri, 31 Aug 2018 13:11:55 -0700
Message-ID: <20180831201155.vqhrmn5fdlqv3fpr@pburton-laptop>
References: <20180827145032.9522-1-hch@lst.de>
 <20180827145032.9522-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180827145032.9522-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Mon, Aug 27, 2018 at 04:50:29PM +0200, Christoph Hellwig wrote:
> Various architectures support both coherent and non-coherent dma on
> a per-device basis.  Move the dma_noncoherent flag from mips the
> mips archdata field to struct device proper to prepare the
> infrastructure for reuse on other architectures.

"mips the mips"

> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index a0aa00cc909d..f99748e9c08e 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -4,6 +4,24 @@
>  
>  #include <linux/dma-mapping.h>
>  
> +#ifdef CONFIG_ARCH_HAS_DMA_COHERENCE_H
> +#include <asm/dma-coherence.h>
> +#else
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)

#elif ?

Thanks,
    Paul
