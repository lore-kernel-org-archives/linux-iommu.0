From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 23/26] iommu/dma: Don't depend on CONFIG_DMA_DIRECT_REMAP
Date: Mon, 29 Apr 2019 15:46:28 +0100
Message-ID: <57ecaf25-ac9a-ec34-d552-bcbc1891875e@arm.com>
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-24-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422175942.18788-24-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 22/04/2019 18:59, Christoph Hellwig wrote:
> For entirely dma coherent architectures there is no requirement to ever
> remap dma coherent allocation.  Move all the remap and pool code under
> IS_ENABLED() checks and drop the Kconfig dependency.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/Kconfig     |  1 -
>   drivers/iommu/dma-iommu.c | 16 +++++++++-------
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index bdc14baf2ee5..6f07f3b21816 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -95,7 +95,6 @@ config IOMMU_DMA
>   	select IOMMU_API
>   	select IOMMU_IOVA
>   	select NEED_SG_DMA_LENGTH
> -	depends on DMA_DIRECT_REMAP
>   
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 8fc6098c1eeb..278a9a960107 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -923,10 +923,11 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
>   	struct page *page = NULL;
>   
>   	/* Non-coherent atomic allocation? Easy */
> -	if (dma_free_from_pool(cpu_addr, alloc_size))
> +	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> +	    dma_free_from_pool(cpu_addr, alloc_size))
>   		return;
>   
> -	if (is_vmalloc_addr(cpu_addr)) {
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
>   		/*
>   		 * If it the address is remapped, then it's either non-coherent
>   		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
> @@ -972,7 +973,7 @@ static void *iommu_dma_alloc_pages(struct device *dev, size_t size,
>   	if (!page)
>   		return NULL;
>   
> -	if (!coherent || PageHighMem(page)) {
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && (!coherent || PageHighMem(page))) {
>   		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
>   
>   		cpu_addr = dma_common_contiguous_remap(page, alloc_size,
> @@ -1005,11 +1006,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
>   
>   	gfp |= __GFP_ZERO;
>   
> -	if (gfpflags_allow_blocking(gfp) &&
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && gfpflags_allow_blocking(gfp) &&
>   	    !(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
>   		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
>   
> -	if (!gfpflags_allow_blocking(gfp) && !coherent)
> +	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
> +	    !gfpflags_allow_blocking(gfp) && !coherent)
>   		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
>   	else
>   		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
> @@ -1041,7 +1043,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
>   	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
>   		return -ENXIO;
>   
> -	if (is_vmalloc_addr(cpu_addr)) {
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
>   		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
>   		if (pages)
> @@ -1063,7 +1065,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   	struct page *page;
>   	int ret;
>   
> -	if (is_vmalloc_addr(cpu_addr)) {
> +	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
>   		struct page **pages = __iommu_dma_get_pages(cpu_addr);
>   
>   		if (pages) {
> 
