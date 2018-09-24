From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 14/20] iommu/tegra: gart: Fix NULL pointer dereference
Date: Mon, 24 Sep 2018 12:49:18 +0200
Message-ID: <20180924104918.GK21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-15-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-15-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:47AM +0300, Dmitry Osipenko wrote:
> Fix NULL pointer dereference on IOMMU domain destruction that happens
> because clients list is being iterated unsafely and its elements are
> getting deleted during the iteration.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowS4ACgkQ3SOs138+
s6Grfg//c9yfUiHhqdvAXDb1PLAB6NcalmJ+iGpEHaw6mo2Rd9rLP7dQOH4dPzR+
VSTWAoWcEj7SsneuIIejLqnjU9jrRoamhWhkiRwjJG2mVQUr/16En3I+7GgDpYg4
Omoru9USR+59HYYledJeued+SHdQOzXn6M/nMtMZkOoW9gUEeusSgwFlS831qndH
ksT9Q1eqtt/yLPXv4veqotexa14DOemfT/e26ONn3mghtewbx+0hsI85MI0JeyRa
2UQeZS8N2VttVgStHV8mqHp5gFn/CcWLzRPeBlCTgbHJUX2RKfy9dmN6SButNYom
n+64LrHzUZ+qZOpYpGMsb5d5DiTU2SJE9yoUsQ5i1m7a7+7LZCUE74griM+QXyk4
LRqiVtQ9+8pORu2PrjjOx1QSUXEhkMl2ZQ+/VnpOtpeRKp/ClaOHQuHdyxPZewMb
0gypg6OIYxr1aA7uC8NtfUC4QsLRilZpwvnqqqpO3imuV4RBhMpVrSZObTTyCkhx
v39X9S0pDxJ3OWMd68Xd53V1/Y33HWYo977JKJ6/+mu2GNhw4dJbipTldcz1AMBY
y6Wkhu89wOcWGZMVvCmhfOE2Jqmpn67zWxQEv4ZYVZBW0H4CKX8goDbJvRJM5qvb
Teme9+YYPKEb/kwpKpMuox/u4+h1MUhJFZXbsLkhgyXrxrEHNtU=
=ZzrS
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
