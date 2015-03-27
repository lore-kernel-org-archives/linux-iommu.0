From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/tegra: Setup aperture
Date: Fri, 27 Mar 2015 11:19:36 +0100
Message-ID: <20150327101935.GB17976@ulmo.nvidia.com>
References: <1427450847-17719-1-git-send-email-thierry.reding@gmail.com>
 <1427450847-17719-2-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427450847-17719-2-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2015 at 11:07:25AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Each address space in the Tegra SMMU provides 4 GiB worth of addresses.
>=20
> Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index fff45b3d3e57..7b36760ae087 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -269,6 +269,11 @@ static int tegra_smmu_domain_init(struct iommu_domai=
n *domain)
> =20
>  	domain->priv =3D as;
> =20
> +	/* setup aperture */
> +	domain->geometry.aperture_start =3D 0;
> +	domain->geometry.aperture_end =3D 0xffffffff;
> +	domain->geometry.force_aperture =3D true;
> +
>  	return 0;
>  }

I also just realized that this hunk conflicts with the IOMMU domain
alloc/free series that you sent out yesterday. Were you planning on
merging that series for 4.1? If so I can regenerate these patches on
top of your series.

Thierry

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVFS62AAoJEN0jrNd/PrOhlnoP/06eStfdZyjj+Carpf/TZwzA
AEt595+IZ0pvK9kDuFts4QWNjl1c7gG0P6K9DUMvqlXAg7P0KVOdlGH3FV4+nVyV
mLV3xFusdXlkCm7dZNT8Lufe/UbuNUNLflWZR+h4TjWUQRYAzJNt8avjD0S8DcaU
MiHb2KXam7pZ1wVy6vVHYTISH6gfmanGgT8GRqiTtGZ6ZYHOmQKV/+zGXi75CpKE
a2nPAmN8u8S2sjY6IRnkq/8rgbYzqS+hWR3tOh0buJXaUs+gkgFS13AxYRzhcJbO
A6kd4uVn5T0P87IcV7do0xoBXEomkPamyha8fFCz9fyxtohfiCAy8OwzzErpFe0Y
vm7/cQnmyjqulYcDFVjc6tTEYfWFPdNQih5s5IUvFSorewVO626Suar2YqOG7Nqa
124pM37KvWzLnN0kCeB7sRm18G1BOO/eV8MaYSYNuZ+RgB2x2DyGK+du5qGpkoIZ
IeN0nQV07GXLbz2xqoeYGKUkHFPBEJVk7f/NknEt0Kx1LwZOsUEblKKfkXuuBAEp
SvEqpyKJ/0q0M3n0e6s9ig7+gXzNpvkOOeJOvlKcxVNA98ULXVrhxGbkea5BJXxs
r2J12nX4OHBHw46Rh/+r4g3dGCq9z4QfpPBVmauOep6xek6fNFhKK3zPv+gxhAE5
2G418jTqbiqTLwGogxuw
=iMcL
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
