From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 11/21] memory: tegra: Use of_device_get_match_data()
Date: Wed, 12 Dec 2018 11:05:41 +0100
Message-ID: <20181212100541.GH15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-12-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-12-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:40PM +0300, Dmitry Osipenko wrote:
> There is no need to match device with the DT node since it was already
> matched, use of_device_get_match_data() helper to get the match-data.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3XUACgkQ3SOs138+
s6EA6A/+LN4VgCT6U19hE/FW6BtGw/WnhMEUJrK+K+kpLpvTKxAdVpOivRaIi7HX
aP7k/gWj4HGq1UTTJrdF9FVh0zomseB5D96qcT/d82st/Aju1RtiIfl2qhzYvMTD
jjiXF/Sgo/kkF9CQjLMQ4A+Oqke4IhNgRo9PbQCFzitlTKDdtO24IM8+fUNjn0SS
9BC3klMphcXvFSyjX5EgLSlNrm3r5pBSl4PENWMOmleHJWrAPFzNt8n8h5iOA5T3
X0XjxJAqLhsKJpGzLyrSC2kw4PmmPZE5pFiG6m90Cw0s7mI4pez+YJdk5SH2Cn1Z
CUxWBExGI8BYWYcscz9jjvMWx4kCWUcHTZQ4u2DVuSMRyYecdjg4eJ+g0+g59v7w
//58PPpBjAcJD2TYHg9sxfKIowdQOlwgW2hJaxrayGrq063XHJUHADSq9fPsyFMg
c8+gmp04yehftEhz2hDd3Dk/9lU05veWF3QVgSXbO5D0dr+ua6JWTAjC089xnqvN
5Lx//AJXw+bG7nQHL54KqJwU756VLG4ZsD22AG7fxuHVMieJry6t/1ocFkCI91gG
/qZEjwl71TvlSq39mmyAdMyhqpwpIqWnHnIEasGqM/Z1ch0VTFfyE4jgEJsitjop
gDQpHu7nPf3LafgcG0aRwKCeLFuf1N2PnNasgd19BxibZ0lufm4=
=XSwA
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--
