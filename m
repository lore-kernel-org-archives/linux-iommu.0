From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 3/4] arm64: Add IOMMU dma_ops
Date: Tue, 28 Jul 2015 18:27:11 +0100
Message-ID: <20150728172710.GB536@e104818-lin.cambridge.arm.com>
References: <cover.1437070995.git.robin.murphy@arm.com>
	<f51a6dfad1367107b07ca43624a990a62f3d4f3c.1437070995.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f51a6dfad1367107b07ca43624a990a62f3d4f3c.1437070995.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 16, 2015 at 07:40:14PM +0100, Robin Murphy wrote:
> +static void *__iommu_alloc_attrs(struct device *dev, size_t size,
> +				 dma_addr_t *handle, gfp_t gfp,
> +				 struct dma_attrs *attrs)
> +{
> +	bool coherent = is_device_dma_coherent(dev);
> +	int ioprot = dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
> +	void *addr;
> +
> +	if (WARN(!dev, "cannot create IOMMU mapping for unknown device\n"))
> +		return NULL;
> +
> +	/*
> +	 * Some drivers rely on this, and we may not want to potentially
> +	 * expose stale kernel data to devices anyway.
> +	 */
> +	gfp |= __GFP_ZERO;
> +
> +	if (gfp & __GFP_WAIT) {
> +		struct page **pages;
> +		pgprot_t pgprot = coherent ? __pgprot(PROT_NORMAL) :
> +					     __pgprot(PROT_NORMAL_NC);
> +
> +		pgprot = __get_dma_pgprot(attrs, pgprot, coherent);

I think you can simplify this:

		pgprot_t pgprot = __get_dma_pgprot(attrs, PAGE_KERNEL, coherent);

(and we could do the same in __dma_alloc)

> +		pages = iommu_dma_alloc(dev, size, gfp, ioprot,	handle,
> +					coherent ? NULL : flush_page);

I commented on patch 2/4. If we checked for IOMMU_CACHE in
iommu_dma_alloc(), we could always pass flush_page here without the
NULL.

> +		if (!pages)
> +			return NULL;
> +
> +		addr = dma_common_pages_remap(pages, size, VM_USERMAP, pgprot,
> +					      __builtin_return_address(0));
> +		if (!addr)
> +			iommu_dma_free(dev, pages, size, handle);

For arm64, it would have been easier to simply flush the caches here and
avoid the flush_page argument. However, I reread your earlier reply, so
if we ever honour the ATTR_NO_KERNEL_MAPPING, then we would have to
iterate over the individual pages in the arch code. Let's leave it as
per your patch 2/4 (with a flush_page argument).

-- 
Catalin
