From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 1/3] iommu/rockchip: rk3288 iommu driver
Date: Wed, 29 Oct 2014 02:50:06 +0800
Message-ID: <CAGS+omAvCLNyxypzFpayVNy1Xz-7VruRBWTmSe61OBwAWuVaLA@mail.gmail.com>
References: <1414413448-15819-1-git-send-email-djkurtz@chromium.org>
	<1414413448-15819-2-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1889383163932365840=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414413448-15819-2-git-send-email-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1889383163932365840==
Content-Type: multipart/alternative; boundary=bcaec511e5faa592b30506801d70

--bcaec511e5faa592b30506801d70
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Heiko,

Does this version work for you on 3.18-rc1?
On Oct 27, 2014 8:44 PM, "Daniel Kurtz" <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:

> The rk3288 has several iommus.  Each iommu belongs to a single master
> device.  There is one device (ISP) that has two slave iommus, but that
> case is not yet supported by this driver.
>
> At subsys init, the iommu driver registers itself as the iommu driver for
> the platform bus.  The master devices find their slave iommus using the
> "iommus" field in their devicetree description.  Since each slave iommu
> belongs to exactly one master, their is no additional data needed at prob=
e
> to associate a slave with its master.
>
> An iommu device's power domain, clock and irq are all shared with its
> master device, and the master device must be careful to attach from the
> iommu only after powering and clocking it (and leave it powered and
> clocked before detaching).  Because their is no guarantee what the status
> of the iommu is at probe, and since the driver does not even know if the
> device is powered, we delay requesting its irq until the master device
> attaches, at which point we have a guarantee that the device is powered
> and clocked and we can reset it and disable its interrupt mask.
>
> An iommu_domain describes a virtual iova address space.  Each iommu_domai=
n
> has a corresponding page table that lists the mappings from iova to
> physical address.
>
> For the rk3288 iommu, the page table has two levels:
>  The Level 1 "directory_table" has 1024 4-byte dte entries.
>  Each dte points to a level 2 "page_table".
>  Each level 2 page_table has 1024 4-byte pte entries.
>  Each pte points to a 4 KiB page of memory.
>
> An iommu_domain is created when a dma_iommu_mapping is created via
> arm_iommu_create_mapping.  Master devices can then attach themselves to
> this mapping (or attach the mapping to themselves?) by calling
> arm_iommu_attach_device().  This in turn instructs the iommu driver to
> write the page table's physical address into the slave iommu's "Directory
> Table Entry" (DTE) register.
>
> In fact multiple master devices, each with their own slave iommu device,
> can all attach to the same mapping.  The iommus for these devices will
> share the same iommu_domain and therefore point to the same page table.
> Thus, the iommu domain maintains a list of iommu devices which are
> attached.  This driver relies on the iommu core to ensure that all device=
s
> have detached before destroying a domain.
>
> Changes in v6:
>   - add .add/remove_device() callbacks.
>   - parse platform_device device tree nodes for "iommus" property
>   - store platform device pointer as group iommudata
>   - Check for existence of iommu group instead of relying on a
>     dev_get_drvdata() to return NULL for a NULL device.
>
> Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> Reviewed-by: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Reviewed-by: St=C3=A9phane Marchesin <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/iommu/Kconfig          |   12 +
>  drivers/iommu/Makefile         |    1 +
>  drivers/iommu/rockchip-iommu.c | 1038
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1051 insertions(+)
>  create mode 100644 drivers/iommu/rockchip-iommu.c
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dd51122..d0a1261 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -152,6 +152,18 @@ config OMAP_IOMMU_DEBUG
>
>           Say N unless you know you need this.
>
> +config ROCKCHIP_IOMMU
> +       bool "Rockchip IOMMU Support"
> +       depends on ARCH_ROCKCHIP
> +       select IOMMU_API
> +       select ARM_DMA_USE_IOMMU
> +       help
> +         Support for IOMMUs found on Rockchip rk32xx SOCs.
> +         These IOMMUs allow virtualization of the address space used by
> most
> +         cores within the multimedia subsystem.
> +         Say Y here if you are using a Rockchip SoC that includes an IOM=
MU
> +         device.
> +
>  config TEGRA_IOMMU_GART
>         bool "Tegra GART IOMMU Support"
>         depends on ARCH_TEGRA_2x_SOC
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 16edef7..3e47ef3 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_IRQ_REMAP) +=3D intel_irq_remapping.o
> irq_remapping.o
>  obj-$(CONFIG_OMAP_IOMMU) +=3D omap-iommu.o
>  obj-$(CONFIG_OMAP_IOMMU) +=3D omap-iommu2.o
>  obj-$(CONFIG_OMAP_IOMMU_DEBUG) +=3D omap-iommu-debug.o
> +obj-$(CONFIG_ROCKCHIP_IOMMU) +=3D rockchip-iommu.o
>  obj-$(CONFIG_TEGRA_IOMMU_GART) +=3D tegra-gart.o
>  obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra-smmu.o
>  obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o
> diff --git a/drivers/iommu/rockchip-iommu.c
> b/drivers/iommu/rockchip-iommu.c
> new file mode 100644
> index 0000000..61d6f87
> --- /dev/null
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -0,0 +1,1038 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/cacheflush.h>
> +#include <asm/pgtable.h>
> +#include <linux/compiler.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
> +#include <linux/list.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +
> +/** MMU register offsets */
> +#define RK_MMU_DTE_ADDR                0x00    /* Directory table addres=
s
> */
> +#define RK_MMU_STATUS          0x04
> +#define RK_MMU_COMMAND         0x08
> +#define RK_MMU_PAGE_FAULT_ADDR 0x0C    /* IOVA of last page fault */
> +#define RK_MMU_ZAP_ONE_LINE    0x10    /* Shootdown one IOTLB entry */
> +#define RK_MMU_INT_RAWSTAT     0x14    /* IRQ status ignoring mask */
> +#define RK_MMU_INT_CLEAR       0x18    /* Acknowledge and re-arm irq */
> +#define RK_MMU_INT_MASK                0x1C    /* IRQ enable */
> +#define RK_MMU_INT_STATUS      0x20    /* IRQ status after masking */
> +#define RK_MMU_AUTO_GATING     0x24
> +
> +#define DTE_ADDR_DUMMY         0xCAFEBABE
> +#define FORCE_RESET_TIMEOUT    100     /* ms */
> +
> +/* RK_MMU_STATUS fields */
> +#define RK_MMU_STATUS_PAGING_ENABLED       BIT(0)
> +#define RK_MMU_STATUS_PAGE_FAULT_ACTIVE    BIT(1)
> +#define RK_MMU_STATUS_STALL_ACTIVE         BIT(2)
> +#define RK_MMU_STATUS_IDLE                 BIT(3)
> +#define RK_MMU_STATUS_REPLAY_BUFFER_EMPTY  BIT(4)
> +#define RK_MMU_STATUS_PAGE_FAULT_IS_WRITE  BIT(5)
> +#define RK_MMU_STATUS_STALL_NOT_ACTIVE     BIT(31)
> +
> +/* RK_MMU_COMMAND command values */
> +#define RK_MMU_CMD_ENABLE_PAGING    0  /* Enable memory translation */
> +#define RK_MMU_CMD_DISABLE_PAGING   1  /* Disable memory translation */
> +#define RK_MMU_CMD_ENABLE_STALL     2  /* Stall paging to allow other
> cmds */
> +#define RK_MMU_CMD_DISABLE_STALL    3  /* Stop stall re-enables paging *=
/
> +#define RK_MMU_CMD_ZAP_CACHE        4  /* Shoot down entire IOTLB */
> +#define RK_MMU_CMD_PAGE_FAULT_DONE  5  /* Clear page fault */
> +#define RK_MMU_CMD_FORCE_RESET      6  /* Reset all registers */
> +
> +/* RK_MMU_INT_* register fields */
> +#define RK_MMU_IRQ_PAGE_FAULT    0x01  /* page fault */
> +#define RK_MMU_IRQ_BUS_ERROR     0x02  /* bus read error */
> +#define RK_MMU_IRQ_MASK          (RK_MMU_IRQ_PAGE_FAULT |
> RK_MMU_IRQ_BUS_ERROR)
> +
> +#define NUM_DT_ENTRIES 1024
> +#define NUM_PT_ENTRIES 1024
> +
> +#define SPAGE_ORDER 12
> +#define SPAGE_SIZE (1 << SPAGE_ORDER)
> +
> + /*
> +  * Support mapping any size that fits in one page table:
> +  *   4 KiB to 4 MiB
> +  */
> +#define RK_IOMMU_PGSIZE_BITMAP 0x007ff000
> +
> +#define IOMMU_REG_POLL_COUNT_FAST 1000
> +
> +struct rk_iommu_domain {
> +       struct list_head iommus;
> +       u32 *dt; /* page directory table */
> +       spinlock_t iommus_lock; /* lock for iommus list */
> +       spinlock_t dt_lock; /* lock for modifying page directory table */
> +};
> +
> +struct rk_iommu {
> +       struct device *dev;
> +       void __iomem *base;
> +       int irq;
> +       struct list_head node; /* entry in rk_iommu_domain.iommus */
> +       struct iommu_domain *domain; /* domain to which iommu is attached
> */
> +};
> +
> +static inline void rk_table_flush(u32 *va, unsigned int count)
> +{
> +       phys_addr_t pa_start =3D virt_to_phys(va);
> +       phys_addr_t pa_end =3D virt_to_phys(va + count);
> +       size_t size =3D pa_end - pa_start;
> +
> +       __cpuc_flush_dcache_area(va, size);
> +       outer_flush_range(pa_start, pa_end);
> +}
> +
> +/**
> + * Inspired by _wait_for in intel_drv.h
> + * This is NOT safe for use in interrupt context.
> + *
> + * Note that it's important that we check the condition again after havi=
ng
> + * timed out, since the timeout could be due to preemption or similar an=
d
> + * we've never had a chance to check the condition before the timeout.
> + */
> +#define rk_wait_for(COND, MS) ({ \
> +       unsigned long timeout__ =3D jiffies + msecs_to_jiffies(MS) + 1;  =
 \
> +       int ret__ =3D 0;                                                 =
 \
> +       while (!(COND)) {                                               \
> +               if (time_after(jiffies, timeout__)) {                   \
> +                       ret__ =3D (COND) ? 0 : -ETIMEDOUT;               =
 \
> +                       break;                                          \
> +               }                                                       \
> +               usleep_range(50, 100);                                  \
> +       }                                                               \
> +       ret__;                                                          \
> +})
> +
> +/*
> + * The Rockchip rk3288 iommu uses a 2-level page table.
> + * The first level is the "Directory Table" (DT).
> + * The DT consists of 1024 4-byte Directory Table Entries (DTEs), each
> pointing
> + * to a "Page Table".
> + * The second level is the 1024 Page Tables (PT).
> + * Each PT consists of 1024 4-byte Page Table Entries (PTEs), each
> pointing to
> + * a 4 KB page of physical memory.
> + *
> + * The DT and each PT fits in a single 4 KB page (4-bytes * 1024 entries=
).
> + * Each iommu device has a MMU_DTE_ADDR register that contains the
> physical
> + * address of the start of the DT page.
> + *
> + * The structure of the page table is as follows:
> + *
> + *                   DT
> + * MMU_DTE_ADDR -> +-----+
> + *                 |     |
> + *                 +-----+     PT
> + *                 | DTE | -> +-----+
> + *                 +-----+    |     |     Memory
> + *                 |     |    +-----+     Page
> + *                 |     |    | PTE | -> +-----+
> + *                 +-----+    +-----+    |     |
> + *                            |     |    |     |
> + *                            |     |    |     |
> + *                            +-----+    |     |
> + *                                       |     |
> + *                                       |     |
> + *                                       +-----+
> + */
> +
> +/*
> + * Each DTE has a PT address and a valid bit:
> + * +---------------------+-----------+-+
> + * | PT address          | Reserved  |V|
> + * +---------------------+-----------+-+
> + *  31:12 - PT address (PTs always starts on a 4 KB boundary)
> + *  11: 1 - Reserved
> + *      0 - 1 if PT @ PT address is valid
> + */
> +#define RK_DTE_PT_ADDRESS_MASK    0xfffff000
> +#define RK_DTE_PT_VALID           BIT(0)
> +
> +static inline phys_addr_t rk_dte_pt_address(u32 dte)
> +{
> +       return (phys_addr_t)dte & RK_DTE_PT_ADDRESS_MASK;
> +}
> +
> +static inline bool rk_dte_is_pt_valid(u32 dte)
> +{
> +       return dte & RK_DTE_PT_VALID;
> +}
> +
> +static u32 rk_mk_dte(u32 *pt)
> +{
> +       phys_addr_t pt_phys =3D virt_to_phys(pt);
> +       return (pt_phys & RK_DTE_PT_ADDRESS_MASK) | RK_DTE_PT_VALID;
> +}
> +
> +/*
> + * Each PTE has a Page address, some flags and a valid bit:
> + * +---------------------+---+-------+-+
> + * | Page address        |Rsv| Flags |V|
> + * +---------------------+---+-------+-+
> + *  31:12 - Page address (Pages always start on a 4 KB boundary)
> + *  11: 9 - Reserved
> + *   8: 1 - Flags
> + *      8 - Read allocate - allocate cache space on read misses
> + *      7 - Read cache - enable cache & prefetch of data
> + *      6 - Write buffer - enable delaying writes on their way to memory
> + *      5 - Write allocate - allocate cache space on write misses
> + *      4 - Write cache - different writes can be merged together
> + *      3 - Override cache attributes
> + *          if 1, bits 4-8 control cache attributes
> + *          if 0, the system bus defaults are used
> + *      2 - Writable
> + *      1 - Readable
> + *      0 - 1 if Page @ Page address is valid
> + */
> +#define RK_PTE_PAGE_ADDRESS_MASK  0xfffff000
> +#define RK_PTE_PAGE_FLAGS_MASK    0x000001fe
> +#define RK_PTE_PAGE_WRITABLE      BIT(2)
> +#define RK_PTE_PAGE_READABLE      BIT(1)
> +#define RK_PTE_PAGE_VALID         BIT(0)
> +
> +static inline phys_addr_t rk_pte_page_address(u32 pte)
> +{
> +       return (phys_addr_t)pte & RK_PTE_PAGE_ADDRESS_MASK;
> +}
> +
> +static inline bool rk_pte_is_page_valid(u32 pte)
> +{
> +       return pte & RK_PTE_PAGE_VALID;
> +}
> +
> +/* TODO: set cache flags per prot IOMMU_CACHE */
> +static u32 rk_mk_pte(phys_addr_t page, int prot)
> +{
> +       u32 flags =3D 0;
> +       flags |=3D (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE : 0;
> +       flags |=3D (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE : 0;
> +       page &=3D RK_PTE_PAGE_ADDRESS_MASK;
> +       return page | flags | RK_PTE_PAGE_VALID;
> +}
> +
> +static u32 rk_mk_pte_invalid(u32 pte)
> +{
> +       return pte & ~RK_PTE_PAGE_VALID;
> +}
> +
> +/*
> + * rk3288 iova (IOMMU Virtual Address) format
> + *  31       22.21       12.11          0
> + * +-----------+-----------+-------------+
> + * | DTE index | PTE index | Page offset |
> + * +-----------+-----------+-------------+
> + *  31:22 - DTE index   - index of DTE in DT
> + *  21:12 - PTE index   - index of PTE in PT @ DTE.pt_address
> + *  11: 0 - Page offset - offset into page @ PTE.page_address
> + */
> +#define RK_IOVA_DTE_MASK    0xffc00000
> +#define RK_IOVA_DTE_SHIFT   22
> +#define RK_IOVA_PTE_MASK    0x003ff000
> +#define RK_IOVA_PTE_SHIFT   12
> +#define RK_IOVA_PAGE_MASK   0x00000fff
> +#define RK_IOVA_PAGE_SHIFT  0
> +
> +static u32 rk_iova_dte_index(dma_addr_t iova)
> +{
> +       return (u32)(iova & RK_IOVA_DTE_MASK) >> RK_IOVA_DTE_SHIFT;
> +}
> +
> +static u32 rk_iova_pte_index(dma_addr_t iova)
> +{
> +       return (u32)(iova & RK_IOVA_PTE_MASK) >> RK_IOVA_PTE_SHIFT;
> +}
> +
> +static u32 rk_iova_page_offset(dma_addr_t iova)
> +{
> +       return (u32)(iova & RK_IOVA_PAGE_MASK) >> RK_IOVA_PAGE_SHIFT;
> +}
> +
> +static u32 rk_iommu_read(struct rk_iommu *iommu, u32 offset)
> +{
> +       return readl(iommu->base + offset);
> +}
> +
> +static void rk_iommu_write(struct rk_iommu *iommu, u32 offset, u32 value=
)
> +{
> +       writel(value, iommu->base + offset);
> +}
> +
> +static void rk_iommu_command(struct rk_iommu *iommu, u32 command)
> +{
> +       writel(command, iommu->base + RK_MMU_COMMAND);
> +}
> +
> +static void rk_iommu_zap_lines(struct rk_iommu *iommu, dma_addr_t iova,
> +                              size_t size)
> +{
> +       dma_addr_t iova_end =3D iova + size;
> +       /*
> +        * TODO(djkurtz): Figure out when it is more efficient to
> shootdown the
> +        * entire iotlb rather than iterate over individual iovas.
> +        */
> +       for (; iova < iova_end; iova +=3D SPAGE_SIZE)
> +               rk_iommu_write(iommu, RK_MMU_ZAP_ONE_LINE, iova);
> +}
> +
> +static bool rk_iommu_is_stall_active(struct rk_iommu *iommu)
> +{
> +       return rk_iommu_read(iommu, RK_MMU_STATUS) &
> RK_MMU_STATUS_STALL_ACTIVE;
> +}
> +
> +static bool rk_iommu_is_paging_enabled(struct rk_iommu *iommu)
> +{
> +       return rk_iommu_read(iommu, RK_MMU_STATUS) &
> +                            RK_MMU_STATUS_PAGING_ENABLED;
> +}
> +
> +static int rk_iommu_enable_stall(struct rk_iommu *iommu)
> +{
> +       int ret;
> +
> +       if (rk_iommu_is_stall_active(iommu))
> +               return 0;
> +
> +       /* Stall can only be enabled if paging is enabled */
> +       if (!rk_iommu_is_paging_enabled(iommu))
> +               return 0;
> +
> +       rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_STALL);
> +
> +       ret =3D rk_wait_for(rk_iommu_is_stall_active(iommu), 1);
> +       if (ret)
> +               dev_err(iommu->dev, "Enable stall request timed out,
> status: %#08x\n",
> +                       rk_iommu_read(iommu, RK_MMU_STATUS));
> +
> +       return ret;
> +}
> +
> +static int rk_iommu_disable_stall(struct rk_iommu *iommu)
> +{
> +       int ret;
> +
> +       if (!rk_iommu_is_stall_active(iommu))
> +               return 0;
> +
> +       rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_STALL);
> +
> +       ret =3D rk_wait_for(!rk_iommu_is_stall_active(iommu), 1);
> +       if (ret)
> +               dev_err(iommu->dev, "Disable stall request timed out,
> status: %#08x\n",
> +                       rk_iommu_read(iommu, RK_MMU_STATUS));
> +
> +       return ret;
> +}
> +
> +static int rk_iommu_enable_paging(struct rk_iommu *iommu)
> +{
> +       int ret;
> +
> +       if (rk_iommu_is_paging_enabled(iommu))
> +               return 0;
> +
> +       rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_PAGING);
> +
> +       ret =3D rk_wait_for(rk_iommu_is_paging_enabled(iommu), 1);
> +       if (ret)
> +               dev_err(iommu->dev, "Enable paging request timed out,
> status: %#08x\n",
> +                       rk_iommu_read(iommu, RK_MMU_STATUS));
> +
> +       return ret;
> +}
> +
> +static int rk_iommu_disable_paging(struct rk_iommu *iommu)
> +{
> +       int ret;
> +
> +       if (!rk_iommu_is_paging_enabled(iommu))
> +               return 0;
> +
> +       rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_PAGING);
> +
> +       ret =3D rk_wait_for(!rk_iommu_is_paging_enabled(iommu), 1);
> +       if (ret)
> +               dev_err(iommu->dev, "Disable paging request timed out,
> status: #%08x\n",
> +                       rk_iommu_read(iommu, RK_MMU_STATUS));
> +
> +       return ret;
> +}
> +
> +static int rk_iommu_force_reset(struct rk_iommu *iommu)
> +{
> +       int ret;
> +       u32 dte_addr;
> +
> +       /*
> +        * Check if register DTE_ADDR is working by writing DTE_ADDR_DUMM=
Y
> +        * and verifying that upper 5 nybbles are read back.
> +        */
> +       rk_iommu_write(iommu, RK_MMU_DTE_ADDR, DTE_ADDR_DUMMY);
> +
> +       dte_addr =3D rk_iommu_read(iommu, RK_MMU_DTE_ADDR);
> +       if (dte_addr !=3D (DTE_ADDR_DUMMY & RK_DTE_PT_ADDRESS_MASK)) {
> +               dev_err(iommu->dev, "Error during raw reset. MMU_DTE_ADDR
> is not functioning\n");
> +               return -EFAULT;
> +       }
> +
> +       rk_iommu_command(iommu, RK_MMU_CMD_FORCE_RESET);
> +
> +       ret =3D rk_wait_for(rk_iommu_read(iommu, RK_MMU_DTE_ADDR) =3D=3D
> 0x00000000,
> +                         FORCE_RESET_TIMEOUT);
> +       if (ret)
> +               dev_err(iommu->dev, "FORCE_RESET command timed out\n");
> +
> +       return ret;
> +}
> +
> +static void log_iova(struct rk_iommu *iommu, dma_addr_t iova)
> +{
> +       u32 dte_index, pte_index, page_offset;
> +       u32 mmu_dte_addr;
> +       phys_addr_t mmu_dte_addr_phys, dte_addr_phys;
> +       u32 *dte_addr;
> +       u32 dte;
> +       phys_addr_t pte_addr_phys =3D 0;
> +       u32 *pte_addr =3D NULL;
> +       u32 pte =3D 0;
> +       phys_addr_t page_addr_phys =3D 0;
> +       u32 page_flags =3D 0;
> +
> +       dte_index =3D rk_iova_dte_index(iova);
> +       pte_index =3D rk_iova_pte_index(iova);
> +       page_offset =3D rk_iova_page_offset(iova);
> +
> +       mmu_dte_addr =3D rk_iommu_read(iommu, RK_MMU_DTE_ADDR);
> +       mmu_dte_addr_phys =3D (phys_addr_t)mmu_dte_addr;
> +
> +       dte_addr_phys =3D mmu_dte_addr_phys + (4 * dte_index);
> +       dte_addr =3D phys_to_virt(dte_addr_phys);
> +       dte =3D *dte_addr;
> +
> +       if (!rk_dte_is_pt_valid(dte))
> +               goto print_it;
> +
> +       pte_addr_phys =3D rk_dte_pt_address(dte) + (pte_index * 4);
> +       pte_addr =3D phys_to_virt(pte_addr_phys);
> +       pte =3D *pte_addr;
> +
> +       if (!rk_pte_is_page_valid(pte))
> +               goto print_it;
> +
> +       page_addr_phys =3D rk_pte_page_address(pte) + page_offset;
> +       page_flags =3D pte & RK_PTE_PAGE_FLAGS_MASK;
> +
> +print_it:
> +       dev_err(iommu->dev, "iova =3D %pad: dte_index: 0x%03x pte_index:
> 0x%03x page_offset: 0x%03x\n",
> +               &iova, dte_index, pte_index, page_offset);
> +       dev_err(iommu->dev, "mmu_dte_addr: %pa dte@%pa: %#08x valid: %u
> pte@%pa: %#08x valid: %u page@%pa flags: %#03x\n",
> +               &mmu_dte_addr_phys, &dte_addr_phys, dte,
> +               rk_dte_is_pt_valid(dte), &pte_addr_phys, pte,
> +               rk_pte_is_page_valid(pte), &page_addr_phys, page_flags);
> +}
> +
> +static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
> +{
> +       struct rk_iommu *iommu =3D dev_id;
> +       u32 status;
> +       u32 int_status;
> +       dma_addr_t iova;
> +
> +       int_status =3D rk_iommu_read(iommu, RK_MMU_INT_STATUS);
> +       if (int_status =3D=3D 0)
> +               return IRQ_NONE;
> +
> +       iova =3D rk_iommu_read(iommu, RK_MMU_PAGE_FAULT_ADDR);
> +
> +       if (int_status & RK_MMU_IRQ_PAGE_FAULT) {
> +               int flags;
> +
> +               status =3D rk_iommu_read(iommu, RK_MMU_STATUS);
> +               flags =3D (status & RK_MMU_STATUS_PAGE_FAULT_IS_WRITE) ?
> +                               IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
> +
> +               dev_err(iommu->dev, "Page fault at %pad of type %s\n",
> +                       &iova,
> +                       (flags =3D=3D IOMMU_FAULT_WRITE) ? "write" : "rea=
d");
> +
> +               log_iova(iommu, iova);
> +
> +               /*
> +                * Report page fault to any installed handlers.
> +                * Ignore the return code, though, since we always zap
> cache
> +                * and clear the page fault anyway.
> +                */
> +               if (iommu->domain)
> +                       report_iommu_fault(iommu->domain, iommu->dev, iov=
a,
> +                                          flags);
> +               else
> +                       dev_err(iommu->dev, "Page fault while iommu not
> attached to domain?\n");
> +
> +               rk_iommu_command(iommu, RK_MMU_CMD_ZAP_CACHE);
> +               rk_iommu_command(iommu, RK_MMU_CMD_PAGE_FAULT_DONE);
> +       }
> +
> +       if (int_status & RK_MMU_IRQ_BUS_ERROR)
> +               dev_err(iommu->dev, "BUS_ERROR occurred at %pad\n", &iova=
);
> +
> +       if (int_status & ~RK_MMU_IRQ_MASK)
> +               dev_err(iommu->dev, "unexpected int_status: %#08x\n",
> +                       int_status);
> +
> +       rk_iommu_write(iommu, RK_MMU_INT_CLEAR, int_status);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
> +                                        dma_addr_t iova)
> +{
> +       struct rk_iommu_domain *rk_domain =3D domain->priv;
> +       unsigned long flags;
> +       phys_addr_t pt_phys, phys =3D 0;
> +       u32 dte, pte;
> +       u32 *page_table;
> +
> +       spin_lock_irqsave(&rk_domain->dt_lock, flags);
> +
> +       dte =3D rk_domain->dt[rk_iova_dte_index(iova)];
> +       if (!rk_dte_is_pt_valid(dte))
> +               goto out;
> +
> +       pt_phys =3D rk_dte_pt_address(dte);
> +       page_table =3D (u32 *)phys_to_virt(pt_phys);
> +       pte =3D page_table[rk_iova_pte_index(iova)];
> +       if (!rk_pte_is_page_valid(pte))
> +               goto out;
> +
> +       phys =3D rk_pte_page_address(pte) + rk_iova_page_offset(iova);
> +out:
> +       spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
> +
> +       return phys;
> +}
> +
> +static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
> +                             dma_addr_t iova, size_t size)
> +{
> +       struct list_head *pos;
> +       unsigned long flags;
> +
> +       /* shootdown these iova from all iommus using this domain */
> +       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
> +       list_for_each(pos, &rk_domain->iommus) {
> +               struct rk_iommu *iommu;
> +               iommu =3D list_entry(pos, struct rk_iommu, node);
> +               rk_iommu_zap_lines(iommu, iova, size);
> +       }
> +       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> +}
> +
> +static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
> +                                 dma_addr_t iova)
> +{
> +       u32 *page_table, *dte_addr;
> +       u32 dte;
> +       phys_addr_t pt_phys;
> +
> +       assert_spin_locked(&rk_domain->dt_lock);
> +
> +       dte_addr =3D &rk_domain->dt[rk_iova_dte_index(iova)];
> +       dte =3D *dte_addr;
> +       if (rk_dte_is_pt_valid(dte))
> +               goto done;
> +
> +       page_table =3D (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
> +       if (!page_table)
> +               return ERR_PTR(-ENOMEM);
> +
> +       dte =3D rk_mk_dte(page_table);
> +       *dte_addr =3D dte;
> +
> +       rk_table_flush(page_table, NUM_PT_ENTRIES);
> +       rk_table_flush(dte_addr, 1);
> +
> +       /*
> +        * Zap the first iova of newly allocated page table so iommu evic=
ts
> +        * old cached value of new dte from the iotlb.
> +        */
> +       rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);
> +
> +done:
> +       pt_phys =3D rk_dte_pt_address(dte);
> +       return (u32 *)phys_to_virt(pt_phys);
> +}
> +
> +static size_t rk_iommu_unmap_iova(struct rk_iommu_domain *rk_domain,
> +                                 u32 *pte_addr, dma_addr_t iova, size_t
> size)
> +{
> +       unsigned int pte_count;
> +       unsigned int pte_total =3D size / SPAGE_SIZE;
> +
> +       assert_spin_locked(&rk_domain->dt_lock);
> +
> +       for (pte_count =3D 0; pte_count < pte_total; pte_count++) {
> +               u32 pte =3D pte_addr[pte_count];
> +               if (!rk_pte_is_page_valid(pte))
> +                       break;
> +
> +               pte_addr[pte_count] =3D rk_mk_pte_invalid(pte);
> +       }
> +
> +       rk_table_flush(pte_addr, pte_count);
> +
> +       return pte_count * SPAGE_SIZE;
> +}
> +
> +static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32
> *pte_addr,
> +                            dma_addr_t iova, phys_addr_t paddr, size_t
> size,
> +                            int prot)
> +{
> +       unsigned int pte_count;
> +       unsigned int pte_total =3D size / SPAGE_SIZE;
> +       phys_addr_t page_phys;
> +
> +       assert_spin_locked(&rk_domain->dt_lock);
> +
> +       for (pte_count =3D 0; pte_count < pte_total; pte_count++) {
> +               u32 pte =3D pte_addr[pte_count];
> +
> +               if (rk_pte_is_page_valid(pte))
> +                       goto unwind;
> +
> +               pte_addr[pte_count] =3D rk_mk_pte(paddr, prot);
> +
> +               paddr +=3D SPAGE_SIZE;
> +       }
> +
> +       rk_table_flush(pte_addr, pte_count);
> +
> +       return 0;
> +unwind:
> +       /* Unmap the range of iovas that we just mapped */
> +       rk_iommu_unmap_iova(rk_domain, pte_addr, iova, pte_count *
> SPAGE_SIZE);
> +
> +       iova +=3D pte_count * SPAGE_SIZE;
> +       page_phys =3D rk_pte_page_address(pte_addr[pte_count]);
> +       pr_err("iova: %pad already mapped to %pa cannot remap to phys: %p=
a
> prot:%#x\n",
> +              &iova, &page_phys, &paddr, prot);
> +
> +       return -EADDRINUSE;
> +}
> +
> +static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova=
,
> +                       phys_addr_t paddr, size_t size, int prot)
> +{
> +       struct rk_iommu_domain *rk_domain =3D domain->priv;
> +       unsigned long flags;
> +       dma_addr_t iova =3D (dma_addr_t)_iova;
> +       u32 *page_table, *pte_addr;
> +       int ret;
> +
> +       spin_lock_irqsave(&rk_domain->dt_lock, flags);
> +
> +       /*
> +        * pgsize_bitmap specifies iova sizes that fit in one page table
> +        * (1024 4-KiB pages =3D 4 MiB).
> +        * So, size will always be 4096 <=3D size <=3D 4194304.
> +        * Since iommu_map() guarantees that both iova and size will be
> +        * aligned, we will always only be mapping from a single dte here=
.
> +        */
> +       page_table =3D rk_dte_get_page_table(rk_domain, iova);
> +       if (IS_ERR(page_table)) {
> +               spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
> +               return PTR_ERR(page_table);
> +       }
> +
> +       pte_addr =3D &page_table[rk_iova_pte_index(iova)];
> +       ret =3D rk_iommu_map_iova(rk_domain, pte_addr, iova, paddr, size,
> prot);
> +       spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
> +
> +       return ret;
> +}
> +
> +static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long
> _iova,
> +                            size_t size)
> +{
> +       struct rk_iommu_domain *rk_domain =3D domain->priv;
> +       unsigned long flags;
> +       dma_addr_t iova =3D (dma_addr_t)_iova;
> +       phys_addr_t pt_phys;
> +       u32 dte;
> +       u32 *pte_addr;
> +       size_t unmap_size;
> +
> +       spin_lock_irqsave(&rk_domain->dt_lock, flags);
> +
> +       /*
> +        * pgsize_bitmap specifies iova sizes that fit in one page table
> +        * (1024 4-KiB pages =3D 4 MiB).
> +        * So, size will always be 4096 <=3D size <=3D 4194304.
> +        * Since iommu_unmap() guarantees that both iova and size will be
> +        * aligned, we will always only be unmapping from a single dte
> here.
> +        */
> +       dte =3D rk_domain->dt[rk_iova_dte_index(iova)];
> +       /* Just return 0 if iova is unmapped */
> +       if (!rk_dte_is_pt_valid(dte)) {
> +               spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
> +               return 0;
> +       }
> +
> +       pt_phys =3D rk_dte_pt_address(dte);
> +       pte_addr =3D (u32 *)phys_to_virt(pt_phys) + rk_iova_pte_index(iov=
a);
> +       unmap_size =3D rk_iommu_unmap_iova(rk_domain, pte_addr, iova, siz=
e);
> +
> +       spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
> +
> +       /* Shootdown iotlb entries for iova range that was just unmapped =
*/
> +       rk_iommu_zap_iova(rk_domain, iova, unmap_size);
> +
> +       return unmap_size;
> +}
> +
> +static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
> +{
> +       struct iommu_group *group;
> +       struct device *iommu_dev;
> +       struct rk_iommu *rk_iommu;
> +
> +       group =3D iommu_group_get(dev);
> +       if (!group)
> +               return NULL;
> +       iommu_dev =3D iommu_group_get_iommudata(group);
> +       rk_iommu =3D dev_get_drvdata(iommu_dev);
> +       iommu_group_put(group);
> +
> +       return rk_iommu;
> +}
> +
> +static int rk_iommu_attach_device(struct iommu_domain *domain,
> +                                 struct device *dev)
> +{
> +       struct rk_iommu *iommu;
> +       struct rk_iommu_domain *rk_domain =3D domain->priv;
> +       unsigned long flags;
> +       int ret;
> +       phys_addr_t dte_addr;
> +
> +       /*
> +        * Allow 'virtual devices' (e.g., drm) to attach to domain.
> +        * Such a device does not belong to an iommu group.
> +        */
> +       iommu =3D rk_iommu_from_dev(dev);
> +       if (!iommu)
> +               return 0;
> +
> +       ret =3D rk_iommu_enable_stall(iommu);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D rk_iommu_force_reset(iommu);
> +       if (ret)
> +               return ret;
> +
> +       iommu->domain =3D domain;
> +
> +       ret =3D devm_request_irq(dev, iommu->irq, rk_iommu_irq,
> +                              IRQF_SHARED, dev_name(dev), iommu);
> +       if (ret)
> +               return ret;
> +
> +       dte_addr =3D virt_to_phys(rk_domain->dt);
> +       rk_iommu_write(iommu, RK_MMU_DTE_ADDR, dte_addr);
> +       rk_iommu_command(iommu, RK_MMU_CMD_ZAP_CACHE);
> +       rk_iommu_write(iommu, RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
> +
> +       ret =3D rk_iommu_enable_paging(iommu);
> +       if (ret)
> +               return ret;
> +
> +       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
> +       list_add_tail(&iommu->node, &rk_domain->iommus);
> +       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> +
> +       dev_info(dev, "Attached to iommu domain\n");
> +
> +       rk_iommu_disable_stall(iommu);
> +
> +       return 0;
> +}
> +
> +static void rk_iommu_detach_device(struct iommu_domain *domain,
> +                                  struct device *dev)
> +{
> +       struct rk_iommu *iommu;
> +       struct rk_iommu_domain *rk_domain =3D domain->priv;
> +       unsigned long flags;
> +
> +       /* Allow 'virtual devices' (eg drm) to detach from domain */
> +       iommu =3D rk_iommu_from_dev(dev);
> +       if (!iommu)
> +               return;
> +
> +       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
> +       list_del_init(&iommu->node);
> +       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
> +
> +       /* Ignore error while disabling, just keep going */
> +       rk_iommu_enable_stall(iommu);
> +       rk_iommu_disable_paging(iommu);
> +       rk_iommu_write(iommu, RK_MMU_INT_MASK, 0);
> +       rk_iommu_write(iommu, RK_MMU_DTE_ADDR, 0);
> +       rk_iommu_disable_stall(iommu);
> +
> +       devm_free_irq(dev, iommu->irq, iommu);
> +
> +       iommu->domain =3D NULL;
> +
> +       dev_info(dev, "Detached from iommu domain\n");
> +}
> +
> +static int rk_iommu_domain_init(struct iommu_domain *domain)
> +{
> +       struct rk_iommu_domain *rk_domain;
> +
> +       rk_domain =3D kzalloc(sizeof(*rk_domain), GFP_KERNEL);
> +       if (!rk_domain)
> +               return -ENOMEM;
> +
> +       /*
> +        * rk32xx iommus use a 2 level pagetable.
> +        * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries=
.
> +        * Allocate one 4 KiB page for each table.
> +        */
> +       rk_domain->dt =3D (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
> +       if (!rk_domain->dt)
> +               goto err_dt;
> +
> +       rk_table_flush(rk_domain->dt, NUM_DT_ENTRIES);
> +
> +       spin_lock_init(&rk_domain->iommus_lock);
> +       spin_lock_init(&rk_domain->dt_lock);
> +       INIT_LIST_HEAD(&rk_domain->iommus);
> +
> +       domain->priv =3D rk_domain;
> +
> +       return 0;
> +err_dt:
> +       kfree(rk_domain);
> +       return -ENOMEM;
> +}
> +
> +static void rk_iommu_domain_destroy(struct iommu_domain *domain)
> +{
> +       struct rk_iommu_domain *rk_domain =3D domain->priv;
> +       int i;
> +
> +       WARN_ON(!list_empty(&rk_domain->iommus));
> +
> +       for (i =3D 0; i < NUM_DT_ENTRIES; i++) {
> +               u32 dte =3D rk_domain->dt[i];
> +               if (rk_dte_is_pt_valid(dte)) {
> +                       phys_addr_t pt_phys =3D rk_dte_pt_address(dte);
> +                       u32 *page_table =3D phys_to_virt(pt_phys);
> +                       free_page((unsigned long)page_table);
> +               }
> +       }
> +
> +       free_page((unsigned long)rk_domain->dt);
> +       kfree(domain->priv);
> +       domain->priv =3D NULL;
> +}
> +
> +static bool rk_iommu_is_dev_iommu_master(struct device *dev)
> +{
> +       struct device_node *np =3D dev->of_node;
> +       int ret;
> +
> +       /*
> +        * An iommu master has an iommus property containing a list of
> phandles
> +        * to iommu nodes, each with an #iommu-cells property with value =
0.
> +        */
> +       ret =3D of_count_phandle_with_args(np, "iommus", "#iommu-cells");
> +       return (ret > 0);
> +}
> +
> +static int rk_iommu_group_set_iommudata(struct iommu_group *group,
> +                                       struct device *dev)
> +{
> +       struct device_node *np =3D dev->of_node;
> +       struct platform_device *pd;
> +       int ret;
> +       struct of_phandle_args args;
> +
> +       /*
> +        * An iommu master has an iommus property containing a list of
> phandles
> +        * to iommu nodes, each with an #iommu-cells property with value =
0.
> +        */
> +       ret =3D of_parse_phandle_with_args(np, "iommus", "#iommu-cells", =
0,
> +                                        &args);
> +       if (ret) {
> +               dev_err(dev, "of_parse_phandle_with_args(%s) =3D> %d\n",
> +                       np->full_name, ret);
> +               return ret;
> +       }
> +       if (args.args_count !=3D 0) {
> +               dev_err(dev, "incorrect number of iommu params found for
> %s (found %d, expected 0)\n",
> +                       args.np->full_name, args.args_count);
> +               return -EINVAL;
> +       }
> +
> +       pd =3D of_find_device_by_node(args.np);
> +       of_node_put(args.np);
> +       if (!pd) {
> +               dev_err(dev, "iommu %s not found\n", args.np->full_name);
> +               return -EPROBE_DEFER;
> +       }
> +
> +       /* TODO(djkurtz): handle multiple slave iommus for a single maste=
r
> */
> +       iommu_group_set_iommudata(group, &pd->dev, NULL);
> +
> +       return 0;
> +}
> +
> +static int rk_iommu_add_device(struct device *dev)
> +{
> +       struct iommu_group *group;
> +       int ret;
> +
> +       if (!rk_iommu_is_dev_iommu_master(dev))
> +               return -ENODEV;
> +
> +       group =3D iommu_group_get(dev);
> +       if (!group) {
> +               group =3D iommu_group_alloc();
> +               if (IS_ERR(group)) {
> +                       dev_err(dev, "Failed to allocate IOMMU group\n");
> +                       return PTR_ERR(group);
> +               }
> +       }
> +
> +       ret =3D iommu_group_add_device(group, dev);
> +       if (ret)
> +               goto err_put_group;
> +
> +       ret =3D rk_iommu_group_set_iommudata(group, dev);
> +       if (ret)
> +               goto err_remove_device;
> +
> +       iommu_group_put(group);
> +
> +       return 0;
> +
> +err_remove_device:
> +       iommu_group_remove_device(dev);
> +err_put_group:
> +       iommu_group_put(group);
> +       return ret;
> +}
> +
> +static void rk_iommu_remove_device(struct device *dev)
> +{
> +       if (!rk_iommu_is_dev_iommu_master(dev))
> +               return;
> +
> +       iommu_group_remove_device(dev);
> +}
> +
> +static const struct iommu_ops rk_iommu_ops =3D {
> +       .domain_init =3D rk_iommu_domain_init,
> +       .domain_destroy =3D rk_iommu_domain_destroy,
> +       .attach_dev =3D rk_iommu_attach_device,
> +       .detach_dev =3D rk_iommu_detach_device,
> +       .map =3D rk_iommu_map,
> +       .unmap =3D rk_iommu_unmap,
> +       .add_device =3D rk_iommu_add_device,
> +       .remove_device =3D rk_iommu_remove_device,
> +       .iova_to_phys =3D rk_iommu_iova_to_phys,
> +       .pgsize_bitmap =3D RK_IOMMU_PGSIZE_BITMAP,
> +};
> +
> +static int rk_iommu_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct rk_iommu *iommu;
> +       struct resource *res;
> +
> +       iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
> +       if (!iommu)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, iommu);
> +       iommu->dev =3D dev;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       iommu->base =3D devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(iommu->base))
> +               return PTR_ERR(iommu->base);
> +
> +       iommu->irq =3D platform_get_irq(pdev, 0);
> +       if (iommu->irq < 0) {
> +               dev_err(dev, "Failed to get IRQ, %d\n", iommu->irq);
> +               return -ENXIO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rk_iommu_remove(struct platform_device *pdev)
> +{
> +       return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id rk_iommu_dt_ids[] =3D {
> +       { .compatible =3D "rockchip,iommu" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
> +#endif
> +
> +static struct platform_driver rk_iommu_driver =3D {
> +       .probe =3D rk_iommu_probe,
> +       .remove =3D rk_iommu_remove,
> +       .driver =3D {
> +                  .name =3D "rk_iommu",
> +                  .owner =3D THIS_MODULE,
> +                  .of_match_table =3D of_match_ptr(rk_iommu_dt_ids),
> +       },
> +};
> +
> +static int __init rk_iommu_init(void)
> +{
> +       int ret;
> +
> +       ret =3D bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
> +       if (ret)
> +               return ret;
> +
> +       return platform_driver_register(&rk_iommu_driver);
> +}
> +static void __exit rk_iommu_exit(void)
> +{
> +       platform_driver_unregister(&rk_iommu_driver);
> +}
> +
> +subsys_initcall(rk_iommu_init);
> +module_exit(rk_iommu_exit);
> +
> +MODULE_DESCRIPTION("IOMMU API for Rockchip");
> +MODULE_AUTHOR("Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org> and Daniel Kurtz <
> djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>");
> +MODULE_ALIAS("platform:rockchip-iommu");
> +MODULE_LICENSE("GPL v2");
> --
> 2.1.0.rc2.206.gedb03e5
>
>

--bcaec511e5faa592b30506801d70
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Heiko,</p>
<p dir=3D"ltr">Does this version work for you on 3.18-rc1?</p>
<div class=3D"gmail_quote">On Oct 27, 2014 8:44 PM, &quot;Daniel Kurtz&quot=
; &lt;<a href=3D"mailto:djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt; =
wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">The rk3288 ha=
s several iommus.=C2=A0 Each iommu belongs to a single master<br>
device.=C2=A0 There is one device (ISP) that has two slave iommus, but that=
<br>
case is not yet supported by this driver.<br>
<br>
At subsys init, the iommu driver registers itself as the iommu driver for<b=
r>
the platform bus.=C2=A0 The master devices find their slave iommus using th=
e<br>
&quot;iommus&quot; field in their devicetree description.=C2=A0 Since each =
slave iommu<br>
belongs to exactly one master, their is no additional data needed at probe<=
br>
to associate a slave with its master.<br>
<br>
An iommu device&#39;s power domain, clock and irq are all shared with its<b=
r>
master device, and the master device must be careful to attach from the<br>
iommu only after powering and clocking it (and leave it powered and<br>
clocked before detaching).=C2=A0 Because their is no guarantee what the sta=
tus<br>
of the iommu is at probe, and since the driver does not even know if the<br=
>
device is powered, we delay requesting its irq until the master device<br>
attaches, at which point we have a guarantee that the device is powered<br>
and clocked and we can reset it and disable its interrupt mask.<br>
<br>
An iommu_domain describes a virtual iova address space.=C2=A0 Each iommu_do=
main<br>
has a corresponding page table that lists the mappings from iova to<br>
physical address.<br>
<br>
For the rk3288 iommu, the page table has two levels:<br>
=C2=A0The Level 1 &quot;directory_table&quot; has 1024 4-byte dte entries.<=
br>
=C2=A0Each dte points to a level 2 &quot;page_table&quot;.<br>
=C2=A0Each level 2 page_table has 1024 4-byte pte entries.<br>
=C2=A0Each pte points to a 4 KiB page of memory.<br>
<br>
An iommu_domain is created when a dma_iommu_mapping is created via<br>
arm_iommu_create_mapping.=C2=A0 Master devices can then attach themselves t=
o<br>
this mapping (or attach the mapping to themselves?) by calling<br>
arm_iommu_attach_device().=C2=A0 This in turn instructs the iommu driver to=
<br>
write the page table&#39;s physical address into the slave iommu&#39;s &quo=
t;Directory<br>
Table Entry&quot; (DTE) register.<br>
<br>
In fact multiple master devices, each with their own slave iommu device,<br=
>
can all attach to the same mapping.=C2=A0 The iommus for these devices will=
<br>
share the same iommu_domain and therefore point to the same page table.<br>
Thus, the iommu domain maintains a list of iommu devices which are<br>
attached.=C2=A0 This driver relies on the iommu core to ensure that all dev=
ices<br>
have detached before destroying a domain.<br>
<br>
Changes in v6:<br>
=C2=A0 - add .add/remove_device() callbacks.<br>
=C2=A0 - parse platform_device device tree nodes for &quot;iommus&quot; pro=
perty<br>
=C2=A0 - store platform device pointer as group iommudata<br>
=C2=A0 - Check for existence of iommu group instead of relying on a<br>
=C2=A0 =C2=A0 dev_get_drvdata() to return NULL for a NULL device.<br>
<br>
Signed-off-by: Daniel Kurtz &lt;<a href=3D"mailto:djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">djk=
urtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
Signed-off-by: Simon Xue &lt;<a href=3D"mailto:xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org">xxm@rock=
-chips.com</a>&gt;<br>
Reviewed-by: Grant Grundler &lt;<a href=3D"mailto:grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">gr=
undler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
Reviewed-by: St=C3=A9phane Marchesin &lt;<a href=3D"mailto:marcheu@chromium=
.org">marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/iommu/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A012 +<br>
=C2=A0drivers/iommu/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 1 +<br>
=C2=A0drivers/iommu/rockchip-iommu.c | 1038 +++++++++++++++++++++++++++++++=
+++++++++<br>
=C2=A03 files changed, 1051 insertions(+)<br>
=C2=A0create mode 100644 drivers/iommu/rockchip-iommu.c<br>
<br>
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig<br>
index dd51122..d0a1261 100644<br>
--- a/drivers/iommu/Kconfig<br>
+++ b/drivers/iommu/Kconfig<br>
@@ -152,6 +152,18 @@ config OMAP_IOMMU_DEBUG<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say N unless you know you need this.<br>
<br>
+config ROCKCHIP_IOMMU<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Rockchip IOMMU Support&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on ARCH_ROCKCHIP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0select IOMMU_API<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0select ARM_DMA_USE_IOMMU<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Support for IOMMUs found on Rockchip rk3=
2xx SOCs.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0These IOMMUs allow virtualization of the=
 address space used by most<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cores within the multimedia subsystem.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y here if you are using a Rockchip S=
oC that includes an IOMMU<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device.<br>
+<br>
=C2=A0config TEGRA_IOMMU_GART<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Tegra GART IOMMU Support&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 depends on ARCH_TEGRA_2x_SOC<br>
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile<br>
index 16edef7..3e47ef3 100644<br>
--- a/drivers/iommu/Makefile<br>
+++ b/drivers/iommu/Makefile<br>
@@ -13,6 +13,7 @@ obj-$(CONFIG_IRQ_REMAP) +=3D intel_irq_remapping.o irq_re=
mapping.o<br>
=C2=A0obj-$(CONFIG_OMAP_IOMMU) +=3D omap-iommu.o<br>
=C2=A0obj-$(CONFIG_OMAP_IOMMU) +=3D omap-iommu2.o<br>
=C2=A0obj-$(CONFIG_OMAP_IOMMU_DEBUG) +=3D omap-iommu-debug.o<br>
+obj-$(CONFIG_ROCKCHIP_IOMMU) +=3D rockchip-iommu.o<br>
=C2=A0obj-$(CONFIG_TEGRA_IOMMU_GART) +=3D tegra-gart.o<br>
=C2=A0obj-$(CONFIG_TEGRA_IOMMU_SMMU) +=3D tegra-smmu.o<br>
=C2=A0obj-$(CONFIG_EXYNOS_IOMMU) +=3D exynos-iommu.o<br>
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.=
c<br>
new file mode 100644<br>
index 0000000..61d6f87<br>
--- /dev/null<br>
+++ b/drivers/iommu/rockchip-iommu.c<br>
@@ -0,0 +1,1038 @@<br>
+/*<br>
+ * This program is free software; you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License version 2 as<br>
+ * published by the Free Software Foundation.<br>
+ */<br>
+<br>
+#include &lt;asm/cacheflush.h&gt;<br>
+#include &lt;asm/pgtable.h&gt;<br>
+#include &lt;linux/compiler.h&gt;<br>
+#include &lt;linux/delay.h&gt;<br>
+#include &lt;linux/device.h&gt;<br>
+#include &lt;linux/errno.h&gt;<br>
+#include &lt;linux/interrupt.h&gt;<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/iommu.h&gt;<br>
+#include &lt;linux/jiffies.h&gt;<br>
+#include &lt;linux/list.h&gt;<br>
+#include &lt;linux/mm.h&gt;<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/of.h&gt;<br>
+#include &lt;linux/of_platform.h&gt;<br>
+#include &lt;linux/platform_device.h&gt;<br>
+#include &lt;linux/slab.h&gt;<br>
+#include &lt;linux/spinlock.h&gt;<br>
+<br>
+/** MMU register offsets */<br>
+#define RK_MMU_DTE_ADDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x00=C2=A0 =C2=A0 /* Directory table address */<br>
+#define RK_MMU_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
+#define RK_MMU_COMMAND=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>
+#define RK_MMU_PAGE_FAULT_ADDR 0x0C=C2=A0 =C2=A0 /* IOVA of last page faul=
t */<br>
+#define RK_MMU_ZAP_ONE_LINE=C2=A0 =C2=A0 0x10=C2=A0 =C2=A0 /* Shootdown on=
e IOTLB entry */<br>
+#define RK_MMU_INT_RAWSTAT=C2=A0 =C2=A0 =C2=A00x14=C2=A0 =C2=A0 /* IRQ sta=
tus ignoring mask */<br>
+#define RK_MMU_INT_CLEAR=C2=A0 =C2=A0 =C2=A0 =C2=A00x18=C2=A0 =C2=A0 /* Ac=
knowledge and re-arm irq */<br>
+#define RK_MMU_INT_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 0x1C=C2=A0 =C2=A0 /* IRQ enable */<br>
+#define RK_MMU_INT_STATUS=C2=A0 =C2=A0 =C2=A0 0x20=C2=A0 =C2=A0 /* IRQ sta=
tus after masking */<br>
+#define RK_MMU_AUTO_GATING=C2=A0 =C2=A0 =C2=A00x24<br>
+<br>
+#define DTE_ADDR_DUMMY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xCAFEBABE<br>
+#define FORCE_RESET_TIMEOUT=C2=A0 =C2=A0 100=C2=A0 =C2=A0 =C2=A0/* ms */<b=
r>
+<br>
+/* RK_MMU_STATUS fields */<br>
+#define RK_MMU_STATUS_PAGING_ENABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+#define RK_MMU_STATUS_PAGE_FAULT_ACTIVE=C2=A0 =C2=A0 BIT(1)<br>
+#define RK_MMU_STATUS_STALL_ACTIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(2)=
<br>
+#define RK_MMU_STATUS_IDLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0BIT(3)<br>
+#define RK_MMU_STATUS_REPLAY_BUFFER_EMPTY=C2=A0 BIT(4)<br>
+#define RK_MMU_STATUS_PAGE_FAULT_IS_WRITE=C2=A0 BIT(5)<br>
+#define RK_MMU_STATUS_STALL_NOT_ACTIVE=C2=A0 =C2=A0 =C2=A0BIT(31)<br>
+<br>
+/* RK_MMU_COMMAND command values */<br>
+#define RK_MMU_CMD_ENABLE_PAGING=C2=A0 =C2=A0 0=C2=A0 /* Enable memory tra=
nslation */<br>
+#define RK_MMU_CMD_DISABLE_PAGING=C2=A0 =C2=A01=C2=A0 /* Disable memory tr=
anslation */<br>
+#define RK_MMU_CMD_ENABLE_STALL=C2=A0 =C2=A0 =C2=A02=C2=A0 /* Stall paging=
 to allow other cmds */<br>
+#define RK_MMU_CMD_DISABLE_STALL=C2=A0 =C2=A0 3=C2=A0 /* Stop stall re-ena=
bles paging */<br>
+#define RK_MMU_CMD_ZAP_CACHE=C2=A0 =C2=A0 =C2=A0 =C2=A0 4=C2=A0 /* Shoot d=
own entire IOTLB */<br>
+#define RK_MMU_CMD_PAGE_FAULT_DONE=C2=A0 5=C2=A0 /* Clear page fault */<br=
>
+#define RK_MMU_CMD_FORCE_RESET=C2=A0 =C2=A0 =C2=A0 6=C2=A0 /* Reset all re=
gisters */<br>
+<br>
+/* RK_MMU_INT_* register fields */<br>
+#define RK_MMU_IRQ_PAGE_FAULT=C2=A0 =C2=A0 0x01=C2=A0 /* page fault */<br>
+#define RK_MMU_IRQ_BUS_ERROR=C2=A0 =C2=A0 =C2=A00x02=C2=A0 /* bus read err=
or */<br>
+#define RK_MMU_IRQ_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (RK_MMU_IRQ_PAGE=
_FAULT | RK_MMU_IRQ_BUS_ERROR)<br>
+<br>
+#define NUM_DT_ENTRIES 1024<br>
+#define NUM_PT_ENTRIES 1024<br>
+<br>
+#define SPAGE_ORDER 12<br>
+#define SPAGE_SIZE (1 &lt;&lt; SPAGE_ORDER)<br>
+<br>
+ /*<br>
+=C2=A0 * Support mapping any size that fits in one page table:<br>
+=C2=A0 *=C2=A0 =C2=A04 KiB to 4 MiB<br>
+=C2=A0 */<br>
+#define RK_IOMMU_PGSIZE_BITMAP 0x007ff000<br>
+<br>
+#define IOMMU_REG_POLL_COUNT_FAST 1000<br>
+<br>
+struct rk_iommu_domain {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head iommus;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *dt; /* page directory table */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t iommus_lock; /* lock for iommus list=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spinlock_t dt_lock; /* lock for modifying page =
directory table */<br>
+};<br>
+<br>
+struct rk_iommu {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void __iomem *base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int irq;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head node; /* entry in rk_iommu_dom=
ain.iommus */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iommu_domain *domain; /* domain to which=
 iommu is attached */<br>
+};<br>
+<br>
+static inline void rk_table_flush(u32 *va, unsigned int count)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t pa_start =3D virt_to_phys(va);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t pa_end =3D virt_to_phys(va + count)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t size =3D pa_end - pa_start;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__cpuc_flush_dcache_area(va, size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0outer_flush_range(pa_start, pa_end);<br>
+}<br>
+<br>
+/**<br>
+ * Inspired by _wait_for in intel_drv.h<br>
+ * This is NOT safe for use in interrupt context.<br>
+ *<br>
+ * Note that it&#39;s important that we check the condition again after ha=
ving<br>
+ * timed out, since the timeout could be due to preemption or similar and<=
br>
+ * we&#39;ve never had a chance to check the condition before the timeout.=
<br>
+ */<br>
+#define rk_wait_for(COND, MS) ({ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout__ =3D jiffies + msecs_to_=
jiffies(MS) + 1;=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret__ =3D 0;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while (!(COND)) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (time_after(jiff=
ies, timeout__)) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret__ =3D (COND) ? 0 : -ETIMEDOUT;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usleep_range(50, 10=
0);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret__;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 \<br>
+})<br>
+<br>
+/*<br>
+ * The Rockchip rk3288 iommu uses a 2-level page table.<br>
+ * The first level is the &quot;Directory Table&quot; (DT).<br>
+ * The DT consists of 1024 4-byte Directory Table Entries (DTEs), each poi=
nting<br>
+ * to a &quot;Page Table&quot;.<br>
+ * The second level is the 1024 Page Tables (PT).<br>
+ * Each PT consists of 1024 4-byte Page Table Entries (PTEs), each pointin=
g to<br>
+ * a 4 KB page of physical memory.<br>
+ *<br>
+ * The DT and each PT fits in a single 4 KB page (4-bytes * 1024 entries).=
<br>
+ * Each iommu device has a MMU_DTE_ADDR register that contains the physica=
l<br>
+ * address of the start of the DT page.<br>
+ *<br>
+ * The structure of the page table is as follows:<br>
+ *<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DT<=
br>
+ * MMU_DTE_ADDR -&gt; +-----+<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 =C2=A0|<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-----+=C2=
=A0 =C2=A0 =C2=A0PT<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| DTE | -&=
gt; +-----+<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-----+=C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0Memory<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 +-----+=C2=A0 =C2=A0 =C2=A0Page<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 | PTE | -&gt; +-----+<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-----+=C2=
=A0 =C2=A0 +-----+=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0|<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 =C2=A0|<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 =C2=A0|<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 +-----+=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0|<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 =C2=A0|<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 =C2=A0|<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-----=
+<br>
+ */<br>
+<br>
+/*<br>
+ * Each DTE has a PT address and a valid bit:<br>
+ * +---------------------+-----------+-+<br>
+ * | PT address=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Reserved=C2=A0 |V|<br>
+ * +---------------------+-----------+-+<br>
+ *=C2=A0 31:12 - PT address (PTs always starts on a 4 KB boundary)<br>
+ *=C2=A0 11: 1 - Reserved<br>
+ *=C2=A0 =C2=A0 =C2=A0 0 - 1 if PT @ PT address is valid<br>
+ */<br>
+#define RK_DTE_PT_ADDRESS_MASK=C2=A0 =C2=A0 0xfffff000<br>
+#define RK_DTE_PT_VALID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+<br>
+static inline phys_addr_t rk_dte_pt_address(u32 dte)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (phys_addr_t)dte &amp; RK_DTE_PT_ADDRESS=
_MASK;<br>
+}<br>
+<br>
+static inline bool rk_dte_is_pt_valid(u32 dte)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return dte &amp; RK_DTE_PT_VALID;<br>
+}<br>
+<br>
+static u32 rk_mk_dte(u32 *pt)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t pt_phys =3D virt_to_phys(pt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (pt_phys &amp; RK_DTE_PT_ADDRESS_MASK) |=
 RK_DTE_PT_VALID;<br>
+}<br>
+<br>
+/*<br>
+ * Each PTE has a Page address, some flags and a valid bit:<br>
+ * +---------------------+---+-------+-+<br>
+ * | Page address=C2=A0 =C2=A0 =C2=A0 =C2=A0 |Rsv| Flags |V|<br>
+ * +---------------------+---+-------+-+<br>
+ *=C2=A0 31:12 - Page address (Pages always start on a 4 KB boundary)<br>
+ *=C2=A0 11: 9 - Reserved<br>
+ *=C2=A0 =C2=A08: 1 - Flags<br>
+ *=C2=A0 =C2=A0 =C2=A0 8 - Read allocate - allocate cache space on read mi=
sses<br>
+ *=C2=A0 =C2=A0 =C2=A0 7 - Read cache - enable cache &amp; prefetch of dat=
a<br>
+ *=C2=A0 =C2=A0 =C2=A0 6 - Write buffer - enable delaying writes on their =
way to memory<br>
+ *=C2=A0 =C2=A0 =C2=A0 5 - Write allocate - allocate cache space on write =
misses<br>
+ *=C2=A0 =C2=A0 =C2=A0 4 - Write cache - different writes can be merged to=
gether<br>
+ *=C2=A0 =C2=A0 =C2=A0 3 - Override cache attributes<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if 1, bits 4-8 control cache attribut=
es<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if 0, the system bus defaults are use=
d<br>
+ *=C2=A0 =C2=A0 =C2=A0 2 - Writable<br>
+ *=C2=A0 =C2=A0 =C2=A0 1 - Readable<br>
+ *=C2=A0 =C2=A0 =C2=A0 0 - 1 if Page @ Page address is valid<br>
+ */<br>
+#define RK_PTE_PAGE_ADDRESS_MASK=C2=A0 0xfffff000<br>
+#define RK_PTE_PAGE_FLAGS_MASK=C2=A0 =C2=A0 0x000001fe<br>
+#define RK_PTE_PAGE_WRITABLE=C2=A0 =C2=A0 =C2=A0 BIT(2)<br>
+#define RK_PTE_PAGE_READABLE=C2=A0 =C2=A0 =C2=A0 BIT(1)<br>
+#define RK_PTE_PAGE_VALID=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(0)<br>
+<br>
+static inline phys_addr_t rk_pte_page_address(u32 pte)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (phys_addr_t)pte &amp; RK_PTE_PAGE_ADDRE=
SS_MASK;<br>
+}<br>
+<br>
+static inline bool rk_pte_is_page_valid(u32 pte)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return pte &amp; RK_PTE_PAGE_VALID;<br>
+}<br>
+<br>
+/* TODO: set cache flags per prot IOMMU_CACHE */<br>
+static u32 rk_mk_pte(phys_addr_t page, int prot)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 flags =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D (prot &amp; IOMMU_READ) ? RK_PTE_PAG=
E_READABLE : 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D (prot &amp; IOMMU_WRITE) ? RK_PTE_PA=
GE_WRITABLE : 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0page &amp;=3D RK_PTE_PAGE_ADDRESS_MASK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return page | flags | RK_PTE_PAGE_VALID;<br>
+}<br>
+<br>
+static u32 rk_mk_pte_invalid(u32 pte)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return pte &amp; ~RK_PTE_PAGE_VALID;<br>
+}<br>
+<br>
+/*<br>
+ * rk3288 iova (IOMMU Virtual Address) format<br>
+ *=C2=A0 31=C2=A0 =C2=A0 =C2=A0 =C2=A022.21=C2=A0 =C2=A0 =C2=A0 =C2=A012.1=
1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
+ * +-----------+-----------+-------------+<br>
+ * | DTE index | PTE index | Page offset |<br>
+ * +-----------+-----------+-------------+<br>
+ *=C2=A0 31:22 - DTE index=C2=A0 =C2=A0- index of DTE in DT<br>
+ *=C2=A0 21:12 - PTE index=C2=A0 =C2=A0- index of PTE in PT @ DTE.pt_addre=
ss<br>
+ *=C2=A0 11: 0 - Page offset - offset into page @ PTE.page_address<br>
+ */<br>
+#define RK_IOVA_DTE_MASK=C2=A0 =C2=A0 0xffc00000<br>
+#define RK_IOVA_DTE_SHIFT=C2=A0 =C2=A022<br>
+#define RK_IOVA_PTE_MASK=C2=A0 =C2=A0 0x003ff000<br>
+#define RK_IOVA_PTE_SHIFT=C2=A0 =C2=A012<br>
+#define RK_IOVA_PAGE_MASK=C2=A0 =C2=A00x00000fff<br>
+#define RK_IOVA_PAGE_SHIFT=C2=A0 0<br>
+<br>
+static u32 rk_iova_dte_index(dma_addr_t iova)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (u32)(iova &amp; RK_IOVA_DTE_MASK) &gt;&=
gt; RK_IOVA_DTE_SHIFT;<br>
+}<br>
+<br>
+static u32 rk_iova_pte_index(dma_addr_t iova)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (u32)(iova &amp; RK_IOVA_PTE_MASK) &gt;&=
gt; RK_IOVA_PTE_SHIFT;<br>
+}<br>
+<br>
+static u32 rk_iova_page_offset(dma_addr_t iova)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (u32)(iova &amp; RK_IOVA_PAGE_MASK) &gt;=
&gt; RK_IOVA_PAGE_SHIFT;<br>
+}<br>
+<br>
+static u32 rk_iommu_read(struct rk_iommu *iommu, u32 offset)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return readl(iommu-&gt;base + offset);<br>
+}<br>
+<br>
+static void rk_iommu_write(struct rk_iommu *iommu, u32 offset, u32 value)<=
br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(value, iommu-&gt;base + offset);<br>
+}<br>
+<br>
+static void rk_iommu_command(struct rk_iommu *iommu, u32 command)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0writel(command, iommu-&gt;base + RK_MMU_COMMAND=
);<br>
+}<br>
+<br>
+static void rk_iommu_zap_lines(struct rk_iommu *iommu, dma_addr_t iova,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t iova_end =3D iova + size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * TODO(djkurtz): Figure out when it is more ef=
ficient to shootdown the<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * entire iotlb rather than iterate over indivi=
dual iovas.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (; iova &lt; iova_end; iova +=3D SPAGE_SIZE=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_write(iomm=
u, RK_MMU_ZAP_ONE_LINE, iova);<br>
+}<br>
+<br>
+static bool rk_iommu_is_stall_active(struct rk_iommu *iommu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rk_iommu_read(iommu, RK_MMU_STATUS) &amp=
; RK_MMU_STATUS_STALL_ACTIVE;<br>
+}<br>
+<br>
+static bool rk_iommu_is_paging_enabled(struct rk_iommu *iommu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rk_iommu_read(iommu, RK_MMU_STATUS) &amp=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 RK_MMU_STATUS_PAGING_ENABLED;<br>
+}<br>
+<br>
+static int rk_iommu_enable_stall(struct rk_iommu *iommu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rk_iommu_is_stall_active(iommu))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Stall can only be enabled if paging is enabl=
ed */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_iommu_is_paging_enabled(iommu))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_STALL=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_wait_for(rk_iommu_is_stall_active(io=
mmu), 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;Enable stall request timed out, status: %#08x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rk_iommu_read(iommu, RK_MMU_STATUS));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static int rk_iommu_disable_stall(struct rk_iommu *iommu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_iommu_is_stall_active(iommu))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_STAL=
L);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_wait_for(!rk_iommu_is_stall_active(i=
ommu), 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;Disable stall request timed out, status: %#08x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rk_iommu_read(iommu, RK_MMU_STATUS));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static int rk_iommu_enable_paging(struct rk_iommu *iommu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rk_iommu_is_paging_enabled(iommu))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_command(iommu, RK_MMU_CMD_ENABLE_PAGIN=
G);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_wait_for(rk_iommu_is_paging_enabled(=
iommu), 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;Enable paging request timed out, status: %#08x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rk_iommu_read(iommu, RK_MMU_STATUS));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static int rk_iommu_disable_paging(struct rk_iommu *iommu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_iommu_is_paging_enabled(iommu))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_command(iommu, RK_MMU_CMD_DISABLE_PAGI=
NG);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_wait_for(!rk_iommu_is_paging_enabled=
(iommu), 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;Disable paging request timed out, status: #%08x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0rk_iommu_read(iommu, RK_MMU_STATUS));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static int rk_iommu_force_reset(struct rk_iommu *iommu)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dte_addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Check if register DTE_ADDR is working by wri=
ting DTE_ADDR_DUMMY<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * and verifying that upper 5 nybbles are read =
back.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_write(iommu, RK_MMU_DTE_ADDR, DTE_ADDR=
_DUMMY);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte_addr =3D rk_iommu_read(iommu, RK_MMU_DTE_AD=
DR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dte_addr !=3D (DTE_ADDR_DUMMY &amp; RK_DTE_=
PT_ADDRESS_MASK)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;Error during raw reset. MMU_DTE_ADDR is not functioning\n&quot;);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_command(iommu, RK_MMU_CMD_FORCE_RESET)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_wait_for(rk_iommu_read(iommu, RK_MMU=
_DTE_ADDR) =3D=3D 0x00000000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0FORCE_RESET_TIMEOUT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;FORCE_RESET command timed out\n&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static void log_iova(struct rk_iommu *iommu, dma_addr_t iova)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dte_index, pte_index, page_offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 mmu_dte_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t mmu_dte_addr_phys, dte_addr_phys;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *dte_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dte;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t pte_addr_phys =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *pte_addr =3D NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 pte =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t page_addr_phys =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 page_flags =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte_index =3D rk_iova_dte_index(iova);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pte_index =3D rk_iova_pte_index(iova);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0page_offset =3D rk_iova_page_offset(iova);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mmu_dte_addr =3D rk_iommu_read(iommu, RK_MMU_DT=
E_ADDR);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mmu_dte_addr_phys =3D (phys_addr_t)mmu_dte_addr=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte_addr_phys =3D mmu_dte_addr_phys + (4 * dte_=
index);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte_addr =3D phys_to_virt(dte_addr_phys);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte =3D *dte_addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_dte_is_pt_valid(dte))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto print_it;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pte_addr_phys =3D rk_dte_pt_address(dte) + (pte=
_index * 4);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pte_addr =3D phys_to_virt(pte_addr_phys);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pte =3D *pte_addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_pte_is_page_valid(pte))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto print_it;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0page_addr_phys =3D rk_pte_page_address(pte) + p=
age_offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0page_flags =3D pte &amp; RK_PTE_PAGE_FLAGS_MASK=
;<br>
+<br>
+print_it:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;dev, &quot;iova =3D %pad: dte=
_index: 0x%03x pte_index: 0x%03x page_offset: 0x%03x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;iova, dte_inde=
x, pte_index, page_offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;dev, &quot;mmu_dte_addr: %pa =
dte@%pa: %#08x valid: %u pte@%pa: %#08x valid: %u page@%pa flags: %#03x\n&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;mmu_dte_addr_p=
hys, &amp;dte_addr_phys, dte,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rk_dte_is_pt_valid(=
dte), &amp;pte_addr_phys, pte,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rk_pte_is_page_vali=
d(pte), &amp;page_addr_phys, page_flags);<br>
+}<br>
+<br>
+static irqreturn_t rk_iommu_irq(int irq, void *dev_id)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu *iommu =3D dev_id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 int_status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t iova;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int_status =3D rk_iommu_read(iommu, RK_MMU_INT_=
STATUS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (int_status =3D=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova =3D rk_iommu_read(iommu, RK_MMU_PAGE_FAULT=
_ADDR);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (int_status &amp; RK_MMU_IRQ_PAGE_FAULT) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D rk_iommu=
_read(iommu, RK_MMU_STATUS);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags =3D (status &=
amp; RK_MMU_STATUS_PAGE_FAULT_IS_WRITE) ?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;Page fault at %pad of type %s\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;iova,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(flags =3D=3D IOMMU_FAULT_WRITE) ? &quot;write&quot; : &quot;read=
&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_iova(iommu, iov=
a);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Report page faul=
t to any installed handlers.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Ignore the retur=
n code, though, since we always zap cache<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * and clear the pa=
ge fault anyway.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iommu-&gt;domai=
n)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0report_iommu_fault(iommu-&gt;domain, iommu-&gt;dev, iova,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f=
lags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err(iommu-&gt;dev, &quot;Page fault while iommu not attached =
to domain?\n&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_command(io=
mmu, RK_MMU_CMD_ZAP_CACHE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_command(io=
mmu, RK_MMU_CMD_PAGE_FAULT_DONE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (int_status &amp; RK_MMU_IRQ_BUS_ERROR)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;BUS_ERROR occurred at %pad\n&quot;, &amp;iova);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (int_status &amp; ~RK_MMU_IRQ_MASK)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(iommu-&gt;d=
ev, &quot;unexpected int_status: %#08x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int_status);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_write(iommu, RK_MMU_INT_CLEAR, int_sta=
tus);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HANDLED;<br>
+}<br>
+<br>
+static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_addr=
_t iova)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu_domain *rk_domain =3D domain-&g=
t;priv;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t pt_phys, phys =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dte, pte;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *page_table;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;rk_domain-&gt;dt_lock, f=
lags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte =3D rk_domain-&gt;dt[rk_iova_dte_index(iova=
)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_dte_is_pt_valid(dte))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pt_phys =3D rk_dte_pt_address(dte);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0page_table =3D (u32 *)phys_to_virt(pt_phys);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pte =3D page_table[rk_iova_pte_index(iova)];<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_pte_is_page_valid(pte))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys =3D rk_pte_page_address(pte) + rk_iova_pag=
e_offset(iova);<br>
+out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;rk_domain-&gt;dt_lo=
ck, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return phys;<br>
+}<br>
+<br>
+static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t iova, size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head *pos;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* shootdown these iova from all iommus using t=
his domain */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;rk_domain-&gt;iommus_loc=
k, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0list_for_each(pos, &amp;rk_domain-&gt;iommus) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu *io=
mmu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu =3D list_entr=
y(pos, struct rk_iommu, node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_zap_lines(=
iommu, iova, size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;rk_domain-&gt;iommu=
s_lock, flags);<br>
+}<br>
+<br>
+static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t iova)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *page_table, *dte_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dte;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t pt_phys;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&amp;rk_domain-&gt;dt_lock);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte_addr =3D &amp;rk_domain-&gt;dt[rk_iova_dte_=
index(iova)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte =3D *dte_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rk_dte_is_pt_valid(dte))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto done;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0page_table =3D (u32 *)get_zeroed_page(GFP_ATOMI=
C | GFP_DMA32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!page_table)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(-ENO=
MEM);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte =3D rk_mk_dte(page_table);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*dte_addr =3D dte;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_table_flush(page_table, NUM_PT_ENTRIES);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_table_flush(dte_addr, 1);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Zap the first iova of newly allocated page t=
able so iommu evicts<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * old cached value of new dte from the iotlb.<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_zap_iova(rk_domain, iova, SPAGE_SIZE);=
<br>
+<br>
+done:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pt_phys =3D rk_dte_pt_address(dte);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (u32 *)phys_to_virt(pt_phys);<br>
+}<br>
+<br>
+static size_t rk_iommu_unmap_iova(struct rk_iommu_domain *rk_domain,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *pte_addr, dma_addr_t iova=
, size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pte_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pte_total =3D size / SPAGE_SIZE;<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&amp;rk_domain-&gt;dt_lock);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (pte_count =3D 0; pte_count &lt; pte_total;=
 pte_count++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 pte =3D pte_add=
r[pte_count];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_pte_is_page=
_valid(pte))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pte_addr[pte_count]=
 =3D rk_mk_pte_invalid(pte);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_table_flush(pte_addr, pte_count);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return pte_count * SPAGE_SIZE;<br>
+}<br>
+<br>
+static int rk_iommu_map_iova(struct rk_iommu_domain *rk_domain, u32 *pte_a=
ddr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dma_addr_t iova, phys_addr_t paddr, size_t size,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int prot)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pte_count;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pte_total =3D size / SPAGE_SIZE;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t page_phys;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_spin_locked(&amp;rk_domain-&gt;dt_lock);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (pte_count =3D 0; pte_count &lt; pte_total;=
 pte_count++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 pte =3D pte_add=
r[pte_count];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rk_pte_is_page_=
valid(pte))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto unwind;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pte_addr[pte_count]=
 =3D rk_mk_pte(paddr, prot);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0paddr +=3D SPAGE_SI=
ZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_table_flush(pte_addr, pte_count);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+unwind:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Unmap the range of iovas that we just mapped=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_unmap_iova(rk_domain, pte_addr, iova, =
pte_count * SPAGE_SIZE);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iova +=3D pte_count * SPAGE_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0page_phys =3D rk_pte_page_address(pte_addr[pte_=
count]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;iova: %pad already mapped to %pa c=
annot remap to phys: %pa prot:%#x\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;iova, &amp;page_phys=
, &amp;paddr, prot);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EADDRINUSE;<br>
+}<br>
+<br>
+static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0phys_addr_t paddr, size_t size, int prot)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu_domain *rk_domain =3D domain-&g=
t;priv;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t iova =3D (dma_addr_t)_iova;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *page_table, *pte_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;rk_domain-&gt;dt_lock, f=
lags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * pgsize_bitmap specifies iova sizes that fit =
in one page table<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * (1024 4-KiB pages =3D 4 MiB).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * So, size will always be 4096 &lt;=3D size &l=
t;=3D 4194304.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Since iommu_map() guarantees that both iova =
and size will be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * aligned, we will always only be mapping from=
 a single dte here.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0page_table =3D rk_dte_get_page_table(rk_domain,=
 iova);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(page_table)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrest=
ore(&amp;rk_domain-&gt;dt_lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(page=
_table);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pte_addr =3D &amp;page_table[rk_iova_pte_index(=
iova)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_iommu_map_iova(rk_domain, pte_addr, =
iova, paddr, size, prot);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;rk_domain-&gt;dt_lo=
ck, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static size_t rk_iommu_unmap(struct iommu_domain *domain, unsigned long _i=
ova,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 size_t size)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu_domain *rk_domain =3D domain-&g=
t;priv;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_addr_t iova =3D (dma_addr_t)_iova;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t pt_phys;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dte;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *pte_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t unmap_size;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;rk_domain-&gt;dt_lock, f=
lags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * pgsize_bitmap specifies iova sizes that fit =
in one page table<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * (1024 4-KiB pages =3D 4 MiB).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * So, size will always be 4096 &lt;=3D size &l=
t;=3D 4194304.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Since iommu_unmap() guarantees that both iov=
a and size will be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * aligned, we will always only be unmapping fr=
om a single dte here.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte =3D rk_domain-&gt;dt[rk_iova_dte_index(iova=
)];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Just return 0 if iova is unmapped */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_dte_is_pt_valid(dte)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrest=
ore(&amp;rk_domain-&gt;dt_lock, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pt_phys =3D rk_dte_pt_address(dte);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pte_addr =3D (u32 *)phys_to_virt(pt_phys) + rk_=
iova_pte_index(iova);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unmap_size =3D rk_iommu_unmap_iova(rk_domain, p=
te_addr, iova, size);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;rk_domain-&gt;dt_lo=
ck, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Shootdown iotlb entries for iova range that =
was just unmapped */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_zap_iova(rk_domain, iova, unmap_size);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return unmap_size;<br>
+}<br>
+<br>
+static struct rk_iommu *rk_iommu_from_dev(struct device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iommu_group *group;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *iommu_dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu *rk_iommu;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0group =3D iommu_group_get(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!group)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_dev =3D iommu_group_get_iommudata(group);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu =3D dev_get_drvdata(iommu_dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_group_put(group);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return rk_iommu;<br>
+}<br>
+<br>
+static int rk_iommu_attach_device(struct iommu_domain *domain,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu *iommu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu_domain *rk_domain =3D domain-&g=
t;priv;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0phys_addr_t dte_addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Allow &#39;virtual devices&#39; (e.g., drm) =
to attach to domain.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Such a device does not belong to an iommu gr=
oup.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu =3D rk_iommu_from_dev(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iommu)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_iommu_enable_stall(iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_iommu_force_reset(iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;domain =3D domain;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D devm_request_irq(dev, iommu-&gt;irq, rk=
_iommu_irq,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_SHARED, dev_name(dev), iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dte_addr =3D virt_to_phys(rk_domain-&gt;dt);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_write(iommu, RK_MMU_DTE_ADDR, dte_addr=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_command(iommu, RK_MMU_CMD_ZAP_CACHE);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_write(iommu, RK_MMU_INT_MASK, RK_MMU_I=
RQ_MASK);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_iommu_enable_paging(iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;rk_domain-&gt;iommus_loc=
k, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0list_add_tail(&amp;iommu-&gt;node, &amp;rk_doma=
in-&gt;iommus);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;rk_domain-&gt;iommu=
s_lock, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot;Attached to iommu domain\n&=
quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_disable_stall(iommu);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static void rk_iommu_detach_device(struct iommu_domain *domain,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu *iommu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu_domain *rk_domain =3D domain-&g=
t;priv;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Allow &#39;virtual devices&#39; (eg drm) to =
detach from domain */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu =3D rk_iommu_from_dev(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iommu)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;rk_domain-&gt;iommus_loc=
k, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0list_del_init(&amp;iommu-&gt;node);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;rk_domain-&gt;iommu=
s_lock, flags);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Ignore error while disabling, just keep goin=
g */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_enable_stall(iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_disable_paging(iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_write(iommu, RK_MMU_INT_MASK, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_write(iommu, RK_MMU_DTE_ADDR, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_iommu_disable_stall(iommu);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0devm_free_irq(dev, iommu-&gt;irq, iommu);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;domain =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(dev, &quot;Detached from iommu domain\=
n&quot;);<br>
+}<br>
+<br>
+static int rk_iommu_domain_init(struct iommu_domain *domain)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu_domain *rk_domain;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_domain =3D kzalloc(sizeof(*rk_domain), GFP_K=
ERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_domain)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * rk32xx iommus use a 2 level pagetable.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Each level1 (dt) and level2 (pt) table has 1=
024 4-byte entries.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Allocate one 4 KiB page for each table.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_domain-&gt;dt =3D (u32 *)get_zeroed_page(GFP=
_KERNEL | GFP_DMA32);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_domain-&gt;dt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_dt;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rk_table_flush(rk_domain-&gt;dt, NUM_DT_ENTRIES=
);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;rk_domain-&gt;iommus_lock);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_init(&amp;rk_domain-&gt;dt_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_LIST_HEAD(&amp;rk_domain-&gt;iommus);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0domain-&gt;priv =3D rk_domain;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+err_dt:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(rk_domain);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+}<br>
+<br>
+static void rk_iommu_domain_destroy(struct iommu_domain *domain)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu_domain *rk_domain =3D domain-&g=
t;priv;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(!list_empty(&amp;rk_domain-&gt;iommus))=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; NUM_DT_ENTRIES; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 dte =3D rk_doma=
in-&gt;dt[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rk_dte_is_pt_va=
lid(dte)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0phys_addr_t pt_phys =3D rk_dte_pt_address(dte);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0u32 *page_table =3D phys_to_virt(pt_phys);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_page((unsigned long)page_table);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0free_page((unsigned long)rk_domain-&gt;dt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(domain-&gt;priv);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0domain-&gt;priv =3D NULL;<br>
+}<br>
+<br>
+static bool rk_iommu_is_dev_iommu_master(struct device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D dev-&gt;of_node;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * An iommu master has an iommus property conta=
ining a list of phandles<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to iommu nodes, each with an #iommu-cells pr=
operty with value 0.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D of_count_phandle_with_args(np, &quot;io=
mmus&quot;, &quot;#iommu-cells&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return (ret &gt; 0);<br>
+}<br>
+<br>
+static int rk_iommu_group_set_iommudata(struct iommu_group *group,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct de=
vice *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_node *np =3D dev-&gt;of_node;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct platform_device *pd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct of_phandle_args args;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * An iommu master has an iommus property conta=
ining a list of phandles<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * to iommu nodes, each with an #iommu-cells pr=
operty with value 0.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D of_parse_phandle_with_args(np, &quot;io=
mmus&quot;, &quot;#iommu-cells&quot;, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;arg=
s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
of_parse_phandle_with_args(%s) =3D&gt; %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0np-&gt;full_name, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (args.args_count !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
incorrect number of iommu params found for %s (found %d, expected 0)\n&quot=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0args.np-&gt;full_name, args.args_count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pd =3D of_find_device_by_node(<a href=3D"http:/=
/args.np" target=3D"_blank">args.np</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0of_node_put(<a href=3D"http://args.np" target=
=3D"_blank">args.np</a>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pd) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
iommu %s not found\n&quot;, args.np-&gt;full_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EPROBE_DEFE=
R;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO(djkurtz): handle multiple slave iommus =
for a single master */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_group_set_iommudata(group, &amp;pd-&gt;de=
v, NULL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int rk_iommu_add_device(struct device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iommu_group *group;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_iommu_is_dev_iommu_master(dev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0group =3D iommu_group_get(dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!group) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0group =3D iommu_gro=
up_alloc();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(group)) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err(dev, &quot;Failed to allocate IOMMU group\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return PTR_ERR(group);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iommu_group_add_device(group, dev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_put_group;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D rk_iommu_group_set_iommudata(group, dev=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_remove_dev=
ice;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_group_put(group);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+err_remove_device:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_group_remove_device(dev);<br>
+err_put_group:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_group_put(group);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
+static void rk_iommu_remove_device(struct device *dev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!rk_iommu_is_dev_iommu_master(dev))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_group_remove_device(dev);<br>
+}<br>
+<br>
+static const struct iommu_ops rk_iommu_ops =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.domain_init =3D rk_iommu_domain_init,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.domain_destroy =3D rk_iommu_domain_destroy,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.attach_dev =3D rk_iommu_attach_device,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.detach_dev =3D rk_iommu_detach_device,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.map =3D rk_iommu_map,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.unmap =3D rk_iommu_unmap,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.add_device =3D rk_iommu_add_device,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove_device =3D rk_iommu_remove_device,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.iova_to_phys =3D rk_iommu_iova_to_phys,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.pgsize_bitmap =3D RK_IOMMU_PGSIZE_BITMAP,<br>
+};<br>
+<br>
+static int rk_iommu_probe(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct device *dev =3D &amp;pdev-&gt;dev;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct rk_iommu *iommu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource *res;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu =3D devm_kzalloc(dev, sizeof(*iommu), GFP=
_KERNEL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iommu)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, iommu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;dev =3D dev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D platform_get_resource(pdev, IORESOURCE_=
MEM, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;base =3D devm_ioremap_resource(&amp;p=
dev-&gt;dev, res);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(iommu-&gt;base))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(iomm=
u-&gt;base);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iommu-&gt;irq =3D platform_get_irq(pdev, 0);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (iommu-&gt;irq &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(dev, &quot;=
Failed to get IRQ, %d\n&quot;, iommu-&gt;irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENXIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+static int rk_iommu_remove(struct platform_device *pdev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br>
+<br>
+#ifdef CONFIG_OF<br>
+static const struct of_device_id rk_iommu_dt_ids[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ .compatible =3D &quot;rockchip,iommu&quot; },=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0{ /* sentinel */ }<br>
+};<br>
+MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);<br>
+#endif<br>
+<br>
+static struct platform_driver rk_iommu_driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.probe =3D rk_iommu_probe,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.remove =3D rk_iommu_remove,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.driver =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &=
quot;rk_iommu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D =
THIS_MODULE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_t=
able =3D of_match_ptr(rk_iommu_dt_ids),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+};<br>
+<br>
+static int __init rk_iommu_init(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bus_set_iommu(&amp;platform_bus_type, &=
amp;rk_iommu_ops);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return platform_driver_register(&amp;rk_iommu_d=
river);<br>
+}<br>
+static void __exit rk_iommu_exit(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0platform_driver_unregister(&amp;rk_iommu_driver=
);<br>
+}<br>
+<br>
+subsys_initcall(rk_iommu_init);<br>
+module_exit(rk_iommu_exit);<br>
+<br>
+MODULE_DESCRIPTION(&quot;IOMMU API for Rockchip&quot;);<br>
+MODULE_AUTHOR(&quot;Simon Xue &lt;<a href=3D"mailto:xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org">xx=
m@rock-chips.com</a>&gt; and Daniel Kurtz &lt;<a href=3D"mailto:djkurtz@chr=
omium.org">djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org</a>&gt;&quot;);<br>
+MODULE_ALIAS(&quot;platform:rockchip-iommu&quot;);<br>
+MODULE_LICENSE(&quot;GPL v2&quot;);<br>
--<br>
2.1.0.rc2.206.gedb03e5<br>
<br>
</blockquote></div>

--bcaec511e5faa592b30506801d70--

--===============1889383163932365840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1889383163932365840==--
