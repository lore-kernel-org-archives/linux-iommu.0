From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 3/4] arm64: Add IOMMU dma_ops
Date: Thu, 18 Jun 2015 23:00:50 +0800
Message-ID: <1434639650.26953.13.camel@mhfsdcap03>
References: <cover.1434036796.git.robin.murphy@arm.com>
	<4e298538ccedbe6f593d8edc40eb3a08ad9e4df5.1434036796.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4e298538ccedbe6f593d8edc40eb3a08ad9e4df5.1434036796.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-06-11 at 16:54 +0100, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> 
> Whilst proliferating per-device private IOMMU data via dev->archdata is
> less than ideal, it will do the job for now, especially since we can't
> easily handle the kind of problematic system topologies in the current
> IOMMU API anyway.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm64/include/asm/device.h      |   3 +
>  arch/arm64/include/asm/dma-mapping.h |  14 ++
>  arch/arm64/mm/dma-mapping.c          | 342 +++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h            |   4 +-
>  4 files changed, 361 insertions(+), 2 deletions(-)
[snip]
> +static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
> +			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +			      struct dma_attrs *attrs)
> +{
> +	struct vm_struct *area;
> +	int ret;
> +
> +	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot,
> +					     is_device_dma_coherent(dev));
> +
> +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> +		return ret;
> +
> +	area = find_vm_area(cpu_addr);
> +	if (WARN_ON(!area || area->pages))
Is it:    if (WARN_ON(!area || !area->pages))
> +		return -ENXIO;
> +
> +	return iommu_dma_mmap(area->pages, size, vma);
> +}
[snip]
>  #endif	/* __KERNEL__ */
>  #endif	/* __DMA_IOMMU_H */
