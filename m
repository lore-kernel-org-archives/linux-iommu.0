From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/9] ARM: dma-mapping: Always pass proper prot flags to
	iommu_map()
Date: Mon, 30 Sep 2013 15:40:58 +0200
Message-ID: <52497F6A.2090505@samsung.com>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380234982-1677-4-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1380234982-1677-4-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2013-09-27 00:36, Andreas Herrmann wrote:
> ... otherwise it is impossible for the low level iommu driver to
> figure out which pte flags should be used.
>
> In __map_sg_chunk we can derive the flags from dma_data_direction.
>
> In __iommu_create_mapping we should treat the memory like
> DMA_BIDIRECTIONAL and pass both IOMMU_READ and IOMMU_WRITE to
> iommu_map.
> __iommu_create_mapping is used during dma_alloc_coherent (via
> arm_iommu_alloc_attrs).  AFAIK dma_alloc_coherent is responsible for
> allocation _and_ mapping.  I think this implies that access to the
> mapped pages should be allowed.
>
> Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Thanks pointing the issue and preparing the patch. I will push it to the 
dma-mapping fixes branch.

> ---
>   arch/arm/mm/dma-mapping.c |   43 ++++++++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f5e1a84..1272ed2 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1232,7 +1232,8 @@ __iommu_create_mapping(struct device *dev, struct page **pages, size_t size)
>   				break;
>   
>   		len = (j - i) << PAGE_SHIFT;
> -		ret = iommu_map(mapping->domain, iova, phys, len, 0);
> +		ret = iommu_map(mapping->domain, iova, phys, len,
> +				IOMMU_READ|IOMMU_WRITE);
>   		if (ret < 0)
>   			goto fail;
>   		iova += len;
> @@ -1431,6 +1432,27 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>   					 GFP_KERNEL);
>   }
>   
> +static int __dma_direction_to_prot(enum dma_data_direction dir)
> +{
> +	int prot;
> +
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
> +	return prot;
> +}
> +
>   /*
>    * Map a part of the scatter-gather list into contiguous io address space
>    */
> @@ -1444,6 +1466,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
>   	int ret = 0;
>   	unsigned int count;
>   	struct scatterlist *s;
> +	int prot;
>   
>   	size = PAGE_ALIGN(size);
>   	*handle = DMA_ERROR_CODE;
> @@ -1460,7 +1483,9 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
>   			!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
>   			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
>   
> -		ret = iommu_map(mapping->domain, iova, phys, len, 0);
> +		prot = __dma_direction_to_prot(dir);
> +
> +		ret = iommu_map(mapping->domain, iova, phys, len, prot);
>   		if (ret < 0)
>   			goto fail;
>   		count += len >> PAGE_SHIFT;
> @@ -1665,19 +1690,7 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
>   	if (dma_addr == DMA_ERROR_CODE)
>   		return dma_addr;
>   
> -	switch (dir) {
> -	case DMA_BIDIRECTIONAL:
> -		prot = IOMMU_READ | IOMMU_WRITE;
> -		break;
> -	case DMA_TO_DEVICE:
> -		prot = IOMMU_READ;
> -		break;
> -	case DMA_FROM_DEVICE:
> -		prot = IOMMU_WRITE;
> -		break;
> -	default:
> -		prot = 0;
> -	}
> +	prot = __dma_direction_to_prot(dir);
>   
>   	ret = iommu_map(mapping->domain, dma_addr, page_to_phys(page), len, prot);
>   	if (ret < 0)

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
