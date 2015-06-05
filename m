From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 3/6] iommu: add ARM short descriptor page table
 allocator.
Date: Fri, 5 Jun 2015 14:12:01 +0100
Message-ID: <20150605131201.GF1198@arm.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
 <1431683009-18158-4-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431683009-18158-4-git-send-email-yong.wu@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <Robin.Murphy@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Sasha Hauer <kernel@pengutronix.de>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>, "arnd@arndb.de" <arnd@arndb.de>, mitchelh@codeaurora.or
List-Id: iommu@lists.linux-foundation.org

Hello,

Thanks for the patch, it's good to see another user of the generic
IO page-table code. However, I have quite a lot of comments on the code.

On Fri, May 15, 2015 at 10:43:26AM +0100, Yong Wu wrote:
> This patch is for ARM Short Descriptor Format.It has 2-levels
> pagetable and the allocator supports 4K/64K/1M/16M.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/Kconfig                |   7 +
>  drivers/iommu/Makefile               |   1 +
>  drivers/iommu/io-pgtable-arm-short.c | 490 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c           |   4 +
>  drivers/iommu/io-pgtable.h           |   6 +
>  5 files changed, 508 insertions(+)
>  create mode 100644 drivers/iommu/io-pgtable-arm-short.c

For some reason, I ended up reviewing this back-to-front (i.e. starting
with the init code), so apologies if the comments feel like they were
written in reverse.

> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 1ae4e54..3d2eac6 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -39,6 +39,13 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
>
>           If unsure, say N here.
>
> +config IOMMU_IO_PGTABLE_SHORT
> +       bool "ARMv7/v8 Short Descriptor Format"
> +       select IOMMU_IO_PGTABLE

depends on ARM || ARM64 || COMPILE_TEST

> +       help
> +         Enable support for the ARM Short descriptor pagetable format.
> +         It has 2-levels pagetable and The allocator supports 4K/64K/1M/16M.

The second sentence is worded rather strangely.

> +
>  endmenu
>
>  config IOMMU_IOVA
> diff --git a/drivers/iommu/io-pgtable-arm-short.c b/drivers/iommu/io-pgtable-arm-short.c
> new file mode 100644
> index 0000000..cc286ce5
> --- /dev/null
> +++ b/drivers/iommu/io-pgtable-arm-short.c
> @@ -0,0 +1,490 @@
> +/*
> + * Copyright (c) 2014-2015 MediaTek Inc.
> + * Author: Yong Wu <yong.wu@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#define pr_fmt(fmt)    "arm-short-desc io-pgtable: "fmt
> +
> +#include <linux/err.h>
> +#include <linux/mm.h>
> +#include <linux/iommu.h>
> +#include <linux/errno.h>
> +
> +#include "io-pgtable.h"
> +
> +typedef u32 arm_short_iopte;
> +
> +struct arm_short_io_pgtable {
> +       struct io_pgtable       iop;
> +       struct kmem_cache       *ptekmem;
> +       size_t                  pgd_size;
> +       void                    *pgd;
> +};
> +
> +#define io_pgtable_short_to_data(x)                            \
> +       container_of((x), struct arm_short_io_pgtable, iop)
> +
> +#define io_pgtable_ops_to_pgtable(x)                           \
> +       container_of((x), struct io_pgtable, ops)
> +
> +#define io_pgtable_short_ops_to_data(x)                                \
> +       io_pgtable_short_to_data(io_pgtable_ops_to_pgtable(x))
> +

These are private macros, so I think you can drop the "short" part to,
err, keep them short.

> +#define ARM_SHORT_MAX_ADDR_BITS                        32
> +
> +#define ARM_SHORT_PGDIR_SHIFT                  20
> +#define ARM_SHORT_PAGE_SHIFT                   12
> +#define ARM_SHORT_PTRS_PER_PTE                 256
> +#define ARM_SHORT_BYTES_PER_PTE                        1024

Isn't that ARM_SHORT_PTRS_PER_PTE * sizeof(arm_short_iopte)?

> +/* 1 level pagetable */
> +#define ARM_SHORT_F_PGD_TYPE_PAGE              (0x1)

I think you're using PAGE and PGTABLE interchangeably, which is really
confusing to read.

> +#define ARM_SHORT_F_PGD_TYPE_PAGE_MSK          (0x3)

This is the TYPE mask.

> +#define ARM_SHORT_F_PGD_TYPE_SECTION           (0x2)
> +#define ARM_SHORT_F_PGD_TYPE_SUPERSECTION      (0x2 | (1 << 18))

Are you sure this is correct? afaict, bit 0 is PXN, so you should actually
be using bit 18 to distinguihs sections and supersections.

> +#define ARM_SHORT_F_PGD_TYPE_SECTION_MSK       (0x3 | (1 << 18))
> +#define ARM_SHORT_F_PGD_TYPE_IS_PAGE(pgd)      (((pgd) & 0x3) == 1)

Use your TYPE mask here.

> +#define ARM_SHORT_F_PGD_TYPE_IS_SECTION(pgd)           \
> +       (((pgd) & ARM_SHORT_F_PGD_TYPE_SECTION_MSK)     \
> +               == ARM_SHORT_F_PGD_TYPE_SECTION)
> +#define ARM_SHORT_F_PGD_TYPE_IS_SUPERSECTION(pgd)      \
> +       (((pgd) & ARM_SHORT_F_PGD_TYPE_SECTION_MSK)     \
> +               == ARM_SHORT_F_PGD_TYPE_SUPERSECTION)
> +
> +#define ARM_SHORT_F_PGD_B_BIT                  BIT(2)
> +#define ARM_SHORT_F_PGD_C_BIT                  BIT(3)
> +#define ARM_SHORT_F_PGD_IMPLE_BIT              BIT(9)
> +#define ARM_SHORT_F_PGD_S_BIT                  BIT(16)
> +#define ARM_SHORT_F_PGD_NG_BIT                 BIT(17)
> +#define ARM_SHORT_F_PGD_NS_BIT_PAGE            BIT(3)
> +#define ARM_SHORT_F_PGD_NS_BIT_SECTION         BIT(19)
> +
> +#define ARM_SHORT_F_PGD_PA_PAGETABLE_MSK       0xfffffc00
> +#define ARM_SHORT_F_PGD_PA_SECTION_MSK         0xfff00000
> +#define ARM_SHORT_F_PGD_PA_SUPERSECTION_MSK    0xff000000
> +
> +/* 2 level pagetable */
> +#define ARM_SHORT_F_PTE_TYPE_GET(val)          ((val) & 0x3)
> +#define ARM_SHORT_F_PTE_TYPE_LARGE             BIT(0)

Careful here, small pages can have bit 0 set for XN.

> +#define ARM_SHORT_F_PTE_TYPE_SMALL             BIT(1)
> +#define ARM_SHORT_F_PTE_B_BIT                  BIT(2)
> +#define ARM_SHORT_F_PTE_C_BIT                  BIT(3)
> +#define ARM_SHORT_F_PTE_IMPLE_BIT              BIT(9)
> +#define ARM_SHORT_F_PTE_S_BIT                  BIT(10)
> +#define ARM_SHORT_F_PTE_PA_LARGE_MSK            0xffff0000
> +#define ARM_SHORT_F_PTE_PA_SMALL_MSK            0xfffff000

I think you can drop the '_F' parts of all these macros.

> +#define ARM_SHORT_PGD_IDX(a)                   ((a) >> ARM_SHORT_PGDIR_SHIFT)
> +#define ARM_SHORT_PTE_IDX(a)                   \
> +       (((a) >> ARM_SHORT_PAGE_SHIFT) & 0xff)

The 0xff comes from ARM_SHORT_PTRS_PER_PTE, right? I think you should fix
your definitions so that these are all derived from each other rather than
open-coding the constants.

> +#define ARM_SHORT_GET_PTE_VA(pgd)              \
> +       (phys_to_virt((unsigned long)pgd & ARM_SHORT_F_PGD_PA_PAGETABLE_MSK))
> +
> +static arm_short_iopte *
> +arm_short_get_pte_in_pgd(arm_short_iopte curpgd, unsigned int iova)
> +{
> +       arm_short_iopte *pte;
> +
> +       pte = ARM_SHORT_GET_PTE_VA(curpgd);
> +       pte += ARM_SHORT_PTE_IDX(iova);
> +       return pte;
> +}
> +
> +static arm_short_iopte *
> +arm_short_supersection_start(arm_short_iopte *pgd)
> +{
> +       return (arm_short_iopte *)(round_down((unsigned long)pgd, (16 * 4)));
> +}

More magic numbers that should be derived from your global constants.

> +static int _arm_short_check_free_pte(struct arm_short_io_pgtable *data,
> +                                    arm_short_iopte *pgd)
> +{
> +       arm_short_iopte *pte;
> +       int i;
> +
> +       pte = ARM_SHORT_GET_PTE_VA(*pgd);
> +
> +       for (i = 0; i < ARM_SHORT_PTRS_PER_PTE; i++) {
> +               if (pte[i] != 0)
> +                       return 1;

-EEXIST?

> +       }
> +
> +       /* Free PTE */
> +       kmem_cache_free(data->ptekmem, pte);
> +       *pgd = 0;

I don't think this is safe, as there's a window where the page table
walker can see the freed pte memory.

> +
> +       return 0;
> +}
> +
> +static int arm_short_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> +                          size_t size)
> +{
> +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> +       arm_short_iopte *pgd;
> +       unsigned long iova_start = iova;
> +       unsigned long long end_plus_1 = iova + size;
> +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> +       void *cookie = data->iop.cookie;
> +       int ret;
> +
> +       do {
> +               pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova);
> +
> +               if (ARM_SHORT_F_PGD_TYPE_IS_PAGE(*pgd)) {
> +                       arm_short_iopte *pte;
> +                       unsigned int pte_offset;
> +                       unsigned int num_to_clean;
> +
> +                       pte_offset = ARM_SHORT_PTE_IDX(iova);
> +                       num_to_clean =
> +                           min((unsigned int)((end_plus_1 - iova) / PAGE_SIZE),
> +                               (ARM_SHORT_PTRS_PER_PTE - pte_offset));
> +
> +                       pte = arm_short_get_pte_in_pgd(*pgd, iova);
> +
> +                       memset(pte, 0, num_to_clean * sizeof(arm_short_iopte));
> +
> +                       ret = _arm_short_check_free_pte(data, pgd);
> +                       if (ret == 1)/* pte is not freed, need to flush pte */
> +                               tlb->flush_pgtable(
> +                                       pte,
> +                                       num_to_clean * sizeof(arm_short_iopte),
> +                                       cookie);
> +                       else
> +                               tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> +                                                  cookie);

Hopefully this can be cleaned up when you remove the outer loop and you
can use the size parameter to figure out which level to unmap.

> +                       iova += num_to_clean << PAGE_SHIFT;
> +               } else if (ARM_SHORT_F_PGD_TYPE_IS_SECTION(*pgd)) {
> +                       *pgd = 0;
> +
> +                       tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> +                                          cookie);
> +                       iova += SZ_1M;

Again, these sizes can be derived from other page table properties that
you have.

> +               } else if (ARM_SHORT_F_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
> +                       arm_short_iopte *start;
> +
> +                       start = arm_short_supersection_start(pgd);
> +                       if (unlikely(start != pgd))
> +                               pr_warn("%s:suppersection start isn't aligned.iova=0x%lx,pgd=0x%x\n",
> +                                       __func__, iova, *pgd);
> +
> +                       memset(start, 0, 16 * sizeof(arm_short_iopte));
> +
> +                       tlb->flush_pgtable(start, 16 * sizeof(arm_short_iopte),
> +                                          cookie);
> +
> +                       iova = (iova + SZ_16M) & (~(SZ_16M - 1));

See later, but I think supersections should not be assumed by default.

> +               } else {
> +                       break;
> +               }
> +       } while (iova < end_plus_1 && iova);

I don't think you need this loop -- unmap will be called in page-sized
chunks (where page-size refers to units as advertised in your IOMMU's
pgsize_bitmap). The tricky part is when somebody unmaps a subset of a
previous mapping that ended up using something like a section. You need
to handle that here by splitting blocks at level 1 into a table and
allocating a level 2.

> +
> +       tlb->tlb_add_flush(iova_start, size, true, cookie);
> +
> +       return 0;

You need to return the size of the region that you managed to unmap, so
0 isn't right here.

> +}
> +
> +static arm_short_iopte __arm_short_pte_port(unsigned int prot, bool large)
> +{
> +       arm_short_iopte pteprot;
> +
> +       pteprot = ARM_SHORT_F_PTE_S_BIT;
> +
> +       pteprot |= large ? ARM_SHORT_F_PTE_TYPE_LARGE :
> +                               ARM_SHORT_F_PTE_TYPE_SMALL;
> +
> +       if (prot & IOMMU_CACHE)
> +               pteprot |=  ARM_SHORT_F_PTE_B_BIT | ARM_SHORT_F_PTE_C_BIT;

Where do you set TEX[0] for write-allocate?

> +       return pteprot;
> +}
> +
> +static arm_short_iopte __arm_short_pgd_port(int prot, bool super)
> +{
> +       arm_short_iopte pgdprot;
> +
> +       pgdprot = ARM_SHORT_F_PGD_S_BIT;
> +       pgdprot |= super ? ARM_SHORT_F_PGD_TYPE_SUPERSECTION :
> +                               ARM_SHORT_F_PGD_TYPE_SECTION;
> +       if (prot & IOMMU_CACHE)
> +               pgdprot |= ARM_SHORT_F_PGD_C_BIT | ARM_SHORT_F_PGD_B_BIT;
> +
> +       return pgdprot;
> +}
> +
> +static int _arm_short_map_page(struct arm_short_io_pgtable *data,
> +                              unsigned int iova, phys_addr_t pa,
> +                              unsigned int prot, bool largepage)
> +{
> +       arm_short_iopte *pgd = data->pgd;
> +       arm_short_iopte *pte;
> +       arm_short_iopte pgdprot, pteprot;
> +       arm_short_iopte mask = largepage ? ARM_SHORT_F_PTE_PA_LARGE_MSK :
> +                                               ARM_SHORT_F_PTE_PA_SMALL_MSK;
> +       int i, ptenum = largepage ? 16 : 1;
> +       bool ptenew = false;
> +       void *pte_new_va;
> +       void *cookie = data->iop.cookie;
> +
> +       if ((iova | pa) & (~mask)) {
> +               pr_err("IOVA|PA Not Aligned(iova=0x%x pa=0x%pa type=%s)\n",
> +                      iova, &pa, largepage ? "large page" : "small page");
> +               return -EINVAL;
> +       }
> +
> +       pgdprot = ARM_SHORT_F_PGD_TYPE_PAGE;
> +       if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> +               pgdprot |= ARM_SHORT_F_PGD_NS_BIT_PAGE;
> +
> +       pgd += ARM_SHORT_PGD_IDX(iova);
> +
> +       if (!(*pgd)) {
> +               pte_new_va = kmem_cache_zalloc(data->ptekmem, GFP_KERNEL);
> +               if (unlikely(!pte_new_va)) {
> +                       pr_err("Failed to alloc pte\n");
> +                       return -ENOMEM;
> +               }
> +
> +               /* Check pte alignment -- must 1K align */
> +               if (unlikely((unsigned long)pte_new_va &
> +                            (ARM_SHORT_BYTES_PER_PTE - 1))) {
> +                       pr_err("The new pte is not aligned! (va=0x%p)\n",
> +                              pte_new_va);
> +                       kmem_cache_free(data->ptekmem, (void *)pte_new_va);
> +                       return -ENOMEM;
> +               }

How are you enforcing this alignment?

> +               ptenew = true;
> +               *pgd = virt_to_phys(pte_new_va) | pgdprot;
> +               kmemleak_ignore(pte_new_va);

Maybe you should be using alloc_pages instead of your kmem_cache (I mention
this again later on).

> +               data->iop.cfg.tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> +                                                cookie);
> +       } else {
> +               /* Someone else may have allocated for this pgd */
> +               if (((*pgd) & (~ARM_SHORT_F_PGD_PA_PAGETABLE_MSK)) != pgdprot) {
> +                       pr_err("The prot of old pgd is not Right!iova=0x%x pgd=0x%x pgprot=0x%x\n",
> +                              iova, (*pgd), pgdprot);

You can probably just WARN here, as I do in the LPAE code. It shows a bug
in the caller of the API.

> +                       return -EEXIST;
> +               }
> +       }
> +
> +       pteprot = (arm_short_iopte)pa;
> +       pteprot |= __arm_short_pte_port(prot, largepage);
> +
> +       pte = arm_short_get_pte_in_pgd(*pgd, iova);
> +
> +       pr_debug("iova:0x%x,pte:0x%p(0x%x),prot:0x%x-%s\n",
> +                iova, pte, ARM_SHORT_PTE_IDX(iova), pteprot,
> +                largepage ? "large page" : "small page");
> +
> +       for (i = 0; i < ptenum; i++) {
> +               if (pte[i]) {
> +                       pr_err("The To-Map pte exists!(iova=0x%x pte=0x%x i=%d)\n",
> +                              iova, pte[i], i);
> +                       goto err_out;
> +               }
> +               pte[i] = pteprot;
> +       }

I don't think you need this loop; you should only be given a page size,
like with unmap.

> +
> +       data->iop.cfg.tlb->flush_pgtable(pte, ptenum * sizeof(arm_short_iopte),
> +                                        cookie);
> +       return 0;
> +
> + err_out:
> +       for (i--; i >= 0; i--)
> +               pte[i] = 0;
> +       if (ptenew)
> +               kmem_cache_free(data->ptekmem, pte_new_va);
> +       return -EEXIST;
> +}
> +
> +static int _arm_short_map_section(struct arm_short_io_pgtable *data,
> +                                 unsigned int iova, phys_addr_t pa,
> +                                 int prot, bool supersection)
> +{
> +       arm_short_iopte pgprot;
> +       arm_short_iopte mask = supersection ?
> +                               ARM_SHORT_F_PGD_PA_SUPERSECTION_MSK :
> +                               ARM_SHORT_F_PGD_PA_SECTION_MSK;
> +       arm_short_iopte *pgd = data->pgd;
> +       int i;
> +       unsigned int pgdnum = supersection ? 16 : 1;
> +
> +       if ((iova | pa) & (~mask)) {
> +               pr_err("IOVA|PA Not Aligned(iova=0x%x pa=0x%pa type=%s)\n",
> +                      iova, &pa, supersection ? "supersection" : "section");
> +               return -EINVAL;
> +       }
> +
> +       pgprot = (arm_short_iopte)pa;
> +
> +       if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> +               pgprot |= ARM_SHORT_F_PGD_NS_BIT_SECTION;
> +
> +       pgprot |= __arm_short_pgd_port(prot, supersection);
> +
> +       pgd += ARM_SHORT_PGD_IDX(iova);
> +
> +       pr_debug("iova:0x%x,pgd:0x%p(0x%p+0x%x),value:0x%x-%s\n",
> +                iova, pgd, data->pgd, ARM_SHORT_PGD_IDX(iova),
> +                pgprot, supersection ? "supersection" : "section");
> +
> +       for (i = 0; i < pgdnum; i++) {
> +               if (unlikely(*pgd)) {
> +                       pr_err("The To-Map pdg exists!(iova=0x%x pgd=0x%x i=%d)\n",
> +                              iova, pgd[i], i);
> +                       goto err_out;
> +               }
> +               pgd[i] = pgprot;
> +       }

Similar comments here.

> +       data->iop.cfg.tlb->flush_pgtable(pgd,
> +                                        pgdnum * sizeof(arm_short_iopte),
> +                                        data->iop.cookie);
> +       return 0;
> +
> + err_out:
> +       for (i--; i >= 0; i--)
> +               pgd[i] = 0;
> +       return -EEXIST;
> +}
> +
> +static int arm_short_map(struct io_pgtable_ops *ops, unsigned long iova,
> +                        phys_addr_t paddr, size_t size, int prot)
> +{
> +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> +       int ret;
> +
> +       if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> +               return -EINVAL;

Why? You could have (another) quirk to select the access model and you
should be able to implement read+write, read-only no-exec and no-access.

> +       if (size == SZ_4K) {/* most case */
> +               ret = _arm_short_map_page(data, iova, paddr, prot, false);
> +       } else if (size == SZ_64K) {
> +               ret = _arm_short_map_page(data, iova, paddr, prot, true);
> +       } else if (size == SZ_1M) {
> +               ret = _arm_short_map_section(data, iova, paddr, prot, false);
> +       } else if (size == SZ_16M) {
> +               ret = _arm_short_map_section(data, iova, paddr, prot, true);
> +       } else {
> +               ret = -EINVAL;
> +       }

Use a switch statement here?

> +       tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
> +       return ret;
> +}
> +
> +static struct io_pgtable *
> +arm_short_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +       struct arm_short_io_pgtable *data;
> +
> +       if (cfg->ias != 32)
> +               return NULL;

I think you just need to check '>'; VAs smaller than 32-bit can still
be translated.

> +       if (cfg->oas > ARM_SHORT_MAX_ADDR_BITS)
> +               return NULL;

What benefit does ARM_SHORT_MAX_ADDR_BITS offer? Why not just '32'?

> +
> +       cfg->pgsize_bitmap &= SZ_4K | SZ_64K | SZ_1M | SZ_16M;

We can't support supersections unconditionally. Please add a quirk for
this, as it relies on IOMMU support.

> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return NULL;
> +
> +       data->pgd_size = SZ_16K;
> +
> +       data->pgd = alloc_pages_exact(data->pgd_size, GFP_KERNEL | __GFP_ZERO);
> +       if (!data->pgd)
> +               goto out_free_data;
> +
> +       cfg->tlb->flush_pgtable(data->pgd, data->pgd_size, cookie);

We may as well postpone this flush to the end of the function, given that
we can still fail at this point.

> +       /* kmem for pte */
> +       data->ptekmem = kmem_cache_create("short-descriptor-pte",

A better name would be "io-pgtable-arm-short", however, why can't you
just use GFP_ATOMIC in your pte allocations and do away with the cache
altogether? Also, what happens if you try to allocate multiple caches
with the same name?

> +                                          ARM_SHORT_BYTES_PER_PTE,
> +                                          ARM_SHORT_BYTES_PER_PTE,
> +                                          0, NULL);
> +
> +       if (IS_ERR_OR_NULL(data->ptekmem)) {

I think you just need a NULL check here.

> +               pr_err("Failed to Create cached mem for PTE %ld\n",
> +                      PTR_ERR(data->ptekmem));

I don't think this error is particularly useful.

> +               goto out_free_pte;
> +       }
> +
> +       /* TTBRs */
> +       cfg->arm_short_cfg.ttbr[0] = virt_to_phys(data->pgd);
> +       cfg->arm_short_cfg.ttbr[1] = 0;
> +
> +       cfg->arm_short_cfg.tcr = 0;
> +
> +       data->iop.ops = (struct io_pgtable_ops) {
> +               .map            = arm_short_map,
> +               .unmap          = arm_short_unmap,
> +               .iova_to_phys   = arm_short_iova_to_phys,
> +       };
> +
> +       return &data->iop;
> +
> +out_free_pte:
> +       free_pages_exact(data->pgd, data->pgd_size);
> +out_free_data:
> +       kfree(data);
> +       return NULL;
> +}
> +
> +static void arm_short_free_pgtable(struct io_pgtable *iop)
> +{
> +       struct arm_short_io_pgtable *data = io_pgtable_short_to_data(iop);
> +
> +       kmem_cache_destroy(data->ptekmem);
> +       free_pages_exact(data->pgd, data->pgd_size);
> +       kfree(data);
> +}
> +
> +struct io_pgtable_init_fns io_pgtable_arm_short_init_fns = {
> +       .alloc  = arm_short_alloc_pgtable,
> +       .free   = arm_short_free_pgtable,
> +};
> +
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index 6436fe2..14a9b3a 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -28,6 +28,7 @@ extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
> +extern struct io_pgtable_init_fns io_pgtable_arm_short_init_fns;
>
>  static const struct io_pgtable_init_fns *
>  io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
> @@ -38,6 +39,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] =
>         [ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
>         [ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
>  #endif
> +#ifdef CONFIG_IOMMU_IO_PGTABLE_SHORT
> +       [ARM_SHORT_DESC] = &io_pgtable_arm_short_init_fns,
> +#endif
>  };
>
>  struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 10e32f6..47efaab 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -9,6 +9,7 @@ enum io_pgtable_fmt {
>         ARM_32_LPAE_S2,
>         ARM_64_LPAE_S1,
>         ARM_64_LPAE_S2,
> +       ARM_SHORT_DESC,
>         IO_PGTABLE_NUM_FMTS,
>  };
>
> @@ -62,6 +63,11 @@ struct io_pgtable_cfg {
>                         u64     vttbr;
>                         u64     vtcr;
>                 } arm_lpae_s2_cfg;
> +
> +               struct {
> +                       u64     ttbr[2];
> +                       u64     tcr;
> +               } arm_short_cfg;

I appreciate that you're not using TEX remapping, but could we include
the NMRR and PRRR registers here (we can just zero them) too, please?
That makes it easier to support a TEX_REMAP quick later on and also sets
them to a known value.

Also, any chance of some self-tests?

Will
