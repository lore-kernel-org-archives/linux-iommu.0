From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 19/23] iommu/tegra: smmu: Unfied driver for Tegra SoCs
Date: Wed, 26 Jun 2013 13:07:47 +0200
Message-ID: <20130626110747.GP27083@manwe>
References: <1372238906-9346-20-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3loezlmesXOUD0D5"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-20-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--3loezlmesXOUD0D5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:28:22PM +0300, Hiroshi Doyu wrote:
> Support multiple generation of Tegra SoCs with this unified
> SMMU driver. Necessary info is expected to be passed from DT.
>=20
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 80 ++--------------------------------------=
------
>  1 file changed, 3 insertions(+), 77 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 6e82df3..ae71721 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -1,5 +1,5 @@
>  /*
> - * IOMMU API for SMMU in Tegra30
> + * IOMMU API for SMMU in Tegra SoC

Maybe "Tegra30 and later SoCs" given that Tegra20 has no compatible
IOMMU?

> -MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra30");
> +MODULE_DESCRIPTION("IOMMU API for SMMU in Tegra SoC");

Same here.

Thierry

--3loezlmesXOUD0D5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysuDAAoJEN0jrNd/PrOhMO0P/0QEvGhLlKsbmaETjBt5yuA2
O4vYbQSeeMhhlyAUeF0QlEZyIMYmh2WKcH/rSqZ3vxzTgfjhDilKV6gdlCxkjald
Kh1wDmxRPIaesqgfIw28x1++SLr+2A91Lfm8zLJmodMbcSrYJGikz/xrWLk5a4LD
f72cissOfaxquvaB73dgffNsiPCtclzmluyjwEK8r2UY1mo97+oA4udWAyYECA8M
NffPltYaAUOz0mi8X3rF+sYqUE6dqhu5yeRZ3QXXu5yP1Vwz/pE4ScZrGWfflG54
zLcK95QCSLtcwWakhAuAi5o/EyaSd7jNDiACInp+8Uw0G8By8dtl1kjYbHjq9xiR
Tg55AJ+MzJRLfQZH0GuAm/c+96WdwURECiMt10vi3m336RhtsNS7bOplYZ0M6+a5
SJbQmDDIrXt+GLeUkTkb5fgRhn6khXPKnrkozVL1jN9YKqFnn6rScr0cPHAKirWS
0Z+sPHqVtxZj/yYn4wA5nHAoCZQtFhu4sU/RxitE1k9Tw2qrbU1KQVnc3fjEdBm3
P0AGa8SJ0INx1B5YvIOsoUlbBumDv7mYQzBWwvFOd5GaP09L5vr6pxUItkWWQEHr
j0WBOXxUNH5CbbF+XLCGARj2HGqYVICHCigqy8R/QveMlRtBOy74VI6sFPFCxkFG
jr4JlypJwwwwdjFvNszt
=oblz
-----END PGP SIGNATURE-----

--3loezlmesXOUD0D5--
