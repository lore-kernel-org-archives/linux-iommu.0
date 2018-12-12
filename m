From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 12/21] memory: tegra: Use relaxed versions of
 readl/writel
Date: Wed, 12 Dec 2018 11:05:56 +0100
Message-ID: <20181212100556.GI15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-13-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IR1Y5IvQhrKgS4e6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-13-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--IR1Y5IvQhrKgS4e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:41PM +0300, Dmitry Osipenko wrote:
> There is no need for inserting of memory barriers to access registers of
> Memory Controller. Hence use the relaxed versions of the accessors.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--IR1Y5IvQhrKgS4e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3YQACgkQ3SOs138+
s6GGGhAAnVGGzhNNAjxLTjYdbjVxTO+bXB0nc146fW2vgphsGF+pQq6buITkXJk2
bz1X74SxdrH2OS2WUS6kyh4wyAQWbWF3krxeOYHt4s4ylOPUk7QgYXmgUgTqCE/M
Mnabz6tXbv4O9Rdqtkt9QbEkiohqxsSZCy55QFaPxSqkytHjDinhyFuKa4pmRUIn
RkjOm2KaSyEIHQAyy3uZQSY1iFfsPx1OA29UVoa+xPtnSgBd/saYDWz+XkTgKgNx
YLiPW36Dzf9HBMYN5XqDunXz4Kv3hgIxU1rbDppouVRrJrwYzIc/NWU6jHN7xsFZ
BrRTj2fOCwCf+P/z5vkNRjK35FvYzK6PcEJ073ZS3IzvNsF923C4HUzNSRf2jVEA
GhZKhnYN/bePEphSTBW0JF58N375gffXoMhSzdskZhBzVHtcr1vYB0akf58o7Hs+
B2j+e/9o68dLhmuIReRlWEdf2LZXZA3rbFs/GFlUCOo7/hCngewR3OqZxdyVp4Up
FVAHlNWKBO6O1orV1hfn0MwKhEiiE7149GjPqe+nMIrNDnyBB5/sTHrW2UveKdAC
QUxACgCtD3fpEe5GrQzyw2cHiqf3OOx3faICD9cbHzU94bsGbuVqcayd9lK3UH31
GzNcx4DNHFy2iuQLK+ppsPTZOlbzYxxf9RKfq6UZEy4oOBPls/s=
=1jiE
-----END PGP SIGNATURE-----

--IR1Y5IvQhrKgS4e6--
