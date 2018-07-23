From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Date: Mon, 23 Jul 2018 10:49:39 +0200
Message-ID: <CAMuHMdX=b0iAnDw1=85MXNBSMD=MxZb27QrO3rEWHYq0vB+3ow@mail.gmail.com>
References: <20180719130516.1989-1-hch@lst.de>
	<20180719130516.1989-5-hch@lst.de> <20180723084207.GI6784@w540>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180723084207.GI6784@w540>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacopo Mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacopo,

On Mon, Jul 23, 2018 at 10:42 AM jacopo mondi <jacopo-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org> wrote:
> I have a single comment on something I noticed which might be an
> implementation bug. On the overall patch architecture, it's very hard
> for me to provide a valuable opinion as it's all relatively new for me
> here :)
>
> On Thu, Jul 19, 2018 at 06:05:15AM -0700, Christoph Hellwig wrote:
> > Half of the file just contains platform device memory setup code which
> > is required for all builds, and half contains helpers for dma coherent
> > allocation, which is only needed if CONFIG_DMA_NONCOHERENT is enabled.
> >
> > Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

> > --- /dev/null
> > +++ b/arch/sh/kernel/dma-coherent.c
> > @@ -0,0 +1,85 @@
> > +/*
> > + * Copyright (C) 2004 - 2007  Paul Mundt
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +#include <linux/mm.h>
> > +#include <linux/init.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/module.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/addrspace.h>
> > +
> > +void *dma_generic_alloc_coherent(struct device *dev, size_t size,
> > +                              dma_addr_t *dma_handle, gfp_t gfp,
> > +                              unsigned long attrs)
> > +{
> > +     void *ret, *ret_nocache;
> > +     int order = get_order(size);
> > +
> > +     gfp |= __GFP_ZERO;
> > +
> > +     ret = (void *)__get_free_pages(gfp, order);
> > +     if (!ret)
> > +             return NULL;
> > +
> > +     /*
> > +      * Pages from the page allocator may have data present in
> > +      * cache. So flush the cache before using uncached memory.
> > +      */
> > +     sh_sync_dma_for_device(ret, size, DMA_BIDIRECTIONAL);
> > +
> > +     ret_nocache = (void __force *)ioremap_nocache(virt_to_phys(ret), size);
> > +     if (!ret_nocache) {
> > +             free_pages((unsigned long)ret, order);
> > +             return NULL;
> > +     }
> > +
> > +     split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
> > +
> > +     *dma_handle = virt_to_phys(ret);
> > +     if (!WARN_ON(!dev))
> > +             *dma_handle - PFN_PHYS(dev->dma_pfn_offset);
>
> I guess this comes from below...

> > -     *dma_handle = virt_to_phys(ret);
> > -     if (!WARN_ON(!dev))
> > -             *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
>
> ... here
>
> Is the s/-=/- intended?
>
> Snippets copied here below:
>
> > +     *dma_handle = virt_to_phys(ret);
> > +     if (!WARN_ON(!dev))
> > +             *dma_handle - PFN_PHYS(dev->dma_pfn_offset);
> vs
> > -     *dma_handle = virt_to_phys(ret);
> > -     if (!WARN_ON(!dev))
> > -             *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);

Doesn't look right to me, neither.

No complaints for 0day? My gcc says:

    error: statement with no effect [-Werror=unused-value]

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
