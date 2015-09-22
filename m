From: Daniel Kurtz via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v5 2/3] arm64: Add IOMMU dma_ops
Date: Wed, 23 Sep 2015 01:12:13 +0800
Message-ID: <CAGS+omCDYrjpr--+sUzaKCxo12Eff6TC04RgroDgKvxHwK3t2Q@mail.gmail.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
	<8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
Reply-To: Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tiffany Lin <tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, wuchengli-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Pawel Osciak <posciak-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Sat, Aug 1, 2015 at 1:18 AM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>
> Unfortunately the device setup code has to start out as a big ugly mess
> in order to work usefully right now, as 'proper' operation depends on
> changes to device probe and DMA configuration ordering, IOMMU groups for
> platform devices, and default domain support in arm/arm64 IOMMU drivers.
> The workarounds here need only exist until that work is finished.
>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---

[snip]

> +static void __iommu_sync_sg_for_cpu(struct device *dev,
> +                                   struct scatterlist *sgl, int nelems,
> +                                   enum dma_data_direction dir)
> +{
> +       struct scatterlist *sg;
> +       int i;
> +
> +       if (is_device_dma_coherent(dev))
> +               return;
> +
> +       for_each_sg(sgl, sg, nelems, i)
> +               __dma_unmap_area(sg_virt(sg), sg->length, dir);
> +}

In an earlier review [0], Marek asked you to change the loop in
__iommu_sync_sg_for_cpu loop() to loop over the virtual areas when
invalidating/cleaning memory ranges.

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328232.html

However, this changed the meaning of the 'nelems' argument from what
was for arm_iommu_sync_sg_for_cpu() in arch/arm/mm/dma-mapping.c:
 "number of buffers to sync (returned from dma_map_sg)"
to:
 "number of virtual areas to sync (same as was passed to dma_map_sg)"

This has caused some confusion by callers of dma_sync_sg_for_device()
that must work for both arm & arm64 as illustrated by [1].
[1] https://lkml.org/lkml/2015/9/21/250

Based on the implementation of debug_dma_sync_sg_for_cpu() in
lib/dma-debug.c, I think the arm interpretation of nelems (returned
from dma_map_sg) is correct.

Therefore, I think we need an outer iteration over dma chunks, and an
inner iteration that calls __dma_map_area() over the set virtual areas
that correspond to that dma chunk, both here and for
__iommu_sync_sg_for_device().  This will be complicated by the fact
that iommu pages could actually be smaller than PAGE_SIZE, and offset
within a single physical page.  Also, as an optimization, we would
want to combine contiguous virtual areas into a single call to
__dma_unmap_area().

-Dan
