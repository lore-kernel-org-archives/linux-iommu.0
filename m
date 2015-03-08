From: Tomasz Figa <tfiga@google.com>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Sun, 8 Mar 2015 13:12:32 +0900
Message-ID: <CAAFQd5CWOjT6XU8PFT+PO6Q2mb-i+iMTtZPSo_RDNUzpOO6TvA@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com> <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi Yong Wu,

Thanks for this series. Please see my comments inline.

On Fri, Mar 6, 2015 at 7:48 PM,  <yong.wu@mediatek.com> wrote:
> From: Yong Wu <yong.wu@mediatek.com>
>
> This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).
> Currently this only supports m4u gen 2 with 2 levels of page table on mt8173.

[snip]

> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> new file mode 100644
> index 0000000..d62d4ab
> --- /dev/null
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -0,0 +1,754 @@
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
> +
> +#define pr_fmt(fmt) "m4u:"fmt

This format is not very useful, especially when using dev_ helpers
prepends messages with device name.

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

CodingStyle: The definitions below do not seem to be aligned
correctly. Please make sure all the values are in the same column and
are aligned using tabs only (remembering that tab width specified by
Linux coding style is 8 characters).

> +
> +#define REG_MMUG_PT_BASE        0x0
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

CodingStyle: Operators (e.g. <<) should have spaces on both sides.

> +#define F_MMU_CTRL_COHERE_EN             BIT(8)
> +
> +#define REG_MMU_IVRP_PADDR               0x114
> +#define F_MMU_IVRP_PA_SET(PA)            (PA>>1)

Please make sure that all references to macro arguments in macro
definitions are surrounded by parentheses to avoid issues with
operator precedence. (i.e. ((pa) >> 1))

CodingStyle: Macro arguments should be lowercase.

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

Multiple coding style issues in these 6 macros, as per my comments above.

> +
> +#define REG_MMU_CPE_DONE              0x12C
> +
> +#define REG_MMU_MAIN_FAULT_ST         0x134
> +
> +#define REG_MMU_FAULT_VA(mmu)         (0x13c+((mmu)<<3))
> +#define F_MMU_FAULT_VA_MSK            ((~0x0)<<12)

Please specify the mask manually to avoid ambiguities with result type.
+ CodingStyle

> +#define F_MMU_FAULT_VA_WRITE_BIT       BIT(1)
> +#define F_MMU_FAULT_VA_LAYER_BIT       BIT(0)
> +
> +#define REG_MMU_INVLD_PA(mmu)         (0x140+((mmu)<<3))
> +#define REG_MMU_INT_ID(mmu)           (0x150+((mmu)<<2))
> +#define F_MMU0_INT_ID_TF_MSK          (~0x3)   /* only for MM iommu. */

Ditto.

> +
> +#define MTK_TFID(larbid, portid) ((larbid << 7) | (portid << 2))

Missing parentheses around macro arguments.

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

[snip]

> +       {"M4U_PORT_HSIC_MAS",              1,  0,    6,  12, 0x11},
> +       {"M4U_PORT_HSIC_DEV",              1,  0,    6,  13, 0x19},
> +       {"M4U_PORT_AP_DMA",                1,  0,    6,  14, 0x18},
> +       {"M4U_PORT_HSIC_DMA",              1,  0,    6,  15, 0xc8},
> +       {"M4U_PORT_MSDC0",                 1,  0,    6,  16, 0x0},
> +       {"M4U_PORT_MSDC3",                 1,  0,    6,  17, 0x20},
> +       {"M4U_PORT_UNKNOWN",               1,  0,    6,  18, 0xf},

Why the MTK_TFID() macro is not used for perisys iommu?

> +};
> +

Anyway, is it really necessary to hardcode the SoC specific topology
data in this driver? Is there really any use besides of printing port
name? If not, you could just print the values in a way letting you
quickly look up in the datasheet, without hardcoding this. Or even
better, you could print which devices are attached to the port.

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
> +
> +       pcurport = piommu->imucfg->pport + portid;
> +       if (portid < piommu->imucfg->m4u_port_nr && pcurport)
> +               return pcurport->port_name;
> +       else
> +               return "UNKNOWN_PORT";
> +}

This function seems to be used just for printing the hardcoded port names.

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

This function seems to be used just for finding an index into the
array of hardcoded port names for printing purposes.

> +
> +static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> +{
> +       struct iommu_domain *domain = dev_id;
> +       struct mtk_iommu_domain *mtkdomain = domain->priv;
> +       struct mtk_iommu_info *piommu = mtkdomain->piommuinfo;
> +
> +       if (irq == piommu->irq)
> +               report_iommu_fault(domain, piommu->dev, 0, 0);

This doesn't look like a good use of report_iommu_fault(). You should
pass real values of iova and flags arguments.

> +       else

This is impossible, no need to check this.

> +               dev_err(piommu->dev, "irq number:%d\n", irq);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static inline void mtk_iommu_clear_intr(void __iomem *m4u_base)

Please let the compiler decide if this function should be inline or not.

> +{
> +       u32 val;
> +
> +       val = readl(m4u_base + REG_MMU_INT_L2_CONTROL);
> +       val |= F_INT_L2_CLR_BIT;
> +       writel(val, m4u_base + REG_MMU_INT_L2_CONTROL);
> +}
> +
> +static int mtk_iommu_invalidate_tlb(const struct mtk_iommu_info *piommu,
> +                                   int isinvall, unsigned int iova_start,
> +                                   unsigned int iova_end)
> +{
> +       void __iomem *m4u_base = piommu->m4u_base;
> +       u32 val;
> +       u64 start, end;
> +
> +       start = sched_clock();

I don't think this is the preferred way of checking time in kernel
drivers, especially after seeing this comment:
http://lxr.free-electrons.com/source/include/linux/sched.h#L2134

You should use ktime_get() and other ktime_ helpers.

> +
> +       if (!isinvall) {
> +               iova_start = round_down(iova_start, SZ_4K);
> +               iova_end = round_up(iova_end, SZ_4K);
> +       }
> +
> +       val = F_MMU_INV_EN_L2 | F_MMU_INV_EN_L1;
> +
> +       writel(val, m4u_base + REG_INVLID_SEL);
> +
> +       if (isinvall) {
> +               writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);

Please move invalidate all into separate function and just call it
wherever the code currently passes true as invall argument. You will
get rid of two of the ifs in this function.

> +       } else {
> +               writel(iova_start, m4u_base + REG_MMU_INVLD_SA);
> +               writel(iova_end, m4u_base + REG_MMU_INVLD_EA);
> +               writel(F_MMU_INV_RANGE, m4u_base + REG_MMU_INVLD);
> +
> +               while (!readl(m4u_base + REG_MMU_CPE_DONE)) {
> +                       end = sched_clock();
> +                       if (end - start >= 100000000ULL) {

Looks like a very interesting magic number. Please define a macro and
use normal time units along with ktime_to_<unit>() helpers.

> +                               dev_warn(piommu->dev, "invalid don't done\n");
> +                               writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);

By following my comment above, you could just call the new invalidate
all function here instead of duplicating the same register write.

> +                       }
> +               };

nit: Unnecessary semicolon.

> +               writel(0, m4u_base + REG_MMU_CPE_DONE);
> +       }
> +
> +       return 0;
> +}
> +
> +static int mtk_iommu_fault_handler(struct iommu_domain *imudomain,
> +                                  struct device *dev, unsigned long iova,
> +                                  int m4uindex, void *pimu)
> +{
> +       void __iomem *m4u_base;
> +       u32 int_state, regval;
> +       int m4u_slave_id = 0;

Why 0? Also this variable doesn't seem to be assigned further in the
code. Should it be a constant? Moreover, shouldn't it be unsigned?

> +       unsigned int layer, write, m4u_port;

Shouldn't layer and write be bool?

> +       unsigned int fault_mva, fault_pa;
> +       struct mtk_iommu_info *piommu = pimu;
> +       struct mtk_iommu_domain *mtkdomain = imudomain->priv;
> +
> +       m4u_base = piommu->m4u_base;
> +       int_state = readl(m4u_base + REG_MMU_MAIN_FAULT_ST);
> +
> +       /* read error info from registers */
> +       fault_mva = readl(m4u_base + REG_MMU_FAULT_VA(m4u_slave_id));
> +       layer = !!(fault_mva & F_MMU_FAULT_VA_LAYER_BIT);
> +       write = !!(fault_mva & F_MMU_FAULT_VA_WRITE_BIT);
> +       fault_mva &= F_MMU_FAULT_VA_MSK;

So I assume the IOMMU virtual address space is 32-bit, so fault_mva
can be unsigned int. However it would be better to use an explicitly
sized type for this, i.e. u32.

> +       fault_pa = readl(m4u_base + REG_MMU_INVLD_PA(m4u_slave_id));

It is not clear from any documentation added by this series how wide
is the physical address space of this IOMMU, especially since the SoC
has ARM64 cores. Please make sure that fault_pa variable is using
explicitly sized type which matches width of the register.

End of part 1. Will continue when I find next chunk of time to spend
on review. :)

Best regards,
Tomasz
