From: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v6 17/18] vfio/type1: Check MSI remapping at irq domain
	level
Date: Fri, 6 Jan 2017 09:31:03 +0000
Message-ID: <AM5PR0401MB2545F1BFDFD57FC8D48E45C59A630@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
	<1483643086-2883-18-git-send-email-eric.auger@redhat.com>
	<AM5PR0401MB25454B0C8F6E610A50B299D19A630@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<af612e18-ca0b-b855-e198-d4c706f2febc@redhat.com>
	<845d7167-6734-03c9-4df6-2f82f1627dbc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <845d7167-6734-03c9-4df6-2f82f1627dbc-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org" <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: "drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "punit.agrawal-5wv7dgnIgG8@public.gmane.org" <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier-5wv7dgnIgG8@public.gmane.org]
> Sent: Friday, January 06, 2017 2:50 PM
> To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; Bharat Bhushan
> <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; punit.agrawal-5wv7dgnIgG8@public.gmane.org; Diana Madalina
> Craciun <diana.craciun-3arQi8VN3Tc@public.gmane.org>; gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Subject: Re: [PATCH v6 17/18] vfio/type1: Check MSI remapping at irq
> domain level
> 
> On 06/01/17 09:08, Auger Eric wrote:
> > Hi Bharat
> >
> > On 06/01/2017 09:50, Bharat Bhushan wrote:
> >> Hi Eric,
> >>
> >>> -----Original Message-----
> >>> From: Eric Auger [mailto:eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> >>> Sent: Friday, January 06, 2017 12:35 AM
> >>> To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> >>> christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; marc.zyngier-5wv7dgnIgG8@public.gmane.org;
> >>> robin.murphy-5wv7dgnIgG8@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> >>> will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org;
> >>> jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> >>> Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; linux-
> >>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> >>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; punit.agrawal-5wv7dgnIgG8@public.gmane.org; Diana
> >>> Madalina Craciun <diana.craciun-3arQi8VN3Tc@public.gmane.org>; gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;
> >>> shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; Bharat Bhushan
> <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>;
> >>> geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> >>> Subject: [PATCH v6 17/18] vfio/type1: Check MSI remapping at irq
> >>> domain level
> >>>
> >>> In case the IOMMU translates MSI transactions (typical case on ARM),
> >>> we check MSI remapping capability at IRQ domain level. Otherwise it
> >>> is checked at IOMMU level.
> >>>
> >>> At this stage the arm-smmu-(v3) still advertise the
> >>> IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be
> removed
> >>> in subsequent patches.
> >>>
> >>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>>
> >>> ---
> >>>
> >>> v6: rewrite test
> >>> ---
> >>>  drivers/vfio/vfio_iommu_type1.c | 9 ++++++---
> >>>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/vfio/vfio_iommu_type1.c
> >>> b/drivers/vfio/vfio_iommu_type1.c index b473ef80..fa0b5c4 100644
> >>> --- a/drivers/vfio/vfio_iommu_type1.c
> >>> +++ b/drivers/vfio/vfio_iommu_type1.c
> >>> @@ -40,6 +40,7 @@
> >>>  #include <linux/mdev.h>
> >>>  #include <linux/notifier.h>
> >>>  #include <linux/dma-iommu.h>
> >>> +#include <linux/irqdomain.h>
> >>>
> >>>  #define DRIVER_VERSION  "0.2"
> >>>  #define DRIVER_AUTHOR   "Alex Williamson
> >>> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
> >>> @@ -1208,7 +1209,7 @@ static int
> vfio_iommu_type1_attach_group(void
> >>> *iommu_data,
> >>>  	struct vfio_domain *domain, *d;
> >>>  	struct bus_type *bus = NULL, *mdev_bus;
> >>>  	int ret;
> >>> -	bool resv_msi;
> >>> +	bool resv_msi, msi_remap;
> >>>  	phys_addr_t resv_msi_base;
> >>>
> >>>  	mutex_lock(&iommu->lock);
> >>> @@ -1284,8 +1285,10 @@ static int
> vfio_iommu_type1_attach_group(void
> >>> *iommu_data,
> >>>  	INIT_LIST_HEAD(&domain->group_list);
> >>>  	list_add(&group->next, &domain->group_list);
> >>>
> >>> -	if (!allow_unsafe_interrupts &&
> >>> -	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
> >>> +	msi_remap = resv_msi ? irq_domain_check_msi_remap() :
> >>
> >> There can be multiple interrupt-controller, at-least theoretically it is
> possible and not sure practically it exists and supported, where not all may
> support IRQ_REMAP. If that is the case be then should we check for IRQ-
> REMAP for that device-bus irq-domain?
> >>
> > I mentioned in the cover letter that the approach was defensive and
> > rough today. As soon as we detect an MSI controller in the platform
> > that has no support for MSI remapping we flag the assignment as
> > unsafe. I think this approach was agreed on the ML. Such rough
> > assessment was used in the past on x86.
> >
> > I am reluctant to add more complexity at that stage. This can be
> > improved latter I think when such platforms show up.
> 
> I don't think this is worth it. If the system is so broken that the designer
> cannot make up their mind about device isolation, too bad.
> People will either disable the non-isolating MSI controller altogether, or force
> the unsafe flag.

Understand, just want to be sure that this is a known limitation. It will be good if we have some comment around this function.

Thanks
-Bharat

> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
