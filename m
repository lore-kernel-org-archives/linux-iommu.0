From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 13/20] iommu/tegra: gart: Fix spinlock recursion
Date: Mon, 24 Sep 2018 12:49:01 +0200
Message-ID: <20180924104901.GJ21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-14-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-14-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:46AM +0300, Dmitry Osipenko wrote:
> Fix spinlock recursion bug that happens on IOMMU domain destruction if
> any of the allocated domains have devices attached to them.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowRoACgkQ3SOs138+
s6GPKQ/8DYlU8PYZ2EJ7v3T1n8v8mTLH8QRZTLiabrpqriO5H7k3vyACE09dIKf/
rOspXZQuy5mD4vFCHS2sXLfIBA7rfNSnE8btKDSVzICPsfZiU0BtW/bwQBu9Xz1M
fi45LpKnnHvDc0PAdFOKwJyp4lkB8bMmgreww5QPNukxeyUgaYCIQNK5JOuLFgsm
+wQswk5+Acr27LXYptJZsGi8cMP5PyCPcs3sVXUlVaQnYLi/zN66U0JfiqiBbEDN
Fn1srQMDZBYf51MOiPE6tjKeitRBRUKhyDOsVkeSZViJANlkaSsWWBD4jnvfA6mY
DrO4WKfDHvasqfeJyfUKRTZC24/hgcTdUW1hgB2G6mc2libuXOyHDZunArczkVNZ
B49mNE7/2D1UjfNF5zQHuLCdk+Z3pXbCPChNdjSyH7L2to2oJn8mLoPvttNK0yap
D1JxAL8ri2vo0d5neOShNlSxQYIsbALPj0G12XStVeVKr5h58FJzcGpvYDTWVFyX
wRt6jOiZjwXzPFjfp6osAgfr055BP27oXlZ0hhLO03mSPBlAUyn2/BIe4wate1WJ
kb9s9dnZjdJ89pbBRBdeq+kFPgoke66HXfDnwH+3+irsohCCBTqvThJ5VcjYb0z9
UK1qA5Ck68PKDRN2RojY49r137kZwt5eGf9XtUDPLjE/hRDyPFc=
=bICD
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
