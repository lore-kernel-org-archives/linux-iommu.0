From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 4 Jun 2014 23:32:00 +0200
Message-ID: <20140604213159.GB18780@mithrandir>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
	<20140530112226.GA3949@e103592.cambridge.arm.com>
	<4830064.JvgTAs8Xty@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7145590475466759764=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4830064.JvgTAs8Xty@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7145590475466759764==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2014 at 09:01:19PM +0200, Arnd Bergmann wrote:
> On Friday 30 May 2014 12:22:32 Dave Martin wrote:
> > > +
> > > +Examples:
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Single-master IOMMU:
> > > +--------------------
> > > +
> > > +	iommu {
> > > +		#address-cells =3D <0>;
> > > +		#size-cells =3D <0>;
> > > +	};
> > > +
> > > +	master {
> > > +		iommus =3D <&/iommu>;
> > > +	};
> > > +
> > > +Multiple-master IOMMU with fixed associations:
> > > +----------------------------------------------
> > > +
> > > +	/* multiple-master IOMMU */
> > > +	iommu {
> > > +		/*
> > > +		 * Masters are statically associated with this IOMMU and
> > > +		 * address translation is always enabled.
> > > +		 */
> > > +		#address-cells =3D <0>;
> > > +		#size-cells =3D <0>;
> >=20
> > In this example, can different translations be set up for the different
> > masters?
> >=20
> > With no cells available to contain any sort of ID, it looks like this
> > is not possible.
>=20
> Correct, this example is for an IOMMU that does not use IDs but has a
> shared address space for all devices.

Couldn't these device all still have separate address spaces?

Thierry

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTj5BPAAoJEN0jrNd/PrOhGcQP/A2I75o+TqycvUJtqqiz5AQC
bh2K9rRqbUgQoBTnAwD4oOmnM50zXpxxOd+1OAEE9Q6mRFw4FpZqGmHnkep89LtR
mh9grCRO6rqnLjt/98K2KzRdW5vtJ0PvuBHsyPW1VIhXr1vp114YkV7+bMqsrtwe
TN3W5YPZLw/vfG4VJV+lkFji3AHFgBnJgvOx12T4eiX4RoTzW4wvNzFsP+2dr50L
rythOupdjbDufTMqoWB4bmXDQBUc5FHax+jTxzAPpLAumTvWn5f3hUjfutPVPzrj
JTy3xkdIXtx+yhLf3DFzMvoWiLbS0xnu1+qJ9xp8Av6R8fCWKLyG/SkP2FAKfWCb
qc4yxogkG49yXIeLteuCFwO3SGqVMeN0b5jWPiuyBWq1avbZq1vJkfExzV+KdAxy
u0wVHxX12ab/NW+lfl2UHRdoNxJdcaVXSdrxlo6UHTptwjKiOiknf+KNQooHU3wr
LJ0dNc2Pay96PLElOkwP/Cv5iZjlp0IeZxvM4/lpYRZc4xxnl1V1gROmWTJGTUcY
m3CXyZ0hJhWBddoDODPeaY7oua2VjeEeZ8nBPkFZncvw9cezPH6EVH/+wLjxGKcG
lWWo7bT6XH4ZFjKp3tU5/J3gAnTAPHrDiOfpQWVns//jh7DHH0EdZCVvAtKpo6re
azJUtvUntUZEH6CGSCXy
=PEUa
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

--===============7145590475466759764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7145590475466759764==--
