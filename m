From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for
	IOMMU drivers
Date: Tue, 2 Dec 2014 13:05:24 +0100
Message-ID: <20141202120523.GA7134@ulmo>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
	<547D84F4.8030204@samsung.com> <2039644.fesfKXTybP@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5407219640190893059=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2039644.fesfKXTybP@wuerfel>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============5407219640190893059==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2014 at 10:36:59AM +0100, Arnd Bergmann wrote:
> On Tuesday 02 December 2014 10:23:00 Marek Szyprowski wrote:
> > >> +static inline void of_iommu_set_ops(struct device_node *np,
> > >> +                                   const struct iommu_ops *ops)
> > >> +{
> > >> +       np->data =3D (struct iommu_ops *)ops;
> > >> +}
> > >> +
> > >> +static inline struct iommu_ops *of_iommu_get_ops(struct device_node=
 *np)
> > >> +{
> > >> +       return np->data;
> > >> +}
> > > This may collide with other users. While use of it is rare, PPC uses
> > > it in its PCI code. The OF_DYNAMIC code frees it but never actually
> > > sets it. There may be some coming usage with the DT overlay code or
> > > that's just a bug. Pantelis or Grant can comment. If not, I think we
> > > really should try to get rid of this pointer rather than expand it's
> > > usage.
> >=20
> > I think that for the initial version it is ok to use np->data. When=20
> > per-iommu
> > controller structure is introduced later, it can be reused also for=20
> > performing
> > of_node to iommu_ops lookup, because IOMMU framework will need to keep =
track
> > on all such iommu controllers anyway.
>=20
> Agreed. I think in the long run, we will have a 'struct iommu' that is
> added into a global linked list and that contains (among other things)
> an iommu_ops pointer and a device_node pointer. The of_iommu_get_ops
> function then walks the list to find the right iommu instance.

If we end up doing that, how is this any different from what Hiroshi and
I initially proposed over a year ago (and then again earlier this year)?

The only remaining difference would be that this current proposal needs
IOMMUs to be registered even before other devices are instantiated for
no apparent reason other than ordering. The original proposal allowed
the IOMMU driver to register just like any other driver and ordering to
be handled via deferred probing.

Thierry

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUfasDAAoJEN0jrNd/PrOhx0oP/1+H6DleTHzi/ueblhUp9lTd
1OjufAVAxkYN1MxM4y0AFE99nW2y8ZrLlEe6FQiNHrh69tKOJtzOlc2w1/JSALyX
wE/mHmT0R1Dm5QY6A+0qSBmd/lMbTgvHToxK1SZEPLKwMH9+Wq3813SoKBs88KBJ
ap+nQgxH25mDcfUGmS+n0hMvR54dwmdaiB1Vj3Y8t9ko8MqI5bPAchmsBlxp6CKR
WwT377BlGT0wB+ROPr1IYMs14UL3drhu0FXmegAN2oi/Xkhi+r+sZRP1uXJvTCEE
+M+jLCeueZOevVbruqAWa0EnvQP7E3JAsj+23CvyoNkI+TeNjhpyC8LzJdtGSE37
50Ib9ufy3hjtaUm0ZUfj5hhfKhtXdZ6Uod7WzVratEW7kH7W5iZ//h8Znuu+xBuq
k2a+Fl4OO2I8weWAom9TLZuvyE9bfdLb70apUwoxYXDEAGyfn7fi7nVm8Bat3atu
1vCSkkI4+FFkXCKjxTX0vp7520hvjAV0EJl/543bP5dQ7tpMwIsfXIKNyXqcLFk2
dXuaI5OBVQoX+FpmffjSTxI0Gsfur7gk/XBVQa91+SaAAL6FegycZ9bKJXsYaWaI
OT1FTSX4aCg3N0UkRkHakNPyQG2LO6XEfKqfSJwcaB99zIY6NWRmGUTS1gzjXu1d
10u62jJKwCBfTL9kUS+r
=Klb3
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--===============5407219640190893059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5407219640190893059==--
