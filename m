From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 3/4] iommu/tegra: gart: Move PFN validation out of
 spinlock
Date: Tue, 26 Sep 2017 13:07:32 +0200
Message-ID: <20170926110732.GB23108@ulmo>
References: <cover.1499270277.git.digetx@gmail.com>
 <301b5e91fae43beae4542e8c4a7d5ca6a6918ba0.1499270277.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <301b5e91fae43beae4542e8c4a7d5ca6a6918ba0.1499270277.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:29:47PM +0300, Dmitry Osipenko wrote:
> Validation of page frame number doesn't require protection with a spinloc=
k,
> let's move it out of spinlock for consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlnKNPQACgkQ3SOs138+
s6G1zQ/+OjD+TOp8nmgVM9th8fwmZ+R9fNQ0MQHdbRwFWCqGDbANtWU9ayiDek6D
GDXCVnkOsutsy8j6yB+6S2f7rRSJEtJFDK/fQ1jRrhmWo+5caqEzH25fjmy2lfm7
UVfUqA1V5dUZRMHOY+6zvGu8YTgg6RA4kIXybKmJQFt5+REu1gO8LVHZUM94E1rt
cuxcWX45CUQeTtUQoCmJyp0X2cbq6expW9Vt3x8mRFVTdRURH7GUFHxTBeRESTj1
ukJ1JEq9vQud7h9Gt6eIkSpNuKb3Ezq9NDLicTZutoiFrpLNgA5jZZS4r3Ga5pCH
QvhACIoWQ5zevKhj3++QeSdTXSAYyTiXdSWSrcOc0G0RVP19N5gKYwc3XwAY1A3i
5xT/nlCOxYlzhNvO1kkhGC396z26iTrzJFSokr76mXtYSKQDnctVVEhelt6sjTWZ
KM+EJWXKAaC5HDEATPV7R/8ZLUSyvMED0CFkKT5ZkexexmLy+Xwncu0b/iGiTLaa
IwMftY3McXl5P/3IuaXOCPYFD5vkhjh8/OZB6UVabYBeTIr5Ul+5GYSFbEiFeHvy
vLnc/5EBM0SQTobq+/SYHRcm4ALXpiFeK5N7a5M4jW6c12AevnV21oeVb/yjAfML
ngBUPoDmz8ENPxZsGbhJIqkXI/RrUnatriY5EtLPhUvekQomY0I=
=ILiL
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
