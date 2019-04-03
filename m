From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 3/3] iommu/tegra-smmu: Respect IOMMU API read-write
 protections
Date: Wed, 3 Apr 2019 10:44:14 +0200
Message-ID: <20190403084414.GC5238@ulmo>
References: <20190306225009.3391-1-digetx@gmail.com>
 <20190306225009.3391-4-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190306225009.3391-4-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 01:50:09AM +0300, Dmitry Osipenko wrote:
> Set PTE read/write attributes accordingly to the the protections requested
> by IOMMU API.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlykcl4ACgkQ3SOs138+
s6H28xAAgNjdDZjkv5RLkJ4TWzCDzmFPgu2T9fGG6G1y/ZluTwUWVSufoTnXpQQA
fgPeZypWXbodkcIk8YRrPUo/vF47hNO4bJJrnFS6/7AQdzgHEf698LnOBh9mzN5R
QXmDBX/EmcwBL9Tmd6V8LIFN6FqrCl+q1jSi3odAFCbb/n+6AdLT4R2B7op1TvBy
xIV47Tq7pY5uQ71KSjT8zN5mHP1WNcEjWg3uuLp3OpZ0Ifv69ihvgU2xd8bGuayH
4IIu3SC4rAycDfPcYveq2EeVuuzuBXxPNiDUlEtCLQCYyNs0BC090xo3mQRBrKF5
rtQHvip+24w1HZxO4Na9eWm52h2Zhi9maw27cgYmfGRwwXA4z2lyYml/7+MOR5JC
tZKPbX5AnymdqAEgdsqAr+y3iGHYydeVS6Jbf//y0vPKylJDK9nUDZdFdFK2MA9c
sPUjYO/6zRdtqmvtg9EWja+8GGQ4/V+UlyswqjXNRv+qZEAxCg3l3gy9hZQVWe01
46zL5U2by3F4+m5HGXqUiQLgUSi5tzUHTl0vlcetJHi9vidKDqQTxlZo3bksjwNg
TmSlm1I6eUqvqE/dZsv0TCfigGvUTxlExOqxIkRcPnfH4y8VRiUtkFIto4u1idQI
g4KaEcvPvnmbd6X0nfPLFJDIhUWRNu1j28czRMFA1ODAzHltloA=
=1HwV
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
