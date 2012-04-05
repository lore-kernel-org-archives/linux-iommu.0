From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Thu, 5 Apr 2012 18:23:18 +0200
Message-ID: <20120405162318.GA10628@avionic-0098.adnet.avionic-design.de>
References: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
	<4F7DBCEE.9080400@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6795570754849911294=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <4F7DBCEE.9080400-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============6795570754849911294==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 04/05/2012 02:42 AM, Thierry Reding wrote:
> > Hi,
> >=20
> > I have a device tree where I have a GART device and a DRM device which =
uses
> > the GART. The GART is implemented by an IOMMU driver (tegra-gart) and
> > requires the user device to be a child of the GART device (it explicitly
> > checks for this when the user device is attached).
>=20
> Isn't this wrong?
>=20
> I would expect the device parent/child relationship to reflect the
> CPU-initiated register access bus topology.
>=20
> A device's interaction with an IOMMU is an aspect of a device's
> initiating accesses itself, not CPU-initiated register accesses.

Actually I have no idea why this was made a requirement. Maybe Hiroshi can
comment on this. The driver really only needs this to basically obtain a
pointer to itself. The MSM I/O MMU implementation does something similar,
though, and goes on to register actual child devices (they are instantiated
in arch/arm/mach-msm/devices-iommu.c). Each of those devices is then assign=
ed
a specific memory area it seems.

> > I've tried two alternatives to achieve this: create the GART device in =
the
> > user driver's .probe() function and explicitly set the DRM device's par=
ent
> > to the resulting platform device like so:
> >=20
> > 	gart =3D platform_device_alloc(...);
> > 	...
> > 	pdev->dev.parent =3D &gart->dev;
>=20
> I guess that won't work when there's more than one device affected by
> the IOMMU?

I don't think having more than one device using the IOMMU will work properly
anyway in the context of the Tegra GART driver because there is not means to
allocate specific regions of the GART aperture to individual devices. So
really the one and only client actually needs to manage the allocations from
the GART aperture.

I'm also not sure if it makes much sense to use the GART from anything other
than the DRM driver.

> > The alternative is to use the device tree to look up the GART device no=
de and
> > resolve it to the corresponding struct device:
> >=20
> > 	gart_node =3D of_parse_phandle(drm->dev->of_node, "gart-parent", 0);
>=20
> That seems more logical to me.
>=20
> > 	gart =3D bus_find_device(drm->dev->bus, NULL, gart_node, match_of_node=
);
>=20
> That part should probably be encapsulated into the IOMMU subsystem? In
> fact, even the of_parse_phandle should perhaps be hidden inside some
> IOMMU iommu_get() call, that can use DT as a data source, or some other
> data structure set up by board files.

Both of these methods don't work too well because they actually require a
reordering of the device hierarchy at runtime. For some reason this leads to
the mutex becoming confused and the warning that I posted. I came up with a
third alternative that does the reparenting in board-dt-tegra20.c after the
call to of_platform_populate() which works similar to the second version and
gets rid of the warning.

I'm still not at all happy with it, though.

Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk99xvYACgkQZ+BJyKLjJp88ggCfdUM3azY0w1WSNvcv7WpzygBZ
ULcAoIMti26ft92jVZybFf6avWS3STyh
=qNqu
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--

--===============6795570754849911294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6795570754849911294==--
