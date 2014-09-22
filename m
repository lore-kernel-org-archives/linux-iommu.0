From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC][PATCH] devicetree: Add master-id-bits property to the
	iommu device
Date: Mon, 22 Sep 2014 11:23:23 +0200
Message-ID: <20140922092322.GI1470@ulmo>
References: <1410718646-9710-1-git-send-email-Varun.Sethi@freescale.com>
	<201409150438.29649.arnd@arndb.de>
	<bfdff6494d7f46ab9a9f00f94159e9e1@BL2PR03MB468.namprd03.prod.outlook.com>
	<201409151857.05463.arnd@arndb.de>
	<febe4a288f2f438ca95988929ee71580@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2452411381798826894=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <febe4a288f2f438ca95988929ee71580-AZ66ij2kwaacCcN9WK45f+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "Mark.Rutland-5wv7dgnIgG8@public.gmane.org" <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============2452411381798826894==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline


--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2014 at 06:04:48PM +0000, Varun Sethi wrote:
> Hi Arnd,
>=20
> > -----Original Message-----
> > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Arnd Bergmann
> > Sent: Monday, September 15, 2014 10:27 PM
> > To: Sethi Varun-B16395
> > Cc: Mark.Rutland-5wv7dgnIgG8@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; Yoder Stuart-B08248;
> > robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > Subject: Re: [RFC][PATCH] devicetree: Add master-id-bits property to the
> > iommu device
> >=20
> > On Monday 15 September 2014, Varun Sethi wrote:
> > > >
> > > > This seems rather specific to MMU-500. I don't think that most
> > > > IOMMUs would use the term 'master ID', 'stream ID' or even the
> > > > general concept, and you don't expand the acronym 'TBU'. I've seen
> > > > many IOMMUs and I don't even know what that means.
> > >
> > > TBU refers to the translation buffer unit, which is responsible for c=
aching
> > page translations. In case of translation miss in the cache, translatio=
n request is
> > forwarded to the TCU (Translation control unit). The master id forwarde=
d to
> > TCU would also contain the TBU ID.  Using the master-id-bits property w=
e can
> > mask out the additional TBU bits at the TCU. This is a cause of concern=
 when we
> > want to share master id for devices which are connected to different TB=
Us. We
> > have a hot pluggable bus architecture, where a device group can have mu=
ltiple
> > devices connected to different TBUs. So, we need a mechanism to mask out
> > additional TBIU bits.
> >=20
> > Ok, I think I understand now
> >=20
> > > > Why do you think this is something that is needed to be known at the
> > > > global level, rather than a property for some individual drivers?
> > > >
> > > In case of Freescale Layerscape SOCs, number of bits used for definin=
g a
> > stream id are specific to a given platform.
> > >
> > > Are you suggesting that this property should be added to the master d=
evice
> > node, rather than the iommu node?
> >=20
> > Most importantly, I think this needs to be part of the (iommu) device s=
pecific
> > binding, not the generic binding that is used for all iommus that may o=
r may not
> > have this concept.
> >=20
> > I believe in case of the ARM SMMU, it should actually go into the maste=
r node
> > as part of the 'iommus' property, because the mask can be different for=
 each
> > master. If your IOMMU has a fixed mask that is used for all devices, th=
at's fine
> > and you can put it into the iommu node itself but document it in the bi=
nding for
> > your IOMMU.
> >=20
> > For hot-pluggable buses, you probably need to have the 'iommus' propert=
y in
> > the node that corresponds to the bus controller, and that will have a m=
ask that
> > is used for all devices plugged into it.
> Can I add a note to the generic binding about representing the "mask"
> as a part of the "iommus" property. This would similar to the note
> about the "dma-ranges"

I think the concept of a mask is fairly device-specific. Adding a note
to it in the generic binding could be confusing to people working with
IOMMUs that don't know the concept.

dma-ranges on the other hand is a generic property, so referring to it
in the generic binding makes sense.

Thierry

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUH+qKAAoJEN0jrNd/PrOh05MP/0OL1tmtGZhZmq5LShiOVggd
m9XL+IKVycTjF++FpmQjwSBSzWFyEoM5SeRfnWZMm+gyTv5euqg5SJF1vUWCUSrI
YK8fhqj9iJZbfW6dP0bKEy+16S+IrsPRJBDBIP7Sp1Lh3dMIm3kR/vW5KgLV1pfR
wViOcuatemB0Dtt3inj6BM3KkQhZl+9u/xZUSMggrAueVW44XkAZ9CxJVlYmGBja
I21Lchn5Vbpwf92l6ZTbFE0M6SKTOcjarXzOIXw647/tK++86CLkbsx5ejDRVntP
uqneT7xde+ope+YC3/BTBUwc9Zg0MFdtjQ4qiK80cpFrt9TtXRJHvSruGqPwkrTL
u2JaPHw7bkoaJBhWCemHYkn0l8/1ft3w+3BtsFrfAMDct0HKghwhUy6GUkK/TXz0
Ta2ZZLXF0E4+jFqd1gTQLYdH0MMSw3WmCUezDX3YhvCiRsjDEk8Oxxw6Nge/sE48
+n+g9nmPoafImtU8nJbJEOSaOv5XUMke/w+nyxUPGEOz09Z2qkfyHNfHULO85iAC
qhxrGmxaXyFJHNOr1kkKUP8Ob6amTA9GdjxdiHaoC6+t1OPafmG6DQQY2fGf8t65
KE8Dc3FA4hWyDzI0OBsxSVRjSYflkOM0LWY2CpKcj3aFq9Js1qxNkaxfaOUaRIb+
ah37VDeyTSDM5G0QA1NO
=inWs
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--

--===============2452411381798826894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2452411381798826894==--
