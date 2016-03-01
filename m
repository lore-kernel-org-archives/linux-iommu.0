From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-armv7s: Fix kmem_cache_alloc() flags
Date: Tue, 1 Mar 2016 18:53:13 +0000
Message-ID: <20160301185312.GC14022@arm.com>
References: <cbd13a3db3924a67f8aa8a352f04c883c47d8815.1456856051.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cbd13a3db3924a67f8aa8a352f04c883c47d8815.1456856051.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 01, 2016 at 06:17:38PM +0000, Robin Murphy wrote:
> Whilst the default SLUB allocator happily just merges the original
> allocation flags from kmem_cache_create() with those passed through
> kmem_cache_alloc(), there is a code path in the SLAB allocator which
> will aggressively BUG_ON() if the cache was created with SLAB_CACHE_DMA
> but GFP_DMA is not specified for an allocation.

It would be nice to include the backtrace here.

> Keep the peace by adding GFP_DMA when allocating a table.
> 
> Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 9fcceb1..9488e3c 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -192,7 +192,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>  	if (lvl == 1)
>  		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
>  	else if (lvl == 2)
> -		table = kmem_cache_zalloc(data->l2_tables, gfp);
> +		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
>  	if (table && !selftest_running) {
>  		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
>  		if (dma_mapping_error(dev, dma))

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Will
