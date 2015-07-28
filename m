From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/io-pgtable-arm: Allow appropriate DMA API use
Date: Tue, 28 Jul 2015 11:17:23 +0100
Message-ID: <20150728101722.GF29209@arm.com>
References: <c8cc82fea26044e393ff857014d4146faac5ec1e.1438019069.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c8cc82fea26044e393ff857014d4146faac5ec1e.1438019069.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Mon, Jul 27, 2015 at 07:18:08PM +0100, Robin Murphy wrote:
> Currently, users of the LPAE page table code are (ab)using dma_map_page()
> as a means to flush page table updates for non-coherent IOMMUs. Since
> from the CPU's point of view, creating IOMMU page tables *is* passing
> DMA buffers to a device (the IOMMU's page table walker), there's little
> reason not to use the DMA API correctly.
> 
> Allow drivers to opt into appropriate DMA operations for page table
> allocation and updates by providing the relevant device, and make the
> flush_pgtable() callback optional in case those DMA API operations are
> sufficient. The expectation is that an LPAE IOMMU should have a full view
> of system memory, so use streaming mappings to avoid unnecessary pressure
> on ZONE_DMA, and treat any DMA translation as a warning sign.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Hi all,
> 
> Since Russell fixing Tegra[1] reminded me, I dug this out from, er,
> rather a long time ago[2] and tidied it up. I've tested the SMMUv2
> version with the MMU-401s on Juno (both coherent and non-coherent)
> with no visible regressions; I have the same hope for the SMMUv3 and
> IPMMU changes since they should be semantically identical. At worst
> the Renesas driver might need a larger DMA mask setting as per
> f1d84548694f, but given that there shouldn't be any highmem involved
> I'd think it should be OK as-is.
> 
> Robin.
> 
> [1]:http://article.gmane.org/gmane.linux.ports.tegra/23150
> [2]:http://article.gmane.org/gmane.linux.kernel.iommu/8972
> 
>  drivers/iommu/io-pgtable-arm.c | 107 +++++++++++++++++++++++++++++++----------
>  drivers/iommu/io-pgtable.h     |   2 +
>  2 files changed, 84 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 4e46021..b93a60e 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -200,12 +200,76 @@ typedef u64 arm_lpae_iopte;
>  
>  static bool selftest_running = false;
>  
> +static dma_addr_t __arm_lpae_dma(struct device *dev, void *pages)
> +{
> +	return phys_to_dma(dev, virt_to_phys(pages));
> +}
> +
> +static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
> +				    struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +	void *pages = alloc_pages_exact(size, gfp | __GFP_ZERO);
> +	struct device *dev = cfg->iommu_dev;
> +	dma_addr_t dma;
> +
> +	if (!pages)
> +		return NULL;

Missing newline here.

> +	if (dev) {
> +		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
> +		if (dma_mapping_error(dev, dma))
> +			goto out_free;
> +		/*
> +		 * We depend on the IOMMU being able to work with any physical
> +		 * address directly, so if the DMA layer suggests it can't by
> +		 * giving us back some translation, that bodes very badly...
> +		 */
> +		if (WARN(dma != __arm_lpae_dma(dev, pages),
> +			 "Cannot accommodate DMA translation for IOMMU page tables\n"))

Now that we have a struct device for the iommu, we could use dev_err to make
this diagnostic more useful.

> +			goto out_unmap;
> +	}

Missing newline again...

> +	if (cfg->tlb->flush_pgtable)

Why would you have both a dev and a flush callback? In which cases is the
DMA API insufficient?

> +		cfg->tlb->flush_pgtable(pages, size, cookie);

... and here (yeah, pedantry, but consistency keeps this file easier to
read).

> +	return pages;
> +
> +out_unmap:
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
> +		dma_unmap_single(dev, __arm_lpae_dma(dev, pages),
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
> +		dma_sync_single_for_device(dev, __arm_lpae_dma(dev, ptep),
> +					   sizeof(pte), DMA_TO_DEVICE);
> +	if (cfg->tlb->flush_pgtable)
> +		cfg->tlb->flush_pgtable(ptep, sizeof(pte), cookie);

Could we kill the flush_pgtable callback completely and just stick in a
dma_wmb() here? Ideally, we've have something like dma_store_release,
which we could use to set the parent page table entry, but that's left
as a future exercise ;)

> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 10e32f6..39fe864 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -41,6 +41,7 @@ struct iommu_gather_ops {
>   * @ias:           Input address (iova) size, in bits.
>   * @oas:           Output address (paddr) size, in bits.
>   * @tlb:           TLB management callbacks for this set of tables.
> + * @iommu_dev:     The owner of the page table memory (for DMA purposes).
>   */
>  struct io_pgtable_cfg {
>  	#define IO_PGTABLE_QUIRK_ARM_NS	(1 << 0)	/* Set NS bit in PTEs */
> @@ -49,6 +50,7 @@ struct io_pgtable_cfg {
>  	unsigned int			ias;
>  	unsigned int			oas;
>  	const struct iommu_gather_ops	*tlb;
> +	struct device			*iommu_dev;

I think we should also update the comments for iommu_gather_ops once
we decide on the fate of flush_pgtable.

Will
