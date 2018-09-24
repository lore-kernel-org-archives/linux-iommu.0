From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 16/20] iommu/tegra: gart: Don't use managed resources
Date: Mon, 24 Sep 2018 12:52:46 +0200
Message-ID: <20180924105246.GM21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-17-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jB+02Y6wHc2pEa2x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-17-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--jB+02Y6wHc2pEa2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:49AM +0300, Dmitry Osipenko wrote:
> GART is a part of the Memory Controller driver that is always built-in,
> hence there is no benefit from the use of managed resources.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

One benefit would be cleanup on probe error. Also, we may eventually
want to make even the memory controller driver buildable as a module.

Thierry

--jB+02Y6wHc2pEa2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluowf4ACgkQ3SOs138+
s6Enbw//ap7tF+xS6njyozu0rJjVrmuTyjWXznxYcc5gfB2IrtvSEGciS1o81G6f
cijMcyvGZS4ChsKlSk0KUt2fSNOj9NBcqiWqAFDzvWgkSvn98to59sMow6T50SSi
qxHTkVN0iMO1IWwx5CTOyb4HY018LQR76J13MYOY6In7tOBX3/MssFsHniD7E01H
PdN4ICE5C9+pTkSpbr+7btE/4AE/yL62lJYMcd8A97U/hh2GhOc89B80PrUN3fAy
znHVjL6Cm+ZtuNtgl6aA1UUYDFomfDHpjSuYPdATUgi5VH04qml7ZVi3An6GyfQZ
310RHjE4PEKDg7OpRfCwnFB5OYLiduXuK2F6Ulv4UMSogiWEcWi+AOv2MvyUstm2
oJH7wMY5DUp0Ch4Is1TxVdHOKNhb0L45p1C16Xbmz1tQXO389D6idFk4dhIZYEFk
CCM8N/1neNSTV600r0hSgmpmlHovvHz/AONlji/GstfCCJqSey1+nXLrOTDPIe4g
OQEFRDkYtywdSgnJqmaiJ7SYdOPY0EqMJxGRQRIUObqw1uxMCGO81t11F2dXu8F1
HogWgI6YXt6LaHU1hRYkbCvAm3DZxQVFWPczxClYp7qvNrDTgne8GNMMWXtQ3dyl
qrRWft5yOX5tO7u8TBB+slvbbEcNJ5XaJMvZqg+kYZ9g7k3AFXs=
=PlGd
-----END PGP SIGNATURE-----

--jB+02Y6wHc2pEa2x--
