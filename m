From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v4 15/16] vfio/type1: Check MSI remapping at irq domain level
Date: Fri, 23 Dec 2016 16:13:24 +0100
Message-ID: <72057deb-cc71-33f1-e96a-ed2c96a99c3b@redhat.com>
References: <1481661034-3088-1-git-send-email-eric.auger@redhat.com>
	<1481661034-3088-16-git-send-email-eric.auger@redhat.com>
	<HE1PR04MB13219CC90CE2BBE62356D94CFF920@HE1PR04MB1321.eurprd04.prod.outlook.com>
	<3ead0cc1-7798-3e39-da56-c18a5989c00c@redhat.com>
	<CANHdaibH3GCFhM4nXh1KJoFhZCodtWo7KfP7AcSoVD0HwjDWfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANHdaibH3GCFhM4nXh1KJoFhZCodtWo7KfP7AcSoVD0HwjDWfg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geetha Akula <geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org" <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "punit.agrawal-5wv7dgnIgG8@public.gmane.org" <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geetha,

On 23/12/2016 14:33, Geetha Akula wrote:
> Hi Eric,
> 
> Seeing same issue reported by Diana on ThunderX with you
> v4.9-reserved-v4 branch.
> Vfio passthough work fine when allow_unsafe_interrupts is set.
Thank you for testing! I will fix the security assessment by better
studying flag propagation in domain hierarchy.

Best Regards

Eric

> 
> 
> Thank you,
> Geetha.
> 
> On Thu, Dec 22, 2016 at 6:32 PM, Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> <mailto:eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>> wrote:
> 
>     Hi Diana,
> 
>     On 22/12/2016 13:41, Diana Madalina Craciun wrote:
>     > Hi Eric,
>     >
>     > On 12/13/2016 10:32 PM, Eric Auger wrote:
>     >> In case the IOMMU does not bypass MSI transactions (typical
>     >> case on ARM), we check all MSI controllers are IRQ remapping
>     >> capable. If not the IRQ assignment may be unsafe.
>     >>
>     >> At this stage the arm-smmu-(v3) still advertise the
>     >> IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be
>     >> removed in subsequent patches.
>     >>
>     >> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
>     <mailto:eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>
>     >> ---
>     >>  drivers/vfio/vfio_iommu_type1.c | 9 ++++++---
>     >>  1 file changed, 6 insertions(+), 3 deletions(-)
>     >>
>     >> diff --git a/drivers/vfio/vfio_iommu_type1.c
>     b/drivers/vfio/vfio_iommu_type1.c
>     >> index d07fe73..a05648b 100644
>     >> --- a/drivers/vfio/vfio_iommu_type1.c
>     >> +++ b/drivers/vfio/vfio_iommu_type1.c
>     >> @@ -37,6 +37,7 @@
>     >>  #include <linux/vfio.h>
>     >>  #include <linux/workqueue.h>
>     >>  #include <linux/dma-iommu.h>
>     >> +#include <linux/irqdomain.h>
>     >>
>     >>  #define DRIVER_VERSION  "0.2"
>     >>  #define DRIVER_AUTHOR   "Alex Williamson
>     <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org <mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>>"
>     >> @@ -765,7 +766,7 @@ static int vfio_iommu_type1_attach_group(void
>     *iommu_data,
>     >>      struct vfio_domain *domain, *d;
>     >>      struct bus_type *bus = NULL;
>     >>      int ret;
>     >> -    bool resv_msi;
>     >> +    bool resv_msi, msi_remap;
>     >>      phys_addr_t resv_msi_base;
>     >>
>     >>      mutex_lock(&iommu->lock);
>     >> @@ -818,8 +819,10 @@ static int
>     vfio_iommu_type1_attach_group(void *iommu_data,
>     >>      INIT_LIST_HEAD(&domain->group_list);
>     >>      list_add(&group->next, &domain->group_list);
>     >>
>     >> -    if (!allow_unsafe_interrupts &&
>     >> -        !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
>     >> +    msi_remap = resv_msi ? irq_domain_check_msi_remap() :
>     >> +                           iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
>     >> +
>     >> +    if (!allow_unsafe_interrupts && !msi_remap) {
>     >>              pr_warn("%s: No interrupt remapping support.  Use
>     the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU
>     support on this platform\n",
>     >>                     __func__);
>     >>              ret = -EPERM;
>     >
>     > I tested your v4.9-reserved-v4 branch on a ITS capable hardware (NXP
>     > LS2080), so I did not set allow_unsafe_interrupts. It fails here
>     > complaining that the there is no interrupt remapping support. The
>     > irq_domain_check_msi_remap function returns false as none of the
>     checked
>     > domains has the IRQ_DOMAIN_FLAG_MSI_REMAP flag set. I think the reason
>     > is that the flags are not propagated through the domain hierarchy when
>     > the domain is created.
> 
>     Hum OK. Please apologize for the inconvenience, all the more so this is
>     the second time you report the same issue for different cause :-( At the
>     moment I can't test on a GICv3 ITS based system. I will try to fix that
>     though.
> 
>     I would like to get the confirmation introducing this flag is the right
>     direction though.
> 
>     Thanks
> 
>     Eric
>     >
>     > Thanks,
>     >
>     > Diana
>     >
>     >
>     >
> 
>     _______________________________________________
>     linux-arm-kernel mailing list
>     linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>     <mailto:linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>     <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>
> 
> 
