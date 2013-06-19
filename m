From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
 protection attributes
Date: Wed, 19 Jun 2013 10:37:03 +0200
Message-ID: <51C16DAF.1090205@samsung.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-4-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1370889285-22799-4-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: iommu@lists.linux-foundation.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 6/10/2013 8:34 PM, Will Deacon wrote:
> IOMMU mappings take a prot parameter, identifying the protection bits
> to enforce on the newly created mapping (READ or WRITE). The ARM
> dma-mapping framework currently just passes 0 as the prot argument,
> resulting in faulting mappings.
>
> This patch infers the protection attributes based on the direction of
> the DMA transfer.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks for fixing this issue. Could I take this patch to my dma-mapping tree
with other dma-mapping changes I've collected recently or do you want my ack
and push it via other tree?

> ---
>   arch/arm/mm/dma-mapping.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 6fb80cf..d119de7 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1636,13 +1636,27 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
>   {
>   	struct dma_iommu_mapping *mapping = dev->archdata.mapping;
>   	dma_addr_t dma_addr;
> -	int ret, len = PAGE_ALIGN(size + offset);
> +	int ret, prot, len = PAGE_ALIGN(size + offset);
>   
>   	dma_addr = __alloc_iova(mapping, len);
>   	if (dma_addr == DMA_ERROR_CODE)
>   		return dma_addr;
>   
> -	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, 0);
> +	switch (dir) {
> +	case DMA_BIDIRECTIONAL:
> +		prot = IOMMU_READ | IOMMU_WRITE;
> +		break;
> +	case DMA_TO_DEVICE:
> +		prot = IOMMU_READ;
> +		break;
> +	case DMA_FROM_DEVICE:
> +		prot = IOMMU_WRITE;
> +		break;
> +	default:
> +		prot = 0;
> +	}
> +
> +	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
>   	if (ret < 0)
>   		goto fail;
>   

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
