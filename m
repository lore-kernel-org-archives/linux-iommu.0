From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [v9,4/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Fri, 19 Feb 2016 23:02:09 -0800
Message-ID: <20160220070209.GA16577@roeck-us.net>
References: <1455669974-1527-5-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455669974-1527-5-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 17, 2016 at 08:46:13AM +0800, Yong Wu wrote:
> This patch adds support for mediatek m4u (MultiMedia Memory Management
> Unit).
> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> ---
> drivers/iommu/Kconfig     |  16 +
>  drivers/iommu/Makefile    |   1 +
>  drivers/iommu/mtk_iommu.c | 732 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 749 insertions(+)
>  create mode 100644 drivers/iommu/mtk_iommu.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index a1e75cb..4922aa8 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -318,4 +318,20 @@ config S390_IOMMU
>  	help
>  	  Support for the IOMMU API for s390 PCI devices.
>  
> +config MTK_IOMMU
> +	bool "MTK IOMMU Support"
> +	depends on ARM || ARM64
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select IOMMU_API
> +	select IOMMU_DMA
> +	select IOMMU_IO_PGTABLE_ARMV7S
> +	select MEMORY
> +	select MTK_SMI
> +	help
> +	  Support for the M4U on certain Mediatek SOCs. M4U is MultiMedia
> +	  Memory Management Unit. This option enables remapping of DMA memory
> +	  accesses for the multimedia subsystem.
> +
> +	  If unsure, say N here.
> +
>  endif # IOMMU_SUPPORT
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 42fc0c2..44ae2e0 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o
>  obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
>  obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
>  obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
> +obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o
>  obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
>  obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
>  obj-$(CONFIG_ROCKCHIP_IOMMU) += rockchip-iommu.o
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> new file mode 100644
> index 0000000..60fe97b
> --- /dev/null
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -0,0 +1,732 @@
> +/*
> + * Copyright (c) 2015-2016 MediaTek Inc.
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
> +#include <linux/clk.h>
> +#include <linux/component.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <soc/mediatek/smi.h>
> +#include <dt-bindings/memory/mt8173-larb-port.h>
> +

Some missing includes:

linux/bug.h
	for WARN_ON()
linux/device.h
	for dev_xxx() error messages, dev_get_drvdata(), etc.
linux/err.h
	for error functions (IS_ERR, error definitions)
linux/slab.h
	for kzalloc() etc.
linux/spinlock.h
	for spinlock functions
asm/barrier.h
	for wmb()

Guenter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
