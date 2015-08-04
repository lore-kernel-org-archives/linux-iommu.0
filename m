From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 05/13] iommu/io-pgtable-arm: Allow appropriate DMA API use
Date: Tue, 04 Aug 2015 16:16:28 +0300
Message-ID: <1652248.uq2uhTW4Yd@avalon>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
	<1438608355-7335-6-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438608355-7335-6-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will and Robin,

Thank you for the patch.

On Monday 03 August 2015 14:25:47 Will Deacon wrote:
> From: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
> 
> Currently, users of the LPAE page table code are (ab)using dma_map_page()
> as a means to flush page table updates for non-coherent IOMMUs. Since
> from the CPU's point of view, creating IOMMU page tables *is* passing
> DMA buffers to a device (the IOMMU's page table walker), there's little
> reason not to use the DMA API correctly.
> 
> Allow IOMMU drivers to opt into DMA API operations for page table
> allocation and updates by providing their appropriate device pointer.
> The expectation is that an LPAE IOMMU should have a full view of system
> memory, so use streaming mappings to avoid unnecessary pressure on
> ZONE_DMA, and treat any DMA translation as a warning sign.

I like the idea of doing this in core code rather than in individual drivers, 
but I believe we're not using the right API. Please see below.

> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig          |   3 +-
>  drivers/iommu/io-pgtable-arm.c | 107 +++++++++++++++++++++++++++++---------
>  drivers/iommu/io-pgtable.h     |   3 ++
>  3 files changed, 89 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f1fb1d3ccc56..d77a848d50de 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -23,7 +23,8 @@ config IOMMU_IO_PGTABLE
>  config IOMMU_IO_PGTABLE_LPAE
>  	bool "ARMv7/v8 Long Descriptor Format"
>  	select IOMMU_IO_PGTABLE
> -	depends on ARM || ARM64 || COMPILE_TEST
> +	# SWIOTLB guarantees a dma_to_phys() implementation
> +	depends on ARM || ARM64 || (COMPILE_TEST && SWIOTLB)
>  	help
>  	  Enable support for the ARM long descriptor pagetable format.
>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 4e460216bd16..28cca8a652f9 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -200,12 +200,76 @@ typedef u64 arm_lpae_iopte;
> 
>  static bool selftest_running = false;
> 
> +static dma_addr_t __arm_lpae_dma_addr(struct device *dev, void *pages)
> +{
> +	return phys_to_dma(dev, virt_to_phys(pages));
> +}
> +
> +static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
> +				    struct io_pgtable_cfg *cfg)
> +{
> +	struct device *dev = cfg->iommu_dev;
> +	dma_addr_t dma;
> +	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
> +
> +	if (!pages)
> +		return NULL;
> +
> +	if (dev) {
> +		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
> +		if (dma_mapping_error(dev, dma))
> +			goto out_free;
> +		/*
> +		 * We depend on the IOMMU being able to work with any physical
> +		 * address directly, so if the DMA layer suggests it can't by
> +		 * giving us back some translation, that bodes very badly...
> +		 */
> +		if (dma != __arm_lpae_dma_addr(dev, pages))
> +			goto out_unmap;

Why do we need to create a mapping at all then ? Because 
dma_sync_single_for_device() requires it ?

> +	}
> +
> +	return pages;
> +
> +out_unmap:
> +	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page
> tables\n");
> +	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
> +out_free:
> +	free_pages_exact(pages, size);
> +	return NULL;
> +}
> +
> +static void __arm_lpae_free_pages(void *pages, size_t size,
> +				  struct io_pgtable_cfg *cfg)
> +{
> +	struct device *dev = cfg->iommu_dev;
> +
> +	if (dev)
> +		dma_unmap_single(dev, __arm_lpae_dma_addr(dev, pages),
> +				 size, DMA_TO_DEVICE);
> +	free_pages_exact(pages, size);
> +}
> +
> +static void __arm_lpae_set_pte(arm_lpae_iopte *ptep, arm_lpae_iopte pte,
> +			       struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +	struct device *dev = cfg->iommu_dev;
> +
> +	*ptep = pte;
> +
> +	if (dev)
> +		dma_sync_single_for_device(dev, __arm_lpae_dma_addr(dev, ptep),
> +					   sizeof(pte), DMA_TO_DEVICE);

This is what I believe to be an API abuse. The dma_sync_single_for_device() 
API is meant to pass ownership of a buffer to the device. Unless I'm mistaken, 
once that's done the CPU isn't allowed to touch the buffer anymore until 
dma_sync_single_for_cpu() is called to get ownership of the buffer back. Sure, 
it might work on many ARM systems, but we really should be careful not to use 
APIs as delicate as DMA mapping and cache handling for purposes different than 
what they explicitly allow.

It might be that I'm wrong and that the streaming DMA API allows this exact 
kind of usage, but I haven't found a clear indication of that in the 
documentation. It could also be that all implementations would support it 
today, and that we would then consider it should be explicitly allowed by the 
API. In both cases a documentation patch would be welcome.

> +	else if (cfg->tlb->flush_pgtable)
> +		cfg->tlb->flush_pgtable(ptep, sizeof(pte), cookie);
> +}
> +
>  static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>  			     unsigned long iova, phys_addr_t paddr,
>  			     arm_lpae_iopte prot, int lvl,
>  			     arm_lpae_iopte *ptep)
>  {
>  	arm_lpae_iopte pte = prot;
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> 
>  	/* We require an unmap first */
>  	if (iopte_leaf(*ptep, lvl)) {
> @@ -213,7 +277,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable
> *data, return -EEXIST;
>  	}
> 
> -	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
>  		pte |= ARM_LPAE_PTE_NS;
> 
>  	if (lvl == ARM_LPAE_MAX_LEVELS - 1)
> @@ -224,8 +288,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable
> *data, pte |= ARM_LPAE_PTE_AF | ARM_LPAE_PTE_SH_IS;
>  	pte |= pfn_to_iopte(paddr >> data->pg_shift, data);
> 
> -	*ptep = pte;
> -	data->iop.cfg.tlb->flush_pgtable(ptep, sizeof(*ptep), data->iop.cookie);
> +	__arm_lpae_set_pte(ptep, pte, cfg, data->iop.cookie);
>  	return 0;
>  }
> 
> @@ -236,12 +299,13 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable
> *data, unsigned long iova, arm_lpae_iopte *cptep, pte;
>  	void *cookie = data->iop.cookie;
>  	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> 
>  	/* Find our entry at the current level */
>  	ptep += ARM_LPAE_LVL_IDX(iova, lvl, data);
> 
>  	/* If we can install a leaf entry at this level, then do so */
> -	if (size == block_size && (size & data->iop.cfg.pgsize_bitmap))
> +	if (size == block_size && (size & cfg->pgsize_bitmap))
>  		return arm_lpae_init_pte(data, iova, paddr, prot, lvl, ptep);
> 
>  	/* We can't allocate tables at the final level */
> @@ -251,18 +315,15 @@ static int __arm_lpae_map(struct arm_lpae_io_pgtable
> *data, unsigned long iova, /* Grab a pointer to the next level */
>  	pte = *ptep;
>  	if (!pte) {
> -		cptep = alloc_pages_exact(1UL << data->pg_shift,
> -					 GFP_ATOMIC | __GFP_ZERO);
> +		cptep = __arm_lpae_alloc_pages(1UL << data->pg_shift,
> +					       GFP_ATOMIC, cfg);
>  		if (!cptep)
>  			return -ENOMEM;
> 
> -		data->iop.cfg.tlb->flush_pgtable(cptep, 1UL << data->pg_shift,
> -						 cookie);
>  		pte = __pa(cptep) | ARM_LPAE_PTE_TYPE_TABLE;
> -		if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> +		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
>  			pte |= ARM_LPAE_PTE_NSTABLE;
> -		*ptep = pte;
> -		data->iop.cfg.tlb->flush_pgtable(ptep, sizeof(*ptep), cookie);
> +		__arm_lpae_set_pte(ptep, pte, cfg, cookie);
>  	} else {
>  		cptep = iopte_deref(pte, data);
>  	}
> @@ -347,7 +408,7 @@ static void __arm_lpae_free_pgtable(struct
> arm_lpae_io_pgtable *data, int lvl, __arm_lpae_free_pgtable(data, lvl + 1,
> iopte_deref(pte, data)); }
> 
> -	free_pages_exact(start, table_size);
> +	__arm_lpae_free_pages(start, table_size, &data->iop.cfg);
>  }
> 
>  static void arm_lpae_free_pgtable(struct io_pgtable *iop)
> @@ -366,8 +427,8 @@ static int arm_lpae_split_blk_unmap(struct
> arm_lpae_io_pgtable *data, unsigned long blk_start, blk_end;
>  	phys_addr_t blk_paddr;
>  	arm_lpae_iopte table = 0;
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	void *cookie = data->iop.cookie;
> -	const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> 
>  	blk_start = iova & ~(blk_size - 1);
>  	blk_end = blk_start + blk_size;
> @@ -393,10 +454,9 @@ static int arm_lpae_split_blk_unmap(struct
> arm_lpae_io_pgtable *data, }
>  	}
> 
> -	*ptep = table;
> -	tlb->flush_pgtable(ptep, sizeof(*ptep), cookie);
> +	__arm_lpae_set_pte(ptep, table, cfg, cookie);
>  	iova &= ~(blk_size - 1);
> -	tlb->tlb_add_flush(iova, blk_size, true, cookie);
> +	cfg->tlb->tlb_add_flush(iova, blk_size, true, cookie);
>  	return size;
>  }
> 
> @@ -418,13 +478,12 @@ static int __arm_lpae_unmap(struct arm_lpae_io_pgtable
> *data,
> 
>  	/* If the size matches this level, we're in the right place */
>  	if (size == blk_size) {
> -		*ptep = 0;
> -		tlb->flush_pgtable(ptep, sizeof(*ptep), cookie);
> +		__arm_lpae_set_pte(ptep, 0, &data->iop.cfg, cookie);
> 
>  		if (!iopte_leaf(pte, lvl)) {
>  			/* Also flush any partial walks */
>  			tlb->tlb_add_flush(iova, size, false, cookie);
> -			tlb->tlb_sync(data->iop.cookie);
> +			tlb->tlb_sync(cookie);
>  			ptep = iopte_deref(pte, data);
>  			__arm_lpae_free_pgtable(data, lvl + 1, ptep);
>  		} else {
> @@ -640,11 +699,12 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg
> *cfg, void *cookie) cfg->arm_lpae_s1_cfg.mair[1] = 0;
> 
>  	/* Looking good; allocate a pgd */
> -	data->pgd = alloc_pages_exact(data->pgd_size, GFP_KERNEL | __GFP_ZERO);
> +	data->pgd = __arm_lpae_alloc_pages(data->pgd_size, GFP_KERNEL, cfg);
>  	if (!data->pgd)
>  		goto out_free_data;
> 
> -	cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);
> +	if (cfg->tlb->flush_pgtable)
> +		cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);
> 
>  	/* TTBRs */
>  	cfg->arm_lpae_s1_cfg.ttbr[0] = virt_to_phys(data->pgd);
> @@ -728,11 +788,12 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg
> *cfg, void *cookie) cfg->arm_lpae_s2_cfg.vtcr = reg;
> 
>  	/* Allocate pgd pages */
> -	data->pgd = alloc_pages_exact(data->pgd_size, GFP_KERNEL | __GFP_ZERO);
> +	data->pgd = __arm_lpae_alloc_pages(data->pgd_size, GFP_KERNEL, cfg);
>  	if (!data->pgd)
>  		goto out_free_data;
> 
> -	cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);
> +	if (cfg->tlb->flush_pgtable)
> +		cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);
> 
>  	/* VTTBR */
>  	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd);
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 10e32f69c668..c69529c78914 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -41,6 +41,8 @@ struct iommu_gather_ops {
>   * @ias:           Input address (iova) size, in bits.
>   * @oas:           Output address (paddr) size, in bits.
>   * @tlb:           TLB management callbacks for this set of tables.
> + * @iommu_dev:     The device representing the DMA configuration for the
> + *                 page table walker.
>   */
>  struct io_pgtable_cfg {
>  	#define IO_PGTABLE_QUIRK_ARM_NS	(1 << 0)	/* Set NS bit in PTEs */
> @@ -49,6 +51,7 @@ struct io_pgtable_cfg {
>  	unsigned int			ias;
>  	unsigned int			oas;
>  	const struct iommu_gather_ops	*tlb;
> +	struct device			*iommu_dev;
> 
>  	/* Low-level data specific to the table format */
>  	union {

-- 
Regards,

Laurent Pinchart
