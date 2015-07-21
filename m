From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iommu: add ARM short descriptor page table
	allocator.
Date: Tue, 21 Jul 2015 18:11:01 +0100
Message-ID: <20150721171101.GN31095@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	<1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437037475-9065-4-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel@pen>
List-Id: iommu@lists.linux-foundation.org

Hello,

This is looking better, but I still have some concerns.

On Thu, Jul 16, 2015 at 10:04:32AM +0100, Yong Wu wrote:
> This patch is for ARM Short Descriptor Format.
> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/Kconfig                |   18 +
>  drivers/iommu/Makefile               |    1 +
>  drivers/iommu/io-pgtable-arm-short.c |  742 ++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c       |    3 -
>  drivers/iommu/io-pgtable.c           |    4 +
>  drivers/iommu/io-pgtable.h           |   13 +
>  6 files changed, 778 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-short.c

[...]

> +#define ARM_SHORT_PGDIR_SHIFT                  20
> +#define ARM_SHORT_PAGE_SHIFT                   12
> +#define ARM_SHORT_PTRS_PER_PTE                 \
> +       (1 << (ARM_SHORT_PGDIR_SHIFT - ARM_SHORT_PAGE_SHIFT))
> +#define ARM_SHORT_BYTES_PER_PTE                        \
> +       (ARM_SHORT_PTRS_PER_PTE * sizeof(arm_short_iopte))
> +
> +/* level 1 pagetable */
> +#define ARM_SHORT_PGD_TYPE_PGTABLE             BIT(0)
> +#define ARM_SHORT_PGD_SECTION_XN               (BIT(0) | BIT(4))
> +#define ARM_SHORT_PGD_TYPE_SECTION             BIT(1)
> +#define ARM_SHORT_PGD_PGTABLE_XN               BIT(2)

This should be PXN, but I'm not even sure why we care for a table at
level 1.

> +#define ARM_SHORT_PGD_B                                BIT(2)
> +#define ARM_SHORT_PGD_C                                BIT(3)
> +#define ARM_SHORT_PGD_PGTABLE_NS               BIT(3)
> +#define ARM_SHORT_PGD_IMPLE                    BIT(9)
> +#define ARM_SHORT_PGD_TEX0                     BIT(12)
> +#define ARM_SHORT_PGD_S                                BIT(16)
> +#define ARM_SHORT_PGD_nG                       BIT(17)
> +#define ARM_SHORT_PGD_SUPERSECTION             BIT(18)
> +#define ARM_SHORT_PGD_SECTION_NS               BIT(19)
> +
> +#define ARM_SHORT_PGD_TYPE_SUPERSECTION                \
> +       (ARM_SHORT_PGD_TYPE_SECTION | ARM_SHORT_PGD_SUPERSECTION)
> +#define ARM_SHORT_PGD_SECTION_TYPE_MSK         \
> +       (ARM_SHORT_PGD_TYPE_SECTION | ARM_SHORT_PGD_SUPERSECTION)
> +#define ARM_SHORT_PGD_PGTABLE_TYPE_MSK         \
> +       (ARM_SHORT_PGD_TYPE_SECTION | ARM_SHORT_PGD_TYPE_PGTABLE)
> +#define ARM_SHORT_PGD_TYPE_IS_PGTABLE(pgd)     \
> +       (((pgd) & ARM_SHORT_PGD_PGTABLE_TYPE_MSK) == ARM_SHORT_PGD_TYPE_PGTABLE)
> +#define ARM_SHORT_PGD_TYPE_IS_SECTION(pgd)     \
> +       (((pgd) & ARM_SHORT_PGD_SECTION_TYPE_MSK) == ARM_SHORT_PGD_TYPE_SECTION)
> +#define ARM_SHORT_PGD_TYPE_IS_SUPERSECTION(pgd)        \
> +       (((pgd) & ARM_SHORT_PGD_SECTION_TYPE_MSK) == \
> +       ARM_SHORT_PGD_TYPE_SUPERSECTION)
> +#define ARM_SHORT_PGD_PGTABLE_MSK              0xfffffc00
> +#define ARM_SHORT_PGD_SECTION_MSK              (~(SZ_1M - 1))
> +#define ARM_SHORT_PGD_SUPERSECTION_MSK         (~(SZ_16M - 1))
> +
> +/* level 2 pagetable */
> +#define ARM_SHORT_PTE_TYPE_LARGE               BIT(0)
> +#define ARM_SHORT_PTE_SMALL_XN                 BIT(0)
> +#define ARM_SHORT_PTE_TYPE_SMALL               BIT(1)
> +#define ARM_SHORT_PTE_B                                BIT(2)
> +#define ARM_SHORT_PTE_C                                BIT(3)
> +#define ARM_SHORT_PTE_SMALL_TEX0               BIT(6)
> +#define ARM_SHORT_PTE_IMPLE                    BIT(9)

This is AP[2] for small pages.

> +#define ARM_SHORT_PTE_S                                BIT(10)
> +#define ARM_SHORT_PTE_nG                       BIT(11)
> +#define ARM_SHORT_PTE_LARGE_TEX0               BIT(12)
> +#define ARM_SHORT_PTE_LARGE_XN                 BIT(15)
> +#define ARM_SHORT_PTE_LARGE_MSK                        (~(SZ_64K - 1))
> +#define ARM_SHORT_PTE_SMALL_MSK                        (~(SZ_4K - 1))
> +#define ARM_SHORT_PTE_TYPE_MSK                 \
> +       (ARM_SHORT_PTE_TYPE_LARGE | ARM_SHORT_PTE_TYPE_SMALL)
> +#define ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(pte)   \
> +       (((((pte) & ARM_SHORT_PTE_TYPE_MSK) >> 1) << 1)\
> +       == ARM_SHORT_PTE_TYPE_SMALL)

I see what you're trying to do here, but the shifting is confusing. I
think it's better doing something like:

	((pte) & ARM_SHORT_PTE_TYPE_SMALL) == ARM_SHORT_PTE_TYPE_SMALL

or even just:

	(pte) & ARM_SHORT_PTE_TYPE_SMALL

> +#define ARM_SHORT_PTE_TYPE_IS_LARGEPAGE(pte)   \
> +       (((pte) & ARM_SHORT_PTE_TYPE_MSK) == ARM_SHORT_PTE_TYPE_LARGE)
> +
> +#define ARM_SHORT_PGD_IDX(a)                   ((a) >> ARM_SHORT_PGDIR_SHIFT)
> +#define ARM_SHORT_PTE_IDX(a)                   \
> +       (((a) >> ARM_SHORT_PAGE_SHIFT) & (ARM_SHORT_PTRS_PER_PTE - 1))
> +
> +#define ARM_SHORT_GET_PTE_VA(pgd)              \
> +       (phys_to_virt((unsigned long)pgd & ARM_SHORT_PGD_PGTABLE_MSK))

Maybe better named as ARM_SHORT_GET_PGTABLE_VA ?

> +
> +#define ARM_SHORT_PTE_LARGE_GET_PROT(pte)      \
> +       (((pte) & (~ARM_SHORT_PTE_LARGE_MSK)) & ~ARM_SHORT_PTE_TYPE_MSK)
> +
> +#define ARM_SHORT_PGD_GET_PROT(pgd)            \
> +       (((pgd) & (~ARM_SHORT_PGD_SECTION_MSK)) & ~ARM_SHORT_PGD_SUPERSECTION)
> +
> +static bool selftest_running;
> +
> +static arm_short_iopte *
> +arm_short_get_pte_in_pgd(arm_short_iopte pgd, unsigned int iova)
> +{
> +       arm_short_iopte *pte;
> +
> +       pte = ARM_SHORT_GET_PTE_VA(pgd);
> +       pte += ARM_SHORT_PTE_IDX(iova);
> +       return pte;
> +}
> +
> +static void _arm_short_free_pgtable(struct arm_short_io_pgtable *data,
> +                                   arm_short_iopte *pgd)
> +{
> +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> +       arm_short_iopte *pte;
> +       int i;
> +
> +       pte = ARM_SHORT_GET_PTE_VA(*pgd);
> +       for (i = 0; i < ARM_SHORT_PTRS_PER_PTE; i++) {
> +               if (pte[i] != 0)
> +                       return;
> +       }

Do you actually need this loop if you're not warning or returning an error?

> +
> +       /* Free whole pte and set pgd to zero while all pte is unmap */
> +       kmem_cache_free(data->ptekmem, pte);
> +       *pgd = 0;

I still don't think this is safe. What stops the page table walker from
speculatively walking freed memory?

> +       tlb->flush_pgtable(pgd, sizeof(*pgd), data->iop.cookie);
> +}
> +
> +static arm_short_iopte
> +__arm_short_pte_prot(struct arm_short_io_pgtable *data, int prot, bool large)
> +{
> +       arm_short_iopte pteprot;
> +
> +       pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
> +       pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
> +                               ARM_SHORT_PTE_TYPE_SMALL;
> +       if (prot & IOMMU_CACHE)
> +               pteprot |=  ARM_SHORT_PTE_B | ARM_SHORT_PTE_C;
> +       if (prot & IOMMU_WRITE)
> +               pteprot |= large ? ARM_SHORT_PTE_LARGE_TEX0 :
> +                               ARM_SHORT_PTE_SMALL_TEX0;

This doesn't make any sense. TEX[2:0] is all about memory attributes, not
permissions, so you're making the mapping write-back, write-allocate but
that's not what the IOMMU_* values are about.

> +       if (prot & IOMMU_NOEXEC)
> +               pteprot |= large ? ARM_SHORT_PTE_LARGE_XN :
> +                       ARM_SHORT_PTE_SMALL_XN;
> +       return pteprot;
> +}
> +
> +static arm_short_iopte
> +__arm_short_pgd_prot(struct arm_short_io_pgtable *data, int prot, bool super)
> +{
> +       arm_short_iopte pgdprot;
> +
> +       pgdprot = ARM_SHORT_PGD_S | ARM_SHORT_PGD_nG;
> +       pgdprot |= super ? ARM_SHORT_PGD_TYPE_SUPERSECTION :
> +                               ARM_SHORT_PGD_TYPE_SECTION;
> +       if (prot & IOMMU_CACHE)
> +               pgdprot |= ARM_SHORT_PGD_C | ARM_SHORT_PGD_B;
> +       if (prot & IOMMU_WRITE)
> +               pgdprot |= ARM_SHORT_PGD_TEX0;

Likewise.

> +       if (prot & IOMMU_NOEXEC)
> +               pgdprot |= ARM_SHORT_PGD_SECTION_XN;
> +       if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> +               pgdprot |= ARM_SHORT_PGD_SECTION_NS;
> +       return pgdprot;
> +}
> +
> +static arm_short_iopte
> +__arm_short_pte_prot_split(struct arm_short_io_pgtable *data,
> +                          arm_short_iopte pgdprot,
> +                          arm_short_iopte pteprot_large,
> +                          bool large)
> +{
> +       arm_short_iopte pteprot = 0;
> +
> +       pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
> +       pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
> +                               ARM_SHORT_PTE_TYPE_SMALL;
> +       /* section to pte prot */
> +       if (pgdprot & ARM_SHORT_PGD_C)
> +               pteprot |= ARM_SHORT_PTE_C;
> +       if (pgdprot & ARM_SHORT_PGD_B)
> +               pteprot |= ARM_SHORT_PTE_B;
> +       if (pgdprot & ARM_SHORT_PGD_TEX0)
> +               pteprot |= large ? ARM_SHORT_PTE_LARGE_TEX0 :
> +                               ARM_SHORT_PTE_SMALL_TEX0;
> +       if (pgdprot & ARM_SHORT_PGD_nG)
> +               pteprot |= ARM_SHORT_PTE_nG;
> +       if (pgdprot & ARM_SHORT_PGD_SECTION_XN)
> +               pteprot |= large ? ARM_SHORT_PTE_LARGE_XN :
> +                               ARM_SHORT_PTE_SMALL_XN;
> +
> +       /* large page to small page pte prot. Only large page may split */
> +       if (pteprot_large && !large) {
> +               if (pteprot_large & ARM_SHORT_PTE_LARGE_TEX0)
> +                       pteprot |= ARM_SHORT_PTE_SMALL_TEX0;
> +               if (pteprot_large & ARM_SHORT_PTE_LARGE_XN)
> +                       pteprot |= ARM_SHORT_PTE_SMALL_XN;
> +       }
> +       return pteprot;
> +}
> +
> +static arm_short_iopte
> +__arm_short_pgtable_prot(struct arm_short_io_pgtable *data, bool noexec)
> +{
> +       arm_short_iopte pgdprot = 0;
> +
> +       pgdprot = ARM_SHORT_PGD_TYPE_PGTABLE;
> +       if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
> +               pgdprot |= ARM_SHORT_PGD_PGTABLE_NS;
> +       if (noexec)
> +               pgdprot |= ARM_SHORT_PGD_PGTABLE_XN;

I don't think you need to worry about XN bits for PGTABLEs.

> +       return pgdprot;
> +}
> +
> +static int
> +_arm_short_map(struct arm_short_io_pgtable *data,
> +              unsigned int iova, phys_addr_t paddr,
> +              arm_short_iopte pgdprot, arm_short_iopte pteprot,
> +              bool large)
> +{
> +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> +       arm_short_iopte *pgd = data->pgd, *pte;
> +       void *cookie = data->iop.cookie, *pte_va;
> +       unsigned int ptenr = large ? 16 : 1;
> +       int i, quirk = data->iop.cfg.quirks;
> +       bool ptenew = false;
> +
> +       pgd += ARM_SHORT_PGD_IDX(iova);
> +
> +       if (!pteprot) { /* section or supersection */
> +               if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK)
> +                       pgdprot &= ~ARM_SHORT_PGD_SECTION_XN;
> +               pte = pgd;
> +               pteprot = pgdprot;
> +       } else {        /* page or largepage */
> +               if (quirk & IO_PGTABLE_QUIRK_SHORT_MTK) {
> +                       if (large) { /* special Bit */

This definitely needs a better comment! What exactly are you doing here
and what is that quirk all about?

> +                               if (pteprot & ARM_SHORT_PTE_LARGE_TEX0) {
> +                                       pteprot &= ~ARM_SHORT_PTE_LARGE_TEX0;
> +                                       pteprot |= ARM_SHORT_PTE_SMALL_TEX0;
> +                               }
> +                               pteprot &= ~ARM_SHORT_PTE_LARGE_XN;
> +                       } else {
> +                               pteprot &= ~ARM_SHORT_PTE_SMALL_XN;
> +                       }
> +               }
> +
> +               if (!(*pgd)) {
> +                       pte_va = kmem_cache_zalloc(data->ptekmem, GFP_ATOMIC);
> +                       if (unlikely(!pte_va))
> +                               return -ENOMEM;
> +                       ptenew = true;
> +                       *pgd = virt_to_phys(pte_va) | pgdprot;
> +                       kmemleak_ignore(pte_va);
> +                       tlb->flush_pgtable(pgd, sizeof(*pgd), cookie);

I think you need to flush this before it becomes visible to the walker.

> +               }
> +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> +       }
> +
> +       pteprot |= (arm_short_iopte)paddr;
> +       for (i = 0; i < ptenr; i++) {
> +               if (pte[i]) {/* Someone else may have allocated for this pte */
> +                       WARN_ON(!selftest_running);
> +                       goto err_exist_pte;
> +               }
> +               pte[i] = pteprot;
> +       }
> +       tlb->flush_pgtable(pte, ptenr * sizeof(*pte), cookie);
> +
> +       return 0;
> +
> +err_exist_pte:
> +       while (i--)
> +               pte[i] = 0;
> +       if (ptenew)
> +               kmem_cache_free(data->ptekmem, pte_va);
> +       return -EEXIST;
> +}
> +
> +static int arm_short_map(struct io_pgtable_ops *ops, unsigned long iova,
> +                        phys_addr_t paddr, size_t size, int prot)
> +{
> +       struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> +       int ret;
> +       arm_short_iopte pgdprot = 0, pteprot = 0;
> +       bool large;
> +
> +       /* If no access, then nothing to do */
> +       if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> +               return 0;
> +
> +       switch (size) {
> +       case SZ_4K:
> +       case SZ_64K:
> +               large = (size == SZ_64K) ? true : false;
> +               pteprot = __arm_short_pte_prot(data, prot, large);
> +               pgdprot = __arm_short_pgtable_prot(data, prot & IOMMU_NOEXEC);
> +               break;
> +
> +       case SZ_1M:
> +       case SZ_16M:
> +               large = (size == SZ_16M) ? true : false;
> +               pgdprot = __arm_short_pgd_prot(data, prot, large);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (WARN_ON((iova | paddr) & (size - 1)))
> +               return -EINVAL;
> +
> +       ret = _arm_short_map(data, iova, paddr, pgdprot, pteprot, large);
> +
> +       tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
> +       tlb->tlb_sync(data->iop.cookie);

In _arm_short_map, it looks like you can only go from invalid -> valid,
so why do you need to flush the TLB here?

> +       return ret;
> +}
> +
> +static phys_addr_t arm_short_iova_to_phys(struct io_pgtable_ops *ops,
> +                                         unsigned long iova)
> +{
> +       struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +       arm_short_iopte *pte, *pgd = data->pgd;
> +       phys_addr_t pa = 0;
> +
> +       pgd += ARM_SHORT_PGD_IDX(iova);
> +
> +       if (ARM_SHORT_PGD_TYPE_IS_PGTABLE(*pgd)) {
> +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> +
> +               if (ARM_SHORT_PTE_TYPE_IS_LARGEPAGE(*pte)) {
> +                       pa = (*pte) & ARM_SHORT_PTE_LARGE_MSK;
> +                       pa |= iova & ~ARM_SHORT_PTE_LARGE_MSK;
> +               } else if (ARM_SHORT_PTE_TYPE_IS_SMALLPAGE(*pte)) {
> +                       pa = (*pte) & ARM_SHORT_PTE_SMALL_MSK;
> +                       pa |= iova & ~ARM_SHORT_PTE_SMALL_MSK;
> +               }
> +       } else if (ARM_SHORT_PGD_TYPE_IS_SECTION(*pgd)) {
> +               pa = (*pgd) & ARM_SHORT_PGD_SECTION_MSK;
> +               pa |= iova & ~ARM_SHORT_PGD_SECTION_MSK;
> +       } else if (ARM_SHORT_PGD_TYPE_IS_SUPERSECTION(*pgd)) {
> +               pa = (*pgd) & ARM_SHORT_PGD_SUPERSECTION_MSK;
> +               pa |= iova & ~ARM_SHORT_PGD_SUPERSECTION_MSK;
> +       }
> +
> +       return pa;
> +}
> +
> +static int
> +arm_short_split_blk_unmap(struct io_pgtable_ops *ops, unsigned int iova,
> +                         phys_addr_t paddr, size_t size,
> +                         arm_short_iopte pgdprotup, arm_short_iopte pteprotup,
> +                         size_t blk_size)
> +{
> +       struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> +       struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +       unsigned long *pgbitmap = &cfg->pgsize_bitmap;
> +       unsigned int blk_base, blk_start, blk_end;
> +       arm_short_iopte pgdprot, pteprot;
> +       size_t mapsize = 0, nextmapsize;
> +       phys_addr_t blk_paddr;
> +       int ret;
> +       unsigned int i;
> +
> +       /* find the nearest mapsize */
> +       for (i = find_first_bit(pgbitmap, BITS_PER_LONG);
> +            i < BITS_PER_LONG && ((1 << i) < blk_size) &&
> +            IS_ALIGNED(size, 1 << i);
> +            i = find_next_bit(pgbitmap, BITS_PER_LONG, i + 1))
> +               mapsize = 1 << i;
> +
> +       if (WARN_ON(!mapsize))
> +               return 0; /* Bytes unmapped */
> +       nextmapsize = 1 << i;
> +
> +       blk_base = iova & ~(blk_size - 1);
> +       blk_start = blk_base;
> +       blk_end = blk_start + blk_size;
> +       blk_paddr = paddr;
> +
> +       for (; blk_start < blk_end;
> +            blk_start += mapsize, blk_paddr += mapsize) {
> +               /* Unmap! */
> +               if (blk_start == iova)
> +                       continue;
> +
> +               /* Try to upper map */
> +               if (blk_base != blk_start &&
> +                   IS_ALIGNED(blk_start | blk_paddr, nextmapsize) &&
> +                   mapsize != nextmapsize) {
> +                       mapsize = nextmapsize;
> +                       i = find_next_bit(pgbitmap, BITS_PER_LONG, i + 1);
> +                       if (i < BITS_PER_LONG)
> +                               nextmapsize = 1 << i;
> +               }
> +
> +               if (mapsize == SZ_1M) {
> +                       pgdprot = pgdprotup;
> +                       pgdprot |= __arm_short_pgd_prot(data, 0, false);
> +                       pteprot = 0;
> +               } else { /* small or large page */
> +                       bool noexec = (blk_size == SZ_64K) ?
> +                               (pteprotup & ARM_SHORT_PTE_LARGE_XN) :
> +                               (pgdprotup & ARM_SHORT_PGD_SECTION_XN);
> +
> +                       pteprot = __arm_short_pte_prot_split(
> +                                               data, pgdprotup, pteprotup,
> +                                               mapsize == SZ_64K);
> +                       pgdprot = __arm_short_pgtable_prot(data, noexec);
> +               }
> +
> +               ret = _arm_short_map(data, blk_start, blk_paddr, pgdprot,
> +                                    pteprot, mapsize == SZ_64K);
> +               if (ret < 0) {
> +                       /* Free the table we allocated */
> +                       arm_short_iopte *pgd = data->pgd, *pte;
> +
> +                       pgd += ARM_SHORT_PGD_IDX(blk_base);
> +                       if (*pgd) {
> +                               pte = ARM_SHORT_GET_PTE_VA(*pgd);
> +                               kmem_cache_free(data->ptekmem, pte);
> +                               *pgd = 0;
> +                               tlb->flush_pgtable(pgd, sizeof(*pgd),
> +                                                  data->iop.cookie);

Again, the ordering looks totally wrong here. You need to:

  (1) Zero the pgd pointer
  (2) Flush the pointer, so the walker can no longer follow the page table
  (3) Invalidate the TLB, so we don't have any cached intermediate walks
  (4) Sync the TLB
  (5) Free the memory

That said, I don't fully follow the logic here.

> +                       }
> +                       return 0;/* Bytes unmapped */
> +               }
> +               tlb->tlb_add_flush(blk_start, mapsize, true, data->iop.cookie);
> +               tlb->tlb_sync(data->iop.cookie);

Why are you doing this here for every iteration?

Will
