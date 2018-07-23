From: jacopo mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Date: Mon, 23 Jul 2018 10:42:07 +0200
Message-ID: <20180723084207.GI6784@w540>
References: <20180719130516.1989-1-hch@lst.de>
 <20180719130516.1989-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180719130516.1989-5-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Christoph,

I have a single comment on something I noticed which might be an
implementation bug. On the overall patch architecture, it's very hard
for me to provide a valuable opinion as it's all relatively new for me
here :)

On Thu, Jul 19, 2018 at 06:05:15AM -0700, Christoph Hellwig wrote:
> Half of the file just contains platform device memory setup code which
> is required for all builds, and half contains helpers for dma coherent
> allocation, which is only needed if CONFIG_DMA_NONCOHERENT is enabled.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/sh/kernel/Makefile       |  2 +-
>  arch/sh/kernel/dma-coherent.c | 85 +++++++++++++++++++++++++++++++++++
>  arch/sh/mm/consistent.c       | 80 ---------------------------------
>  3 files changed, 86 insertions(+), 81 deletions(-)
>  create mode 100644 arch/sh/kernel/dma-coherent.c
>
> diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
> index cb5f1bfb52de..d5ddb64bfffe 100644
> --- a/arch/sh/kernel/Makefile
> +++ b/arch/sh/kernel/Makefile
> @@ -45,7 +45,7 @@ obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
>  obj-$(CONFIG_HIBERNATION)	+= swsusp.o
>  obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
> -obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o
> +obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-nommu.o dma-coherent.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
>
>  ccflags-y := -Werror
> diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
> new file mode 100644
> index 000000000000..0e7720b5d495
> --- /dev/null
> +++ b/arch/sh/kernel/dma-coherent.c
> @@ -0,0 +1,85 @@
> +/*
> + * Copyright (C) 2004 - 2007  Paul Mundt
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +#include <linux/mm.h>
> +#include <linux/init.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <asm/cacheflush.h>
> +#include <asm/addrspace.h>
> +
> +void *dma_generic_alloc_coherent(struct device *dev, size_t size,
> +				 dma_addr_t *dma_handle, gfp_t gfp,
> +				 unsigned long attrs)
> +{
> +	void *ret, *ret_nocache;
> +	int order = get_order(size);
> +
> +	gfp |= __GFP_ZERO;
> +
> +	ret = (void *)__get_free_pages(gfp, order);
> +	if (!ret)
> +		return NULL;
> +
> +	/*
> +	 * Pages from the page allocator may have data present in
> +	 * cache. So flush the cache before using uncached memory.
> +	 */
> +	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
> +
> +	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
> +	if (!ret_nocache) {
> +		free_pages((unsigned long)ret, order);
> +		return NULL;
> +	}
> +
> +	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
> +
> +	*dma_handle = virt_to_phys(ret);
> +	if (!WARN_ON(!dev))
> +		*dma_handle - PFN_PHYS(dev->dma_pfn_offset);

I guess this comes from below...

> +
> +	return ret_nocache;
> +}
> +
> +void dma_generic_free_coherent(struct device *dev, size_t size,
> +			       void *vaddr, dma_addr_t dma_handle,
> +			       unsigned long attrs)
> +{
> +	int order = get_order(size);
> +	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
> +	int k;
> +
> +	if (!WARN_ON(!dev))
> +		pfn + dev->dma_pfn_offset;
> +
> +	for (k = 0; k < (1 << order); k++)
> +		__free_pages(pfn_to_page(pfn + k), 0);
> +
> +	iounmap(vaddr);
> +}
> +
> +void sh_sync_dma_for_device(void *vaddr, size_t size,
> +		    enum dma_data_direction direction)
> +{
> +	void *addr = sh_cacheop_vaddr(vaddr);
> +
> +	switch (direction) {
> +	case DMA_FROM_DEVICE:		/* invalidate only */
> +		__flush_invalidate_region(addr, size);
> +		break;
> +	case DMA_TO_DEVICE:		/* writeback only */
> +		__flush_wback_region(addr, size);
> +		break;
> +	case DMA_BIDIRECTIONAL:		/* writeback and invalidate */
> +		__flush_purge_region(addr, size);
> +		break;
> +	default:
> +		BUG();
> +	}
> +}
> +EXPORT_SYMBOL(sh_sync_dma_for_device);
> diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
> index 1622ae6b9dbd..792f36129062 100644
> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -1,10 +1,6 @@
>  /*
> - * arch/sh/mm/consistent.c
> - *
>   * Copyright (C) 2004 - 2007  Paul Mundt
>   *
> - * Declared coherent memory functions based on arch/x86/kernel/pci-dma_32.c
> - *
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
> @@ -13,83 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/dma-debug.h>
>  #include <linux/io.h>
> -#include <linux/module.h>
> -#include <linux/gfp.h>
> -#include <asm/cacheflush.h>
> -#include <asm/addrspace.h>
> -
> -void *dma_generic_alloc_coherent(struct device *dev, size_t size,
> -				 dma_addr_t *dma_handle, gfp_t gfp,
> -				 unsigned long attrs)
> -{
> -	void *ret, *ret_nocache;
> -	int order = get_order(size);
> -
> -	gfp |= __GFP_ZERO;
> -
> -	ret = (void *)__get_free_pages(gfp, order);
> -	if (!ret)
> -		return NULL;
> -
> -	/*
> -	 * Pages from the page allocator may have data present in
> -	 * cache. So flush the cache before using uncached memory.
> -	 */
> -	sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
> -
> -	ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
> -	if (!ret_nocache) {
> -		free_pages((unsigned long)ret, order);
> -		return NULL;
> -	}
> -
> -	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
> -
> -	*dma_handle = virt_to_phys(ret);
> -	if (!WARN_ON(!dev))
> -		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);

... here

Is the s/-=/- intended?

Snippets copied here below:

> +	*dma_handle = virt_to_phys(ret);
> +	if (!WARN_ON(!dev))
> +		*dma_handle - PFN_PHYS(dev->dma_pfn_offset);
vs
> -	*dma_handle = virt_to_phys(ret);
> -	if (!WARN_ON(!dev))
> -		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);



--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbVZTfAAoJEHI0Bo8WoVY8ACMP/3SFUmXHB3DC+La4lFnC9/Wn
wzjjONpPwkZLx4Ly7r2AxUSraloiwUhp00fT7glnOzYF9FgOJz78oFebb1evh4D8
+UQMoTHhjRl0TF1OcQYvvVl0OBNDfNfiLlwC5miPuViFsas37OITFavIlwzp8zID
jYw1GtLA0QyffdVhgVwIbODZDwFFbEg//EIwU/yLHu9egdRBxOIRgYs854yQXwa3
pBn/2NugUgByVLFcpg5dMX3eyA4MeVGPTlxhc6OFiq9D8zAMiFxaxwI8zNryvN2m
D1yoVvodrb7TAi7sTP6Obwbaw5DgpNFsFwXgYfC7hFbtj7EjzQjEkjqf76KGfqjB
Vx+SSdnUTZBpVe4n0ynPHLYKDFBJXUxERn/+7/5XbUw5w33MeR5ebIvojqQjN7Gc
psCB6Za2TnHKASdpSm4e2cewfqnfTPUOHS+Yv4DNFXJa7RttRZs5lptGIwp2YwNq
cd6h0jmJeRhWZITvWqJ/BQ+fk/WgoSUIoEX6RKZYYM1l0DfJmOzeJqNHVBLLb5a1
xY0zugo+n52pHoAt31m0jxJtDTVWkMLA1bKyLxRyTZAXXWBNIRMrCyte9UdYG2y8
rq+oxkfN+8Sc7A28hNUWtHLxG4NHA5v/i8b7PotGItdXCmlkIqNKaTrx8NR8pqwK
tQ6PrQzodz/7fD3RYMgQ
=p5wX
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
