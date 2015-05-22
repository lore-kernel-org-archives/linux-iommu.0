From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 3/6] iommu: add ARM short descriptor page table
	allocator.
Date: Fri, 22 May 2015 11:14:28 +0800
Message-ID: <1432264468.5092.92.camel@mhfsdcap03>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
	<1431683009-18158-4-git-send-email-yong.wu@mediatek.com>
	<55561124.2080909@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55561124.2080909-5wv7dgnIgG8@public.gmane.org>
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
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>L
List-Id: iommu@lists.linux-foundation.org

Hi Robin,
    Thanks very much for so detail suggestion.
    please also help check my comment, the others i will change in next
time.
On Fri, 2015-05-15 at 16:30 +0100, Robin Murphy wrote:
> Oops, seems I'm rather behind on things - I started this review on the 
> RFC, but I'll finish it here...
> 
> On 15/05/15 10:43, Yong Wu wrote:
> > This patch is for ARM Short Descriptor Format.It has 2-levels
> > pagetable and the allocator supports 4K/64K/1M/16M.
> >
> 
>  From the look of the code, this doesn't fully support partial unmaps 
> (i.e. splitting block entries), am I right? That's OK for DMA-API use, 
> since that doesn't permit partial unmaps anyway, but I'd say it's worth 
> making it clear that that's still a TODO in order for short-descriptor 
> mappings to fully support arbitrary raw IOMMU API usage.
Yes. I don't add split right now due to I check that
iommu_map/iommu_unmap make sure iova|pa be aligned.

I will add split for fully support in next version. Thanks.
> 
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >   drivers/iommu/Kconfig                |   7 +
> >   drivers/iommu/Makefile               |   1 +
> >   drivers/iommu/io-pgtable-arm-short.c | 490 +++++++++++++++++++++++++++++++++++
> >   drivers/iommu/io-pgtable.c           |   4 +
> >   drivers/iommu/io-pgtable.h           |   6 +
> >   5 files changed, 508 insertions(+)
> >   create mode 100644 drivers/iommu/io-pgtable-arm-short.c
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 1ae4e54..3d2eac6 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -39,6 +39,13 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
> >
> >            If unsure, say N here.
> >
> > +config IOMMU_IO_PGTABLE_SHORT
> > +       bool "ARMv7/v8 Short Descriptor Format"
> > +       select IOMMU_IO_PGTABLE
> > +       help
> > +         Enable support for the ARM Short descriptor pagetable format.
> > +         It has 2-levels pagetable and The allocator supports 4K/64K/1M/16M.
> > +
> >   endmenu
> >
> >   config IOMMU_IOVA
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index 080ffab..815b3c8 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -3,6 +3,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
> >   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> >   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
> >   obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> > +obj-$(CONFIG_IOMMU_IO_PGTABLE_SHORT) += io-pgtable-arm-short.o
> >   obj-$(CONFIG_IOMMU_IOVA) += iova.o
> >   obj-$(CONFIG_OF_IOMMU) += of_iommu.o
> >   obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
> > diff --git a/drivers/iommu/io-pgtable-arm-short.c b/drivers/iommu/io-pgtable-arm-short.c
> > new file mode 100644
> > index 0000000..cc286ce5
> > --- /dev/null
> > +++ b/drivers/iommu/io-pgtable-arm-short.c
> > @@ -0,0 +1,490 @@
> > +/*
> > + * Copyright (c) 2014-2015 MediaTek Inc.
> > + * Author: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +#define pr_fmt(fmt)    "arm-short-desc io-pgtable: "fmt
> > +
> > +#include <linux/err.h>
> > +#include <linux/mm.h>
> > +#include <linux/iommu.h>
> > +#include <linux/errno.h>
> 
> Alphabetically-sorted includes, please. Also, this list doesn't look 
> particularly correct - e.g. I don't think you're actually using anything 
> from mm.h, but you are relying on stuff from kernel.h, slab.h, gfp.h, 
> etc. being pulled in indirectly.
> 
> > +
> > +#include "io-pgtable.h"
> > +
> > +typedef u32 arm_short_iopte;
> > +
> > +struct arm_short_io_pgtable {
> > +       struct io_pgtable       iop;
> > +       struct kmem_cache       *ptekmem;
> > +       size_t                  pgd_size;
> > +       void                    *pgd;
> > +};
> > +
> > +#define io_pgtable_short_to_data(x)                            \
> > +       container_of((x), struct arm_short_io_pgtable, iop)
> > +
> > +#define io_pgtable_ops_to_pgtable(x)                           \
> > +       container_of((x), struct io_pgtable, ops)
> 
> This macro may as well be factored out into io-pgtable.h before 
> duplication spreads any further. I don't see any reason for it not to 
> live alongside the definition of struct io_pgtable, anyway.
Thanks. I will move it into io-pgtable.h.
Then I think this also should be deleted in io-pgtable-arm.c.
> 
> > +
> > +#define io_pgtable_short_ops_to_data(x)                                \
> > +       io_pgtable_short_to_data(io_pgtable_ops_to_pgtable(x))
> > +
> > +#define ARM_SHORT_MAX_ADDR_BITS                        32
> > +
> > +#define ARM_SHORT_PGDIR_SHIFT                  20
> > +#define ARM_SHORT_PAGE_SHIFT                   12
> > +#define ARM_SHORT_PTRS_PER_PTE                 256
> > +#define ARM_SHORT_BYTES_PER_PTE                        1024
> > +
> > +/* 1 level pagetable */
> > +#define ARM_SHORT_F_PGD_TYPE_PAGE              (0x1)
> > +#define ARM_SHORT_F_PGD_TYPE_PAGE_MSK          (0x3)
> > +#define ARM_SHORT_F_PGD_TYPE_SECTION           (0x2)
> > +#define ARM_SHORT_F_PGD_TYPE_SUPERSECTION      (0x2 | (1 << 18))
> > +#define ARM_SHORT_F_PGD_TYPE_SECTION_MSK       (0x3 | (1 << 18))
> > +#define ARM_SHORT_F_PGD_TYPE_IS_PAGE(pgd)      (((pgd) & 0x3) == 1)
> 
> This confused me on first glance looking at the places it's used, 
> because it's not actually referring to a thing which is a page. Maybe 
> ..._IS_TABLE would be a better name?
Yes. It is better. From the spec, it is "page table".
Then How about "ARM_SHORT_F_PGD_TYPE_IS_PAGETABLE"?
It is a little long, but there are only 2 lines use it and Both are not
over 80 character even though "_IS_PAGETABLE".
> 
> > +#define ARM_SHORT_F_PGD_TYPE_IS_SECTION(pgd)           \
> > +       (((pgd) & ARM_SHORT_F_PGD_TYPE_SECTION_MSK)     \
> > +               == ARM_SHORT_F_PGD_TYPE_SECTION)
> > +#define ARM_SHORT_F_PGD_TYPE_IS_SUPERSECTION(pgd)      \
> > +       (((pgd) & ARM_SHORT_F_PGD_TYPE_SECTION_MSK)     \
> > +               == ARM_SHORT_F_PGD_TYPE_SUPERSECTION)
> > +
> > +#define ARM_SHORT_F_PGD_B_BIT                  BIT(2)
> > +#define ARM_SHORT_F_PGD_C_BIT                  BIT(3)
> > +#define ARM_SHORT_F_PGD_IMPLE_BIT              BIT(9)
> > +#define ARM_SHORT_F_PGD_S_BIT                  BIT(16)
> > +#define ARM_SHORT_F_PGD_NG_BIT                 BIT(17)
> > +#define ARM_SHORT_F_PGD_NS_BIT_PAGE            BIT(3)
> > +#define ARM_SHORT_F_PGD_NS_BIT_SECTION         BIT(19)
> > +
> > +#define ARM_SHORT_F_PGD_PA_PAGETABLE_MSK       0xfffffc00
> > +#define ARM_SHORT_F_PGD_PA_SECTION_MSK         0xfff00000
> > +#define ARM_SHORT_F_PGD_PA_SUPERSECTION_MSK    0xff000000
> > +
> > +/* 2 level pagetable */
> > +#define ARM_SHORT_F_PTE_TYPE_GET(val)          ((val) & 0x3)
> > +#define ARM_SHORT_F_PTE_TYPE_LARGE             BIT(0)
> > +#define ARM_SHORT_F_PTE_TYPE_SMALL             BIT(1)
> > +#define ARM_SHORT_F_PTE_B_BIT                  BIT(2)
> > +#define ARM_SHORT_F_PTE_C_BIT                  BIT(3)
> > +#define ARM_SHORT_F_PTE_IMPLE_BIT              BIT(9)
> > +#define ARM_SHORT_F_PTE_S_BIT                  BIT(10)
> > +#define ARM_SHORT_F_PTE_PA_LARGE_MSK            0xffff0000
> > +#define ARM_SHORT_F_PTE_PA_SMALL_MSK            0xfffff000
> > +
> > +#define ARM_SHORT_PGD_IDX(a)                   ((a) >> ARM_SHORT_PGDIR_SHIFT)
> > +#define ARM_SHORT_PTE_IDX(a)                   \
> > +       (((a) >> ARM_SHORT_PAGE_SHIFT) & 0xff)
> > +#define ARM_SHORT_GET_PTE_VA(pgd)              \
> > +       (phys_to_virt((unsigned long)pgd & ARM_SHORT_F_PGD_PA_PAGETABLE_MSK))
> > +
> > +static arm_short_iopte *
> > +arm_short_get_pte_in_pgd(arm_short_iopte curpgd, unsigned int iova)
> > +{
> > +       arm_short_iopte *pte;
> > +
> > +       pte = ARM_SHORT_GET_PTE_VA(curpgd);
> > +       pte += ARM_SHORT_PTE_IDX(iova);
> > +       return pte;
> > +}
> > +
> > +static arm_short_iopte *
> > +arm_short_supersection_start(arm_short_iopte *pgd)
> > +{
> > +       return (arm_short_iopte *)(round_down((unsigned long)pgd, (16 * 4)));
> > +}
> > +
> > +static int _arm_short_check_free_pte(struct arm_short_io_pgtable *data,
> > +                                    arm_short_iopte *pgd)
> 
> Given that this is only returning success/failure, it should probably be 
> bool rather than int.
Thanks.
> 
> > +{
> > +       arm_short_iopte *pte;
> > +       int i;
> > +
> > +       pte = ARM_SHORT_GET_PTE_VA(*pgd);
> > +
> > +       for (i = 0; i < ARM_SHORT_PTRS_PER_PTE; i++) {
> > +               if (pte[i] != 0)
> > +                       return 1;
> > +       }
> > +
> > +       /* Free PTE */
> > +       kmem_cache_free(data->ptekmem, pte);
> > +       *pgd = 0;
> > +
> > +       return 0;
> > +}
> > +
> > +static phys_addr_t arm_short_iova_to_phys(struct io_pgtable_ops *ops,
> > +                                         unsigned long iova)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> > +       arm_short_iopte *pte, *pgd = data->pgd;
> > +       phys_addr_t pa = 0;
> > +
> > +       pgd += ARM_SHORT_PGD_IDX(iova);
> > +
> > +       if (ARM_SHORT_F_PGD_TYPE_IS_PAGE(*pgd)) {
> > +               u8 pte_type;
> > +
> > +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > +               pte_type = ARM_SHORT_F_PTE_TYPE_GET(*pte);
> > +
> > +               if (pte_type == ARM_SHORT_F_PTE_TYPE_LARGE) {
> > +                       pa = (*pte) & ARM_SHORT_F_PTE_PA_LARGE_MSK;
> > +                       pa |= iova & (~ARM_SHORT_F_PTE_PA_LARGE_MSK);
> > +               } else if (pte_type == ARM_SHORT_F_PTE_TYPE_SMALL) {
> > +                       pa = (*pte) & ARM_SHORT_F_PTE_PA_SMALL_MSK;
> > +                       pa |= iova & (~ARM_SHORT_F_PTE_PA_SMALL_MSK);
> > +               }
> > +       } else {
> > +               if (ARM_SHORT_F_PGD_TYPE_IS_SECTION(*pgd)) {
> > +                       pa = (*pgd) & ARM_SHORT_F_PGD_PA_SECTION_MSK;
> > +                       pa |= iova & (~ARM_SHORT_F_PGD_PA_SECTION_MSK);
> > +               } else if (ARM_SHORT_F_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
> > +                       pa = (*pgd) & ARM_SHORT_F_PGD_PA_SUPERSECTION_MSK;
> > +                       pa |= iova & (~ARM_SHORT_F_PGD_PA_SUPERSECTION_MSK);
> > +               }
> > +       }
> > +
> > +       return pa;
> > +}
> > +
> > +static int arm_short_unmap(struct io_pgtable_ops *ops, unsigned long iova,
> > +                          size_t size)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> > +       arm_short_iopte *pgd;
> > +       unsigned long iova_start = iova;
> > +       unsigned long long end_plus_1 = iova + size;
> 
> Since everything's at page granularity, working with IOVA PFNs rather 
> than raw addresses might be more convenient, and also sidesteps the 
> 32-bit overflow problem. On 64-bit platforms, we're wasting a whole 95 
> bits of a long long here ;)
About IOVA PFNs, if add it, we have to include "iova.h". then it may add
a new relationship with other module. I am not sure it is ok.
in pg-iotable-arm.c, I also don't see it. so I don't prepare to add iova
pfn, is it ok?

iova here always is 32bit, and iova+size may over 32bit. so I use "long
long" here. "long long" always is 64bit in 32bit&64bit platform?
"long" may be error while 32bit platform. 

I will add split and try to delete this in next version.
> 
> > +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > +       void *cookie = data->iop.cookie;
> > +       int ret;
> > +
> > +       do {
> > +               pgd = (arm_short_iopte *)data->pgd + ARM_SHORT_PGD_IDX(iova);
> > +
> > +               if (ARM_SHORT_F_PGD_TYPE_IS_PAGE(*pgd)) {
> > +                       arm_short_iopte *pte;
> > +                       unsigned int pte_offset;
> > +                       unsigned int num_to_clean;
> > +
> > +                       pte_offset = ARM_SHORT_PTE_IDX(iova);
> > +                       num_to_clean =
> > +                           min((unsigned int)((end_plus_1 - iova) / PAGE_SIZE),
> 
> Shouldn't this be page size for the IOMMU, not the CPU? I'm a bit slow 
> today, but this looks like it might go wrong when PAGE_SIZE > 4K.
Thanks. Then I will add a define like this:
#define IOMMU_PAGE_SIZE_4K  SZ_4K
And I will put it into io-pgtable.h,  the io-pgtable-arm.c may also need
it.
> 
> > +                               (ARM_SHORT_PTRS_PER_PTE - pte_offset));
> > +
> > +                       pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > +
> > +                       memset(pte, 0, num_to_clean * sizeof(arm_short_iopte));
> > +
> > +                       ret = _arm_short_check_free_pte(data, pgd);
> > +                       if (ret == 1)/* pte is not freed, need to flush pte */
> > +                               tlb->flush_pgtable(
> > +                                       pte,
> > +                                       num_to_clean * sizeof(arm_short_iopte),
> > +                                       cookie);
> > +                       else
> > +                               tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> > +                                                  cookie);
> > +
> > +                       iova += num_to_clean << PAGE_SHIFT;
> > +               } else if (ARM_SHORT_F_PGD_TYPE_IS_SECTION(*pgd)) {
> > +                       *pgd = 0;
> > +
> > +                       tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> > +                                          cookie);
> > +                       iova += SZ_1M;
> > +               } else if (ARM_SHORT_F_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
> > +                       arm_short_iopte *start;
> > +
> > +                       start = arm_short_supersection_start(pgd);
> > +                       if (unlikely(start != pgd))
> > +                               pr_warn("%s:suppersection start isn't aligned.iova=0x%lx,pgd=0x%x\n",
> 
> Nit: typo in "supersection" here.
> 
> > +                                       __func__, iova, *pgd);
> > +
> > +                       memset(start, 0, 16 * sizeof(arm_short_iopte));
> > +
> > +                       tlb->flush_pgtable(start, 16 * sizeof(arm_short_iopte),
> > +                                          cookie);
> > +
> > +                       iova = (iova + SZ_16M) & (~(SZ_16M - 1));
> 
> iova = ALIGN(iova + SZ_16M, SZ_16M);
> 
> Except that being unaligned in the first place is an error condition, so 
> it would make more sense to just have "iova += SZ_16M;" here, and put 
> "iova = ALIGN(iova, SZ_16M) after the warning in the error path above.
> 
> Since you don't handle splitting block mappings, and you also seem to be 
> missing an equivalent warning for unaligned second-level large pages, it 
> might be better to simply return an error if the requested size and 
> alignment don't exactly match the type of entry found, rather than let 
> the page tables get into an unexpectedly inconsistent state.
OK. I will add split and add the align checking of start_iova for each
case..
> 
> > +               } else {
> > +                       break;
> > +               }
> > +       } while (iova < end_plus_1 && iova);
> > +
> > +       tlb->tlb_add_flush(iova_start, size, true, cookie);
> > +
> > +       return 0;
> > +}
> > +
> > +static arm_short_iopte __arm_short_pte_port(unsigned int prot, bool large)
> 
> I assume _port is a typo of _prot
> 
> > +{
> > +       arm_short_iopte pteprot;
> > +
> > +       pteprot = ARM_SHORT_F_PTE_S_BIT;
> > +
> > +       pteprot |= large ? ARM_SHORT_F_PTE_TYPE_LARGE :
> > +                               ARM_SHORT_F_PTE_TYPE_SMALL;
> > +
> > +       if (prot & IOMMU_CACHE)
> > +               pteprot |=  ARM_SHORT_F_PTE_B_BIT | ARM_SHORT_F_PTE_C_BIT;
> > +
> > +       return pteprot;
> > +}
> > +
> > +static arm_short_iopte __arm_short_pgd_port(int prot, bool super)
> 
> Ditto
> 
> > +{
> > +       arm_short_iopte pgdprot;
> > +
> > +       pgdprot = ARM_SHORT_F_PGD_S_BIT;
> > +       pgdprot |= super ? ARM_SHORT_F_PGD_TYPE_SUPERSECTION :
> > +                               ARM_SHORT_F_PGD_TYPE_SECTION;
> > +       if (prot & IOMMU_CACHE)
> > +               pgdprot |= ARM_SHORT_F_PGD_C_BIT | ARM_SHORT_F_PGD_B_BIT;
> > +
> > +       return pgdprot;
> > +}
> > +
> > +static int _arm_short_map_page(struct arm_short_io_pgtable *data,
> > +                              unsigned int iova, phys_addr_t pa,
> > +                              unsigned int prot, bool largepage)
> > +{
> > +       arm_short_iopte *pgd = data->pgd;
> > +       arm_short_iopte *pte;
> > +       arm_short_iopte pgdprot, pteprot;
> > +       arm_short_iopte mask = largepage ? ARM_SHORT_F_PTE_PA_LARGE_MSK :
> > +                                               ARM_SHORT_F_PTE_PA_SMALL_MSK;
> > +       int i, ptenum = largepage ? 16 : 1;
> > +       bool ptenew = false;
> > +       void *pte_new_va;
> > +       void *cookie = data->iop.cookie;
> > +
> > +       if ((iova | pa) & (~mask)) {
> > +               pr_err("IOVA|PA Not Aligned(iova=0x%x pa=0x%pa type=%s)\n",
> > +                      iova, &pa, largepage ? "large page" : "small page");
> 
> Nit: you may as well just have largepage ?  "large" : "small" here and 
> "...type=%s page..." in the format string.
> 
> > +               return -EINVAL;
> > +       }
> > +
> > +       pgdprot = ARM_SHORT_F_PGD_TYPE_PAGE;
> > +       if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> > +               pgdprot |= ARM_SHORT_F_PGD_NS_BIT_PAGE;
> > +
> > +       pgd += ARM_SHORT_PGD_IDX(iova);
> > +
> > +       if (!(*pgd)) {
> > +               pte_new_va = kmem_cache_zalloc(data->ptekmem, GFP_KERNEL);
> > +               if (unlikely(!pte_new_va)) {
> > +                       pr_err("Failed to alloc pte\n");
> 
> The allocator should already print the details of a failure, so I don't 
> think this adds much.
> 
> > +                       return -ENOMEM;
> > +               }
> > +
> > +               /* Check pte alignment -- must 1K align */
> > +               if (unlikely((unsigned long)pte_new_va &
> > +                            (ARM_SHORT_BYTES_PER_PTE - 1))) {
> > +                       pr_err("The new pte is not aligned! (va=0x%p)\n",
> > +                              pte_new_va);
> > +                       kmem_cache_free(data->ptekmem, (void *)pte_new_va);
> > +                       return -ENOMEM;
> > +               }
> 
> Can this ever actually happen? Besides, if kmem_cache_alloc isn't 
> honouring the alignment specified in kmem_cache_create, I think the 
> kernel might have bigger problems anyway...
Thanks. I will delete it.
> 
> > +               ptenew = true;
> > +               *pgd = virt_to_phys(pte_new_va) | pgdprot;
> > +               kmemleak_ignore(pte_new_va);
> > +               data->iop.cfg.tlb->flush_pgtable(pgd, sizeof(arm_short_iopte),
> > +                                                cookie);
> > +       } else {
> > +               /* Someone else may have allocated for this pgd */
> > +               if (((*pgd) & (~ARM_SHORT_F_PGD_PA_PAGETABLE_MSK)) != pgdprot) {
> > +                       pr_err("The prot of old pgd is not Right!iova=0x%x pgd=0x%x pgprot=0x%x\n",
> > +                              iova, (*pgd), pgdprot);
> > +                       return -EEXIST;
> > +               }
> > +       }
> > +
> > +       pteprot = (arm_short_iopte)pa;
> > +       pteprot |= __arm_short_pte_port(prot, largepage);
> > +
[snip]
> > +static int arm_short_map(struct io_pgtable_ops *ops, unsigned long iova,
> > +                        phys_addr_t paddr, size_t size, int prot)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> > +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > +       int ret;
> > +
> > +       if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> > +               return -EINVAL;
> > +
> > +       if (size == SZ_4K) {/* most case */
> > +               ret = _arm_short_map_page(data, iova, paddr, prot, false);
> > +       } else if (size == SZ_64K) {
> > +               ret = _arm_short_map_page(data, iova, paddr, prot, true);
> > +       } else if (size == SZ_1M) {
> > +               ret = _arm_short_map_section(data, iova, paddr, prot, false);
> > +       } else if (size == SZ_16M) {
> > +               ret = _arm_short_map_section(data, iova, paddr, prot, true);
> > +       } else {
> > +               ret = -EINVAL;
> > +       }
> 
> I think this might be nicer as a switch statement. You could perhaps 
> move the add_flush beforehand (since it's unconditional here anyway) and 
> get rid of ret altogether.
move the add_flush before map?
if we change the pagetable firstly, then add_flush. is it better?
> 
> Alternatively, given that map_page and map_section are so similar, maybe 
> it's worth sorting out the pgprot and pgd/pte pointer for the 
> page/section distinction here, then just passing those to a single 
> function which maps compound/non-compound leaf entries.
Ok. I will try to merge them in one function like _arm_short_map.
> 
> > +       tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
> > +       return ret;
> > +}
> > +
> > +static struct io_pgtable *
> > +arm_short_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> > +{
> > +       struct arm_short_io_pgtable *data;
> > +
> > +       if (cfg->ias != 32)
> > +               return NULL;
> > +
> > +       if (cfg->oas > ARM_SHORT_MAX_ADDR_BITS)
> > +               return NULL;
> > +
> > +       cfg->pgsize_bitmap &= SZ_4K | SZ_64K | SZ_1M | SZ_16M;
> > +
> > +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +       if (!data)
> > +               return NULL;
> > +
> > +       data->pgd_size = SZ_16K;
> > +
> > +       data->pgd = alloc_pages_exact(data->pgd_size, GFP_KERNEL | __GFP_ZERO);
> 
> I think this needs __GFP_DMA too, to ensure the pgd lies below the 4GB 
> boundary on arm64/LPAE systems with memory above that.
Thanks.
> > @@ -62,6 +63,11 @@ struct io_pgtable_cfg {
> >                          u64     vttbr;
> >                          u64     vtcr;
> >                  } arm_lpae_s2_cfg;
> > +
> > +               struct {
> > +                       u64     ttbr[2];
> > +                       u64     tcr;
> 
> The ARM ARM defines these all as 32-bit registers for the 
> short-descriptor format, so I think u32 would be more appropriate - 
> better to let the compiler truncate things and warn about it, than have 
> the hardware do it silently at runtime ;)
I will change both of them to u32.
> 
> > +               } arm_short_cfg;
> >          };
> >   };
> >
> > --
> > 1.8.1.1.dirty
> >
> 
