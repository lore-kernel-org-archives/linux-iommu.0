From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 18/21] iommu/tegra: gart: Prepend error/debug messages
 with "gart:"
Date: Wed, 12 Dec 2018 11:20:58 +0100
Message-ID: <20181212102058.GL15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-19-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/jkxxxtAhYIHVDuh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-19-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--/jkxxxtAhYIHVDuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:47PM +0300, Dmitry Osipenko wrote:
> GART became a part of Memory Controller, hence now the drivers device
> is Memory Controller and not GART. As a result all printed messages are
> prepended with the "tegra-mc 7000f000.memory-controller:", so let's
> prepend GART's messages with "gart:" in order to differentiate them
> from the MC.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/iommu/tegra-gart.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--/jkxxxtAhYIHVDuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ4QoACgkQ3SOs138+
s6FaAA//W+T5CGeUZoovs6Ol4TC4GKo1Ig1hAN32fYi6MLJecFSOJJQhh1klmk8b
8pCoOOEkbr5tOTKgReveh8RRIXL4V68aNpQ0iuGgrutH9kNJSHiEdWS0/cq8yyei
kobNf8pgjUiu8ZL/HKyN3PjQSXFeAeCmK+tYsJTMPxT+XxYZvNEntMqSKobH+Aa9
9q1LeyJz6y7ALgHBluAAuds0eSNRY10oUcG+feIe9TOM89Znt+KbQirChbRerst0
4cScjW0zr8RIYV1oYY9y784UAtRFp97264AMevYtzAffhMqDC9ycsg6DafAUC2ed
8quEH8VTH+7VdoVSy0m2AikAMZZ0hVoLb3Ub7B2Q8TC+XFAcoQjgW4J376DIZDW8
jL6HQoriN/9URyQo8fNjs0Toa9/pCnJtS4SXwMFL5CgGJs2+ToyNGYlduLjVcKT/
fdLdydRmNpImRvNUuYcKwDrtIPCL52AswBwu0WNzZpZmAl2cEmvmzOc5sJ+3sEwW
nHtotQHjmd69BqxkdLd4K4cVxptT/XPhW+FSlMf9BoKra/mMWvfNbxddDJxdB3VX
a1oYtCI11P8LvaVn7K2yDtCSf5BWaCk2Gs9R28QBjdSVcLPFaHVDW3oobat/dwRx
3EXh0r4DeQdtSs23JQDfXCJi1LAmyvTbi6USoxm18hcx9oscMnI=
=ZNdi
-----END PGP SIGNATURE-----

--/jkxxxtAhYIHVDuh--
