From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 26/26] arm64: trim includes in dma-mapping.c
Date: Mon, 29 Apr 2019 16:00:22 +0100
Message-ID: <8d257026-870c-c183-4c34-48b9f8bc6872@arm.com>
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-27-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422175942.18788-27-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> With most of the previous functionality now elsewhere a lot of the
> headers included in this file are not needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 184ef9ccd69d..15bd768ceb7e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -5,20 +5,9 @@
>    */
>   
>   #include <linux/gfp.h>
> -#include <linux/acpi.h>
> -#include <linux/memblock.h>
>   #include <linux/cache.h>
> -#include <linux/export.h>
> -#include <linux/slab.h>
> -#include <linux/genalloc.h>
> -#include <linux/dma-direct.h>
>   #include <linux/dma-noncoherent.h>
> -#include <linux/dma-contiguous.h>
>   #include <linux/dma-iommu.h>
> -#include <linux/vmalloc.h>
> -#include <linux/swiotlb.h>
> -#include <linux/pci.h>
> -

Nit: please keep the blank line between linux/ and asm/ include blocks 
to match the predominant local style.

With that,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   #include <asm/cacheflush.h>
>   
>   pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> 
