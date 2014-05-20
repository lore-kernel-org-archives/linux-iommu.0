From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] arm: dma-iommu: Clean up redundant variable
Date: Tue, 20 May 2014 15:06:37 +0200
Message-ID: <537B535D.1090303@samsung.com>
References: <1400560379-1502-1-git-send-email-ritesh.harjani@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1400560379-1502-1-git-send-email-ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org
Cc: mp.vikram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-05-20 06:32, ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> mapping->size can be derived from mapping->bits << PAGE_SHIFT
> which makes mapping->size as redundant.
>
> Clean this up.
>
> Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reported-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Thanks for this cleanup. I will add it to my tree.

> ---
>   arch/arm/include/asm/dma-iommu.h |  1 -
>   arch/arm/mm/dma-mapping.c        | 11 ++++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
> index eec0a12..8e3fcb9 100644
> --- a/arch/arm/include/asm/dma-iommu.h
> +++ b/arch/arm/include/asm/dma-iommu.h
> @@ -18,7 +18,6 @@ struct dma_iommu_mapping {
>   	unsigned int		extensions;
>   	size_t			bitmap_size;	/* size of a single bitmap */
>   	size_t			bits;		/* per bitmap */
> -	unsigned int		size;		/* per bitmap */
>   	dma_addr_t		base;
>   
>   	spinlock_t		lock;
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 6b00be1..3d43c41 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1074,6 +1074,7 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
>   	unsigned int order = get_order(size);
>   	unsigned int align = 0;
>   	unsigned int count, start;
> +	size_t mapping_size = mapping->bits << PAGE_SHIFT;
>   	unsigned long flags;
>   	dma_addr_t iova;
>   	int i;
> @@ -1119,7 +1120,7 @@ static inline dma_addr_t __alloc_iova(struct dma_iommu_mapping *mapping,
>   	}
>   	spin_unlock_irqrestore(&mapping->lock, flags);
>   
> -	iova = mapping->base + (mapping->size * i);
> +	iova = mapping->base + (mapping_size * i);
>   	iova += start << PAGE_SHIFT;
>   
>   	return iova;
> @@ -1129,6 +1130,7 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
>   			       dma_addr_t addr, size_t size)
>   {
>   	unsigned int start, count;
> +	size_t mapping_size = mapping->bits << PAGE_SHIFT;
>   	unsigned long flags;
>   	dma_addr_t bitmap_base;
>   	u32 bitmap_index;
> @@ -1136,14 +1138,14 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
>   	if (!size)
>   		return;
>   
> -	bitmap_index = (u32) (addr - mapping->base) / (u32) mapping->size;
> +	bitmap_index = (u32) (addr - mapping->base) / (u32) mapping_size;
>   	BUG_ON(addr < mapping->base || bitmap_index > mapping->extensions);
>   
> -	bitmap_base = mapping->base + mapping->size * bitmap_index;
> +	bitmap_base = mapping->base + mapping_size * bitmap_index;
>   
>   	start = (addr - bitmap_base) >>	PAGE_SHIFT;
>   
> -	if (addr + size > bitmap_base + mapping->size) {
> +	if (addr + size > bitmap_base + mapping_size) {
>   		/*
>   		 * The address range to be freed reaches into the iova
>   		 * range of the next bitmap. This should not happen as
> @@ -1964,7 +1966,6 @@ arm_iommu_create_mapping(struct bus_type *bus, dma_addr_t base, size_t size)
>   	mapping->extensions = extensions;
>   	mapping->base = base;
>   	mapping->bits = BITS_PER_BYTE * bitmap_size;
> -	mapping->size = mapping->bits << PAGE_SHIFT;
>   
>   	spin_lock_init(&mapping->lock);
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
