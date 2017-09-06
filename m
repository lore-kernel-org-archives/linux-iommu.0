From: Anup Patel via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v6] vfio: platform: reset: Add Broadcom FlexRM reset module
Date: Wed, 6 Sep 2017 13:44:56 +0530
Message-ID: <CAALAos8FGSr=5zHYKS7yP62dq=GUd4ziLFx-2gNzZL38nqE73A@mail.gmail.com>
References: <1503979486-5364-1-git-send-email-anup.patel@broadcom.com>
	<1503979486-5364-2-git-send-email-anup.patel@broadcom.com>
	<20170829140902.GK32175@char.us.oracle.com>
	<CAALAos9a7qrHtYpcW0NRyo4uowet8nWLettSKa=+qyNSeVcqRQ@mail.gmail.com>
	<20170905095713.0db61015@w520.home>
Reply-To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170905095713.0db61015-DGNDKt5SQtizQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 5, 2017 at 9:27 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, 4 Sep 2017 15:20:11 +0530
> Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>
>> Sorry for delayed response...
>>
>> On Tue, Aug 29, 2017 at 7:39 PM, Konrad Rzeszutek Wilk
>> <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>> > On Tue, Aug 29, 2017 at 09:34:46AM +0530, Anup Patel wrote:
>> >> This patch adds Broadcom FlexRM low-level reset for
>> >> VFIO platform.
>> >>
>> >
>> > Is there an document that explains and /or details the various
>> > registers?
>>
>> Yes, there is a document but its not publicly accessible.
>>
>> >> It will do the following:
>> >> 1. Disable/Deactivate each FlexRM ring
>> >> 2. Flush each FlexRM ring
>> >>
>> >> The cleanup sequence for FlexRM rings is adapted from
>> >> Broadcom FlexRM mailbox driver.
>> >>
>> >> Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> >> Reviewed-by: Oza Oza <oza.oza-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> >> Reviewed-by: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> >> Reviewed-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> >> ---
>> >>  drivers/vfio/platform/reset/Kconfig                |   9 ++
>> >>  drivers/vfio/platform/reset/Makefile               |   1 +
>> >>  .../vfio/platform/reset/vfio_platform_bcmflexrm.c  | 100 +++++++++++++++++++++
>> >>  3 files changed, 110 insertions(+)
>> >>  create mode 100644 drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
>> >>
>> >> diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
>> >> index 70cccc5..392e3c0 100644
>> >> --- a/drivers/vfio/platform/reset/Kconfig
>> >> +++ b/drivers/vfio/platform/reset/Kconfig
>> >> @@ -13,3 +13,12 @@ config VFIO_PLATFORM_AMDXGBE_RESET
>> >>         Enables the VFIO platform driver to handle reset for AMD XGBE
>> >>
>> >>         If you don't know what to do here, say N.
>> >> +
>> >> +config VFIO_PLATFORM_BCMFLEXRM_RESET
>> >> +     tristate "VFIO support for Broadcom FlexRM reset"
>> >> +     depends on VFIO_PLATFORM && (ARCH_BCM_IPROC || COMPILE_TEST)
>> >> +     default ARCH_BCM_IPROC
>> >> +     help
>> >> +       Enables the VFIO platform driver to handle reset for Broadcom FlexRM
>> >> +
>> >> +       If you don't know what to do here, say N.
>> >> diff --git a/drivers/vfio/platform/reset/Makefile b/drivers/vfio/platform/reset/Makefile
>> >> index 93f4e23..8d9874b 100644
>> >> --- a/drivers/vfio/platform/reset/Makefile
>> >> +++ b/drivers/vfio/platform/reset/Makefile
>> >> @@ -5,3 +5,4 @@ ccflags-y += -Idrivers/vfio/platform
>> >>
>> >>  obj-$(CONFIG_VFIO_PLATFORM_CALXEDAXGMAC_RESET) += vfio-platform-calxedaxgmac.o
>> >>  obj-$(CONFIG_VFIO_PLATFORM_AMDXGBE_RESET) += vfio-platform-amdxgbe.o
>> >> +obj-$(CONFIG_VFIO_PLATFORM_BCMFLEXRM_RESET) += vfio_platform_bcmflexrm.o
>> >> diff --git a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
>> >> new file mode 100644
>> >> index 0000000..966a813
>> >> --- /dev/null
>> >> +++ b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
>> >> @@ -0,0 +1,100 @@
>> >> +/*
>> >> + * Copyright (C) 2017 Broadcom
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify
>> >> + * it under the terms of the GNU General Public License version 2 as
>> >> + * published by the Free Software Foundation.
>> >> + *
>> >> + * This program is distributed in the hope that it will be useful,
>> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >> + * GNU General Public License for more details.
>> >> + *
>> >> + * You should have received a copy of the GNU General Public License
>> >> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> >> + */
>> >> +
>> >> +/*
>> >> + * This driver provides reset support for Broadcom FlexRM ring manager
>> >> + * to VFIO platform.
>> >> + */
>> >> +
>> >> +#include <linux/delay.h>
>> >> +#include <linux/init.h>
>> >> +#include <linux/io.h>
>> >> +#include <linux/kernel.h>
>> >> +#include <linux/module.h>
>> >> +
>> >> +#include "vfio_platform_private.h"
>> >> +
>> >> +/* FlexRM configuration */
>> >> +#define RING_REGS_SIZE                                       0x10000
>> >> +#define RING_VER_MAGIC                                       0x76303031
>> >> +
>> >> +/* Per-Ring register offsets */
>> >> +#define RING_VER                                     0x000
>> >> +#define RING_CONTROL                                 0x034
>> >> +#define RING_FLUSH_DONE                                      0x038
>> >> +
>> >> +/* Register RING_CONTROL fields */
>> >> +#define CONTROL_FLUSH_SHIFT                          5
>> >> +
>> >> +/* Register RING_FLUSH_DONE fields */
>> >> +#define FLUSH_DONE_MASK                                      0x1
>> >> +
>> >> +static int vfio_platform_bcmflexrm_shutdown(void __iomem *ring)
>> >> +{
>> >> +     unsigned int timeout;
>> >> +
>> >> +     /* Disable/inactivate ring */
>> >> +     writel_relaxed(0x0, ring + RING_CONTROL);
>> >> +
>> >> +     /* Flush ring with timeout of 1s */
>> >> +     timeout = 1000;
>> >
>> > Perhaps a #define for this value?
>>
>> This magic value 1000 makes it explicit that we try till 1 second
>> because inside the loop we have mdelay(1).
>>
>> >
>> >> +     writel_relaxed(BIT(CONTROL_FLUSH_SHIFT), ring + RING_CONTROL);
>> >> +     do {
>> >> +             if (readl_relaxed(ring + RING_FLUSH_DONE) & FLUSH_DONE_MASK)
>> >> +                     break;
>> >> +             mdelay(1);
>> >> +     } while (--timeout);
>> >> +
>> >> +     if (!timeout) {
>> >> +             pr_warn("VFIO FlexRM shutdown timeout\n");
>
> Since you're planning a new version anyway, perhaps we could also pass
> the device through and use a dev_warn here so we can associate this
> error to a specific device.  Perhaps even knowing which ring on the
> device encountered the timeout would be useful.  Thanks,

Sure, will do.

Regards,
Anup
