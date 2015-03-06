From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Fri, 6 Mar 2015 10:58:21 +0000
Message-ID: <20150306105821.GE22377@arm.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425638900-24989-3-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 06, 2015 at 10:48:17AM +0000, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> 
> This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).
> Currently this only supports m4u gen 2 with 2 levels of page table on mt8173.

[...]

> diff --git a/drivers/iommu/mtk_iommu_pagetable.c b/drivers/iommu/mtk_iommu_pagetable.c
> new file mode 100644
> index 0000000..5fe9640
> --- /dev/null
> +++ b/drivers/iommu/mtk_iommu_pagetable.c
> @@ -0,0 +1,439 @@
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
> +#include <linux/err.h>
> +#include <linux/mm.h>
> +#include <linux/iommu.h>
> +#include <linux/errno.h>
> +#include "asm/cacheflush.h"
> +
> +#include "mtk_iommu.h"
> +#include "mtk_iommu_pagetable.h"
> +
> +/* 2 level pagetable: pgd -> pte */
> +#define F_PTE_TYPE_GET(regval)  (regval & 0x3)
> +#define F_PTE_TYPE_LARGE         BIT(0)
> +#define F_PTE_TYPE_SMALL         BIT(1)
> +#define F_PTE_B_BIT              BIT(2)
> +#define F_PTE_C_BIT              BIT(3)
> +#define F_PTE_BIT32_BIT          BIT(9)
> +#define F_PTE_S_BIT              BIT(10)
> +#define F_PTE_NG_BIT             BIT(11)
> +#define F_PTE_PA_LARGE_MSK            (~0UL << 16)
> +#define F_PTE_PA_LARGE_GET(regval)    ((regval >> 16) & 0xffff)
> +#define F_PTE_PA_SMALL_MSK            (~0UL << 12)
> +#define F_PTE_PA_SMALL_GET(regval)    ((regval >> 12) & (~0))
> +#define F_PTE_TYPE_IS_LARGE_PAGE(pte) ((imu_pte_val(pte) & 0x3) == \
> +                                       F_PTE_TYPE_LARGE)
> +#define F_PTE_TYPE_IS_SMALL_PAGE(pte) ((imu_pte_val(pte) & 0x3) == \
> +                                       F_PTE_TYPE_SMALL)

This looks like the ARM short-descriptor format to me. Could you please
add a new page table format to the io-pgtable code, so that other IOMMU
drivers can make use of this? I know there was some interest in using
short descriptor for the ARM SMMU, for example.

Cheers,

Will
