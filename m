From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 9/9] iommu/tegra: Use helper functions to access
 dev->iommu_fwspec
Date: Wed, 12 Dec 2018 10:53:28 +0100
Message-ID: <20181212095328.GB15092@ulmo>
References: <20181211121910.5604-1-joro@8bytes.org>
 <20181211121910.5604-10-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211121910.5604-10-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 01:19:10PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>=20
> Use the new helpers dev_iommu_fwspec_get()/set() to access
> the dev->iommu_fwspec pointer. This makes it easier to move
> that pointer later into another struct.
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/tegra-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ2pUACgkQ3SOs138+
s6EgZA//e4+EUwlbBiONcBMcFK3Lp+OMNWMDeI5NDEdtigsIto/yEl8kKnYw84sy
5vvFhasY1oUEmxuIvctMxdcS+NHIUV4z+mV9iV1J6vMQFXcBB47JFnZfpfDxV2X2
+zFGe0UmOgLArSq78bL2BRvx9mJRlzapN5szI/GcHBjJuW/CKjySmNiZdDACIZML
2nPZe6lUloJV4xgcoiULetrVVaQbdwCzldPXaQSVbrvjl2r8IcqcvTYVjkzaJ0ah
gY5BEJsdp8hj3PdeYUNn4XCLtDWoh2CfdEpP7AjhpEUxzFoYTjk8k4XA6Lsh26hf
i6qTUaI6ISSpPx01zTA0Zd9aFPvDLbE0+7uGzVHAWzY58og5FclzVS/MT0kslEkl
XTYPcV9LlR7v67DxI/5p9yFoQJM0v3i+da8ERqZQuN2S0wprSYTN10htl1t51zNj
MHnVO0SyIH4tIpHbWQjjCTPvvVEbntFu/kxi214QHkZ7Yd28tQG0O6LY/E3QgPsB
VCOWKMCwFAgoKDdSn/lMBgEokV+ayjjhC7UYlquv/HB/lCYpnAZliYEe1ubZyD6e
UQ+jJFJDzn4KmFpH+y63BMQmH+ffy28t8SSuWSlqrbwP1F0QsQzIzlt/DPInB+01
/PfdHzsOmZlsXNYi3gAcG6CBZVe4birNpKcw8tjup/qd3MwOQEU=
=7QgA
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
