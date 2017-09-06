From: Anup Patel <anup.patel@broadcom.com>
Subject: Re: [PATCH v7] vfio: platform: reset: Add Broadcom FlexRM reset module
Date: Wed, 6 Sep 2017 16:42:33 +0530
Message-ID: <CAALAos8jpDTXVGf9OBB5EBAUU6XrZRiyawnB7P+hwB8HG8gjzA@mail.gmail.com>
References: <1504685798-27645-1-git-send-email-anup.patel@broadcom.com>
 <1504685798-27645-2-git-send-email-anup.patel@broadcom.com> <140636c0-6d69-13fb-b17b-3c2a4bf3a1c7@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <140636c0-6d69-13fb-b17b-3c2a4bf3a1c7@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 6, 2017 at 4:39 PM, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Anup,
>
> On 06/09/2017 10:16, Anup Patel wrote:
>> This patch adds Broadcom FlexRM low-level reset for
>> VFIO platform.
>>
>> It will do the following:
>> 1. Disable/Deactivate each FlexRM ring
>> 2. Flush each FlexRM ring
>>
>> The cleanup sequence for FlexRM rings is adapted from
>> Broadcom FlexRM mailbox driver.
>>
>> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
>> Reviewed-by: Oza Oza <oza.oza@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/vfio/platform/reset/Kconfig                |   9 ++
>>  drivers/vfio/platform/reset/Makefile               |   1 +
>>  .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 115 +++++++++++++++++++++
>>  3 files changed, 125 insertions(+)
>>  create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
>>
>> diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
>> index 70cccc5..392e3c0 100644
>> --- a/drivers/vfio/platform/reset/Kconfig
>> +++ b/drivers/vfio/platform/reset/Kconfig
>> @@ -13,3 +13,12 @@ config VFIO_PLATFORM_AMDXGBE_RESET
>>         Enables the VFIO platform driver to handle reset for AMD XGBE
>>
>>         If you don't know what to do here, say N.
>> +
>> +config VFIO_PLATFORM_BCMFLEXRM_RESET
>> +     tristate "VFIO support for Broadcom FlexRM reset"
>> +     depends on VFIO_PLATFORM && (ARCH_BCM_IPROC || COMPILE_TEST)
>> +     default ARCH_BCM_IPROC
>> +     help
>> +       Enables the VFIO platform driver to handle reset for Broadcom FlexRM
>> +
>> +       If you don't know what to do here, say N.
>> diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
>> index 93f4e23..8d9874b 100644
>> --- a/drivers/vfio/platform/reset/Makefile
>> +++ b/drivers/vfio/platform/reset/Makefile
>> @@ -5,3 +5,4 @@ ccflags-y += -Idrivers/vfio/platform
>>
>>  obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
>>  obj-$(CONFIG_VFIO_PLATFORM_AMDXGBE_RESET) += vfio-platform-amdxgbe.o
>> +obj-$(CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET) += vfio_platform_bcmflexrm.o
>> diff --git a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
>> new file mode 100644
>> index 0000000..5f89066
>> --- /dev/null
>> +++ b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
>> @@ -0,0 +1,115 @@
>> +/*
>> + * Copyright (C) 2017 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +/*
>> + * This driver provides reset support for Broadcom FlexRM ring manager
>> + * to VFIO platform.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +
>> +#include "vfio_platform_private.h"
>> +
>> +/* FlexRM configuration */
>> +#define RING_REGS_SIZE                                       0x10000
>> +#define RING_VER_MAGIC                                       0x76303031
>> +
>> +/* Per-Ring register offsets */
>> +#define RING_VER                                     0x000
>> +#define RING_CONTROL                                 0x034
>> +#define RING_FLUSH_DONE                                      0x038
>> +
>> +/* Register RING_CONTROL fields */
>> +#define CONTROL_FLUSH_SHIFT                          5
>> +
>> +/* Register RING_FLUSH_DONE fields */
>> +#define FLUSH_DONE_MASK                                      0x1
>> +
>> +static int vfio_platform_bcmflexrm_shutdown(void __iomem *ring)
>> +{
>> +     unsigned int timeout;
>> +
>> +     /* Disable/inactivate ring */
>> +     writel_relaxed(0x0, ring + RING_CONTROL);
>> +
>> +     /* Set ring flush state */
>> +     timeout = 1000; /* timeout of 1s */
>> +     writel_relaxed(BIT(CONTROL_FLUSH_SHIFT), ring + RING_CONTROL);
>> +     do {
>> +             if (readl_relaxed(ring + RING_FLUSH_DONE) &
>> +                 FLUSH_DONE_MASK)
>> +                     break;
>> +             mdelay(1);
>> +     } while (--timeout);
>> +     if (!timeout)
>> +             return -ETIMEDOUT;
>> +
>> +     /* Clear ring flush state */
>> +     timeout = 1000; /* timeout of 1s */
>> +     writel_relaxed(0x0, ring + RING_CONTROL);
>> +     do {
>> +             if (!(readl_relaxed(ring + RING_FLUSH_DONE) &
>> +                   FLUSH_DONE_MASK))
>> +                     break;
>> +             mdelay(1);
>> +     } while (--timeout);
>> +     if (!timeout)
>> +             return -ETIMEDOUT;
>> +
>> +     return 0;
>> +}
>> +
>> +static int vfio_platform_bcmflexrm_reset(struct vfio_platform_device *vdev)
>> +{
>> +     void __iomem *ring;
>> +     int rc = 0, ret = 0, ring_num = 0;
>> +     struct vfio_platform_region *reg = &vdev->regions[0];
>> +
>> +     /* Map FlexRM ring registers if not mapped */
>> +     if (!reg->ioaddr) {
>> +             reg->ioaddr = ioremap_nocache(reg->addr, reg->size);
>> +             if (!reg->ioaddr)
>> +                     return -ENOMEM;
>> +     }
>> +
>> +     /* Discover and shutdown each FlexRM ring */
>> +     for (ring = reg->ioaddr;
>> +          ring < (reg->ioaddr + reg->size); ring += RING_REGS_SIZE) {
>> +             if (readl_relaxed(ring + RING_VER) == RING_VER_MAGIC) {
>> +                     rc = vfio_platform_bcmflexrm_shutdown(ring);
>> +                     if (rc) {
>> +                             dev_warn(vdev->device,
>> +                                      "FlexRM ring%d shutdown error %d\n",
>> +                                      ring_num, rc);
>> +                             ret = rc;
> miss |= ?

Oops, I missed it.

Thanks for catching.

Regards,
Anup
