From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC PATCH 15/15] iommu/exynos: update to use iommu big-endian
Date: Thu, 09 Jun 2016 08:51:18 +0200
Message-ID: <338cbdc6-2830-813b-713e-1cc40d23d1f9@samsung.com>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-16-matthew@mattleach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20160608183110.13851-16-matthew@mattleach.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Matthew Leach <matthew@mattleach.net>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi


On 2016-06-08 20:31, Matthew Leach wrote:
> From: Ben Dooks <ben.dooks@codethink.co.uk>
>
> Add initial support for big endian by always writing the pte
> in le32. Note, revisit if hardware capable of doing big endian
> fetches.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Just to keep my curiosity satisfied - what's the reason to use
big-endian on ARM?

Good luck with fixing the kernel and userspace codes, which usually
assume little-endian is the only possible order!

> ---
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org (open list)
> ---
>   drivers/iommu/exynos-iommu.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 5ecc86c..dd8b3b3 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -54,6 +54,10 @@ typedef u32 sysmmu_pte_t;
>   #define lv2ent_small(pent) ((*(pent) & 2) == 2)
>   #define lv2ent_large(pent) ((*(pent) & 3) == 1)
>   
> +#ifdef CONFIG_BIG_ENDIAN
> +#warning "revisit driver if we can enable big-endian ptes"
> +#endif
> +

This warning can be removed. There is no way to force SYSMMU to operate with
big-endian PTEs according to the datasheet.

>   /*
>    * v1.x - v3.x SYSMMU supports 32bit physical and 32bit virtual address spaces
>    * v5.0 introduced support for 36bit physical address space by shifting
> @@ -716,7 +720,7 @@ static inline void update_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
>   {
>   	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent), sizeof(*ent),
>   				DMA_TO_DEVICE);
> -	*ent = val;
> +	*ent = cpu_to_le32(val);
>   	dma_sync_single_for_device(dma_dev, virt_to_phys(ent), sizeof(*ent),
>   				   DMA_TO_DEVICE);
>   }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
