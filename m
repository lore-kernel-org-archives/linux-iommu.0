From: Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Mon, 9 Mar 2015 16:24:18 +0800
Message-ID: <CAGS+omApXnka518EgZ+DF+Zc5gTQw_9o3vqz01Z3fRLDtdhhRA@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com> <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425638900-24989-3-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yong Wu,

On Fri, Mar 6, 2015 at 6:48 PM,  <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
> This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).
> Currently this only supports m4u gen 2 with 2 levels of page table on mt8173.
>
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/Kconfig               |  11 +
>  drivers/iommu/Makefile              |   1 +
>  drivers/iommu/mtk_iommu.c           | 754 ++++++++++++++++++++++++++++++++++++
>  drivers/iommu/mtk_iommu.h           |  73 ++++
>  drivers/iommu/mtk_iommu_pagetable.c | 439 +++++++++++++++++++++
>  drivers/iommu/mtk_iommu_pagetable.h |  49 +++
>  6 files changed, 1327 insertions(+)
>  create mode 100644 drivers/iommu/mtk_iommu.c
>  create mode 100644 drivers/iommu/mtk_iommu.h
>  create mode 100644 drivers/iommu/mtk_iommu_pagetable.c
>  create mode 100644 drivers/iommu/mtk_iommu_pagetable.h
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 19027bb..e63f5b6 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -326,4 +326,15 @@ config ARM_SMMU
>           Say Y here if your SoC includes an IOMMU device implementing
>           the ARM SMMU architecture.
>
> +config MTK_IOMMU
> +       bool "MTK IOMMU Support"
> +       select IOMMU_API
> +       select IOMMU_DMA
> +       select MTK_SMI
> +       help
> +         Support for the IOMMUs on certain Mediatek SOCs.
> +         These IOMMUs allow the multimedia hardware access discontinuous memory.
> +
> +         If unsure, say N here.
> +
>  endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 37bfc4e..f2a8027 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>  obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>  obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU) += of_iommu.o
> +obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o mtk_iommu_pagetable.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
>  obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
>  obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> new file mode 100644
> index 0000000..d62d4ab
> --- /dev/null
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -0,0 +1,754 @@
> +/*
> + * Copyright (c) 2014-2015 MediaTek Inc.
> + * Author: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
> +
> +#define pr_fmt(fmt) "m4u:"fmt
> +
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/mm.h>
> +#include <linux/iommu.h>
> +#include <linux/errno.h>
> +#include <linux/list.h>
> +#include <linux/memblock.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/mtk-smi.h>
> +#include <asm/cacheflush.h>
> +
> +#include "mtk_iommu.h"
> +
> +#define REG_MMUG_PT_BASE        0x0

It would be a lot easier to follow the driver if the register names
matched the datasheet:

REG_MMU_PT_BASE_ADDR  0x000
REG_MMU_INT_CONTROL     0x220
REG_MMU_INT_FAULT_ST     0x224
REG_MMU_INVALIDATE          0x5c0
REG_MMU_INVLD_START_A  0x5c4
REG_MMU_INVLD_END_A      0x5c8
REG_MMU_INV_SEL                0x5d8
REG_MMU_DCM                       0x5f0

> +
> +#define REG_MMU_INVLD           0x20
> +#define F_MMU_INV_ALL           0x2
> +#define F_MMU_INV_RANGE                 0x1
> +
> +#define REG_MMU_INVLD_SA        0x24
> +#define REG_MMU_INVLD_EA         0x28
> +
> +#define REG_MMU_INVLD_SEC         0x2c
> +#define F_MMU_INV_SEC_ALL          0x2
> +#define F_MMU_INV_SEC_RANGE        0x1
> +
> +#define REG_INVLID_SEL          0x38
> +#define F_MMU_INV_EN_L1                 BIT(0)
> +#define F_MMU_INV_EN_L2                 BIT(1)
> +
> +#define REG_MMU_STANDARD_AXI_MODE   0x48
> +#define REG_MMU_DCM_DIS             0x50
> +#define REG_MMU_LEGACY_4KB_MODE     0x60
> +
> +#define REG_MMU_CTRL_REG                 0x110
> +#define F_MMU_CTRL_REROUTE_PFQ_TO_MQ_EN  BIT(4)
> +#define F_MMU_CTRL_TF_PROT_VAL(prot)      (((prot) & 0x3)<<5)
> +#define F_MMU_CTRL_COHERE_EN             BIT(8)
> +
> +#define REG_MMU_IVRP_PADDR               0x114
> +#define F_MMU_IVRP_PA_SET(PA)            (PA>>1)
> +
> +#define REG_MMU_INT_L2_CONTROL      0x120
> +#define F_INT_L2_CLR_BIT            BIT(12)
> +
> +#define REG_MMU_INT_MAIN_CONTROL    0x124
> +#define F_INT_TRANSLATION_FAULT(MMU)           (1<<(0+(((MMU)<<1)|((MMU)<<2))))
> +#define F_INT_MAIN_MULTI_HIT_FAULT(MMU)        (1<<(1+(((MMU)<<1)|((MMU)<<2))))
> +#define F_INT_INVALID_PA_FAULT(MMU)            (1<<(2+(((MMU)<<1)|((MMU)<<2))))
> +#define F_INT_ENTRY_REPLACEMENT_FAULT(MMU)     (1<<(3+(((MMU)<<1)|((MMU)<<2))))
> +#define F_INT_TLB_MISS_FAULT(MMU)              (1<<(4+(((MMU)<<1)|((MMU)<<2))))
> +#define F_INT_PFH_FIFO_ERR(MMU)                (1<<(6+(((MMU)<<1)|((MMU)<<2))))

This is not readable.  For one thing, kernel style is to always place
spaces around operators.
Did you run checkpatch?

Assuming MMU is either 0 or 1, this would shift the error bits for
MMU=1 by "(((MMU) << 1) | ((MMU) << 2))" = 6 bits.
( This "MMU" does not look like it could possibly be correct since
F_INT_PFH_FIFO_ERR(0) == F_INT_TRANSLATION_FAULT(1).

Since in the code below, "MMU" is always m4u_slave_id, (a constant 0),
just remove all of this complexity until it is actually used.
For now just define these macros as:

#define F_INT_TRANSLATION_FAULT        BIT(0)
#define F_INT_MAIN_MULTI_HIT_FAULT     BIT(1)
#define F_INT_INVALID_PA_FAULT         BIT(2)
#define F_INT_ENTRY_REPLACEMENT_FAULT  BIT(3)
#define F_INT_TLB_MISS_FAULT           BIT(4)
#define F_INT_PFH_FIFO_ERR             BIT(6)

A later patch that adds support for slave_id != 0 can then fix up
these macros to do what ever it is you are trying to do here.

> +
> +#define REG_MMU_CPE_DONE              0x12C
> +
> +#define REG_MMU_MAIN_FAULT_ST         0x134
> +
> +#define REG_MMU_FAULT_VA(mmu)         (0x13c+((mmu)<<3))
> +#define F_MMU_FAULT_VA_MSK            ((~0x0)<<12)
> +#define F_MMU_FAULT_VA_WRITE_BIT       BIT(1)
> +#define F_MMU_FAULT_VA_LAYER_BIT       BIT(0)
> +
> +#define REG_MMU_INVLD_PA(mmu)         (0x140+((mmu)<<3))
> +#define REG_MMU_INT_ID(mmu)           (0x150+((mmu)<<2))
> +#define F_MMU0_INT_ID_TF_MSK          (~0x3)   /* only for MM iommu. */
> +
> +#define MTK_TFID(larbid, portid) ((larbid << 7) | (portid << 2))
> +
> +static const struct mtk_iommu_port mtk_iommu_mt8173_port[] = {
> +       /* port name                m4uid slaveid larbid portid tfid */
> +       /* larb0 */
> +       {"M4U_PORT_DISP_OVL0",          0,  0,    0,  0, MTK_TFID(0, 0)},
> +       {"M4U_PORT_DISP_RDMA0",         0,  0,    0,  1, MTK_TFID(0, 1)},
> +       {"M4U_PORT_DISP_WDMA0",         0,  0,    0,  2, MTK_TFID(0, 2)},
> +       {"M4U_PORT_DISP_OD_R",          0,  0,    0,  3, MTK_TFID(0, 3)},
> +       {"M4U_PORT_DISP_OD_W",          0,  0,    0,  4, MTK_TFID(0, 4)},
> +       {"M4U_PORT_MDP_RDMA0",          0,  0,    0,  5, MTK_TFID(0, 5)},
> +       {"M4U_PORT_MDP_WDMA",           0,  0,    0,  6, MTK_TFID(0, 6)},
> +       {"M4U_PORT_MDP_WROT0",          0,  0,    0,  7, MTK_TFID(0, 7)},
> +
> +       /* larb1 */
> +       {"M4U_PORT_HW_VDEC_MC_EXT",      0,  0,   1,  0, MTK_TFID(1, 0)},
> +       {"M4U_PORT_HW_VDEC_PP_EXT",      0,  0,   1,  1, MTK_TFID(1, 1)},
> +       {"M4U_PORT_HW_VDEC_UFO_EXT",     0,  0,   1,  2, MTK_TFID(1, 2)},
> +       {"M4U_PORT_HW_VDEC_VLD_EXT",     0,  0,   1,  3, MTK_TFID(1, 3)},
> +       {"M4U_PORT_HW_VDEC_VLD2_EXT",    0,  0,   1,  4, MTK_TFID(1, 4)},
> +       {"M4U_PORT_HW_VDEC_AVC_MV_EXT",  0,  0,   1,  5, MTK_TFID(1, 5)},
> +       {"M4U_PORT_HW_VDEC_PRED_RD_EXT", 0,  0,   1,  6, MTK_TFID(1, 6)},
> +       {"M4U_PORT_HW_VDEC_PRED_WR_EXT", 0,  0,   1,  7, MTK_TFID(1, 7)},
> +       {"M4U_PORT_HW_VDEC_PPWRAP_EXT",  0,  0,   1,  8, MTK_TFID(1, 8)},
> +
> +       /* larb2 */
> +       {"M4U_PORT_IMGO",                0,  0,    2,  0, MTK_TFID(2, 0)},
> +       {"M4U_PORT_RRZO",                0,  0,    2,  1, MTK_TFID(2, 1)},
> +       {"M4U_PORT_AAO",                 0,  0,    2,  2, MTK_TFID(2, 2)},
> +       {"M4U_PORT_LCSO",                0,  0,    2,  3, MTK_TFID(2, 3)},
> +       {"M4U_PORT_ESFKO",               0,  0,    2,  4, MTK_TFID(2, 4)},
> +       {"M4U_PORT_IMGO_D",              0,  0,    2,  5, MTK_TFID(2, 5)},
> +       {"M4U_PORT_LSCI",                0,  0,    2,  6, MTK_TFID(2, 6)},
> +       {"M4U_PORT_LSCI_D",              0,  0,    2,  7, MTK_TFID(2, 7)},
> +       {"M4U_PORT_BPCI",                0,  0,    2,  8, MTK_TFID(2, 8)},
> +       {"M4U_PORT_BPCI_D",              0,  0,    2,  9, MTK_TFID(2, 9)},
> +       {"M4U_PORT_UFDI",                0,  0,    2,  10, MTK_TFID(2, 10)},
> +       {"M4U_PORT_IMGI",                0,  0,    2,  11, MTK_TFID(2, 11)},
> +       {"M4U_PORT_IMG2O",               0,  0,    2,  12, MTK_TFID(2, 12)},
> +       {"M4U_PORT_IMG3O",               0,  0,    2,  13, MTK_TFID(2, 13)},
> +       {"M4U_PORT_VIPI",                0,  0,    2,  14, MTK_TFID(2, 14)},
> +       {"M4U_PORT_VIP2I",               0,  0,    2,  15, MTK_TFID(2, 15)},
> +       {"M4U_PORT_VIP3I",               0,  0,    2,  16, MTK_TFID(2, 16)},
> +       {"M4U_PORT_LCEI",                0,  0,    2,  17, MTK_TFID(2, 17)},
> +       {"M4U_PORT_RB",                  0,  0,    2,  18, MTK_TFID(2, 18)},
> +       {"M4U_PORT_RP",                  0,  0,    2,  19, MTK_TFID(2, 19)},
> +       {"M4U_PORT_WR",                  0,  0,    2,  20, MTK_TFID(2, 20)},
> +
> +       /* larb3 */
> +       {"M4U_PORT_VENC_RCPU",            0,  0,   3,  0, MTK_TFID(3, 0)},
> +       {"M4U_PORT_VENC_REC",             0,  0,   3,  1, MTK_TFID(3, 1)},
> +       {"M4U_PORT_VENC_BSDMA",           0,  0,   3,  2, MTK_TFID(3, 2)},
> +       {"M4U_PORT_VENC_SV_COMV",         0,  0,   3,  3, MTK_TFID(3, 3)},
> +       {"M4U_PORT_VENC_RD_COMV",         0,  0,   3,  4, MTK_TFID(3, 4)},
> +       {"M4U_PORT_JPGENC_RDMA",          0,  0,   3,  5, MTK_TFID(3, 5)},
> +       {"M4U_PORT_JPGENC_BSDMA",         0,  0,   3,  6, MTK_TFID(3, 6)},
> +       {"M4U_PORT_JPGDEC_WDMA",          0,  0,   3,  7, MTK_TFID(3, 7)},
> +       {"M4U_PORT_JPGDEC_BSDMA",         0,  0,   3,  8, MTK_TFID(3, 8)},
> +       {"M4U_PORT_VENC_CUR_LUMA",        0,  0,   3,  9, MTK_TFID(3, 9)},
> +       {"M4U_PORT_VENC_CUR_CHROMA",      0,  0,   3,  10, MTK_TFID(3, 10)},
> +       {"M4U_PORT_VENC_REF_LUMA",        0,  0,   3,  11, MTK_TFID(3, 11)},
> +       {"M4U_PORT_VENC_REF_CHROMA",      0,  0,   3,  12, MTK_TFID(3, 12)},
> +       {"M4U_PORT_VENC_NBM_RDMA",        0,  0,   3,  13, MTK_TFID(3, 13)},
> +       {"M4U_PORT_VENC_NBM_WDMA",        0,  0,   3,  14, MTK_TFID(3, 14)},
> +
> +       /* larb4 */
> +       {"M4U_PORT_DISP_OVL1",             0,  0,   4,  0, MTK_TFID(4, 0)},
> +       {"M4U_PORT_DISP_RDMA1",            0,  0,   4,  1, MTK_TFID(4, 1)},
> +       {"M4U_PORT_DISP_RDMA2",            0,  0,   4,  2, MTK_TFID(4, 2)},
> +       {"M4U_PORT_DISP_WDMA1",            0,  0,   4,  3, MTK_TFID(4, 3)},
> +       {"M4U_PORT_MDP_RDMA1",             0,  0,   4,  4, MTK_TFID(4, 4)},
> +       {"M4U_PORT_MDP_WROT1",             0,  0,   4,  5, MTK_TFID(4, 5)},
> +
> +       /* larb5 */
> +       {"M4U_PORT_VENC_RCPU_SET2",        0,  0,    5,  0, MTK_TFID(5, 0)},
> +       {"M4U_PORT_VENC_REC_FRM_SET2",     0,  0,    5,  1, MTK_TFID(5, 1)},
> +       {"M4U_PORT_VENC_REF_LUMA_SET2",    0,  0,    5,  2, MTK_TFID(5, 2)},
> +       {"M4U_PORT_VENC_REC_CHROMA_SET2",  0,  0,    5,  3, MTK_TFID(5, 3)},
> +       {"M4U_PORT_VENC_BSDMA_SET2",       0,  0,    5,  4, MTK_TFID(5, 4)},
> +       {"M4U_PORT_VENC_CUR_LUMA_SET2",    0,  0,    5,  5, MTK_TFID(5, 5)},
> +       {"M4U_PORT_VENC_CUR_CHROMA_SET2",  0,  0,    5,  6, MTK_TFID(5, 6)},
> +       {"M4U_PORT_VENC_RD_COMA_SET2",     0,  0,    5,  7, MTK_TFID(5, 7)},
> +       {"M4U_PORT_VENC_SV_COMA_SET2",     0,  0,    5,  8, MTK_TFID(5, 8)},
> +
> +       /* perisys iommu */
> +       {"M4U_PORT_RESERVE",               1,  0,    6,  0, 0xff},
> +       {"M4U_PORT_SPM",                   1,  0,    6,  1, 0x50},
> +       {"M4U_PORT_MD32",                  1,  0,    6,  2, 0x90},
> +       {"M4U_PORT_PTP_THERM",             1,  0,    6,  4, 0xd0},
> +       {"M4U_PORT_PWM",                   1,  0,    6,  5, 0x1},
> +       {"M4U_PORT_MSDC1",                 1,  0,    6,  6, 0x21},
> +       {"M4U_PORT_MSDC2",                 1,  0,    6,  7, 0x41},
> +       {"M4U_PORT_NFI",                   1,  0,    6,  8, 0x8},
> +       {"M4U_PORT_AUDIO",                 1,  0,    6,  9, 0x48},
> +       {"M4U_PORT_RESERVED2",             1,  0,    6,  10, 0xfe},
> +       {"M4U_PORT_HSIC_XHCI",             1,  0,    6,  11, 0x9},
> +
> +       {"M4U_PORT_HSIC_MAS",              1,  0,    6,  12, 0x11},
> +       {"M4U_PORT_HSIC_DEV",              1,  0,    6,  13, 0x19},
> +       {"M4U_PORT_AP_DMA",                1,  0,    6,  14, 0x18},
> +       {"M4U_PORT_HSIC_DMA",              1,  0,    6,  15, 0xc8},
> +       {"M4U_PORT_MSDC0",                 1,  0,    6,  16, 0x0},
> +       {"M4U_PORT_MSDC3",                 1,  0,    6,  17, 0x20},
> +       {"M4U_PORT_UNKNOWN",               1,  0,    6,  18, 0xf},
> +};
> +
> +static const struct mtk_iommu_cfg mtk_iommu_mt8173_cfg = {
> +       .larb_nr = 6,
> +       .m4u_port_nr = ARRAY_SIZE(mtk_iommu_mt8173_port),
> +       .pport = mtk_iommu_mt8173_port,
> +};
> +
> +static const char *mtk_iommu_get_port_name(const struct mtk_iommu_info *piommu,
> +                                          unsigned int portid)
> +{
> +       const struct mtk_iommu_port *pcurport = NULL;

No need for NULL init.

> +
> +       pcurport = piommu->imucfg->pport + portid;
> +       if (portid < piommu->imucfg->m4u_port_nr && pcurport)

The pcurport NULL check is a bit superfluous here, right?

> +               return pcurport->port_name;
> +       else
> +               return "UNKNOWN_PORT";
> +}
> +
> +static int mtk_iommu_get_port_by_tfid(const struct mtk_iommu_info *pimu,
> +                                     int tf_id)
> +{
> +       const struct mtk_iommu_cfg *pimucfg = pimu->imucfg;
> +       int i;
> +       unsigned int portid = pimucfg->m4u_port_nr;
> +
> +       for (i = 0; i < pimucfg->m4u_port_nr; i++) {
> +               if (pimucfg->pport[i].tf_id == tf_id) {
> +                       portid = i;
> +                       break;
> +               }
> +       }
> +       if (i == pimucfg->m4u_port_nr)
> +               dev_err(pimu->dev, "tf_id find fail, tfid %d\n", tf_id);
> +       return portid;
> +}
> +
> +static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> +{
> +       struct iommu_domain *domain = dev_id;
> +       struct mtk_iommu_domain *mtkdomain = domain->priv;
> +       struct mtk_iommu_info *piommu = mtkdomain->piommuinfo;
> +
> +       if (irq == piommu->irq)
> +               report_iommu_fault(domain, piommu->dev, 0, 0);
> +       else
> +               dev_err(piommu->dev, "irq number:%d\n", irq);

If this isr doesn't handle the irq, return IRQ_NONE, not IRQ_HANDLED.

> +
> +       return IRQ_HANDLED;
> +}
> +

*snip*

Ok, enough for now :-).

Best Regards,
-Dan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
