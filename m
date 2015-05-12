From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [RFC PATCH] iommu: add ARM short descriptor page table allocator.
Date: Tue, 12 May 2015 11:15:44 +0200
Message-ID: <CABuKBeKupM0zmWu6T3g5omH7PRo9Oxp85bfpQVhC1ur16_dzvg@mail.gmail.com>
References: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, srv_heupstream <srv_heupstream@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

2015-04-28 9:41 GMT+02:00 Yong Wu <yong.wu@mediatek.com>:
> This patch is for ARM Short Descriptor Format.It has 2-levels
> pagetable and the allocator supports 4K/64K/1M/16M.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/Kconfig                |   7 +
>  drivers/iommu/Makefile               |   1 +
>  drivers/iommu/io-pgtable-arm-short.c | 489 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c           |   4 +
>  drivers/iommu/io-pgtable.h           |   6 +
>  5 files changed, 507 insertions(+)
>  create mode 100644 drivers/iommu/io-pgtable-arm-short.c
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index baa0d97..8e50e73 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -38,6 +38,13 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
>
>           If unsure, say N here.
>
> +config IOMMU_IO_PGTABLE_SHORT
> +       bool "ARMv7/v8 Short Descriptor Format"
> +       select IOMMU_IO_PGTABLE
> +       help
> +         Enable support for the ARM Short descriptor pagetable format.
> +         It has 2-levels pagetable and The allocator supports 4K/64K/1M/16M.
> +
>  endmenu
>
>  config IOMMU_IOVA
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 080ffab..815b3c8 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> +obj-$(CONFIG_IOMMU_IO_PGTABLE_SHORT) += io-pgtable-arm-short.o
>  obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU) += of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
> diff --git a/drivers/iommu/io-pgtable-arm-short.c b/drivers/iommu/io-pgtable-arm-short.c
> new file mode 100644
> index 0000000..8d723ec
> --- /dev/null
> +++ b/drivers/iommu/io-pgtable-arm-short.c
> @@ -0,0 +1,489 @@
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
> +#define ARM_SHORT_MAX_ADDR_BITS                        32
> +
> +#define ARM_SHORT_PGDIR_SHIFT                  20
> +#define ARM_SHORT_PAGE_SHIFT                   12
> +#define ARM_SHORT_PTRS_PER_PTE                 256
> +#define ARM_SHORT_BYTES_PER_PTE                        1024
> +
> +/* 1 level pagetable */
> +#define ARM_SHORT_F_PGD_TYPE_PAGE              (0x1)
> +#define ARM_SHORT_F_PGD_TYPE_PAGE_MSK          (0x3)
> +#define ARM_SHORT_F_PGD_TYPE_SECTION           (0x2)
> +#define ARM_SHORT_F_PGD_TYPE_SUPERSECTION      (0x2 | (1 << 18))
> +#define ARM_SHORT_F_PGD_TYPE_SECTION_MSK       (0x3 | (1 << 18))
> +#define ARM_SHORT_F_PGD_TYPE_IS_PAGE(pgd)      (((pgd) & 0x3) == 1)
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
> +#define ARM_SHORT_F_PTE_TYPE_SMALL             BIT(1)
> +#define ARM_SHORT_F_PTE_B_BIT                  BIT(2)
> +#define ARM_SHORT_F_PTE_C_BIT                  BIT(3)
> +#define ARM_SHORT_F_PTE_IMPLE_BIT              BIT(9)
> +#define ARM_SHORT_F_PTE_S_BIT                  BIT(10)
> +#define ARM_SHORT_F_PTE_PA_LARGE_MSK            0xffff0000
> +#define ARM_SHORT_F_PTE_PA_SMALL_MSK            0xfffff000
> +
> +#define ARM_SHORT_PGD_IDX(a)                   ((a) >> ARM_SHORT_PGDIR_SHIFT)
> +#define ARM_SHORT_PTE_IDX(a)                   \
> +       (((a) >> ARM_SHORT_PAGE_SHIFT) & 0xff)
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
> +
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
> +       }
> +
> +       /* Free PTE */
> +       kmem_cache_free(data->ptekmem, pte);
> +       *pgd = 0;
> +
> +       return 0;
> +}
> +
> +static phys_addr_t arm_short_iova_to_phys(struct io_pgtable_ops *ops,
> +                                         unsigned long iova)
> +{
> +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> +       arm_short_iopte *pte, *pgd = data->pgd;
> +       phys_addr_t pa = 0;
> +
> +       pgd += ARM_SHORT_PGD_IDX(iova);
> +
> +       if (ARM_SHORT_F_PGD_TYPE_IS_PAGE(*pgd)) {
> +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> +
> +               if (ARM_SHORT_F_PTE_TYPE_GET(*pte)
> +                   == ARM_SHORT_F_PTE_TYPE_LARGE) {
> +                       pa = (*pte) & ARM_SHORT_F_PTE_PA_LARGE_MSK;
> +                       pa |= iova & (~ARM_SHORT_F_PTE_PA_LARGE_MSK);
> +               } else if (ARM_SHORT_F_PTE_TYPE_GET(*pte)
> +                          == ARM_SHORT_F_PTE_TYPE_SMALL) {

Would make it easier to read:
u8 pte_type;

[...]

pte_type = ARM_SHORT_F_PTE_TYPE_GET(*pte)
if (pte_type == ARM_SHORT_F_PTE_TYPE_LARGE) {
[...]
} else if (pte_type == ARM_SHORT_F_PTE_TYPE_SMALL) {
[...]
