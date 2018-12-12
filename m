From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 07/21] ARM: dts: tegra20: Update Memory Controller
 node to the new binding
Date: Wed, 12 Dec 2018 11:02:29 +0100
Message-ID: <20181212100229.GD15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-8-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-8-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:36PM +0300, Dmitry Osipenko wrote:
> Device tree binding of Memory Controller has been changed: GART has been
> squashed into the MC, there are a new mandatory clock and #iommu-cells
> properties, the compatible has been changed to 'tegra20-mc-gart'.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3LUACgkQ3SOs138+
s6GEFBAAuSSc+1QIBQ8l6lCc7s4lS7wgI3s3yQNLwQKke9yteMQyJh86aqFr4P6m
OzmzqFI1HuCE7BhBkxZPjn0lWvsQzEbdjmjqrbbBEw/Iany8fwERcAEY4EY6kHLy
mWWl/k7DnX2n1zO8KXzp+pRzAOvo191jx8TxO0DhWXibFi2N08rET2jZjZE7NHuq
ykkV1etDZiF9qWeXRF5Lg5HjI5jDCyROjviokWveaa7eSUzUvGmD57c0JelGoz2i
VIQJSHCaMpc/d/P1tzorvIqi972VOURzREy6tuopN8b1zZyRe+KwwbcngwfQ+xDV
tFrNZRVa6/QZMh9v5vlXhGPpDr1fR/RaGq/S1CtJX0hg+uqyjckJDK6pYZkz8UI1
5DpD2bfoasYvpDG8ShLkGXdKhra6vll+e0R1TrjBv1HcLzcLMg3T1VPCBvIF0Ix3
8Wp9BU52LhykSdlQwalnmnl+THFaU+fSUv+stvqgVkVlQhCOW3kPINkYbbqrHUye
lEhvCTrhV3+whFiUVVPCHC5/PoNqDM3R1k1QOIFCwADzVUKDMar+89wo6s4rKYqE
EytYAl3XLGBdqtSfIMuak4uc1H2hPOgTt5w+tGgyHZ4UYAwV1YAw80NopFlQZuC3
Muk4wHCaapWKgyyIhIr9IkKEdDUMz9wYyEtihZDEyCtAp074c5Y=
=8FTX
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
