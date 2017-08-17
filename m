From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] iommu/tegra*: Add support for struct iommu_device
Date: Thu, 17 Aug 2017 15:58:03 +0200
Message-ID: <20170817135803.GG6854@ulmo>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MiFvc8Vo6wRSORdP"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1502317752-8792-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 12:29:10AM +0200, Joerg Roedel wrote:
> Hi,
>=20
> here are two patches to add support for 'struct iommu_device'
> to the tegra iommu-drivers. This will make the iommu-core
> code aware of the hardware iommus that a driver manages.
>=20
> It will also add the iommus to sysfs and link them to the
> devices managed by them.
>=20
> The patches apply on-top of Robin's iommu-group patches.
>=20
> Please review.
>=20
> Regards,
>=20
> 	Joerg
>=20
> Joerg Roedel (2):
>   iommu/tegra: Add support for struct iommu_device
>   iommu/tegra-gart: Add support for struct iommu_device
>=20
>  drivers/iommu/tegra-gart.c | 26 ++++++++++++++++++++++++++
>  drivers/iommu/tegra-smmu.c | 25 +++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)

The series:

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--MiFvc8Vo6wRSORdP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmVoOoACgkQ3SOs138+
s6FntQ//Sj2bmb18nz79VHIJOgT1md+3bIw/NU+P4VX7Dx1vUpyfHyshbqHDt4tH
toBXbnHcAOXfQ7wSw92xnLxy5tUBld88kcsRGzl1HiYQf3jmRMyScWi2/Hu6wUL5
OWJNhkxWtQ3XEC29FRMpW05JSrSeak50zjvteP/Z7S0kKifmhMvB8YceXdLe0RKG
2Hh1gWm6PBGVhP9Eo56r3ocLg5e2y/xpBOm5QxtHjSpEY5YRCy695srGoAivuoMp
th2BjowvBLT2zg1J9XRjSUP011C9hb02rWBa14v2ws+xrJwiRHHviMeFwZwB5unZ
/LijWRVBTr4OZ5cVmSJO3Kbb3xPRbyhuYlPCdr3q/K5qEHMgzm+KAhGK1Y7SYv6J
GriiRSbWZgkeJU7Lt+pKQwemSebpUttFmovKnP90vMUuhQ+fLyQjtFeLrUznXhxb
rXiqx434IRfG0hEbnUJqd23QY/p4nEWoO7dy5Dgo5DP9uv9hRR1wRjpBHeOrvk2D
ntYGGePkMlGShcgq8FUdnhpZ5fhQyXRoKonloD9d/M9Z9EMnWf7jN7uC6m5hWz8x
T4I8sui+tfayma+SVnsZWYkU0dJvAyRVzmqenLhEfBE9Ka/YyI5l+gTS8592iwTZ
U/wzzOi2Hu5b703TDDjdPgxAx5wYDR6lXX4rLxmChnrdge1yT5k=
=Gyme
-----END PGP SIGNATURE-----

--MiFvc8Vo6wRSORdP--
