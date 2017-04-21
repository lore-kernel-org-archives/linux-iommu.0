From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS
	mmaping code
Date: Fri, 21 Apr 2017 18:32:33 +0100
Message-ID: <20170421173233.GE5312@e104818-lin.cambridge.arm.com>
References: <CGME20170331110300eucas1p1535f003de554a9f6e1db56eb47630885@eucas1p1.samsung.com>
	<1490958171-2303-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490958171-2303-1-git-send-email-a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 31, 2017 at 01:02:51PM +0200, Andrzej Hajda wrote:
> In case of DMA_ATTR_FORCE_CONTIGUOUS allocations vm_area->pages
> is invalid. __iommu_mmap_attrs and __iommu_get_sgtable should not
> use it and take advantage of contiguous nature of the allocation.

As I replied to your original patch, I think
dma_common_contiguous_remap() should be fixed not to leave a dangling
area->pages pointer.

>  arch/arm64/mm/dma-mapping.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index f7b5401..41c7c36 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -703,6 +703,10 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>  	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
>  		return ret;
>  
> +	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS)
> +		return vm_iomap_memory(vma,
> +				page_to_phys(vmalloc_to_page(cpu_addr)), size);

I replied to Geert's patch on whether we actually need to call
dma_common_contiguous_remap() in __iommu_alloc_attrs() if the device is
coherent. We don't do this for the swiotlb allocation. If we are going
to change this, cpu_addr may or may not be in the vmalloc range and
vmalloc_to_page() would fail (I guess we could add an is_vmalloc_addr()
check).

Alternatively, just open-code dma_common_contiguous_remap() in
__iommu_alloc_attrs() to keep a valid area->pages around (I think Geert
already suggested this). AFAICT, arch/arm does this already in its own
__iommu_alloc_buffer().

Yet another option would be for iommu_dma_alloc() to understand
DMA_ATTR_FORCE_CONTIGUOUS and remove the arm64-specific handling.

> @@ -715,8 +719,19 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>  			       size_t size, unsigned long attrs)
>  {
>  	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	struct vm_struct *area = find_vm_area(cpu_addr);
> +	struct vm_struct *area;
> +
> +	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +		int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +
> +		if (!ret)
> +			sg_set_page(sgt->sgl, vmalloc_to_page(cpu_addr),
> +				    PAGE_ALIGN(size), 0);
>  
> +		return ret;
> +	}
> +
> +	area = find_vm_area(cpu_addr);

As Russell already stated, this function needs a "fix" regardless of the
DMA_ATTR_FORCE_CONTIGUOUS as we may not have page structures
(*_from_coherent allocations). But I agree with you that
dma_get_sgtable() issues should be addressed separately (and I'm happy
to disable such API on arm64 until sorted).

-- 
Catalin
