From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 08/21] memory: tegra: Don't invoke Tegra30+ specific
 memory timing setup on Tegra20
Date: Wed, 12 Dec 2018 11:02:40 +0100
Message-ID: <20181212100240.GE15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-9-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-9-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:37PM +0300, Dmitry Osipenko wrote:
> This fixes irrelevant "tegra-mc 7000f000.memory-controller: no memory
> timings for RAM code 0 registered" warning message during of kernels
> boot-up on Tegra20.
>=20
> Fixes: a8d502fd3348 ("memory: tegra: Squash tegra20-mc into common tegra-=
mc driver")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3MAACgkQ3SOs138+
s6G2aQ/+KD5RdCGYz1SWzQhTm7DVXypS7nOngN1v/CDf5Zt8ZavPn2kSksNkC8Ub
Bj3MVBMOnmmyrcjHbz1lbio75ULX4igdx5BjKVWBq/nYyq0W9tSKfCydNu0wURX6
Zffuk8TT3GHUHB45eekxWIRQFZiy68MO3XtNvBfd6gpCoTahAYQP14pN7RVYLGXt
/W0MZoV+swTBAms56x11rZ+gZiq7kfErXjDYkslTnPYLzKyM5NjTuML20dr/O4Tl
Grfw0AAwdtzrPKfC9ogiuvzZSKUT/GxXzIiUixuogJO+/y0701m9Nva1BOYqFJFK
iurUym4MFe8y/sMmRoCg5/mlVHiUJk7HSHV+ifQorzEKk2yT0ZbPqY1dJMz4b0df
ytmfW0OiaWNIzCrrYPTWWBa0G409XapFaqmYX4uYrXimZWEnt5ybjzQYt3labnrm
VgzOcRhq0nQmAdxWL5fWZuButOgWrYiIkxDJ/PBOvdTZ1dsr1pUoa4yM7VMGleyx
PvLwZ1xZP3CNbdrI+BQpGxUFFo+Gvhlw3a/Tmr7JUjITtWtvwPNyGC/dZ+saUeff
u2zL55tW7bxeAOEbChNQEEDX67jSmf1qbisIdqw8seFpaa09sdqhGiApmrcGnGo9
uCcTn7u6m82mjNEEdbdVddrwAcoFEw9+Xj8/Qu1JSmxRiCZ4Jw0=
=nQFn
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
