From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 2/3] iommu/tegra-smmu: Properly release domain
 resources
Date: Wed, 3 Apr 2019 10:43:47 +0200
Message-ID: <20190403084347.GB5238@ulmo>
References: <20190306225009.3391-1-digetx@gmail.com>
 <20190306225009.3391-3-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190306225009.3391-3-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 01:50:08AM +0300, Dmitry Osipenko wrote:
> Release all memory allocations associated with a released domain and emit
> warning if domain is in-use at the time of destruction.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykckMACgkQ3SOs138+
s6GSzg//cVlslOgK1ZaY2ZafDCO60gxqAHS8eLwbT0IXpDfdAcd51IWQwI9zvv4f
AY+eNqVuzrwccsL6gYnyZuIcp6v1zryeab/2VP7QySfoYTF4AXLXsZKI1bEBeT7H
fyq0Vg16P8BrIuzptVQH2H1ElgpRVjrsfIJsV33pqN8rn7VRMQYRPMXhXY1sC5zP
+7zXyg8RYKVtFhbFXuzm88QNk19DZ1kXgfIVbLD7cQ800MqE7eurwOwwxIOQlWup
61xgQHRWyRRgEKniYUR+nBxtf5MMvwmWNVXuHIqIpKrU5qt6WF4fSsea3eXeOIHV
Ubbu48yHrYHogZbH+GXPWZKAb75tapqqc0VbDbB7KVP2y85GnHHa4TPO7DOKLDv9
Uv6HPaDatWts7Es1XWkHdNFG+yhiMe+43bC3dKwfWfNnGSoBQ+WjSDOUr/zjMAZs
TNuGaO2C51H40LKxxmDYU3Aq1Mo9n9hgGnyANBK7F7PrV58QCzwVRNuX8CfXXdKu
DagdnXExfZqPTvXtE7UXqC6wR6KhRk/goEuboZ2TwBFqFPU5VcNSmbabv8vGRFnW
gUccLURShcs8OKfmTOymI7FHQQGkmI1U8JNT0KZGi4DgeC1/ZSyS8Rrz1GwXOdpA
wkwHMFstN4rfiKH2FTzwToaUHKHeXVKqeKgX6tXPSdBakDP58xs=
=51+Y
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
