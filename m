From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/3] iommu: implement common IOMMU ops for DMA
	mapping
Date: Mon, 9 Feb 2015 04:05:39 +0000
Message-ID: <20150209040539.GE13969@arm.com>
References: <cover.1423226542.git.robin.murphy@arm.com>
	<da0e905ae94f2fca241a47b2a20e078255e45a81.1423226542.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <da0e905ae94f2fca241a47b2a20e078255e45a81.1423226542.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org" <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Fri, Feb 06, 2015 at 02:55:13PM +0000, Robin Murphy wrote:
> Taking inspiration from the existing arch/arm code, break out some
> generic functions to interface the DMA-API to the IOMMU-API. This will
> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
> 
> Whilst this RFC series is aimed at enabling arm64, once any remaining
> obvious issues in the common code are addressed we can complete the
> refactoring by porting arch/arm over for a merge-worthy series.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig     |   7 +
>  drivers/iommu/Makefile    |   1 +
>  drivers/iommu/dma-iommu.c | 552 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h |  94 ++++++++
>  4 files changed, 654 insertions(+)
>  create mode 100644 drivers/iommu/dma-iommu.c
>  create mode 100644 include/linux/dma-iommu.h
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index a839ca9..19027bb 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -20,6 +20,13 @@ config OF_IOMMU
>         def_bool y
>         depends on OF && IOMMU_API
> 
> +# IOMMU-agnostic DMA-mapping layer
> +config IOMMU_DMA
> +       def_bool n

This can just be `bool' (n is the default).

> +       depends on NEED_SG_DMA_LENGTH
> +       select IOMMU_API
> +       select IOMMU_IOVA
> +
>  config FSL_PAMU
>         bool "Freescale IOMMU support"
>         depends on PPC_E500MC
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 0b1b94e..37bfc4e 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> +obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>  obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU) += of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> new file mode 100644
> index 0000000..b97cc0b9
> --- /dev/null
> +++ b/drivers/iommu/dma-iommu.c
> @@ -0,0 +1,552 @@
> +/*
> + * A fairly generic DMA-API to IOMMU-API glue layer.
> + *
> + * Copyright (C) 2014 ARM Ltd.
> + *
> + * based in part on arch/arm/mm/dma-mapping.c:
> + * Copyright (C) 2000-2004 Russell King
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define pr_fmt(fmt)    "%s: " fmt, __func__
> +
> +#include <linux/dma-contiguous.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/iova.h>
> +
> +int iommu_dma_init(void)
> +{
> +       return iommu_iova_cache_init();
> +}
> +
> +struct iommu_dma_domain {
> +       struct iommu_domain *domain;
> +       struct iova_domain *iovad;
> +       struct kref kref;
> +};
> +
> +static inline dma_addr_t dev_dma_addr(struct device *dev, dma_addr_t addr)
> +{
> +       BUG_ON(addr < dev->dma_pfn_offset);

Shouldn't we convert the pfn_offset to an address before this check?

> +       return addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
> +}
> +
> +static int __dma_direction_to_prot(enum dma_data_direction dir, bool coherent)
> +{
> +       int prot = coherent ? IOMMU_CACHE : 0;
> +
> +       switch (dir) {
> +       case DMA_BIDIRECTIONAL:
> +               return prot | IOMMU_READ | IOMMU_WRITE;
> +       case DMA_TO_DEVICE:
> +               return prot | IOMMU_READ;
> +       case DMA_FROM_DEVICE:
> +               return prot | IOMMU_WRITE;
> +       default:
> +               return 0;
> +       }
> +}

We could actually stick this into a header file as a generic helper.
arch/arm/ already uses its own flavour, for example.

> +static struct iova *__alloc_iova(struct device *dev, size_t size, bool coherent)
> +{
> +       struct iommu_dma_domain *dom = get_dma_domain(dev);
> +       struct iova_domain *iovad = dom->iovad;
> +       unsigned long shift = iova_shift(iovad);
> +       unsigned long length = iova_align(iovad, size) >> shift;
> +       unsigned long limit_pfn = iovad->dma_32bit_pfn;
> +       u64 dma_limit = coherent ? dev->coherent_dma_mask : *dev->dma_mask;

Should we use dma_get_mask in the non-coherent case in case the mask pointer
is NULL?

> +       limit_pfn = min(limit_pfn, (unsigned long)(dma_limit >> shift));

min_t avoids the explicit cast.

> +       /* Alignment should probably come from a domain/device attribute... */
> +       return alloc_iova(iovad, length, limit_pfn, false);
> +}
> +
> +/*
> + * Create a mapping in device IO address space for specified pages
> + */
> +dma_addr_t iommu_dma_create_iova_mapping(struct device *dev,
> +               struct page **pages, size_t size, bool coherent)
> +{
> +       struct iommu_dma_domain *dom = get_dma_domain(dev);
> +       struct iova_domain *iovad = dom->iovad;
> +       struct iommu_domain *domain = dom->domain;
> +       struct iova *iova;
> +       unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;

Why not just make the size parameter npages instead?

> +       dma_addr_t addr_lo, addr_hi;
> +       int i, prot = __dma_direction_to_prot(DMA_BIDIRECTIONAL, coherent);
> +
> +       iova = __alloc_iova(dev, size, coherent);
> +       if (!iova)
> +               return DMA_ERROR_CODE;
> +
> +       addr_hi = addr_lo = iova_dma_addr(iovad, iova);
> +       for (i = 0; i < count; ) {
> +               unsigned int next_pfn = page_to_pfn(pages[i]) + 1;
> +               phys_addr_t phys = page_to_phys(pages[i]);
> +               unsigned int len, j;
> +
> +               for (j = i+1; j < count; j++, next_pfn++)
> +                       if (page_to_pfn(pages[j]) != next_pfn)
> +                               break;
> +
> +               len = (j - i) << PAGE_SHIFT;
> +               if (iommu_map(domain, addr_hi, phys, len, prot))
> +                       goto fail;
> +               addr_hi += len;
> +               i = j;
> +       }

This loop is pretty miserable to read. Could we pass this off to ->map_sg
and avoid the need to check that the pfns are contiguous?

> +       return dev_dma_addr(dev, addr_lo);
> +fail:
> +       iommu_unmap(domain, addr_lo, addr_hi - addr_lo);
> +       __free_iova(iovad, iova);
> +       return DMA_ERROR_CODE;
> +}
> +
> +int iommu_dma_release_iova_mapping(struct device *dev, dma_addr_t iova,
> +               size_t size)
> +{
> +       struct iommu_dma_domain *dom = get_dma_domain(dev);
> +       struct iova_domain *iovad = dom->iovad;
> +       size_t offset = iova_offset(iovad, iova);
> +       size_t len = iova_align(iovad, size + offset);
> +
> +       iommu_unmap(dom->domain, iova - offset, len);
> +       free_iova(iovad, iova_pfn(iovad, iova));
> +       return 0;
> +}
> +
> +struct page **iommu_dma_alloc_buffer(struct device *dev, size_t size,
> +               gfp_t gfp, struct dma_attrs *attrs,
> +               void (clear_buffer)(struct page *page, size_t size))
> +{
> +       struct page **pages;
> +       int count = size >> PAGE_SHIFT;
> +       int array_size = count * sizeof(struct page *);
> +       int i = 0;
> +
> +       if (array_size <= PAGE_SIZE)
> +               pages = kzalloc(array_size, GFP_KERNEL);
> +       else
> +               pages = vzalloc(array_size);
> +       if (!pages)
> +               return NULL;
> +
> +       if (dma_get_attr(DMA_ATTR_FORCE_CONTIGUOUS, attrs)) {
> +               unsigned long order = get_order(size);
> +               struct page *page;
> +
> +               page = dma_alloc_from_contiguous(dev, count, order);
> +               if (!page)
> +                       goto error;
> +
> +               if (clear_buffer)
> +                       clear_buffer(page, size);

For cache-coherent systems, this is just a memset so perhaps we could
default to that if no function pointer is passed? It would also be cool
to do the highmem vs lowmem stuff in core code, but that's more fiddly
than it looks and probably not worth the hassle.

> +struct iommu_dma_domain *iommu_dma_create_domain(const struct iommu_ops *ops,
> +               dma_addr_t base, size_t size)
> +{
> +       struct iommu_dma_domain *dom;
> +       struct iommu_domain *domain;
> +       struct iova_domain *iovad;
> +       struct iommu_domain_geometry *dg;
> +       unsigned long order, base_pfn, end_pfn;
> +
> +       pr_debug("base=%pad\tsize=0x%zx\n", &base, size);

We can lose the debug prints for upstream.

> +       dom = kzalloc(sizeof(*dom), GFP_KERNEL);
> +       if (!dom)
> +               return NULL;
> +
> +       /*
> +        * HACK: We'd like to ask the relevant IOMMU in ops for a suitable
> +        * domain, but until that happens, bypass the bus nonsense and create
> +        * one directly for this specific device/IOMMU combination...
> +        */
> +       domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +
> +       if (!domain)
> +               goto out_free_dma_domain;
> +       domain->ops = ops;
> +
> +       if (ops->domain_init(domain))
> +               goto out_free_iommu_domain;
> +       /*
> +        * ...and do the bare minimum to sanity-check that the domain allows
> +        * at least some access to the device...
> +        */
> +       dg = &domain->geometry;
> +       if (!(base <= dg->aperture_end && base + size > dg->aperture_start)) {
> +               pr_warn("DMA range outside IOMMU capability; is DT correct?\n");

We probably shouldn't print things about DT in core (non-OF) code.

> +               goto out_free_iommu_domain;
> +       }
> +       /* ...then finally give it a kicking to make sure it fits */
> +       dg->aperture_start = max(base, dg->aperture_start);
> +       dg->aperture_end = min(base + size - 1, dg->aperture_end);
> +       /*
> +        * Note that this almost certainly breaks the case where multiple
> +        * devices with different DMA capabilities need to share a domain,
> +        * but we don't have the necessary information to handle that here
> +        * anyway - "proper" group and domain allocation needs to involve
> +        * the IOMMU driver and a complete view of the bus.
> +        */
> +
> +       iovad = kzalloc(sizeof(*iovad), GFP_KERNEL);
> +       if (!iovad)
> +               goto out_free_iommu_domain;
> +
> +       /* Use the smallest supported page size for IOVA granularity */
> +       order = __ffs(ops->pgsize_bitmap);
> +       base_pfn = max(dg->aperture_start >> order, (dma_addr_t)1);
> +       end_pfn = dg->aperture_end >> order;
> +       init_iova_domain(iovad, 1UL << order, base_pfn, end_pfn);
> +
> +       dom->domain = domain;
> +       dom->iovad = iovad;
> +       kref_init(&dom->kref);
> +       pr_debug("domain %p created\n", dom);
> +       return dom;
> +
> +out_free_iommu_domain:
> +       kfree(domain);
> +out_free_dma_domain:
> +       kfree(dom);
> +       return NULL;
> +}
> +
> +static void iommu_dma_free_domain(struct kref *kref)
> +{
> +       struct iommu_dma_domain *dom;
> +
> +       dom = container_of(kref, struct iommu_dma_domain, kref);
> +       put_iova_domain(dom->iovad);
> +       iommu_domain_free(dom->domain);
> +       kfree(dom);
> +       pr_debug("domain %p freed\n", dom);
> +}
> +
> +void iommu_dma_release_domain(struct iommu_dma_domain *dom)
> +{
> +       kref_put(&dom->kref, iommu_dma_free_domain);
> +}
> +
> +struct iommu_domain *iommu_dma_raw_domain(struct iommu_dma_domain *dom)
> +{
> +       return dom ? dom->domain : NULL;
> +}
> +
> +int iommu_dma_attach_device(struct device *dev, struct iommu_dma_domain *dom)
> +{
> +       int ret;
> +
> +       kref_get(&dom->kref);
> +       ret = iommu_attach_device(dom->domain, dev);
> +       if (ret)
> +               iommu_dma_release_domain(dom);

Shouldn't this be the responsibility of the caller?

> +       else
> +               set_dma_domain(dev, dom);
> +       pr_debug("%s%s attached to domain %p\n", dev_name(dev),
> +                       ret?" *not*":"", dom);
> +       return ret;
> +}
> +
> +void iommu_dma_detach_device(struct device *dev)
> +{
> +       struct iommu_dma_domain *dom = get_dma_domain(dev);
> +
> +       if (!dom) {
> +               dev_warn(dev, "Not attached\n");
> +               return;
> +       }
> +       set_dma_domain(dev, NULL);
> +       iommu_detach_device(dom->domain, dev);

I think this means that we should be checking for NULL DMA domains in all of
the IOVA calls, or can we assume our callers behave themselves?

> +       iommu_dma_release_domain(dom);
> +       pr_debug("%s detached from domain %p\n", dev_name(dev), dom);
> +}
> +
> +int iommu_dma_supported(struct device *dev, u64 mask)
> +{
> +       /*
> +        * This looks awful, but really it's reasonable to assume that if an
> +        * IOMMU can't address everything that the CPU can, it probably isn't
> +        * generic enough to be using this implementation in the first place.
> +        */
> +       return 1;

Hmm, perhaps, but I don't think it's *completely* unrealistic to have an
IOMMU with more limited physical addressing caps than the CPU. Maybe we
could have an IOMMU callback for querying the addressing capabilities?

It shouldn't block this series, I'm just interested in your thoughts on
solving this in the future.

Will
