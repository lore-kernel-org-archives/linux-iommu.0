From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 11/13] gpu: host1x: Use sychronized interface of the
 IOMMU-API
Date: Thu, 17 Aug 2017 15:29:04 +0200
Message-ID: <20170817132904.GB6854@ulmo>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
 <1502974596-23835-12-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502974596-23835-12-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 02:56:34PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>=20
> The map and unmap functions of the IOMMU-API changed their
> semantics: They do no longer guarantee that the hardware
> TLBs are synchronized with the page-table updates they made.
>=20
> To make conversion easier, new synchronized functions have
> been introduced which give these guarantees again until the
> code is converted to use the new TLB-flush interface of the
> IOMMU-API, which allows certain optimizations.
>=20
> But for now, just convert this code to use the synchronized
> functions so that it will behave as before.
>=20
> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/gpu/host1x/cdma.c | 6 +++---
>  drivers/gpu/host1x/job.c  | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmVmiAACgkQ3SOs138+
s6HEmQ//SAxCmzq1ntGkx0hQayS42QtymmlrEcHF1W6h1vf3TcwRoBeuqNh7kAx7
z51eC5fnbj0B7wTCMrXklGMRESJuPuAmDe5sNkutgLadpJWs+juyggIi0cjLDLfj
ssGDxcy03wbQt+LRKe1hRhcIWk9mkGV1nVtFQ8K6p3XO6dlFR6jryrGVmsEOuaK3
ui1JPRBboC86Qq0J1QIwPGxMhlfQOvVFOQ1ItVi8GybCE9siFIMbS4LJV4iuHMOL
yhBVAe48+1ViO6NTNiVCq2twZILskCnXXTBRUkMe7qLkCgS+XFTDaGRv2FOFod/5
u8LywV7pdcoGJ9kQboGTf20RJzna8bmqdph1gqs3PrxF+Hr2YqeolQM4fvB7QB2L
Mln+s5UvXIefro2EjRyJpg7+T2Nq02o7oMfdRke1zGM8rxFw6elsjVdUE9x/WKd1
VeFvw0Iu+wBQc41JwIxAI85YAblP+ac3mYQiaihH4wM1DBSfi+tjEPvN7xKQTGaS
oN5fdFTX09+uWACUCTyD7XXbNXJ7pHFfsbq8x9OUyOI/S6JrO0UrFtwa25DA2miJ
t9BJjZMH99y3J0ejMcQtZBXJr88Cm8/4W1rI12YGOXy5Wk8EalgY0CZKTlfzrKWQ
Kh7YcbumLicFDK6Rm2CxvJfMWGTBWVzsHLYnsV6nLK1JZJgdA+k=
=ddw6
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
