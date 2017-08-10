From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v4] vfio: platform: reset: Add Broadcom FlexRM reset
 module
Date: Thu, 10 Aug 2017 13:23:38 -0600
Message-ID: <20170810132338.406b06ce@w520.home>
References: <1501652310-3638-1-git-send-email-anup.patel@broadcom.com>
        <1501652310-3638-2-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501652310-3638-2-git-send-email-anup.patel@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup.patel@broadcom.com>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: iommu@lists.linux-foundation.org

On Wed,  2 Aug 2017 11:08:30 +0530
Anup Patel <anup.patel@broadcom.com> wrote:

> This patch adds Broadcom FlexRM low-level reset for
> VFIO platform.
> 
> It will do the following:
> 1. Disable/Deactivate each FlexRM ring
> 2. Flush each FlexRM ring
> 
> The cleanup sequence for FlexRM rings is adapted from
> Broadcom FlexRM mailbox driver.
> 
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Reviewed-by: Oza Oza <oza.oza@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vfio/platform/reset/Kconfig                |   8 ++
>  drivers/vfio/platform/reset/Makefile               |   1 +
>  .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 100 +++++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> 
> diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
> index 70cccc5..8833805 100644
> --- a/drivers/vfio/platform/reset/Kconfig
> +++ b/drivers/vfio/platform/reset/Kconfig
> @@ -13,3 +13,11 @@ config VFIO_PLATFORM_AMDXGBE_RESET
>  	  Enables the VFIO platform driver to handle reset for AMD XGBE
>  
>  	  If you don't know what to do here, say N.
> +
> +config VFIO_PLATFORM_BCMFLEXRM_RESET
> +	tristate "VFIO support for Broadcom FlexRM reset"
> +	depends on VFIO_PLATFORM && (ARCH_BCM_IPROC || COMPILE_TEST)
> +	help
> +	  Enables the VFIO platform driver to handle reset for Broadcom FlexRM
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
> index 93f4e23..8d9874b 100644
> --- a/drivers/vfio/platform/reset/Makefile
> +++ b/drivers/vfio/platform/reset/Makefile
> @@ -5,3 +5,4 @@ ccflags-y += -Idrivers/vfio/platform
>  
>  obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
>  obj-$(CONFIG_VFIO_PLATFORM_AMDXGBE_RESET) += vfio-platform-amdxgbe.o
> +obj-$(CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET) += vfio_platform_bcmflexrm.o
> diff --git a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> new file mode 100644
> index 0000000..104c3c1
> --- /dev/null
> +++ b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> @@ -0,0 +1,100 @@
> +/*
> + * Copyright (C) 2017 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * This driver provides reset support for Broadcom FlexRM ring manager
> + * to VFIO platform.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "vfio_platform_private.h"
> +
> +/* FlexRM configuration */
> +#define RING_REGS_SIZE					0x10000
> +#define RING_VER_MAGIC					0x76303031
> +
> +/* Per-Ring register offsets */
> +#define RING_VER					0x000
> +#define RING_CONTROL					0x034
> +#define RING_FLUSH_DONE					0x038
> +
> +/* Register RING_CONTROL fields */
> +#define CONTROL_FLUSH_SHIFT				5
> +
> +/* Register RING_FLUSH_DONE fields */
> +#define FLUSH_DONE_MASK					0x1
> +
> +static int vfio_platform_bcmflexrm_shutdown(void __iomem *ring)
> +{
> +	unsigned int timeout;
> +
> +	/* Disable/inactivate ring */
> +	writel_relaxed(0x0, ring + RING_CONTROL);
> +
> +	/* Flush ring with timeout of 1s */
> +	timeout = 1000;
> +	writel_relaxed(BIT(CONTROL_FLUSH_SHIFT), ring + RING_CONTROL);
> +	do {
> +		if (readl_relaxed(ring + RING_FLUSH_DONE) & FLUSH_DONE_MASK)
> +			break;
> +		mdelay(1);
> +	} while (timeout--);
> +
> +	if (!timeout) {
> +		pr_warn("VFIO FlexRM shutdown timeout\n");
> +		return -ETIMEDOUT;
> +	}


This doesn't work, timeout is ~0 here.

> +
> +	return 0;
> +}
> +
> +static int vfio_platform_bcmflexrm_reset(struct vfio_platform_device *vdev)
> +{
> +	int rc = 0;
> +	void __iomem *ring;
> +	struct vfio_platform_region *reg = &vdev->regions[0];
> +
> +	/* Map FlexRM ring registers if not mapped */
> +	if (!reg->ioaddr) {
> +		reg->ioaddr = ioremap_nocache(reg->addr, reg->size);
> +		if (!reg->ioaddr)
> +			return -ENOMEM;
> +	}
> +
> +	/* Discover and shutdown each FlexRM ring */
> +	for (ring = reg->ioaddr;
> +	     ring < (reg->ioaddr + reg->size); ring += RING_REGS_SIZE) {
> +		if (readl_relaxed(ring + RING_VER) == RING_VER_MAGIC) {
> +			rc = vfio_platform_bcmflexrm_shutdown(ring);
> +			if (rc)
> +				break;
> +		}
> +	}
> +
> +	return rc;
> +}
> +
> +module_vfio_reset_handler("brcm,iproc-flexrm-mbox",
> +			  vfio_platform_bcmflexrm_reset);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Anup Patel <anup.patel@broadcom.com>");
> +MODULE_DESCRIPTION("Reset support for Broadcom FlexRM VFIO platform device");
