From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 10/13] drm/tegra: Use sychronized interface of the
 IOMMU-API
Date: Thu, 17 Aug 2017 15:28:47 +0200
Message-ID: <20170817132847.GA6854@ulmo>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
 <1502974596-23835-11-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502974596-23835-11-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Joerg Roedel <jroedel@suse.de>, David Airlie <airlied@linux.ie>, Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 02:56:33PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
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
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/gpu/drm/tegra/drm.c | 6 +++---
>  drivers/gpu/drm/tegra/gem.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmVmgwACgkQ3SOs138+
s6HBHRAAgzMEqZRwr7seo3DpY7xLYFX2rLLXC+mpZrazHOzP7PGdF4dIHfV5bgRS
Y6einAYR/ihwFeEITZ7E891UFvUv2xmduyAraliD17TomE5XYxMNpyxle4QvAb3j
toOLjoqTmTNdFLlQOSrIfaEvAd17NpnQ0GwQeTpTyH6E5zG6QmXBv0kLQCg2Rj9s
WyOwV7Cjk9t/ELe1GPNV+93fIXTXyfyU9jw1qfVc5T/L+DvM/UYkfBRQgQeXW/Ne
o2/Lw3VCgBwhQ/fWCPgbVyH8rVH8GwxGajjS3S9kA8GC0+3XyUUpcbZOzmmZZVv9
WY+HJc8ynRlNB00VlsvsHpBzEBPgDnLl9NAV0L2hjoqR7J5VtQPWZ8O6g8SjnvtF
/7w+3UomaIMy8F77f8JH9d/+gEnpHgSngg2nEEbqJu6eXDKOaO24IdOID8ypjpUi
qXkBW4ZXerKFJSoeFhwj1vhA5n7hHeKUDGIBF1n2kW2QqmXAHeHFr11h1iprr9Nu
FAZUTWrjPf4NB5iWK04ZXlsz3kTLTax4PkSYMMgvK/K2Qzj87XRTHXV358PzkVfL
QqEJdMnQkQTsaIxDbovnB3deBHK2CDXzugJew/G0I8bli5VHLEN1q6ijj6u1n/R4
RJ5E7fJ9J0cts9gZ3Q7yhZuDllAtwteK+wmBRGRCq8G9EhYCP6M=
=E1sc
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
