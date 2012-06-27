From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: Tegra DRM device tree bindings
Date: Wed, 27 Jun 2012 07:14:18 +0200
Message-ID: <20120627051418.GB7177@avionic-0098.mockup.avionic-design.de>
References: <20120626105513.GA9552@avionic-0098.mockup.avionic-design.de>
 <20120626160224.40ba10a26e3dd3a56b1f312c@nvidia.com>
 <20120626140033.GC1115@avionic-0098.mockup.avionic-design.de>
 <23B010BBA481A74B98487467C29BA57BF2361DA3AA@HKMAIL01.nvidia.com>
 <4FEA6E09.30800@nvidia.com>
 <23B010BBA481A74B98487467C29BA57BF2361DA3C4@HKMAIL01.nvidia.com>
 <4FEA7472.7050201@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4FEA7472.7050201-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 08:48:18PM -0600, Stephen Warren wrote:
> On 06/26/2012 08:32 PM, Mark Zhang wrote:
> >> On 06/26/2012 07:46 PM, Mark Zhang wrote:
> >>>>> On Tue, 26 Jun 2012 12:55:13 +0200
> >>>>> Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> >> ...
> >>>> I'm not sure I understand how information about the carveout would be
> >>>> obtained from the IOMMU API, though.
> >>>
> >>> I think that can be similar with current gart implementation. Define =
carveout as:
> >>>
> >>> carveout {
> >>>         compatible =3D "nvidia,tegra20-carveout";
> >>>         size =3D <0x10000000>;
> >>> };
> >>>
> >>> Then create a file such like "tegra-carveout.c" to get these definiti=
ons and
> >> register itself as platform device's iommu instance.
> >>
> >> The carveout isn't a HW object, so it doesn't seem appropriate to defi=
ne a DT
> >> node to represent it.
> >=20
> > Yes. But I think it's better to export the size of carveout as a config=
urable item.
> > So we need to define this somewhere. How about define carveout as a pro=
perty of gart?
>=20
> There already exists a way of preventing Linux from using certain chunks
> of memory; the /memreserve/ syntax. From a brief look at the dtc source,
> it looks like /memreserve/ entries can have labels, which implies that a
> property in the GART node could refer to the /memreserve/ entry by
> phandle in order to know what memory regions to use.

Wasn't the whole point of using a carveout supposed to be a replacement
for the GART? As such I'd think the carveout should rather be a property
of the host1x device.

AIUI what we want to do is have a large contiguous region of memory that
a central component (host1x) manages as a pool from which clients (DRM,
V4L, ...) can allocate buffers as needed. Since all of this memory will
be contiguous anyway there isn't much use for the GART anymore.

But maybe I'm misunderstanding.

Thierry

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP6paqAAoJEN0jrNd/PrOhE+IP/2JQEqYfLD6sdKSmpOJ6TQmH
cyBc3XOcN87kv6DxKMRG60Spd0w+G/aJKBcWbQv0deumxXaN7oLUrsdvd7xOuPfH
AHPnpAUGGnTrWK1bA8aMZY2r/u3woHw+kc/V1/l9KdVBXCIkOqC4ko/iBU8U+Fmx
iONudqqehxSUzGM0Md3jT4TPxIPR8INfGHc64xCy7HxarCHALQoHC6fJL0GmRJTS
wfoOzmmotCpNspwmgHWwPIflNGhetEOCz3/AVlgGsAjHsawO0tZjpsNx4NbQaZBI
fm7aheTDRlxfEKTN41Qz/EDJEqz3z8y9HMX0b+uY6cL5ttBSbg3ePOiLkWwA2dUd
ArQrR1PL2n6YBBSRmuJcFCnzs0pJGSyvzi8tOHXueW3fi2mxcVK9otDcMIGpoii8
47/+MBSRpxHL7baNpf9ybiYuhukwswVSYRR4VPLsByUP9MUh70BZH5IXuax5clz1
d8n7bUma6A8UwK4lZSGGOhpO0xS0346YsHdDyQwnjp79TQjvcy58piU4ODr9fWLh
ksVM01/fBpE/skHUbzCkn5y19oXAz7MrLhzxCuA59Wj5y/9ZndjYqXUdBIsvV5i3
QWp6LE5bYcJWHwAWLJfGOstDTnZK4jzvfJT0uuvGhdsT5+yydp4TIl9L4v06vIys
xBZ1IsOUVoFgBVi9jvnc
=q0Me
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
