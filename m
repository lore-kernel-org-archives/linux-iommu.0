From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Sat, 7 Apr 2012 13:35:10 +0200
Message-ID: <20120407113510.GA22116@avionic-0098.mockup.avionic-design.de>
References: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
	<20120407022423.EFB053E1858@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4867264973012825602=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120407022423.EFB053E1858@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4867264973012825602==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Grant Likely wrote:
> On Thu, 5 Apr 2012 10:42:58 +0200, Thierry Reding <thierry.reding@avionic=
-design.de> wrote:
> > Hi,
> >=20
> > I have a device tree where I have a GART device and a DRM device which =
uses
> > the GART. The GART is implemented by an IOMMU driver (tegra-gart) and
> > requires the user device to be a child of the GART device (it explicitly
> > checks for this when the user device is attached).
> >=20
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
> Yeah, don't *ever* try to do this.  The device hierarchy is a complex
> data structure which must never be directly manipulated.
>=20
> >=20
> > The alternative is to use the device tree to look up the GART device no=
de and
> > resolve it to the corresponding struct device:
> >=20
> > 	gart_node =3D of_parse_phandle(drm->dev->of_node, "gart-parent", 0);
> > 	gart =3D bus_find_device(drm->dev->bus, NULL, gart_node, match_of_node=
);
> >=20
> > Where match_of_node matches each struct device's .of_node field to the
> > gart_node.
> >=20
> > Both of these variants seem to work, and the DRM device can be properly
> > attached to the GART device. However, after the DRM driver's .probe() e=
xits,
> > I get the following error:
>=20
> I don't understand what you're trying to describe here as the 2nd
> option.
>=20
> Regardless, reparenting should not ben the solution at all.  What does
> the device tree that you envision look like for this?  What devices
> are created, and what drivers bind to them?

The reason why I need to reparent at all is because the IOMMU driver requir=
es
the user to be a child of the IOMMU device. If you look at the driver in
drivers/iommu/tegra-gart.c you'll see that it references dev->parent in
several places, most notably in the gart_iommu_attach_dev() function. So
there's really only two options that I can see: 1) create a virtual device
that is a child of the GART and is in charge of the actual allocations from
the GART and have the DRM driver use that interface or 2) change the GART
driver's behaviour in a way that the parent/child relationship is no longer=
 a
requirement.

1) has the advantage of providing a central allocation manager for the GART
and will allow to register multiple clients with the GART. 2) does not have
that advantage.

Another alternative may be to allow only a single device to attach to the
GART that doesn't have to be a child of the GART. That way the DRM could ta=
ke
care of GART aperture allocations, which seems to be the most logical place
to do that anyway.

Thierry

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+AJm4ACgkQZ+BJyKLjJp/L5ACgmQTURsVtgdJQ8ghYsEJF+AZW
8QwAn2fsVBjsmTXn94AGhUvVdQVE4P1w
=kViq
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

--===============4867264973012825602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4867264973012825602==--
