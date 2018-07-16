From: Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Clean up pasid quirk for
	pre-production devices"
Date: Mon, 16 Jul 2018 15:53:09 +0800
Message-ID: <20180716075309.GN1267@zhen-hp.sh.intel.com>
References: <1531031001-5783-1-git-send-email-baolu.lu@linux.intel.com>
	<5B4C34E4.30004@linux.intel.com>
Reply-To: Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7704700869497265899=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5B4C34E4.30004-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7704700869497265899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kd7cwL6IYJrQFfWn"
Content-Disposition: inline


--kd7cwL6IYJrQFfWn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.07.16 14:02:12 +0800, Lu Baolu wrote:
> Hi Joerg,
>=20
> The graphic guys are looking forward to having this in 4.18.
> Is it possible to take it in the following rcs?
>=20

This breakes intel gfx driver in 4.18 when gfx dmar is on.
Please include this fix ASAP.

Tested-by: Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

thanks!

>=20
> On 07/08/2018 02:23 PM, Lu Baolu wrote:
> > This reverts commit ab96746aaa344fb720a198245a837e266fad3b62.
> >
> > The commit ab96746aaa34 ("iommu/vt-d: Clean up pasid quirk for
> > pre-production devices") triggers ECS mode on some platforms
> > which have broken ECS support. As the result, graphic device
> > will be inoperable on boot.
> >
> > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D107017
> >
> > Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/iommu/intel-iommu.c | 32 ++++++++++++++++++++++++++++++--
> >  include/linux/intel-iommu.h |  1 +
> >  2 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index b344a88..115ff26 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -484,14 +484,37 @@ static int dmar_forcedac;
> >  static int intel_iommu_strict;
> >  static int intel_iommu_superpage =3D 1;
> >  static int intel_iommu_ecs =3D 1;
> > +static int intel_iommu_pasid28;
> >  static int iommu_identity_mapping;
> > =20
> >  #define IDENTMAP_ALL		1
> >  #define IDENTMAP_GFX		2
> >  #define IDENTMAP_AZALIA		4
> > =20
> > -#define ecs_enabled(iommu)	(intel_iommu_ecs && ecap_ecs(iommu->ecap))
> > -#define pasid_enabled(iommu)	(ecs_enabled(iommu) && ecap_pasid(iommu->=
ecap))
> > +/* Broadwell and Skylake have broken ECS support =E2=80=94 normal so-c=
alled "second
> > + * level" translation of DMA requests-without-PASID doesn't actually h=
appen
> > + * unless you also set the NESTE bit in an extended context-entry. Whi=
ch of
> > + * course means that SVM doesn't work because it's trying to do nested
> > + * translation of the physical addresses it finds in the process page =
tables,
> > + * through the IOVA->phys mapping found in the "second level" page tab=
les.
> > + *
> > + * The VT-d specification was retroactively changed to change the defi=
nition
> > + * of the capability bits and pretend that Broadwell/Skylake never hap=
pened...
> > + * but unfortunately the wrong bit was changed. It's ECS which is brok=
en, but
> > + * for some reason it was the PASID capability bit which was redefined=
 (from
> > + * bit 28 on BDW/SKL to bit 40 in future).
> > + *
> > + * So our test for ECS needs to eschew those implementations which set=
 the old
> > + * PASID capabiity bit 28, since those are the ones on which ECS is br=
oken.
> > + * Unless we are working around the 'pasid28' limitations, that is, by=
 putting
> > + * the device into passthrough mode for normal DMA and thus masking th=
e bug.
> > + */
> > +#define ecs_enabled(iommu) (intel_iommu_ecs && ecap_ecs(iommu->ecap) &=
& \
> > +			    (intel_iommu_pasid28 || !ecap_broken_pasid(iommu->ecap)))
> > +/* PASID support is thus enabled if ECS is enabled and *either* of the=
 old
> > + * or new capability bits are set. */
> > +#define pasid_enabled(iommu) (ecs_enabled(iommu) &&			\
> > +			      (ecap_pasid(iommu->ecap) || ecap_broken_pasid(iommu->ecap)))
> > =20
> >  int intel_iommu_gfx_mapped;
> >  EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
> > @@ -554,6 +577,11 @@ static int __init intel_iommu_setup(char *str)
> >  			printk(KERN_INFO
> >  				"Intel-IOMMU: disable extended context table support\n");
> >  			intel_iommu_ecs =3D 0;
> > +		} else if (!strncmp(str, "pasid28", 7)) {
> > +			printk(KERN_INFO
> > +				"Intel-IOMMU: enable pre-production PASID support\n");
> > +			intel_iommu_pasid28 =3D 1;
> > +			iommu_identity_mapping |=3D IDENTMAP_GFX;
> >  		} else if (!strncmp(str, "tboot_noforce", 13)) {
> >  			printk(KERN_INFO
> >  				"Intel-IOMMU: not forcing on after tboot. This could expose securi=
ty risk for tboot\n");
> > diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> > index 1df9401..ef169d6 100644
> > --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -121,6 +121,7 @@
> >  #define ecap_srs(e)		((e >> 31) & 0x1)
> >  #define ecap_ers(e)		((e >> 30) & 0x1)
> >  #define ecap_prs(e)		((e >> 29) & 0x1)
> > +#define ecap_broken_pasid(e)	((e >> 28) & 0x1)
> >  #define ecap_dis(e)		((e >> 27) & 0x1)
> >  #define ecap_nest(e)		((e >> 26) & 0x1)
> >  #define ecap_mts(e)		((e >> 25) & 0x1)
>=20

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--kd7cwL6IYJrQFfWn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCW0xO5QAKCRCxBBozTXgY
JxcqAJ4q4apZs8P0KaW9SpeNJw7O+zpxQQCfXxLa3d/Ii8e/v/W8dEcKrZMlpxM=
=r6f5
-----END PGP SIGNATURE-----

--kd7cwL6IYJrQFfWn--

--===============7704700869497265899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7704700869497265899==--
