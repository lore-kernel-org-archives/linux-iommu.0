From: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS
	mmaping code
Date: Fri, 14 Apr 2017 10:28:58 +0200
Message-ID: <a9b645bc-0991-555f-93d4-9e2f5d1fefa4@samsung.com>
References: <CGME20170331110300eucas1p1535f003de554a9f6e1db56eb47630885@eucas1p1.samsung.com>
	<1490958171-2303-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1490958171-2303-1-git-send-email-a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Gently ping.

Regards
Andrzej

On 31.03.2017 13:02, Andrzej Hajda wrote:
> In case of DMA_ATTR_FORCE_CONTIGUOUS allocations vm_area->pages
> is invalid. __iommu_mmap_attrs and __iommu_get_sgtable should not
> use it and take advantage of contiguous nature of the allocation.
>
> Fixes: 44176bb ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
> Signed-off-by: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Hi Robin, Geert,
>
> In this version of the patch I have replaced temporal pages and
> iommu_dma_mmap with remap_pfn_range or rather its simplified version
> vm_iomap_memory.
> Unfortunately I have not find nice helper for sgtable creation, so I
> left sg allocation inside _iommu_mmap_attrs.
>
> As the fixing of DMA_ATTR_FORCE_CONTIGUOUS related crashes has higher
> priority I have focused only on it in this patch.
>
> Regards
> Andrzej
> ---
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
> +
>  	area = find_vm_area(cpu_addr);
>  	if (WARN_ON(!area || !area->pages))
>  		return -ENXIO;
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
>  	if (WARN_ON(!area || !area->pages))
>  		return -ENXIO;
>  
