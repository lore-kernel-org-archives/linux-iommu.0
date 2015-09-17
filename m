From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 3/6] iommu: add ARM short descriptor page table
 allocator.
Date: Thu, 17 Sep 2015 22:54:22 +0800
Message-ID: <1442501662.8145.151.camel@mhfsdcap03>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
	 <1438597279-2937-4-git-send-email-yong.wu@mediatek.com>
	 <20150916155824.GM28771@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150916155824.GM28771-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>"arnd-r2nGTMty4D4@public.gmane.org" <a>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-09-16 at 16:58 +0100, Will Deacon wrote:
> On Mon, Aug 03, 2015 at 11:21:16AM +0100, Yong Wu wrote:
> > This patch is for ARM Short Descriptor Format.
> > 
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/iommu/Kconfig                |  18 +
> >  drivers/iommu/Makefile               |   1 +
> >  drivers/iommu/io-pgtable-arm-short.c | 813 +++++++++++++++++++++++++++++++++++
> >  drivers/iommu/io-pgtable-arm.c       |   3 -
> >  drivers/iommu/io-pgtable.c           |   4 +
> >  drivers/iommu/io-pgtable.h           |  14 +
> >  6 files changed, 850 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/iommu/io-pgtable-arm-short.c
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index f1fb1d3..3abd066 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -39,6 +39,24 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
> > 
> >           If unsure, say N here.
> > 
> > +config IOMMU_IO_PGTABLE_SHORT
> > +       bool "ARMv7/v8 Short Descriptor Format"
> > +       select IOMMU_IO_PGTABLE
> > +       depends on ARM || ARM64 || COMPILE_TEST
> > +       help
> > +         Enable support for the ARM Short-descriptor pagetable format.
> > +         This allocator supports 2 levels translation tables which supports
> 
> Some minor rewording here:
> 
> "...2 levels of translation tables, which enables a 32-bit memory map based
>  on..."

Hi Will,
    OK.Thanks very much for your review so detail every time.

> 
> > +         a memory map based on memory sections or pages.
> > +
> > +config IOMMU_IO_PGTABLE_SHORT_SELFTEST
> > +       bool "Short Descriptor selftests"
> > +       depends on IOMMU_IO_PGTABLE_SHORT
> > +       help
> > +         Enable self-tests for Short-descriptor page table allocator.
> > +         This performs a series of page-table consistency checks during boot.
> > +
> > +         If unsure, say N here.
> > +
> >  endmenu
> > 
> >  config IOMMU_IOVA
> 
> [...]
> > +#define ARM_SHORT_PGD_PGTABLE_MSK              0xfffffc00
> 
> You could use (~(ARM_SHORT_BYTES_PER_PTE - 1)), I think.

Yes. Thanks.

> > +/* level 2 pagetable */
> > +#define ARM_SHORT_PTE_TYPE_LARGE               BIT(0)
> > +#define ARM_SHORT_PTE_SMALL_XN                 BIT(0)
> > +#define ARM_SHORT_PTE_TYPE_SMALL               BIT(1)
> > +#define ARM_SHORT_PTE_B                                BIT(2)
> > +#define ARM_SHORT_PTE_C                                BIT(3)
> > +#define ARM_SHORT_PTE_RD_WR                    (3 << 4)
> > +#define ARM_SHORT_PTE_RDONLY                   BIT(9)
> > +#define ARM_SHORT_PTE_S                                BIT(10)
> > +#define ARM_SHORT_PTE_nG                       BIT(11)
> > +#define ARM_SHORT_PTE_LARGE_XN                 BIT(15)
> > +#define ARM_SHORT_PTE_LARGE_MSK                        (~(SZ_64K - 1))
> > +#define ARM_SHORT_PTE_SMALL_MSK                        (~(SZ_4K - 1))
> > +#define ARM_SHORT_PTE_TYPE_MSK                 \
> > +       (ARM_SHORT_PTE_TYPE_LARGE | ARM_SHORT_PTE_TYPE_SMALL)
> > +#define ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(pte)   \
> > +       (((pte) & ARM_SHORT_PTE_TYPE_SMALL) == ARM_SHORT_PTE_TYPE_SMALL)
> 
> Maybe a comment here, because it's confusing that you don't and with the
> mask due to XN.

I will add a comment like : 
/* The bit0 in small page is XN */

> > +#define ARM_SHORT_PTE_LARGE_GET_PROT(pte)      \
> > +       (((pte) & (~ARM_SHORT_PTE_LARGE_MSK)) & ~ARM_SHORT_PTE_TYPE_MSK)
> 
> AFAICT, the only user of this also does an '& ~ARM_SHORT_PTE_SMALL_MSK'.
> Wouldn't it be better to define ARM_SHORT_PTE_GET_PROT, which just returns
> the AP bits? That said, what are you going to do about XN? I know you
> don't support it in your hardware, but this could code should still do
> the right thing.

I'm a little confuse here: rename to ARM_SHORT_PTE_GET_PROT which just
return the AP bits? like this :
//=====
#define ARM_SHORT_PTE_GET_PROT(pte) \
(((pte) & (~ARM_SHORT_PTE_SMALL_MSK)) & ~ARM_SHORT_PTE_TYPE_MSK)
//=====

This macro is only used to get the prot of large page while split.

If it only return AP bits, then how about PXN,TEX[2:0] in large page?
(we need transform PXN in large-page to XN in small-page while split)

how about add a comment like below:
//=====
/* Get the prot of large page for split */
#define ARM_SHORT_PTE_LARGE_GET_PROT(pte)      \
   (((pte) & (~ARM_SHORT_PTE_LARGE_MSK)) & ~ARM_SHORT_PTE_TYPE_MSK)
//=====
or rename it ARM_SHORT_PTE_GET_PROT_SPLIT?

> 
> > +static int
> > +__arm_short_set_pte(arm_short_iopte *ptep, arm_short_iopte pte,
> > +                   unsigned int ptenr, struct io_pgtable_cfg *cfg)
> > +{
> > +       struct device *dev = cfg->iommu_dev;
> > +       int i;
> > +
> > +       for (i = 0; i < ptenr; i++) {
> > +               if (ptep[i] && pte) {
> > +                       /* Someone else may have allocated for this pte */
> > +                       WARN_ON(!selftest_running);
> > +                       goto err_exist_pte;
> > +               }
> > +               ptep[i] = pte;
> > +       }
> > +
> > +       if (selftest_running)
> > +               return 0;
> > +
> > +       dma_sync_single_for_device(dev, __arm_short_dma_addr(dev, ptep),
> > +                                  sizeof(*ptep) * ptenr, DMA_TO_DEVICE);
> > +       return 0;
> > +
> > +err_exist_pte:
> > +       while (i--)
> > +               ptep[i] = 0;
> 
> What about a dma_sync for the failure case?

I will add it.

> 
> > +       return -EEXIST;
> > +}
> > +
> > +static void *
> > +__arm_short_alloc_pgtable(size_t size, gfp_t gfp, bool pgd,
> > +                         struct io_pgtable_cfg *cfg)
> > +{
> > +       struct arm_short_io_pgtable *data;
> > +       struct device *dev = cfg->iommu_dev;
> > +       dma_addr_t dma;
> > +       void *va;
> > +
> > +       if (pgd) {/* lvl1 pagetable */
> > +               va = alloc_pages_exact(size, gfp);
> > +       } else {  /* lvl2 pagetable */
> > +               data = io_pgtable_cfg_to_data(cfg);
> > +               va = kmem_cache_zalloc(data->pgtable_cached, gfp);
> > +       }
> > +
> > +       if (!va)
> > +               return NULL;
> > +
> > +       if (selftest_running)
> > +               return va;
> > +
> > +       dma = dma_map_single(dev, va, size, DMA_TO_DEVICE);
> > +       if (dma_mapping_error(dev, dma))
> > +               goto out_free;
> > +
> > +       if (dma != __arm_short_dma_addr(dev, va))
> > +               goto out_unmap;
> > +
> > +       if (!pgd) {
> > +               kmemleak_ignore(va);
> > +               dma_sync_single_for_device(dev, __arm_short_dma_addr(dev, va),
> > +                                          size, DMA_TO_DEVICE);
> 
> Why do you need to do this as well as the dma_map_single above?

It's redundance, I will delete it...

> 
> > +       }
> > +
> > +       return va;
> > +
> > +out_unmap:
> > +       dev_err_ratelimited(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
> > +       dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
> > +out_free:
> > +       if (pgd)
> > +               free_pages_exact(va, size);
> > +       else
> > +               kmem_cache_free(data->pgtable_cached, va);
> > +       return NULL;
> > +}
> > +
> > +static void
> > +__arm_short_free_pgtable(void *va, size_t size, bool pgd,
> > +                        struct io_pgtable_cfg *cfg)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_cfg_to_data(cfg);
> > +       struct device *dev = cfg->iommu_dev;
> > +
> > +       if (!selftest_running)
> > +               dma_unmap_single(dev, __arm_short_dma_addr(dev, va),
> > +                                size, DMA_TO_DEVICE);
> > +
> > +       if (pgd)
> > +               free_pages_exact(va, size);
> > +       else
> > +               kmem_cache_free(data->pgtable_cached, va);
> > +}
> > +
> > +static arm_short_iopte
> > +__arm_short_pte_prot(struct arm_short_io_pgtable *data, int prot, bool large)
> > +{
> > +       arm_short_iopte pteprot;
> > +       int quirk = data->iop.cfg.quirks;
> > +
> > +       pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
> > +       pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
> > +                               ARM_SHORT_PTE_TYPE_SMALL;
> > +       if (prot & IOMMU_CACHE)
> > +               pteprot |=  ARM_SHORT_PTE_B | ARM_SHORT_PTE_C;
> > +       if (!(quirk & IO_PGTABLE_QUIRK_SHORT_NO_XN) && (prot & IOMMU_NOEXEC)) {
> > +                       pteprot |= large ? ARM_SHORT_PTE_LARGE_XN :
> > +                               ARM_SHORT_PTE_SMALL_XN;
> 
> Weird indentation, man. Also, see my later comment about combining NO_XN
> with NO_PERMS (the latter subsumes the first)

Sorry, I misunderstanded about the quirk, I will use NO_PERMS which
contain NO_XN.

> 
> > +       }
> > +       if (!(quirk & IO_PGTABLE_QUIRK_SHORT_NO_PERMS)) {
> > +               pteprot |= ARM_SHORT_PTE_RD_WR;
> > +               if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> > +                       pteprot |= ARM_SHORT_PTE_RDONLY;
> > +       }
> > +       return pteprot;
> > +}
> > +
[...]
> > +static arm_short_iopte
> > +__arm_short_pte_prot_split(struct arm_short_io_pgtable *data,
> > +                          arm_short_iopte pgdprot,
> > +                          arm_short_iopte pteprot_large,
> > +                          bool large)
> > +{
> > +       arm_short_iopte pteprot = 0;
> > +
> > +       pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG | ARM_SHORT_PTE_RD_WR;
> > +       pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
> > +                               ARM_SHORT_PTE_TYPE_SMALL;
> > +
> > +       /* large page to small page pte prot. Only large page may split */
> > +       if (!pgdprot && !large) {
> 
> It's slightly complicated having these two variables controlling the
> behaviour of the split. In reality, we're either splitting a section or
> a large page, so there are three valid combinations.
> 
> It might be simpler to operate on IOMMU_{READ,WRITE,NOEXEC,CACHE} as
> much as possible, and then have some simple functions to encode/decode
> these into section/large/small page prot bits. We could then just pass
> the IOMMU_* prot around along with the map size. What do you think?

It will be more simple if IOMMU_{READ,WRITE,NOEXEC,CACHE} prot can be
used here. But we cann't get IOMMU_x prot while split in unmap. is it
right?
we can only get the prot from the pagetable, then restructure the new
prot after split.

> 
> > +               pteprot |= pteprot_large & ~ARM_SHORT_PTE_SMALL_MSK;
> > +               if (pteprot_large & ARM_SHORT_PTE_LARGE_XN)
> > +                       pteprot |= ARM_SHORT_PTE_SMALL_XN;
> > +       }
> > +
> > +       /* section to pte prot */
> > +       if (pgdprot & ARM_SHORT_PGD_C)
> > +               pteprot |= ARM_SHORT_PTE_C;
> > +       if (pgdprot & ARM_SHORT_PGD_B)
> > +               pteprot |= ARM_SHORT_PTE_B;
> > +       if (pgdprot & ARM_SHORT_PGD_nG)
> > +               pteprot |= ARM_SHORT_PTE_nG;
> > +       if (pgdprot & ARM_SHORT_PGD_SECTION_XN)
> > +               pteprot |= large ? ARM_SHORT_PTE_LARGE_XN :
> > +                               ARM_SHORT_PTE_SMALL_XN;
> > +       if (pgdprot & ARM_SHORT_PGD_RD_WR)
> > +               pteprot |= ARM_SHORT_PTE_RD_WR;
> > +       if (pgdprot & ARM_SHORT_PGD_RDONLY)
> > +               pteprot |= ARM_SHORT_PTE_RDONLY;
> > +
> > +       return pteprot;
> > +}
> > +
> > +static int
> > +_arm_short_map(struct arm_short_io_pgtable *data,
> > +              unsigned int iova, phys_addr_t paddr,
> > +              arm_short_iopte pgdprot, arm_short_iopte pteprot,
> > +              bool large)
> > +{
> > +       struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +       arm_short_iopte *pgd = data->pgd, *pte;
> > +       void *pte_new = NULL;
> > +       int ret;
> > +
> > +       pgd += ARM_SHORT_PGD_IDX(iova);
> > +
> > +       if (!pteprot) { /* section or supersection */
> > +               pte = pgd;
> > +               pteprot = pgdprot;
> > +       } else {        /* page or largepage */
> > +               if (!(*pgd)) {
> > +                       pte_new = __arm_short_alloc_pgtable(
> > +                                       ARM_SHORT_BYTES_PER_PTE,
> > +                                       GFP_ATOMIC, false, cfg);
> > +                       if (unlikely(!pte_new))
> > +                               return -ENOMEM;
> > +
> > +                       pgdprot |= virt_to_phys(pte_new);
> > +                       __arm_short_set_pte(pgd, pgdprot, 1, cfg);
> > +               }
> > +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > +       }
> > +
> > +       pteprot |= (arm_short_iopte)paddr;
> > +       ret = __arm_short_set_pte(pte, pteprot, large ? 16 : 1, cfg);
> > +       if (ret && pte_new)
> > +               __arm_short_free_pgtable(pte_new, ARM_SHORT_BYTES_PER_PTE,
> > +                                        false, cfg);
> 
> Don't you need to kill the pgd entry before freeing this? Please see my
> previous comments about safely freeing page tables:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358268.html
> 
> (at the end of the post)


 I will add like this:
//======================
  if (ret && pte_new)
        goto err_unmap_pgd:

  if (data->iop.cfg.quirk & IO_PGTABLE_QUIRK_TLBI_ON_MAP) {
        tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
        tlb->tlb_sync(data->iop.cookie);
   }
   return ret;

err_unmap_pgd:
           __arm_short_set_pte(pgd, 0, 1, cfg);
           tlb->tlb_add_flush(iova, SZ_1M, true, data->iop.cookie); /*
the size is 1M, the whole pgd */
           tlb->tlb_sync(data->iop.cookie); 
           __arm_short_free_pgtable(pte_new, ARM_SHORT_BYTES_PER_PTE,
                                   false, cfg);
   return ret;
//======================

Here I move the TLBI_ON_MAP quirk into _arm_short_map, then the map from
split also could flush-tlb if it's necessary.

> > +       return ret;
> > +}
> > +
[...]
> > +static bool _arm_short_whether_free_pgtable(arm_short_iopte *pgd)
> > +{
> 
> _arm_short_pgtable_empty might be a better name.

Thanks.

> 
> > +       arm_short_iopte *pte;
> > +       int i;
> > +
> > +       pte = ARM_SHORT_GET_PGTABLE_VA(*pgd);
> > +       for (i = 0; i < ARM_SHORT_PTRS_PER_PTE; i++) {
> > +               if (pte[i] != 0)
> > +                       return false;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> > +static int
> > +arm_short_split_blk_unmap(struct io_pgtable_ops *ops, unsigned int iova,
> > +                         phys_addr_t paddr, size_t size,
> > +                         arm_short_iopte pgdprotup, arm_short_iopte pteprotup,
> > +                         size_t blk_size)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > +       struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +       unsigned long *pgbitmap = &cfg->pgsize_bitmap;
> > +       unsigned int blk_base, blk_start, blk_end, i;
> > +       arm_short_iopte pgdprot, pteprot;
> > +       phys_addr_t blk_paddr;
> > +       size_t mapsize = 0, nextmapsize;
> > +       int ret;
> > +
> > +       /* find the nearest mapsize */
> > +       for (i = find_first_bit(pgbitmap, BITS_PER_LONG);
> > +            i < BITS_PER_LONG && ((1 << i) < blk_size) &&
> > +            IS_ALIGNED(size, 1 << i);
> > +            i = find_next_bit(pgbitmap, BITS_PER_LONG, i + 1))
> > +               mapsize = 1 << i;
> > +
> > +       if (WARN_ON(!mapsize))
> > +               return 0; /* Bytes unmapped */
> > +       nextmapsize = 1 << i;
> > +
> > +       blk_base = iova & ~(blk_size - 1);
> > +       blk_start = blk_base;
> > +       blk_end = blk_start + blk_size;
> > +       blk_paddr = paddr;
> > +
> > +       for (; blk_start < blk_end;
> > +            blk_start += mapsize, blk_paddr += mapsize) {
> > +               /* Unmap! */
> > +               if (blk_start == iova)
> > +                       continue;
> > +
> > +               /* Try to upper map */
> > +               if (blk_base != blk_start &&
> > +                   IS_ALIGNED(blk_start | blk_paddr, nextmapsize) &&
> > +                   mapsize != nextmapsize) {
> > +                       mapsize = nextmapsize;
> > +                       i = find_next_bit(pgbitmap, BITS_PER_LONG, i + 1);
> > +                       if (i < BITS_PER_LONG)
> > +                               nextmapsize = 1 << i;
> > +               }
> > +
> > +               if (mapsize == SZ_1M) {
> 
> How do we get here with a mapsize of 1M?

About the split, there may be some cases:

super section may split to section, or large page, or small page.
section may split to large page, or small page.
large page may split to small page.

How do we get here with a mapsize of 1M?
->the mapsize will be 1M while supersection split to section.
  If we run the self-test, we can get the mapsize's change.

> 
> > +                       pgdprot = pgdprotup;
> > +                       pgdprot |= __arm_short_pgd_prot(data, 0, false);

    Here I cann't get IOMMU_{READ,WRITE,NOEXEC,CACHE}, I have to use 0
as the second parameter(some bits like PGD_B/PGD_C have been record in
pgdprotup)

> > +                       pteprot = 0;
> > +               } else { /* small or large page */
> > +                       pgdprot = (blk_size == SZ_64K) ? 0 : pgdprotup;
> > +                       pteprot = __arm_short_pte_prot_split(
> > +                                       data, pgdprot, pteprotup,
> > +                                       mapsize == SZ_64K);
> > +                       pgdprot = __arm_short_pgtable_prot(data);
> > +               }
> > +
> > +               ret = _arm_short_map(data, blk_start, blk_paddr, pgdprot,
> > +                                    pteprot, mapsize == SZ_64K);
> > +               if (ret < 0) {
> > +                       /* Free the table we allocated */
> > +                       arm_short_iopte *pgd = data->pgd, *pte;
> > +
> > +                       pgd += ARM_SHORT_PGD_IDX(blk_base);
> > +                       if (*pgd) {
> > +                               pte = ARM_SHORT_GET_PGTABLE_VA(*pgd);
> > +                               __arm_short_set_pte(pgd, 0, 1, cfg);
> > +                               tlb->tlb_add_flush(blk_base, blk_size, true,
> > +                                                  data->iop.cookie);
> > +                               tlb->tlb_sync(data->iop.cookie);
> > +                               __arm_short_free_pgtable(
> > +                                       pte, ARM_SHORT_BYTES_PER_PTE,
> > +                                       false, cfg);
> 
> This looks wrong. _arm_short_map cleans up if it returns non-zero already.

...
YES. It seems that I can delete the "if" for the error case.

if (ret < 0)
	return 0;

> 
> > +                       }
> > +                       return 0;/* Bytes unmapped */
> > +               }
> > +       }
> > +
> > +       tlb->tlb_add_flush(blk_base, blk_size, true, data->iop.cookie);
> > +       tlb->tlb_sync(data->iop.cookie);
> 
> Why are you syncing here? You can postpone this to the caller, if it turns
> out the unmap was a success.

I only saw that there is a tlb_add_flush in arm_lpae_split_blk_unmap. so
add it here.
About this, I think that we can delete the tlb-flush here. see below.

> 
> > +       return size;
> > +}
> > +
> > +static int arm_short_unmap(struct io_pgtable_ops *ops,
> > +                          unsigned long iova,
> > +                          size_t size)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +       struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > +       arm_short_iopte *pgd, *pte = NULL;
> > +       arm_short_iopte curpgd, curpte = 0;
> > +       phys_addr_t paddr;
> > +       unsigned int iova_base, blk_size = 0;
> > +       void *cookie = data->iop.cookie;
> > +       bool pgtablefree = false;
> > +
> > +       pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova);
> > +
> > +       /* Get block size */
> > +       if (ARM_SHORT_PGD_TYPE_IS_PGTABLE(*pgd)) {
> > +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > +
> > +               if (ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(*pte))
> > +                       blk_size = SZ_4K;
> > +               else if (ARM_SHORT_PTE_TYPE_IS_LARGEPAGE(*pte))
> > +                       blk_size = SZ_64K;
> > +               else
> > +                       WARN_ON(1);

> > +       } else if (ARM_SHORT_PGD_TYPE_IS_SECTION(*pgd)) {
> > +               blk_size = SZ_1M;
> > +       } else if (ARM_SHORT_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
> > +               blk_size = SZ_16M;
> > +       } else {
> > +               WARN_ON(1);
> 
> Maybe return 0 or something instead of falling through with blk_size == 0?

how about :
//=====
        if (WARN_ON(blk_size == 0))
		return 0;
//=====
 return 0 and report the error information.

> 
> > +       }
> > +
> > +       iova_base = iova & ~(blk_size - 1);
> > +       pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova_base);
> > +       paddr = arm_short_iova_to_phys(ops, iova_base);
> > +       curpgd = *pgd;
> > +
> > +       if (blk_size == SZ_4K || blk_size == SZ_64K) {
> > +               pte = arm_short_get_pte_in_pgd(*pgd, iova_base);
> > +               curpte = *pte;
> > +               __arm_short_set_pte(pte, 0, blk_size / SZ_4K, cfg);
> > +
> > +            pgtablefree = _arm_short_whether_free_pgtable(pgd);
> > +            if (pgtablefree)
> > +(1)(2)                 __arm_short_set_pte(pgd, 0, 1, cfg);
> > +       } else if (blk_size == SZ_1M || blk_size == SZ_16M) {
> > +               __arm_short_set_pte(pgd, 0, blk_size / SZ_1M, cfg);
> > +       }
> > +
> > +(3)    cfg->tlb->tlb_add_flush(iova_base, blk_size, true, cookie);
> > +(4)    cfg->tlb->tlb_sync(cookie);
> > +
> > +       if (pgtablefree)/* Free pgtable after tlb-flush */
> > +(5)              __arm_short_free_pgtable(ARM_SHORT_GET_PGTABLE_VA(curpgd),
> > +                                        ARM_SHORT_BYTES_PER_PTE, false, cfg);
> 
> Curious, but why do you care about freeing this on unmap? It will get
> freed when the page table itself is freed anyway (via the ->free callback).

This is free the level2 pagetable while there is no item in it. It isn't
level1 pagetable(->free callback).

The flow of free pagetable is following your suggestion that 5 steps
what I mark above like (1)..(5). so I have to move free_pgtable after
(4)tlb_sync. and add a comment /* Free pgtable after tlb-flush */.
the comment may should be changed to : /* Free level2 pgtable after
tlb-flush */

> > +
> > +       if (blk_size > size) { /* Split the block */
> > +               return arm_short_split_blk_unmap(
> > +                               ops, iova, paddr, size,
> > +                               ARM_SHORT_PGD_GET_PROT(curpgd),
> > +                               ARM_SHORT_PTE_LARGE_GET_PROT(curpte),
> > +                               blk_size);

    About add flush-tlb after split. There is a flush-tlb before. And
the map in split is from invalid to valid. It don't need flush-tlb
again.

> > +       } else if (blk_size < size) {
> > +               /* Unmap the block while remap partial again after split */
> > +               return blk_size +
> > +                       arm_short_unmap(ops, iova + blk_size, size - blk_size);
> > +       }
> > +
> > +       return size;
> > +}
> > +
> > +static struct io_pgtable *
> > +arm_short_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > +{
> > +       struct arm_short_io_pgtable *data;
> > +
> > +       if (cfg->ias > 32 || cfg->oas > 32)
> > +               return NULL;
> > +
> > +       cfg->pgsize_bitmap &=
> > +               (cfg->quirks & IO_PGTABLE_QUIRK_SHORT_SUPERSECTION) ?
> > +               (SZ_4K | SZ_64K | SZ_1M | SZ_16M) : (SZ_4K | SZ_64K | SZ_1M);
> > +
> > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return NULL;
> > +
> > +       data->pgd_size = SZ_16K;
> > +       data->pgd = __arm_short_alloc_pgtable(
> > +                                       data->pgd_size,
> > +                                       GFP_KERNEL | __GFP_ZERO | __GFP_DMA,
> > +                                       true, cfg);
> > +       if (!data->pgd)
> > +               goto out_free_data;
> > +       wmb();/* Ensure the empty pgd is visible before any actual TTBR write */
> > +
> > +       data->pgtable_cached = kmem_cache_create(
> > +                                       "io-pgtable-arm-short",
> > +                                        ARM_SHORT_BYTES_PER_PTE,
> > +                                        ARM_SHORT_BYTES_PER_PTE,
> > +                                        0, NULL);

I prepare to add SLAB_CACHE_DMA to guarantee the level2 pagetable base
address(pa) is alway 32bit(not over 4GB).

> > +       if (!data->pgtable_cached)
> > +               goto out_free_pgd;
> > +
> > +       /* TTBRs */
> > +       cfg->arm_short_cfg.ttbr[0] = virt_to_phys(data->pgd);
> > +       cfg->arm_short_cfg.ttbr[1] = 0;
> > +       cfg->arm_short_cfg.tcr = 0;
> > +       cfg->arm_short_cfg.nmrr = 0;
> > +       cfg->arm_short_cfg.prrr = 0;

           About SCTLR, How about we add it here:
          //===========
          cfg->arm_short_cfg.sctlr = 0; /* The iommu user should
configure IOMMU_{READ/WRITE} */
          //===========
           Is the comment ok?
> > +
> > +       data->iop.ops = (struct io_pgtable_ops) {
> > +               .map            = arm_short_map,
> > +               .unmap          = arm_short_unmap,
> > +               .iova_to_phys   = arm_short_iova_to_phys,
> > +       };
> > +
> > +       return &data->iop;
> > +
> > +out_free_pgd:
> > +       __arm_short_free_pgtable(data->pgd, data->pgd_size, true, cfg);
> > +out_free_data:
> > +       kfree(data);
> > +       return NULL;
> > +}
> > +
> [...]
> 
> > diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> > index 6436fe2..14a9b3a 100644
> > --- a/drivers/iommu/io-pgtable.c
> > +++ b/drivers/iommu/io-pgtable.c
> > @@ -28,6 +28,7 @@ extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns;
> >  extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
> >  extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
> >  extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
> > +extern struct io_pgtable_init_fns io_pgtable_arm_short_init_fns;
> > 
> >  static const struct io_pgtable_init_fns *
> >  io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
> > @@ -38,6 +39,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
> >         [ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
> >         [ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
> >  #endif
> > +#ifdef CONFIG_IOMMU_IO_PGTABLE_SHORT
> > +       [ARM_SHORT_DESC] = &io_pgtable_arm_short_init_fns,
> > +#endif
> >  };
> > 
> >  struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > index 68c63d9..0f45e60 100644
> > --- a/drivers/iommu/io-pgtable.h
> > +++ b/drivers/iommu/io-pgtable.h
> > @@ -9,6 +9,7 @@ enum io_pgtable_fmt {
> >         ARM_32_LPAE_S2,
> >         ARM_64_LPAE_S1,
> >         ARM_64_LPAE_S2,
> > +       ARM_SHORT_DESC,
> >         IO_PGTABLE_NUM_FMTS,
> >  };
> > 
> > @@ -45,6 +46,9 @@ struct iommu_gather_ops {
> >   */
> >  struct io_pgtable_cfg {
> >         #define IO_PGTABLE_QUIRK_ARM_NS (1 << 0)        /* Set NS bit in PTEs */
> > +       #define IO_PGTABLE_QUIRK_SHORT_SUPERSECTION     BIT(1)
> > +       #define IO_PGTABLE_QUIRK_SHORT_NO_XN            BIT(2) /* No XN bit */
> > +       #define IO_PGTABLE_QUIRK_SHORT_NO_PERMS         BIT(3) /* No AP bit */
> 
> Why have two quirks for this? I suggested included NO_XN in NO_PERMS:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/361160.html

Sorry. I will change like this in next time:

#define IO_PGTABLE_QUIRK_NO_PERMS            BIT(1) /* No XN/AP bits */
#define IO_PGTABLE_QUIRK_TLBI_ON_MAP         BIT(2) /* TLB-Flush after
map */
#define IO_PGTABLE_QUIRK_SHORT_SUPERSECTION  BIT(3)

Do I need change (1 << 0) to BIT(0) in ARM_NS?

> 
> >         int                             quirks;
> >         unsigned long                   pgsize_bitmap;
> >         unsigned int                    ias;
> > @@ -64,6 +68,13 @@ struct io_pgtable_cfg {
> >                         u64     vttbr;
> >                         u64     vtcr;
> >                 } arm_lpae_s2_cfg;
> > +
> > +               struct {
> > +                       u32     ttbr[2];
> > +                       u32     tcr;
> > +                       u32     nmrr;
> > +                       u32     prrr;
> > +               } arm_short_cfg;
> 
> We don't return an SCTLR value here, so a comment somewhere saying that
> access flag is not supported would be helpful (so that drivers can ensure
> that they configure things for the AP[2:0] permission model).

Do we need add SCTLR? like: 
         struct {
                 u32     ttbr[2];
                 u32     tcr;
                 u32     nmrr;
                 u32     prrr;
+                u32     sctlr;
          } arm_short_cfg;

  Or only add a comment in the place where ttbr,tcr is set?
  /* The iommu user should configure IOMMU_{READ/WRITE} since SCTLR
isn't implemented */
> 
> Will


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
