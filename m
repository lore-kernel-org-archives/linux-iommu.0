From: Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: RE: [PATCH v6 17/18] vfio/type1: Check MSI remapping at irq domain
 level
Date: Fri, 6 Jan 2017 08:50:20 +0000
Message-ID: <AM5PR0401MB25454B0C8F6E610A50B299D19A630@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-18-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483643086-2883-18-git-send-email-eric.auger@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "drjones@redhat.com" <drjones@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pranav.sawargaonkar@gmail.com" <pranav.sawargaonkar@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "punit.agrawal@arm.com" <punit.agrawal@arm.com>, Diana Madalina Craciun <diana.craciun@nxp.com>, "gpkulkarni@gmail.com" <gpkulkarni@gmail.com>, "shankerd@codeaurora.org" <shankerd@codeaurora.org>, "geethasowjanya.akula@gmail.com" <geethasowjanya.akula@gmail.com>
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: Friday, January 06, 2017 12:35 AM
> To: eric.auger@redhat.com; eric.auger.pro@gmail.com;
> christoffer.dall@linaro.org; marc.zyngier@arm.com;
> robin.murphy@arm.com; alex.williamson@redhat.com;
> will.deacon@arm.com; joro@8bytes.org; tglx@linutronix.de;
> jason@lakedaemon.net; linux-arm-kernel@lists.infradead.org
> Cc: kvm@vger.kernel.org; drjones@redhat.com; linux-
> kernel@vger.kernel.org; pranav.sawargaonkar@gmail.com;
> iommu@lists.linux-foundation.org; punit.agrawal@arm.com; Diana Madalina
> Craciun <diana.craciun@nxp.com>; gpkulkarni@gmail.com;
> shankerd@codeaurora.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
> geethasowjanya.akula@gmail.com
> Subject: [PATCH v6 17/18] vfio/type1: Check MSI remapping at irq domain
> level
>=20
> In case the IOMMU translates MSI transactions (typical case on ARM), we
> check MSI remapping capability at IRQ domain level. Otherwise it is check=
ed
> at IOMMU level.
>=20
> At this stage the arm-smmu-(v3) still advertise the
> IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be removed
> in subsequent patches.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v6: rewrite test
> ---
>  drivers/vfio/vfio_iommu_type1.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c index b473ef80..fa0b5c4 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -40,6 +40,7 @@
>  #include <linux/mdev.h>
>  #include <linux/notifier.h>
>  #include <linux/dma-iommu.h>
> +#include <linux/irqdomain.h>
>=20
>  #define DRIVER_VERSION  "0.2"
>  #define DRIVER_AUTHOR   "Alex Williamson
> <alex.williamson@redhat.com>"
> @@ -1208,7 +1209,7 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
>  	struct vfio_domain *domain, *d;
>  	struct bus_type *bus =3D NULL, *mdev_bus;
>  	int ret;
> -	bool resv_msi;
> +	bool resv_msi, msi_remap;
>  	phys_addr_t resv_msi_base;
>=20
>  	mutex_lock(&iommu->lock);
> @@ -1284,8 +1285,10 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
>=20
> -	if (!allow_unsafe_interrupts &&
> -	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
> +	msi_remap =3D resv_msi ? irq_domain_check_msi_remap() :

There can be multiple interrupt-controller, at-least theoretically it is po=
ssible and not sure practically it exists and supported, where not all may =
support IRQ_REMAP. If that is the case be then should we check for IRQ-REMA=
P for that device-bus irq-domain?

Thanks
-Bharat

> +				iommu_capable(bus,
> IOMMU_CAP_INTR_REMAP);
> +
> +	if (!allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the
> module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support
> on this platform\n",
>  		       __func__);
>  		ret =3D -EPERM;
> --
> 1.9.1
