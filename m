From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 04/20] iommu: Introduce iotlb_sync_map callback
Date: Mon, 24 Sep 2018 12:06:28 +0200
Message-ID: <20180924100628.GF21032@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-5-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180924004153.8232-5-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 03:41:37AM +0300, Dmitry Osipenko wrote:
> Introduce iotlb_sync_map() callback that is invoked in the end of
> iommu_map(). This new callback allows IOMMU drivers to avoid syncing
> after mapping of each contiguous chunk and sync only when the whole
> mapping is completed, optimizing performance of the mapping operation.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 8 ++++++--
>  include/linux/iommu.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluotyQACgkQ3SOs138+
s6Hu5Q/9Fao/qs6ZsPgCpKGQ5rCOFkk1DdOsQluo4ar889JUxblUq/sDiCIny3Cp
RVoi8a9nZldE1uXIhUkJ8LMer8qZYNNfqTVs2VkB6NSBLJBuxnt1eZTK3mmSXPnj
pWvuL5tBIVQmYQyp3qkeYdHkSFAoG7d1vq+7IgSduEBfCvo0Zw6b+5eyuAgQxVKc
ibR+KRfWRK+YGrt28NkjfXrmEy5nCbqvxa3exs/LnGohehpRbl+7fPLSkEGMC/lW
GuESgYxfBG67Zo1MDDFPiCp2JL5pqfgXE5dI4vstx68oPEULfdlaxfzHTTck+OBx
uTRt5kImF4d9a7oD0XUplbo01bP7KEnBdDeEw2vNHXGjvbmqYxYqvaAb7I7iKbWV
V5dXp3H8yG/o+5e8m9fh8NrLUmAMfu+LOGMGksZirtWLnLh6JfjqmM+zWgW/nHUv
LjfEJCYH7GzH31BPPmI8e3PUmQByo1RZx+hUWaPyLdAmXsVCdlqI8BGeO8a82Td4
4D1M6Gm2qguonHPQiJbYVzTff7PC4Axonb7JtYeDZlSjcQKjWZjAvUrQ4OQvxJa7
k1Al+5C2Wau4UwsKoQECtYolEdEhCcSUFTNnhonUd8epAPB34z7RuIyo6jof6Bxm
Sgh49Of1Rimye14XhJ7wFhjMLFgVFOElRM/5mbVoNbXitp6H8Wc=
=Y+NX
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
