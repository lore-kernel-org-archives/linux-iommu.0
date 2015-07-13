From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 2/4] iommu: Implement common IOMMU ops for DMA mapping
Date: Mon, 13 Jul 2015 20:34:13 +0800
Message-ID: <1436790853.25951.20.camel@mhfsdcap03>
References: <cover.1436552949.git.robin.murphy@arm.com>
	<d1a97aaee42f30370b58b3f7ed6a3559633010ad.1436552949.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <d1a97aaee42f30370b58b3f7ed6a3559633010ad.1436552949.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-07-10 at 20:19 +0100, Robin Murphy wrote:
> Taking inspiration from the existing arch/arm code, break out some
> generic functions to interface the DMA-API to the IOMMU-API. This will
> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig     |   7 +
>  drivers/iommu/Makefile    |   1 +
>  drivers/iommu/dma-iommu.c | 536 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h |  84 ++++++++
>  include/linux/iommu.h     |   1 +
>  5 files changed, 629 insertions(+)
>  create mode 100644 drivers/iommu/dma-iommu.c
>  create mode 100644 include/linux/dma-iommu.h
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index f1fb1d3..efb0e66 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -48,6 +48,13 @@ config OF_IOMMU
>         def_bool y
>         depends on OF && IOMMU_API
>  
> +# IOMMU-agnostic DMA-mapping layer
> +config IOMMU_DMA
> +	bool
> +	depends on NEED_SG_DMA_LENGTH
> +	select IOMMU_API
> +	select IOMMU_IOVA
> +
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
>  	depends on PPC32
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index c6dcc51..f465cfb 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> +obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>  obj-$(CONFIG_IOMMU_IOVA) += iova.o
[...]
> +/**
> + * iommu_dma_alloc - Allocate and map a buffer contiguous in IOVA space
> + * @dev: Device to allocate memory for. Must be a real device
> + *	 attached to an iommu_dma_domain
> + * @size: Size of buffer in bytes
> + * @gfp: Allocation flags
> + * @prot: IOMMU mapping flags
> + * @coherent: Which dma_mask to base IOVA allocation on
> + * @handle: Out argument for allocated DMA handle
> + * @flush_page: Arch callback to flush a single page from caches as
> + *		necessary. May be NULL for coherent allocations
> + *
> + * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
> + * but an IOMMU which supports smaller pages might not map the whole thing.
> + * For now, the buffer is unconditionally zeroed for compatibility
> + *
> + * Return: Array of struct page pointers describing the buffer,
> + *	   or NULL on failure.
> + */
> +struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> +		int prot, bool coherent, dma_addr_t *handle,
> +		void (*flush_page)(const void *, phys_addr_t))
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);

Compare with DMA-v2."struct iommu_dma_domain" is deleted and the iommu
domain is got from its iommu_group->domain. So I have to create a
iommu_group.
And the struct iommu_group is defined in iommu.c, I can not write like
this: group->domain = ****.

After check, I have to use iommu_attach_group.
Then our code may like this:
//====
static int mtk_iommu_add_device(struct device *dev)
{
      *******
	if (!dev->archdata.dma_ops)/* Not a iommu client device */
		return -ENODEV;
	group = iommu_group_get(dev);
	if (!group)
		group = iommu_group_alloc();

	ret = iommu_group_add_device(group, dev);

	/* get the mtk_iommu_domain from the master iommu device */
        mtkdom = ****;
	iommu_attach_group(&mtkdom->domain, group); /*attach the iommu domain
*/
	iommu_group_put(group);
	return ret;
}

static int mtk_iommu_attach_device(struct iommu_domain *domain,
				   struct device *dev)
{
	struct mtk_iommu_domain *priv = to_mtk_domain(domain), *imudom;
	struct iommu_group *group;

	/* Reserve one iommu domain as the m4u domain which all 
	 * Multimedia modules share and free the others */
	if (!imudev->archdata.iommu)
		imudev->archdata.iommu = priv;
	else if (imudev->archdata.iommu != priv)
		iommu_domain_free(domain);

	group = iommu_group_get(dev);
      /* return 0 while the attach device is from
__iommu_attach_notifier.
       * the iommu_group will be created in add_device after
mtk-iommu-probe
       */
	if (!group)
		return 0;
	iommu_group_put(group);

	mtk_iommu_init_domain_context(priv); /* init the pagetable */
	mtk_iommu_config(priv, dev, true); /* config the iommu info */

	return 0;
}
//====
    Is it ok? I'm preparing the next patch like this, Could you help
give some suggestion about the flow.
    Thanks very much.

> +	struct iova_domain *iovad = domain->dma_api_cookie;
> +	struct iova *iova;
> +	struct page **pages;
> +	struct sg_table sgt;
> +	struct sg_mapping_iter miter;
> +	dma_addr_t dma_addr;
> +	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +	*handle = DMA_ERROR_CODE;
> +
> +	pages = __iommu_dma_alloc_pages(count, gfp);
> +	if (!pages)
> +		return NULL;
> +
> +	iova = __alloc_iova(dev, size, coherent);
> +	if (!iova)
> +		goto out_free_pages;
> +
> +	size = iova_align(iovad, size);
> +	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> +		goto out_free_iova;
> +
> +	dma_addr = iova_dma_addr(iovad, iova);
> +	if (iommu_map_sg(domain, dma_addr, sgt.sgl, sgt.orig_nents, prot)
> +			< size)
> +		goto out_free_sg;
> +
> +	/* Using the non-flushing flag since we're doing our own */
> +	sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
> +	while (sg_miter_next(&miter)) {
> +		memset(miter.addr, 0, PAGE_SIZE);
> +		if (flush_page)
> +			flush_page(miter.addr, page_to_phys(miter.page));
> +	}
> +	sg_miter_stop(&miter);
> +	sg_free_table(&sgt);
> +
> +	*handle = dma_addr;
> +	return pages;
> +
> +out_free_sg:
> +	sg_free_table(&sgt);
> +out_free_iova:
> +	__free_iova(iovad, iova);
> +out_free_pages:
> +	__iommu_dma_free_pages(pages, count);
> +	return NULL;
> +}
> +
[...]
>  enum iommu_cap {
