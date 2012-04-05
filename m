From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Thu, 5 Apr 2012 20:08:05 +0200
Message-ID: <20120405180805.GB11601@avionic-0098.adnet.avionic-design.de>
References: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
 <4F7DBCEE.9080400@wwwdotorg.org>
 <20120405162318.GA10628@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8884549793756196800=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120405162318.GA10628-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============8884549793756196800==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thierry Reding wrote:
> * Stephen Warren wrote:
> > On 04/05/2012 02:42 AM, Thierry Reding wrote:
> > > Hi,
> > >=20
> > > I have a device tree where I have a GART device and a DRM device whic=
h uses
> > > the GART. The GART is implemented by an IOMMU driver (tegra-gart) and
> > > requires the user device to be a child of the GART device (it explici=
tly
> > > checks for this when the user device is attached).
> >=20
> > Isn't this wrong?
> >=20
> > I would expect the device parent/child relationship to reflect the
> > CPU-initiated register access bus topology.
> >=20
> > A device's interaction with an IOMMU is an aspect of a device's
> > initiating accesses itself, not CPU-initiated register accesses.
>=20
> Actually I have no idea why this was made a requirement. Maybe Hiroshi can
> comment on this. The driver really only needs this to basically obtain a
> pointer to itself. The MSM I/O MMU implementation does something similar,
> though, and goes on to register actual child devices (they are instantiat=
ed
> in arch/arm/mach-msm/devices-iommu.c). Each of those devices is then assi=
gned
> a specific memory area it seems.
[...]
> I don't think having more than one device using the IOMMU will work prope=
rly
> anyway in the context of the Tegra GART driver because there is not means=
 to
> allocate specific regions of the GART aperture to individual devices. So
> really the one and only client actually needs to manage the allocations f=
rom
> the GART aperture.

I've been thinking about this some more and it occurred to me that maybe it
would be best to add an additional layer between the GART and the clients
which could manage the allocations. Such a virtual device could actually be
registered as a child of the GART device and allow individual drivers to
request mappings from it so that there is a single instance handing them out
and keep them consistent.

How does that sound?

Thierry

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk9934UACgkQZ+BJyKLjJp+JTQCaAsO7hMrqmsPikuU+bZUQdlpp
hQsAn3RvLwOGNlJaDihRs7stlpzCvX82
=eNXu
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

--===============8884549793756196800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8884549793756196800==--
