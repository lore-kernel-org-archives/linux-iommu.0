From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/23] ARM: tegra: Create a DT header defining swgroups ID
Date: Wed, 26 Jun 2013 12:38:17 +0200
Message-ID: <20130626103816.GI27083@manwe>
References: <1372238906-9346-2-git-send-email-hdoyu@nvidia.com>
 <20130626100648.GC27083@manwe>
 <20130626.133141.857713230994773030.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130626.133141.857713230994773030.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:31:41PM +0200, Hiroshi Doyu wrote:
> Hi Thierry,
>=20
> Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Wed, 26 Jun 2013 12:06:=
49 +0200:
> ...
> > I'm not entirely sure where to find these mappings in the TRM. I see
> > that there's a list of the groups in 15.10.11, but where do the numbers
> > come from?
>=20
> To convert swgroup ID bit to register address,
>=20
> #define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)
>=20
> in "[PATCH 15/23] iommu/tegra: smmu: Calculate ASID register offset by ID"

Oh, I see. Thanks for pointing that out.

> > And why are some of the names aliased? If it's for
> > readability only maybe we could add some more for SWGID_HC ->
> > SWGID_HOST1X and perhaps SWGID_NV -> SWGID_GR3D.
>=20
> I used the exact same name from TRM register definition. I thought
> that same naming in TRM may be better since this bit is converted to
> register, but I'm quite open to rename if needed.

I think it's fine to keep the names from the TRM. I was just wondering
why some groups can be referenced using multiple names, like ISP2 -> ISP
and MSENC -> MPE.

Thierry

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysSYAAoJEN0jrNd/PrOhuFIQAIr7iNbk/vdPMV5KINXG5aKO
nV9PlShoZAzeIiyRxe332sWQNK4Ry/xkMyUsr6oNIo4pnYxEXln94n9D3dzIRQUS
V2Q6Hdm/1ZsLJ+uRJVQm9+EIuTsXH6W4dSXZwHnYK4THDtdpTka25hDCpRnyWkLf
DZHgM6AOVd8yqMCZPqll1WVMhGp0mcmELdOrnotAkWOHFm1gqjNHIaqOhVBE3AlO
y98UkKBgdPnaS/UVHCrf3jroZe9oTKFoAuhuQYtINgs1ahY547W3SxrcIu/SINY9
hr6iszjV5eruFWVcGAzQj3fb13l0/N2gg4WilLBQSyZEtzjRBnD7Dpl0ftFoC6da
KVGVNmdXQcBp6ubWKxJZjnNrALfFl2ONldJj2bI8TlmtuasRfGN7eDGj7iDBDnSz
uXBJWJND44CJ9ks+CwNmfimxzXUrWOFgtbVIjJaP5H+2oJbBXRD+LIY86AlwEZH/
UEiLiRDaKaRC8uH1IX6v6O0eE5fSq9Si5zvI4C6SB5uM4e3/gDXjd39dnV99/Ejm
I0qoBmtjWRS92Eb7RWNJXkVSFvnuk34TYhkWXJ57B4eD1S/kOUUZnIJO8X+g6+zl
jGVD0pT7pLSjnWZqC4KUgiIse8y6p2hycdOwVmh3LxfcHgMQQRNCcaDyVNx1bX5C
6Sr3bL2jUFlCuo2GQmk9
=z4A3
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--
