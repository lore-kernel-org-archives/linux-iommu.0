From: =?iso-8859-1?Q?GAUGUEY_R=E9my_228890?= <remy.gauguey@cea.fr>
Subject: [PATCH v3 4/6] vfio: type1: replace domain wide protection flags
 with supported capabilities
Date: Thu, 29 Jan 2015 12:24:14 +0000
Message-ID: <022C7612790E20489F80A6F0D54B849F3B2C11AD@EXDAG0-B1.intra.cea.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: fr-FR
Sender: linux-kernel-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "open list:VFIO DRIVER" <kvm@vger.kernel.org>, "will.deacon@arm.com" <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org

Hi Antonios,=20

On Thu, 27 Nov 2014 18:22:53 Antonios Motakis wrote:
>VFIO_IOMMU_TYPE1 keeps track for each domain it knows a list of protec=
tion
>flags it always applies to all mappings in the domain. This is used fo=
r
>domains that support IOMMU_CAP_CACHE_COHERENCY.
>
>Refactor this slightly, by keeping track instead that a given domain
>supports the capability, and applying the IOMMU_CACHE protection flag =
when
>doing the actual DMA mappings.
>
>This will allow us to reuse the behavior for IOMMU_CAP_NOEXEC, which w=
e
>also want to keep track of, but without applying it to all domains tha=
t
>support it unless the user explicitly requests it.
>
>Signed-off-by: Antonios Motakis <a.motakis@xxxxxxxxxxxxxxxxxxxxxx>
>---
> drivers/vfio/vfio_iommu_type1.c | 25 +++++++++++++++++--------
> 1 file changed, 17 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu=
_type1.c
>index 4a9d666..c54dab8 100644
>--- a/drivers/vfio/vfio_iommu_type1.c
>+++ b/drivers/vfio/vfio_iommu_type1.c
> 			if (ret)
> 				return ret;
>=20
>@@ -731,7 +740,7 @@ static int vfio_iommu_type1_attach_group(void *iom=
mu_data,
> 	}
>=20
> 	if (iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
>-		domain->prot |=3D IOMMU_CACHE;
>+		domain->caps |=3D IOMMU_CAP_CACHE_COHERENCY;

IMHO this is not good since IOMMU_CAP_CACHE_COHERENCY is not a bitfield=
 but an enum=20
See include/linux/iommu.h=20
enum iommu_cap {
	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
					   transactions */
	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
};
One possible fix would to redefine the enum with values with bitfiled v=
alues
enum iommu_cap {
	IOMMU_CAP_CACHE_COHERENCY =3D 1, /* IOMMU can enforce cache coherent D=
MA
					   transactions */
	IOMMU_CAP_INTR_REMAP =3D 2,	/* IOMMU supports interrupt isolation */
	IOMMU_CAP_NOEXEC =3D 4,		/* IOMMU_NOEXEC flag */
};

Regards
R=E9my

>_______________________________________________
>kvmarm mailing list
>kvmarm@xxxxxxxxxxxxxxxxxxxxx
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
