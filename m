From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] iommu/tegra-gart: Add support for struct iommu_device
Date: Fri, 18 Aug 2017 14:47:18 +0200
Message-ID: <20170818124718.GC4556@ulmo>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
 <1502317752-8792-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502317752-8792-3-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 12:29:12AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>=20
> Add a struct iommu_device to each tegra-gart and register it
> with the iommu-core. Also link devices added to the driver
> to their respective hardware iommus.
>=20
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/tegra-gart.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmW4dUACgkQ3SOs138+
s6GlfRAAm+4WcacW+vbO4DgRHvEVSJqpCLXbVznf6uZXsS8eVLBSdqYY18zSXs0N
pN763cRN9ZGYVrX6Rkv+l3CrbylSMyqc4RQuSs/oYInyGO8h6CNGda713xLfDgvB
0j++xlGWfAT9sGq33GTEXnFLC8o6yNEi8yrfcfyArD4TJQ+5p15yilfagHbj5g71
GWvjIHYze+MK1BcuRiPqnlcv3FFMmezdRvK/1hUOaRulbO18zO9HY5F0w/rlNrnR
JzR7wPeiBIRobwUoHsQbmQ6JmAFokLyhkkPc4hP3xcjE5XwtG0ABGlptPhIA6fNT
JGu4CaIHwSGE3JzZ6/s1M6Pysm/qPAJEuNt0qSeMKyNLb8m+zuVIzU/PLCNLicNs
piz+A0dpTlrePRDWpuAjdmtY0I9W7JdIfM2EQTckzSDWFMwSJdzgzKuQfGkwJYrR
+7n0+OBuRouxMdFm71Hb592+/OgGT/O3+ZdzP5w/ReYQ8hkc6Ctpu/LWmWBRTrGW
ISI712kXkxo5Omgc8ppiU/yS3GOqq13t2ALxsbysEqOQpDQcA7xxYz8j+C7GDSUj
gVYtp76nCQ+qbdhWnBVanSu9VZmrsuJ3zVeS9Sx+kzerTE0uGylrDHmoJyaexb+o
0dDupuKnbXDjyCo4ICtXgWHCd+Q8vK627JJ0KP7GEdFOG90zh6A=
=/FQ1
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--
