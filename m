From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Mon, 19 May 2014 22:32:33 +0200
Message-ID: <20140519203232.GD30737@mithrandir>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<4391809.OTRCiJQXS4@wuerfel> <20140519125336.GA9466@ulmo>
	<20140519172113.GA13858@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1514826189690655445=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140519172113.GA13858-M5GwZQ6tE7x5pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1514826189690655445==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2014 at 06:22:31PM +0100, Dave Martin wrote:
> On Mon, May 19, 2014 at 01:53:37PM +0100, Thierry Reding wrote:
[...]
> > My understanding here is mostly based on the OpenFirmware working group
> > proposal for the dma-ranges property[0]. I'll give another example to
> > try and clarify how I had imagined this to work:
> >=20
> > 	/ {
> > 		#address-cells =3D <2>;
> > 		#size-cells =3D <2>;
> >=20
> > 		iommu {
> > 			/*
> > 			 * This is somewhat unusual (or maybe not) in that we
> > 			 * need 2 cells to represent the size of an address
> > 			 * space that is 32 bits long.
> > 			 */
> > 			#address-cells =3D <1>;
> > 			#size-cells =3D <2>;
> >=20
> > 			#iommu-cells =3D <1>;
> > 		};
> >=20
> > 		master {
> > 			iommus =3D <&/iommu 42>;
>=20
> Comparing this with the other discussion thread, we have a similar
> concept here, in that the iommu is made a logical parent, however...
>=20
> Firstly, there's an implicit assumption here that the only kind of
> thing the master could possibly be connected to is an IOMMU, with
> no non-trivial interconnect in between.  I'm not sure this is going
> to scale to complex SoCs.

Here we go again. We're now in the very same bad spot that we've been in
so many times before. There are at least two SoCs that we know do not
require anything fancy, yet we're blocking adding support for those use
cases because we think that at some point some IOMMU may require more
than that. But at the same time it seems like we don't have enough data
about what exactly that is, so we keep speculating. At this rate we're
making it impossible to get a reasonable feature set supported upstream.

That's very frustrating.

> If a range of Stream IDs may be issued (especially from something like
> a PCIe RC where the stream ID may be a many-bit value), describing
> the IDs individually may be impractical.

The IOMMU specifier is completely specific to the IOMMU. If an IOMMU has
a need to represent the stream IDs as a range there's nothing keeping it
=66rom defining the specifier accordingly.

Thierry

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTempgAAoJEN0jrNd/PrOh49UQAJaXjkkOPMxasxWoF9dWXyYC
/sF7hp4FG3rp2tJokX5tEtEd9/GM1SSSqYWcoHv1I6Hmhn3WHGiJCQwWYBjxheHW
ftSQsqKvai99taKs+kZH0MEg/4MbReA13bk6HJvIuftxl+KyPhAYxtIJu/ewAIro
CZcMBbVpMg4UF2yDkB9VtjVTnRy2OdgbHwfsh73Dcr129Ultm380uf5X3MSJ9Z/B
FYxiVFmQV+JGD2UzCg6cdOURdlY/xI7/UJ1AowXzhfBw/HJJ0hXHHYF4hwdhyo2f
OVqjb1wv6v6uWPqny9uiyX1HDM6nMkDRkTnXPue/jYkI8+MWkdXghNzCv5XofY8K
ncjo5Iew2SGV9bM7qrrGEPNCex9SojATzNdBxhGMRJcUkzXx/LU6XiHxc52FJdX0
glREVlhzMcU51IG03CbJIISJJ6eNgypSocdLYBgjzI7V0uELRc0Pb2SdPjwmdumU
BTQnTIEm9TIz+Jz6t5oH9/URkv5n9L57KOAusWi/Snzgu3SVnwoJwLBQVoEhfL3e
gl6i8Xz1mdOSeQm79SkPmC8o4817HvC9RQT6LJEJdAJBab2tI/r4zwZqw6uBDU6M
LUiccDtUYzTF9h14ZKLvgmvY0v0LVZCYb7aDSoOBD2Q3xgCFiXXzj479lrvF3O/b
6gqRHs5qDXwVP7jTlOm2
=SkCa
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

--===============1514826189690655445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1514826189690655445==--
