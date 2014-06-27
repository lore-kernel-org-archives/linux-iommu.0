From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 04/10] memory: Add Tegra124 memory controller support
Date: Fri, 27 Jun 2014 13:15:16 +0200
Message-ID: <20140627111514.GE2797@ulmo>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
	<9283417.yKmnrljUYI@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9180625063192358407=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9283417.yKmnrljUYI@wuerfel>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============9180625063192358407==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2014 at 01:07:04PM +0200, Arnd Bergmann wrote:
> On Thursday 26 June 2014 22:49:44 Thierry Reding wrote:
> > +static const struct tegra_mc_client tegra124_mc_clients[] =3D {
> > +       {
> > +               .id =3D 0x01,
> > +               .name =3D "display0a",
> > +               .swgroup =3D TEGRA_SWGROUP_DC,
> > +               .smmu =3D {
> > +                       .reg =3D 0x228,
> > +                       .bit =3D 1,
> > +               },
> > +               .latency =3D {
> > +                       .reg =3D 0x2e8,
> > +                       .shift =3D 0,
> > +                       .mask =3D 0xff,
> > +                       .def =3D 0xc2,
> > +               },
> > +       }, {
>=20
> This is a rather long table that I assume would need to get duplicated
> and modified for each specific SoC. Have you considered to put the inform=
ation
> into DT instead, as auxiliary data in the iommu specifier as provided by
> the device?

Most of this data really is register information and I don't think that
belongs in DT. Also since this is fixed for a given SoC and in no way
configurable (well, with the exception of the .def field above) I don't
see any point in parsing this from device tree.

Also only the .smmu substruct is immediately relevant to the IOMMU part
of the driver. The .swgroup field could possibly also be moved into that
substructure since it is only relevant to the IOMMU.

So essentially what this table does is map SWGROUPs (which are provided
in the IOMMU specifier) to the clients and registers that the IOMMU
programming needs. As an analogy it corresponds roughly to the pins and
pingroups tables of pinctrl drivers. Those don't belong in device tree
either.

Thierry

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTrVJCAAoJEN0jrNd/PrOhoJwP/3bcyKeMM9rOidAK/YuG2rkx
wxOt4mD+g6YYYCAPjsijMjbzdA17V/PAnSEnLUFQdwnsqD88SCIt2gQsgDdhchN/
KXuWatve2B08m+S0rnaJrTsImcC/uSnKTAgyvOP8brC8zkc+5N04FB+fTiVhz1YE
XPjcib08jgdOsasFyhCRJDHukdDXDjrv8xBhpDBZwuSxVjKWzXJFQPW8Lca8/Qm6
fPxYJftIlMEXq/1CuuG7vEka56bJX7jBJK6qQX2nRBM0jMx55N7z/5fdbFwN2rlU
3dD1fGbcEjcgJiyMABtZJFPHoEtKkQ52S6vtJFMr6NrnaVnQr/Xlmp8j1iBxAE4h
zVwi/v9zHj6371jBaU0YkGp20sSj3+o0mkqTbq4+oOK7q4bWa6Hg2nGIsrgHkZ0K
boVNARzkU4p/iF3MWVSJ23oDSgTtH85hHRUFnzOQySMOb1/2Rd2RdRGhJE/Aypli
pYzgKei3ESWERIf/EKphRTz33johFZGJW65UXOlh39C0Lwzn0ehPPiZvhorIn86E
0kAB73a/Ar2JY7o6AIJnh46YcMJXUTaUJPf7qknfK7GH+YztcVU4yEbhDtvzWjr0
vUf5XREWOb/0WcotPxCTbyslSwdK7AQdBvCIIdOUmoUkw+0owbOpJySgUub8kP6O
lG+7+Jkzm1YqClKMUxvH
=edre
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--

--===============9180625063192358407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9180625063192358407==--
