From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v10 3/3] iommu/exynos: Add iommu driver for Exynos Platforms
Date: Tue, 6 Mar 2012 22:13:01 +0900
Message-ID: <CAH9JG2W=E7xmEO3o+up5a5Vm1PrPp60w0cfzN7=bYQO2BX1teA@mail.gmail.com>
References: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <002201ccfb73$93311520$b9933f60$%cho@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: pullip.cho@samsung.com
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Sanghyun Lee <sanghyun75.lee@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Younglak Kim <younglak1004.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Subash Patel <subash.ramaswamy@linaro.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

some not critical comments.

Thank you,
Kyungmin Park

On Tue, Mar 6, 2012 at 5:31 PM, KyongHo Cho <pullip.cho@samsung.com> wr=
ote:
> HAALgBjAGgAbwBAAHMAYQBtAHMAdQBuAGcALgBjAG8AbQA=3D;Tue,
> =A006 Mar 2012 08:31:29 GMT;WwBQAEEAVABDAEgAIAB2ADEAMAAgADMALwAzAF0AI=
ABpAG8AbQBtAHUALwBlAHgAeQBuAG8AcwA6ACAAQQBkAGQAIABpAG8AbQBtAHUAIABkAHIA=
aQB2AGUAcgAgAGYAbwByACAARQB4AHkAbgBvAHMAIABQAGwAYQB0AGYAbwByAG0AcwA=3D
> x-cr-puzzleid: {CF0AAF04-8639-4D69-B4E1-BF71EA1B0A70}
What's this?
>
> This is the System MMU driver and IOMMU API implementation for
> Exynos SOC platforms. Exynos platforms has more than 10 System
> MMUs dedicated for each multimedia accellerators.
>
> The System MMU driver is already in arc/arm/plat-s5p but it is
> moved to drivers/iommu due to Ohad Ben-Cohen gathered IOMMU drivers
> there
>
> Any device driver in Exynos platforms that needs to control its
> System MMU must call platform_set_sysmmu() to inform System MMU
> driver who will control it.
> platform_set_sysmmu() is defined in <mach/sysmmu.h>
Does it really required? if we can remove it. it can be compiled
without arch dependency.
>
> Cc: Joerg Roedel <joerg.roedel@amd.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
> ---
> =A0drivers/iommu/Kconfig =A0 =A0 =A0 =A0| =A0 21 +
> =A0drivers/iommu/Makefile =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/iommu/exynos-iommu.c | 1088 ++++++++++++++++++++++++++++++=
++++++++++++
> =A03 files changed, 1110 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/iommu/exynos-iommu.c
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6bea696..25d3eed 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -142,4 +142,25 @@ config OMAP_IOMMU_DEBUG
>
> =A0 =A0 =A0 =A0 =A0Say N unless you know you need this.
>
> +config EXYNOS_IOMMU
> + =A0 =A0 =A0 bool "Exynos IOMMU Support"
> + =A0 =A0 =A0 depends on EXYNOS_DEV_SYSMMU
> + =A0 =A0 =A0 select IOMMU_API
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Support for the IOMMU(System MMU) of Samsung Exynos=
 application
> + =A0 =A0 =A0 =A0 processor family. This enables H/W multimedia accel=
lerators to see
> + =A0 =A0 =A0 =A0 non-linear physical memory chunks as a linear memor=
y in their
> + =A0 =A0 =A0 =A0 address spaces
> +
> + =A0 =A0 =A0 =A0 If unsure, say N here.
> +
> +config EXYNOS_IOMMU_DEBUG
> + =A0 =A0 =A0 bool "Debugging log for Exynos IOMMU"
> + =A0 =A0 =A0 depends on EXYNOS_IOMMU
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Select this to see the detailed log message that sh=
ows what
> + =A0 =A0 =A0 =A0 happens in the IOMMU driver
> +
> + =A0 =A0 =A0 =A0 Say N unless you need kernel log message for IOMMU =
debugging
> +
> =A0endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 0e36b49..5a8fd97 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_IRQ_REMAP) +=3D intr_remapping.o
> =A0obj-$(CONFIG_OMAP_IOMMU) +=3D omap-iommu.o
> =A0obj-$(CONFIG_OMAP_IOVMM) +=3D omap-iovmm.o
> =A0obj-$(CONFIG_OMAP_IOMMU_DEBUG) +=3D omap-iommu-debug.o
> +obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iomm=
u.c
> new file mode 100644
> index 0000000..4c1c48a
> --- /dev/null
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -0,0 +1,1088 @@
> +/* linux/drivers/iommu/exynos_iommu.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + * =A0 =A0 =A0 =A0 =A0 =A0 http://www.samsung.com
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifdef CONFIG_EXYNOS_IOMMU_DEBUG
> +#define DEBUG
> +#endif
If it's used only at here. you can add it at Makefile.

ifeq ($(CONFIG_EXYNOS_IOMMU_DEBUG),y)
         CFLAGS-exynos-iommu        +=3D -DDEBUG
endif

Of course you can select as your preference.
> +
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/mm.h>
> +#include <linux/iommu.h>
> +#include <linux/errno.h>
> +#include <linux/list.h>
> +#include <linux/memblock.h>
> +#include <linux/export.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/pgtable.h>
> +
> +#include <mach/sysmmu.h>
> +
> +#define S5P_MMU_CTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000
> +#define S5P_MMU_CFG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x004
> +#define S5P_MMU_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x008
> +#define S5P_MMU_FLUSH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00C
> +#define S5P_PT_BASE_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x014
> +#define S5P_INT_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x018
> +#define S5P_INT_CLEAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01C
> +#define S5P_PAGE_FAULT_ADDR =A0 =A0 =A0 =A0 =A0 =A00x024
> +#define S5P_AW_FAULT_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x028
> +#define S5P_AR_FAULT_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A00x02C
> +#define S5P_DEFAULT_SLAVE_ADDR =A0 =A0 =A0 =A0 0x030
> +#define S5P_MMU_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x034
> +#define S5P_PB0_SADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04C
> +#define S5P_PB0_EADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x050
> +#define S5P_PB1_SADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x054
> +#define S5P_PB1_EADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x058
> +
> +#define SECT_ORDER 20
> +#define LPAGE_ORDER 16
> +#define SPAGE_ORDER 12
> +
> +#define SECT_SIZE (1 << SECT_ORDER)
> +#define LPAGE_SIZE (1 << LPAGE_ORDER)
> +#define SPAGE_SIZE (1 << SPAGE_ORDER)
> +
> +#define SECT_MASK (~(SECT_SIZE - 1))
> +#define LPAGE_MASK (~(LPAGE_SIZE - 1))
> +#define SPAGE_MASK (~(SPAGE_SIZE - 1))
> +
> +#define lv1ent_fault(sent) (((*(sent) & 3) =3D=3D 0) || ((*(sent) & =
3) =3D=3D 3))
> +#define lv1ent_page(sent) ((*(sent) & 3) =3D=3D 1)
> +#define lv1ent_section(sent) ((*(sent) & 3) =3D=3D 2)
> +
> +#define lv2ent_fault(pent) ((*(pent) & 3) =3D=3D 0)
> +#define lv2ent_small(pent) ((*(pent) & 2) =3D=3D 2)
#define lv2ent_small(pent) ((*(pent) & 3) =3D=3D 2)?
> +#define lv2ent_large(pent) ((*(pent) & 3) =3D=3D 1)
> +
> +#define section_phys(sent) (*(sent) & SECT_MASK)
> +#define section_offs(iova) ((iova) & 0xFFFFF)
> +#define lpage_phys(pent) (*(pent) & LPAGE_MASK)
> +#define lpage_offs(iova) ((iova) & 0xFFFF)
> +#define spage_phys(pent) (*(pent) & SPAGE_MASK)
> +#define spage_offs(iova) ((iova) & 0xFFF)
> +
> +#define lv1ent_offset(iova) ((iova) >> SECT_ORDER)
> +#define lv2ent_offset(iova) (((iova) & 0xFF000) >> SPAGE_ORDER)
> +
> +#define NUM_LV1ENTRIES 4096
> +#define NUM_LV2ENTRIES 256
> +
> +#define LV2TABLE_SIZE (NUM_LV2ENTRIES * sizeof(long))
> +
> +#define SPAGES_PER_LPAGE (LPAGE_SIZE / SPAGE_SIZE)
> +
> +#define lv2table_base(sent) (*(sent) & 0xFFFFFC00)
> +
> +#define mk_lv1ent_sect(pa) ((pa) | 2)
> +#define mk_lv1ent_page(pa) ((pa) | 1)
> +#define mk_lv2ent_lpage(pa) ((pa) | 1)
> +#define mk_lv2ent_spage(pa) ((pa) | 2)
> +
> +#define CTRL_ENABLE =A0 =A00x5
> +#define CTRL_BLOCK =A0 =A0 0x7
> +#define CTRL_DISABLE =A0 0x0
> +
> +#define REG_MMU_CTRL =A0 =A0 =A0 =A0 =A0 0x000
> +#define REG_MMU_CFG =A0 =A0 =A0 =A0 =A0 =A00x004
> +#define REG_MMU_STATUS =A0 =A0 =A0 =A0 0x008
> +#define REG_MMU_FLUSH =A0 =A0 =A0 =A0 =A00x00C
> +#define REG_MMU_FLUSH_ENTRY =A0 =A00x010
> +#define REG_PT_BASE_ADDR =A0 =A0 =A0 0x014
> +#define REG_INT_STATUS =A0 =A0 =A0 =A0 0x018
> +#define REG_INT_CLEAR =A0 =A0 =A0 =A0 =A00x01C
> +#define REG_MMU_VERSION =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x034
Please place it in order.
> +
> +#define REG_PAGE_FAULT_ADDR =A0 =A00x024
> +#define REG_AW_FAULT_ADDR =A0 =A0 =A00x028
> +#define REG_AR_FAULT_ADDR =A0 =A0 =A00x02C
> +#define REG_DEFAULT_SLAVE_ADDR 0x030
> +
> +static unsigned long *section_entry(unsigned long *pgtable, unsigned=
 long iova)
> +{
> + =A0 =A0 =A0 return pgtable + lv1ent_offset(iova);
> +}
> +
> +static unsigned long *page_entry(unsigned long *sent, unsigned long =
iova)
> +{
> + =A0 =A0 =A0 return (unsigned long *)__va(lv2table_base(sent)) + lv2=
ent_offset(iova);
> +}
> +
> +enum EXYNOS_SYSMMU_INTERRUPT_TYPE {
> + =A0 =A0 =A0 SYSMMU_PAGEFAULT,
> + =A0 =A0 =A0 SYSMMU_AR_MULTIHIT,
> + =A0 =A0 =A0 SYSMMU_AW_MULTIHIT,
> + =A0 =A0 =A0 SYSMMU_BUSERROR,
> + =A0 =A0 =A0 SYSMMU_AR_SECURITY,
> + =A0 =A0 =A0 SYSMMU_AR_ACCESS,
> + =A0 =A0 =A0 SYSMMU_AW_SECURITY,
> + =A0 =A0 =A0 SYSMMU_AW_PROTECTION, /* 7 */
> + =A0 =A0 =A0 SYSMMU_FAULT_UNKNOWN,
> + =A0 =A0 =A0 SYSMMU_FAULTS_NUM
missing comma, "SYSMMU_FAULTS_NUM,"
> +};
> +
> +typedef int (*sysmmu_fault_handler_t)(enum EXYNOS_SYSMMU_INTERRUPT_T=
YPE itype,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long pgtable_b=
ase, unsigned long fault_addr);
> +
> +static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] =3D {
> + =A0 =A0 =A0 REG_PAGE_FAULT_ADDR,
> + =A0 =A0 =A0 REG_AR_FAULT_ADDR,
> + =A0 =A0 =A0 REG_AW_FAULT_ADDR,
> + =A0 =A0 =A0 REG_DEFAULT_SLAVE_ADDR,
> + =A0 =A0 =A0 REG_AR_FAULT_ADDR,
> + =A0 =A0 =A0 REG_AR_FAULT_ADDR,
> + =A0 =A0 =A0 REG_AW_FAULT_ADDR,
> + =A0 =A0 =A0 REG_AW_FAULT_ADDR
ditto.
> +};
> +
> +static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] =3D {
> + =A0 =A0 =A0 "PAGE FAULT",
> + =A0 =A0 =A0 "AR MULTI-HIT FAULT",
> + =A0 =A0 =A0 "AW MULTI-HIT FAULT",
> + =A0 =A0 =A0 "BUS ERROR",
> + =A0 =A0 =A0 "AR SECURITY PROTECTION FAULT",
> + =A0 =A0 =A0 "AR ACCESS PROTECTION FAULT",
> + =A0 =A0 =A0 "AW SECURITY PROTECTION FAULT",
> + =A0 =A0 =A0 "AW ACCESS PROTECTION FAULT",
> + =A0 =A0 =A0 "UNKNOWN FAULT"
ditto.
> +};
> +
> +/* We does not consider super section mapping (16MB) */
> +struct iommu_client {
> + =A0 =A0 =A0 struct list_head node;
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 int refcnt;
> +};
> +
> +struct exynos_iommu_domain {
> + =A0 =A0 =A0 struct list_head clients; /* list of iommu_client */
> + =A0 =A0 =A0 unsigned long *pgtable; /* lv1 page table, 16KB */
> + =A0 =A0 =A0 short *lv2entcnt; /* free lv2 entry counter for each se=
ction */
> + =A0 =A0 =A0 spinlock_t lock; /* lock for this structure and attache=
d iommu_client */
> + =A0 =A0 =A0 spinlock_t pgtablelock; /* lock for modifying page tabl=
e @ pgtable */
> +};
> +
> +struct sysmmu_drvdata {
> + =A0 =A0 =A0 struct device *sysmmu;
> + =A0 =A0 =A0 char *dbgname;
> + =A0 =A0 =A0 int nsfrs;
> + =A0 =A0 =A0 void __iomem **sfrbases;
> + =A0 =A0 =A0 struct clk *clk[2];
> + =A0 =A0 =A0 bool active;
> + =A0 =A0 =A0 rwlock_t lock;
> + =A0 =A0 =A0 struct iommu_domain *domain;
> + =A0 =A0 =A0 sysmmu_fault_handler_t fault_handler;
> + =A0 =A0 =A0 unsigned long pgtable;
> + =A0 =A0 =A0 struct iommu_client client;
> +};
> +
> +static bool set_sysmmu_active(struct sysmmu_drvdata *data)
> +{
> + =A0 =A0 =A0 /* return true if the System MMU was not active previou=
sly
> + =A0 =A0 =A0 =A0 =A0and it needs to be initialized */
> + =A0 =A0 =A0 if (WARN_ON_ONCE(data->active))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> + =A0 =A0 =A0 data->active =3D true;
> + =A0 =A0 =A0 return true;
> +}
> +
> +static bool set_sysmmu_inactive(struct sysmmu_drvdata *data)
> +{
> + =A0 =A0 =A0 /* return true if the System MMU is needed to be disabl=
ed */
> + =A0 =A0 =A0 if (WARN_ON_ONCE(!data->active))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> + =A0 =A0 =A0 data->active =3D false;
> + =A0 =A0 =A0 return true;
> +}
> +
> +static bool is_sysmmu_active(struct sysmmu_drvdata *data)
> +{
> + =A0 =A0 =A0 return data->active;
> +}
> +
> +static void sysmmu_block(void __iomem *sfrbase)
> +{
> + =A0 =A0 =A0 __raw_writel(CTRL_BLOCK, sfrbase + REG_MMU_CTRL);
> +}
> +
> +static void sysmmu_unblock(void __iomem *sfrbase)
> +{
> + =A0 =A0 =A0 __raw_writel(CTRL_ENABLE, sfrbase + REG_MMU_CTRL);
> +}
> +
> +static void __sysmmu_tlb_invalidate(void __iomem *sfrbase)
> +{
> + =A0 =A0 =A0 __raw_writel(0x1, sfrbase + REG_MMU_FLUSH);
> +}
> +
> +static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long iova)
> +{
> + =A0 =A0 =A0 __raw_writel((iova & SPAGE_MASK) | 1, sfrbase + REG_MMU=
_FLUSH_ENTRY);
> +}
> +
> +static void __sysmmu_set_ptbase(void __iomem *sfrbase,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned long pgd)
> +{
> + =A0 =A0 =A0 __raw_writel(0x1, sfrbase + REG_MMU_CFG); /* 16KB LV1, =
LRU */
> + =A0 =A0 =A0 __raw_writel(pgd, sfrbase + REG_PT_BASE_ADDR);
> +
> + =A0 =A0 =A0 __sysmmu_tlb_invalidate(sfrbase);
> +}
> +
> +static void __sysmmu_set_prefbuf(void __iomem *sfrbase, unsigned lon=
g base,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long size, int idx)
> +{
> + =A0 =A0 =A0 __raw_writel(base, sfrbase + S5P_PB0_SADDR + idx * 8);
> + =A0 =A0 =A0 __raw_writel(size - 1 + base, =A0sfrbase + S5P_PB0_EADD=
R + idx * 8);
> +}
> +
> +void exynos_sysmmu_set_prefbuf(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d long base0, unsigned long size0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d long base1, unsigned long size1)
> +{
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->ar=
chdata.iommu);
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 BUG_ON((base0 + size0) <=3D base0);
> + =A0 =A0 =A0 BUG_ON((size1 > 0) && ((base1 + size1) <=3D base1));
It's bogus check. it's impossible. Do you think overflow case?
> +
> + =A0 =A0 =A0 read_lock_irqsave(&data->lock, flags);
> + =A0 =A0 =A0 if (!is_sysmmu_active(data))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(data->sfrbases[i] + S5P_MMU_=
VERSION) >> 28) =3D=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_block(data->sfrb=
ases[i]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size1 =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (siz=
e0 <=3D SZ_128K) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 base1 =3D base0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 size1 =3D size0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 size1 =3D size0 -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ALIGN(size0 / 2, SZ_64K);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 size0 =3D size0 - size1;
Umm I mis-understand this codes at first. it think size1 has 0
already. so it's meaning-less but now it re-use the size1 above.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 base1 =3D base0 + size0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_prefbuf(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 data->sfrbases[i], base0, size0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_prefbuf(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 data->sfrbases[i], base1, size1, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_unblock(data->sf=
rbases[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +finish:
> + =A0 =A0 =A0 read_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +static void __set_fault_handler(struct sysmmu_drvdata *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 sysmmu_fault_handler_t handler)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 write_lock_irqsave(&data->lock, flags);
> + =A0 =A0 =A0 data->fault_handler =3D handler;
> + =A0 =A0 =A0 write_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +void exynos_sysmmu_set_fault_handler(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 sysmmu_fault_handler_t handler)
> +{
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->ar=
chdata.iommu);
> +
> + =A0 =A0 =A0 __set_fault_handler(data, handler);
> +}
> +
> +static int default_fault_handler(enum EXYNOS_SYSMMU_INTERRUPT_TYPE i=
type,
Can you use the small letter instead of large one? do you see codes lik=
e this?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long pgtable_base, =
unsigned long fault_addr)
> +{
> + =A0 =A0 =A0 unsigned long *ent;
> +
> + =A0 =A0 =A0 if ((itype >=3D SYSMMU_FAULTS_NUM) || (itype < SYSMMU_P=
AGEFAULT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_UNKNOWN;
> +
> + =A0 =A0 =A0 pr_err("%s occured at 0x%lx(Page table base: 0x%lx)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_fault_name[itype=
], fault_addr, pgtable_base);
> +
> + =A0 =A0 =A0 ent =3D section_entry(__va(pgtable_base), fault_addr);
> + =A0 =A0 =A0 pr_err("\tLv1 entry: 0x%lx\n", *ent);
> +
> + =A0 =A0 =A0 if (lv1ent_page(ent)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ent =3D page_entry(ent, fault_addr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("\t Lv2 entry: 0x%lx\n", *ent);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_err("Generating Kernel OOPS... because it is unrecov=
erable.\n");
> +
> + =A0 =A0 =A0 BUG();
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 /* SYSMMU is in blocked when interrupt occurred. */
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_id;
> + =A0 =A0 =A0 struct resource *irqres;
> + =A0 =A0 =A0 struct platform_device *pdev;
> + =A0 =A0 =A0 enum EXYNOS_SYSMMU_INTERRUPT_TYPE itype;
> + =A0 =A0 =A0 unsigned long addr =3D -1;
> +
> + =A0 =A0 =A0 int i, ret =3D -ENOSYS;
> +
> + =A0 =A0 =A0 read_lock(&data->lock);
> +
> + =A0 =A0 =A0 WARN_ON(!is_sysmmu_active(data));
> +
> + =A0 =A0 =A0 pdev =3D to_platform_device(data->sysmmu);
> + =A0 =A0 =A0 for (i =3D 0; i < pdev->num_resources; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irqres =3D platform_get_resource(pdev, =
IORESOURCE_IRQ, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (irqres && ((int)irqres->start =3D=3D=
 irq))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (i =3D=3D pdev->num_resources) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_UNKNOWN;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i /=3D 2;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D (enum EXYNOS_SYSMMU_INTERRUPT=
_TYPE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(__raw_readl(data-=
>sfrbases[i] + REG_INT_STATUS));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WARN_ON(!((itype >=3D 0) && (itype =
< SYSMMU_FAULT_UNKNOWN))))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 itype =3D SYSMMU_FAULT_=
UNKNOWN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D __raw_readl(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->s=
frbases[i] + fault_reg_offset[itype]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (data->domain)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D report_iommu_fault(data->domain=
, data->client.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr, i=
type);
> +
> + =A0 =A0 =A0 if ((ret =3D=3D -ENOSYS) && data->fault_handler) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long base =3D data->pgtable;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (itype !=3D SYSMMU_FAULT_UNKNOWN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 base =3D __raw_readl(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 data->sfrbases[i] + REG_PT_BASE_ADDR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D data->fault_handler(itype, base=
, addr);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!ret && (itype !=3D SYSMMU_FAULT_UNKNOWN))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(1 << itype, data->sfrbases=
[i] + REG_INT_CLEAR);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data->sysmmu, "(%s) %s is not h=
andled.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->d=
bgname, sysmmu_fault_name[itype]);
> +
> + =A0 =A0 =A0 if (itype !=3D SYSMMU_FAULT_UNKNOWN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_unblock(data->sfrbases[i]);
> +
> + =A0 =A0 =A0 read_unlock(&data->lock);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static bool __sysmmu_disable(struct sysmmu_drvdata *data)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 bool disabled =3D false;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 write_lock_irqsave(&data->lock, flags);
> +
> + =A0 =A0 =A0 if (!set_sysmmu_inactive(data))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(CTRL_DISABLE, data->sfrbas=
es[i] + REG_MMU_CTRL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->clk[1])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(data->clk[1=
]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->clk[0])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(data->clk[0=
]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disabled =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->pgtable =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->domain =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(data->sysmmu);
> + =A0 =A0 =A0 }
> +
> +finish:
> + =A0 =A0 =A0 write_unlock_irqrestore(&data->lock, flags);
> +
> + =A0 =A0 =A0 return disabled;
> +}
> +
> +/* __exynos_sysmmu_enable: Enables System MMU
> + *
> + * returns -error if an error occurred and System MMU is not enabled=
,
> + * 0 if the System MMU has been just enabled and 1 if System MMU was=
 already
> + * enabled before.
> + */
> +static int __exynos_sysmmu_enable(struct device *dev, unsigned long =
pgtable,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 struct iommu_domain *domain)
> +{
> + =A0 =A0 =A0 int i, ret =3D 0;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->ar=
chdata.iommu);
> +
> + =A0 =A0 =A0 BUG_ON(!memblock_is_memory(pgtable));
> +
> + =A0 =A0 =A0 ret =3D pm_runtime_get_sync(data->sysmmu);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 write_lock_irqsave(&data->lock, flags);
> +
> + =A0 =A0 =A0 if (!set_sysmmu_active(data)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* RPM of sysmmu won't be refcounted */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put(data->sy=
smmu);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (WARN_ON(pgtable !=3D data->pgtable)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_sysmmu_inactive(dat=
a);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data->sysmmu, "(%s) Already ena=
bled\n", data->dbgname);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (data->clk[0])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(data->clk[0]);
> + =A0 =A0 =A0 if (data->clk[1])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(data->clk[1]);
> +
> + =A0 =A0 =A0 data->pgtable =3D pgtable;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_ptbase(data->sfrbases[i], =
pgtable);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((readl(data->sfrbases[i] + S5P_MMU_=
VERSION) >> 28) =3D=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* System MMU version i=
s 3.x */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel((1 << 12) =
| (2 << 28),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 data->sfrbases[i] + S5P_MMU_CFG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_prefbuf(da=
ta->sfrbases[i], 0, -1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_set_prefbuf(da=
ta->sfrbases[i], 0, -1, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(CTRL_ENABLE, data->sfrbase=
s[i] + REG_MMU_CTRL);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 data->domain =3D domain;
> +
> + =A0 =A0 =A0 dev_dbg(data->sysmmu, "(%s) Enabled\n", data->dbgname);
> +finish:
> + =A0 =A0 =A0 write_unlock_irqrestore(&data->lock, flags);
> +
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_disable(data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data->sysmmu, "(%s) Failed to e=
nable\n", data->dbgname);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct iommu_client *__get_enabled_iommu_client(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
iommu_domain *domain, struct device *dev)
> +{
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->ar=
chdata.iommu);
> + =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D __exynos_sysmmu_enable(dev, __pa(priv->pgtable)=
, domain);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(ret);
> + =A0 =A0 =A0 else if (ret =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EBUSY);
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&data->client.node);
> + =A0 =A0 =A0 data->client.dev =3D dev;
> + =A0 =A0 =A0 data->client.refcnt =3D 1;
> +
> + =A0 =A0 =A0 return &data->client;
> +}
> +
> +int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
> +{
> + =A0 =A0 =A0 return __exynos_sysmmu_enable(dev, pgtable, NULL);
> +}
> +
> +void exynos_sysmmu_disable(struct device *dev)
> +{
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->ar=
chdata.iommu);
> + =A0 =A0 =A0 bool disabled;
> +
> + =A0 =A0 =A0 disabled =3D __sysmmu_disable(data);
> + =A0 =A0 =A0 dev_dbg(data->sysmmu,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disabled ? "(%s) Disabl=
ed.\n" :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(%s) D=
eactivation request ignorred.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->dbgname);
> +}
> +
> +static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned=
 long iova)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->ar=
chdata.iommu);
> +
> + =A0 =A0 =A0 read_lock_irqsave(&data->lock, flags);
> +
> + =A0 =A0 =A0 if (is_sysmmu_active(data)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_block(data->sfrb=
ases[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_tlb_invalidate=
_entry(data->sfrbases[i], iova);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_unblock(data->sf=
rbases[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data->sysmmu,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(%s) Disabled. Skippin=
g invalidating TLB.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->dbgname);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 read_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +void exynos_sysmmu_tlb_invalidate(struct device *dev)
> +{
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 struct sysmmu_drvdata *data =3D dev_get_drvdata(dev->ar=
chdata.iommu);
> +
> + =A0 =A0 =A0 read_lock_irqsave(&data->lock, flags);
> +
> + =A0 =A0 =A0 if (is_sysmmu_active(data)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_block(data->sfrb=
ases[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __sysmmu_tlb_invalidate=
(data->sfrbases[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_unblock(data->sf=
rbases[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(data->sysmmu,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "(%s) Disabled. Skippin=
g invalidating TLB.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->dbgname);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 read_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +static int exynos_sysmmu_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 int i, ret;
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct sysmmu_drvdata *data;
> +
> + =A0 =A0 =A0 dev =3D &pdev->dev;
> +
> + =A0 =A0 =A0 data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> + =A0 =A0 =A0 if (!data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Not enough memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_alloc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D dev_set_drvdata(dev, data);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unabled to initialize dri=
ver data\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_init;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 data->nsfrs =3D pdev->num_resources / 2;
> + =A0 =A0 =A0 data->sfrbases =3D kmalloc(sizeof(*data->sfrbases) * da=
ta->nsfrs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> + =A0 =A0 =A0 if (data->sfrbases =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Not enough memory\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_init;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D platform_get_resource(pdev, IOR=
ESOURCE_MEM, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unable to=
 find IOMEM region\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->sfrbases[i] =3D ioremap(res->star=
t, resource_size(res));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!data->sfrbases[i]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unable to=
 map IOMEM @ PA:%#x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->start);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOENT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_res;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < data->nsfrs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D platform_get_irq(pdev, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret <=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unable to=
 find IRQ resource\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(ret, exynos_sysmmu_=
irq, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 dev_name(dev), data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Unabled t=
o register interrupt handler\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (dev_get_platdata(dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *deli, *beg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sysmmu_platform_data *platdata =3D=
 dev_get_platdata(dev);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 beg =3D platdata->clockname;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (deli =3D beg; (*deli !=3D '\0') &&=
 (*deli !=3D ','); deli++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTHING */;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*deli =3D=3D '\0')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 deli =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *deli =3D '\0';
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->clk[0] =3D clk_get(dev, beg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(data->clk[0])) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->clk[0] =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "No clock =
descriptor registered\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->clk[0] && deli) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *deli =3D ',';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->clk[1] =3D clk_ge=
t(dev, deli + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (IS_ERR(data->clk[1]=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->c=
lk[1] =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->dbgname =3D platdata->dbgname;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 data->sysmmu =3D dev;
> + =A0 =A0 =A0 rwlock_init(&data->lock);
> +
> + =A0 =A0 =A0 __set_fault_handler(data, &default_fault_handler);
> +
> + =A0 =A0 =A0 if (dev->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_enable(dev);
> +
> + =A0 =A0 =A0 dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
> + =A0 =A0 =A0 return 0;
> +err_irq:
> + =A0 =A0 =A0 while (i-- > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int irq;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq =3D platform_get_irq(pdev, i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(irq, data);
> + =A0 =A0 =A0 }
> +err_res:
> + =A0 =A0 =A0 while (data->nsfrs-- > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(data->sfrbases[data->nsfrs]);
> + =A0 =A0 =A0 kfree(data->sfrbases);
> +err_init:
> + =A0 =A0 =A0 kfree(data);
> +err_alloc:
> + =A0 =A0 =A0 dev_err(dev, "Failed to initialize\n");
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct platform_driver exynos_sysmmu_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D exynos_sysmmu_probe,
> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODU=
LE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "exynos-s=
ysmmu",
> + =A0 =A0 =A0 }
> +};
> +
> +static inline void pgtable_flush(void *vastart, void *vaend)
> +{
> + =A0 =A0 =A0 dmac_flush_range(vastart, vaend);
> + =A0 =A0 =A0 outer_flush_range(virt_to_phys(vastart),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 virt_to=
_phys(vaend));
> +}
> +
> +static int exynos_iommu_domain_init(struct iommu_domain *domain)
> +{
> + =A0 =A0 =A0 struct exynos_iommu_domain *priv;
> +
> + =A0 =A0 =A0 priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> + =A0 =A0 =A0 if (!priv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 priv->pgtable =3D (unsigned long *)__get_free_pages(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL | __GFP_ZERO, 2);
> + =A0 =A0 =A0 if (!priv->pgtable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_pgtable;
> +
> + =A0 =A0 =A0 priv->lv2entcnt =3D (short *)__get_free_pages(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL | __GFP_ZERO, 1);
> + =A0 =A0 =A0 if (!priv->lv2entcnt)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_counter;
> +
> + =A0 =A0 =A0 pgtable_flush(priv->pgtable, priv->pgtable + NUM_LV1ENT=
RIES);
> +
> + =A0 =A0 =A0 spin_lock_init(&priv->lock);
> + =A0 =A0 =A0 spin_lock_init(&priv->pgtablelock);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&priv->clients);
> +
> + =A0 =A0 =A0 domain->priv =3D priv;
> + =A0 =A0 =A0 return 0;
> +
> +err_counter:
> + =A0 =A0 =A0 free_pages((unsigned long)priv->pgtable, 2);
> +err_pgtable:
> + =A0 =A0 =A0 kfree(priv);
> + =A0 =A0 =A0 return -ENOMEM;
> +}
> +
> +static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
> +{
> + =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> + =A0 =A0 =A0 struct list_head *pos, *n;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 WARN_ON(!list_empty(&priv->clients));
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> +
> + =A0 =A0 =A0 list_for_each_safe(pos, n, &priv->clients) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct iommu_client *client;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client =3D list_entry(pos, struct iommu=
_client, node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exynos_sysmmu_disable(client->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(client);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < NUM_LV1ENTRIES; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lv1ent_page(priv->pgtable + i))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(__va(lv2table_bas=
e(priv->pgtable + i)));
> +
> + =A0 =A0 =A0 free_pages((unsigned long)priv->pgtable, 2);
> + =A0 =A0 =A0 free_pages((unsigned long)priv->lv2entcnt, 1);
> + =A0 =A0 =A0 kfree(domain->priv);
> + =A0 =A0 =A0 domain->priv =3D NULL;
> +}
> +
> +static int exynos_iommu_attach_device(struct iommu_domain *domain,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct device *dev)
> +{
> + =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> + =A0 =A0 =A0 struct iommu_client *client =3D NULL;
> + =A0 =A0 =A0 struct list_head *pos;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> +
> + =A0 =A0 =A0 list_for_each(pos, &priv->clients) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct iommu_client *cur;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur =3D list_entry(pos, struct iommu_cl=
ient, node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cur->dev =3D=3D dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client =3D cur;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (client !=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 client->refcnt++;
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
> +
> + =A0 =A0 =A0 if (client !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "%s: IOMMU with pgtable 0x=
%lx already attached\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 __func__, __pa(priv->pgtable));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 client =3D __get_enabled_iommu_client(domain, dev);
> + =A0 =A0 =A0 if (IS_ERR(client))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(client);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> + =A0 =A0 =A0 list_add_tail(&client->node, &priv->clients);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s: Attached new IOMMU with pgtable 0x%lx=
\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __pa(priv->pgtable));
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static void exynos_iommu_detach_device(struct iommu_domain *domain,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct device *dev)
> +{
> + =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> + =A0 =A0 =A0 struct iommu_client *client =3D NULL;
> + =A0 =A0 =A0 struct list_head *pos;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->lock, flags);
> +
> + =A0 =A0 =A0 list_for_each(pos, &priv->clients) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct iommu_client *cur;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur =3D list_entry(pos, struct iommu_cl=
ient, node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cur->dev =3D=3D dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur->refcnt--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 client =3D cur;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->lock, flags);
> +
> + =A0 =A0 =A0 if (WARN_ON(client =3D=3D NULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (client->refcnt > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "IOMMU is still attache=
d %d times with pgtable %#lx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 client->refcnt, __pa(priv->pgtable));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 list_del(&client->node);
> + =A0 =A0 =A0 exynos_sysmmu_disable(client->dev);
> + =A0 =A0 =A0 dev_dbg(dev, "%s: Detached IOMMU with pgtable 0x%lx\n",=
 __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __pa(priv->pgtable));
> +}
> +
> +static unsigned long *alloc_lv2entry(unsigned long *sent, unsigned l=
ong iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 short *pgcounter)
> +{
> + =A0 =A0 =A0 if (lv1ent_fault(sent)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *pent;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pent =3D kzalloc(LV2TABLE_SIZE, GFP_ATO=
MIC);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON((unsigned long)pent & (LV2TABLE_=
SIZE - 1));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *sent =3D mk_lv1ent_page(__pa(pent));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pgcounter =3D NUM_LV2ENTRIES;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgtable_flush(pent, pent + NUM_LV2ENTRI=
ES);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgtable_flush(sent, sent + 1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return page_entry(sent, iova);
> +}
> +
> +static int lv1set_section(unsigned long *sent, phys_addr_t paddr, sh=
ort *pgcnt)
> +{
> + =A0 =A0 =A0 if (lv1ent_section(sent))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EADDRINUSE;
> +
> + =A0 =A0 =A0 if (lv1ent_page(sent)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (*pgcnt !=3D NUM_LV2ENTRIES)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EADDRINUSE;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(page_entry(sent, 0));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pgcnt =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 *sent =3D mk_lv1ent_sect(paddr);
> +
> + =A0 =A0 =A0 pgtable_flush(sent, sent + 1);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int lv2set_page(unsigned long *pent, phys_addr_t paddr, size_=
t size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 short *pgcnt)
> +{
> + =A0 =A0 =A0 if (size =3D=3D SPAGE_SIZE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!lv2ent_fault(pent))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EADDRINUSE;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pent =3D mk_lv2ent_spage(paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgtable_flush(pent, pent + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pgcnt -=3D 1;
> + =A0 =A0 =A0 } else { /* size =3D=3D LPAGE_SIZE */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < SPAGES_PER_LPAGE; i++=
, pent++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!lv2ent_fault(pent)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(=
pent, 0, sizeof(*pent) * i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
-EADDRINUSE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pent =3D mk_lv2ent_lpa=
ge(paddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgtable_flush(pent - SPAGES_PER_LPAGE, =
pent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pgcnt -=3D SPAGES_PER_LPAGE;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int exynos_iommu_map(struct iommu_domain *domain, unsigned lo=
ng iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0phys_addr_t paddr, s=
ize_t size, int prot)
> +{
> + =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> + =A0 =A0 =A0 unsigned long *entry;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int ret =3D -ENOMEM;
> +
> + =A0 =A0 =A0 BUG_ON(priv->pgtable =3D=3D NULL);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->pgtablelock, flags);
> +
> + =A0 =A0 =A0 entry =3D section_entry(priv->pgtable, iova);
> +
> + =A0 =A0 =A0 if (size =3D=3D SECT_SIZE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D lv1set_section(entry, paddr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &priv->lv2entcnt[lv1ent_offset(iova)]);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *pent;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pent =3D alloc_lv2entry(entry, iova,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &priv->lv2entcnt[lv1ent_offset(iova)]);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D lv2set_page(pen=
t, paddr, size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &priv->lv2entcnt[lv1ent_offset(iova)]);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Failed to map iova 0x%lx/=
0x%x bytes\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, iova, size);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->pgtablelock, flags);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static size_t exynos_iommu_unmap(struct iommu_domain *domain,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0unsigned long iova, size_t size)
> +{
> + =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> + =A0 =A0 =A0 struct iommu_client *client;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 unsigned long *ent;
> +
> + =A0 =A0 =A0 BUG_ON(priv->pgtable =3D=3D NULL);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->pgtablelock, flags);
> +
> + =A0 =A0 =A0 ent =3D section_entry(priv->pgtable, iova);
> +
> + =A0 =A0 =A0 if (lv1ent_section(ent)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(size < SECT_SIZE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ent =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pgtable_flush(ent, ent + 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D SECT_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (unlikely(lv1ent_fault(ent))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (size > SECT_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D SECT_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* lv1ent_page(sent) =3D=3D true here */
> +
> + =A0 =A0 =A0 ent =3D page_entry(ent, iova);
> +
> + =A0 =A0 =A0 if (unlikely(lv2ent_fault(ent))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D SPAGE_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (lv2ent_small(ent)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *ent =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size =3D SPAGE_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 priv->lv2entcnt[lv1ent_offset(iova)] -=3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* lv1ent_large(ent) =3D=3D true here */
> + =A0 =A0 =A0 BUG_ON(size < LPAGE_SIZE);
> +
> + =A0 =A0 =A0 memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
> +
> + =A0 =A0 =A0 size =3D LPAGE_SIZE;
> + =A0 =A0 =A0 priv->lv2entcnt[lv1ent_offset(iova)] -=3D SPAGES_PER_LP=
AGE;
> +done:
> + =A0 =A0 =A0 list_for_each_entry(client, &priv->clients, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysmmu_tlb_invalidate_entry(client->dev=
, iova);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->pgtablelock, flags);
> +
> + =A0 =A0 =A0 return size;
> +}
> +
> +static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *do=
main,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 unsigned long iova)
> +{
> + =A0 =A0 =A0 struct exynos_iommu_domain *priv =3D domain->priv;
> + =A0 =A0 =A0 unsigned long *entry;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 phys_addr_t phys =3D -1;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&priv->pgtablelock, flags);
> +
> + =A0 =A0 =A0 entry =3D section_entry(priv->pgtable, iova);
> +
> + =A0 =A0 =A0 if (lv1ent_section(entry)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys =3D section_phys(entry) + section_=
offs(iova);
> + =A0 =A0 =A0 } else if (lv1ent_page(entry)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 entry =3D page_entry(entry, iova);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lv2ent_large(entry))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys =3D lpage_phys(ent=
ry) + lpage_offs(iova);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lv2ent_small(entry))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phys =3D spage_phys(ent=
ry) + spage_offs(iova);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&priv->pgtablelock, flags);
> +
> + =A0 =A0 =A0 return phys;
What's happened if phys has -1? I mean it can't trigger any condition a=
t above.
> +}
> +
> +static struct iommu_ops exynos_iommu_ops =3D {
> + =A0 =A0 =A0 .domain_init =3D &exynos_iommu_domain_init,
> + =A0 =A0 =A0 .domain_destroy =3D &exynos_iommu_domain_destroy,
> + =A0 =A0 =A0 .attach_dev =3D &exynos_iommu_attach_device,
> + =A0 =A0 =A0 .detach_dev =3D &exynos_iommu_detach_device,
> + =A0 =A0 =A0 .map =3D &exynos_iommu_map,
> + =A0 =A0 =A0 .unmap =3D &exynos_iommu_unmap,
> + =A0 =A0 =A0 .iova_to_phys =3D &exynos_iommu_iova_to_phys,
> + =A0 =A0 =A0 .pgsize_bitmap =3D SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
> +};
> +
> +static int __init exynos_iommu_init(void)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D platform_driver_register(&exynos_sysmmu_driver)=
;
> +
> + =A0 =A0 =A0 if (ret =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_set_iommu(&platform_bus_type, &exyn=
os_iommu_ops);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +arch_initcall(exynos_iommu_init);
> --
> 1.7.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
