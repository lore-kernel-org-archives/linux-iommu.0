From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 06/21] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
Date: Wed, 12 Dec 2018 11:02:14 +0100
Message-ID: <20181212100214.GC15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-7-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-7-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:35PM +0300, Dmitry Osipenko wrote:
> Splitting GART and Memory Controller wasn't a good decision that was made
> back in the day. Given that the GART driver wasn't ever been used by
> anything in the kernel, we decided that it will be better to correct the
> mistakes of the past and merge two bindings into a single one. As a result
> there is a DT ABI change for the Memory Controller that allows not to
> break newer kernels using older DT and not to break older kernels using
> newer DT, that is done by changing the 'compatible' of the node to
> 'tegra20-mc-gart' and adding a new-required clock property. The new clock
> property also puts the tegra20-mc binding in line with the bindings of the
> later Tegra generations.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/iommu/nvidia,tegra20-gart.txt    | 14 ----------
>  .../memory-controllers/nvidia,tegra20-mc.txt  | 27 +++++++++++++------
>  2 files changed, 19 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra2=
0-gart.txt

Acked-by: Thierry Reding <treding@nvidia.com>

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3KYACgkQ3SOs138+
s6FZRA//cB/CHkKjPsOF+E9nDI2hDiPmyB3xhsehRWwGC5Vt5DasCimC/0yT6qXd
aQrbl4QAlaTxxoGKRjPBOb09kTFto9ZPlKoxgFSNZSYN1eYg75l+i8uUHF6vLRwf
Mwgk7NSRHS5mhGlBzzuuUEgQgNTBDOnAmd3n7kmDTgKy67cHkER9t9oilMFXL9FV
3TacwTj6HjaO9Ec/V4K8lzi/Qi5wbjhTZpGyN/K+ojCM/T/5NAuUJjlOEyJHOIK6
gg9xcBnsp4ApUyjEXXAcaabRBROl2/oorX6UsrsGAt7OfbJlzo1Z+R1bof4BOyGy
kJHyrPYWxuHYegZTPPHm+p67uJBg5N8LC7mcWs+ZpypVgDjjUIjwZr7qDEkCtGrg
suPXqEHUi47SAdQ+MNm6ISEmJX7PnIUbQcCi0/aOJ5J9Bm+d7+l421CrvTGn/e70
mFnUwJCW6xWZLK/IpEvRBtY2fMnIssMrBLbXC76oNyA4dgEttHZitBc5Iei3sLsw
4PSE2lF03RU2FZ2FCln4vn/ORACLrTAofeieL4vPHGAljFDLgdP3nL9E+wvHGqgq
hWBRlptbxsyFyiK0nWO72mQslRYChirO0LYtxsJrVU42iQqSRYxibTqVNsdR3Tol
4aKnjZuuuafbRyZjZfmEHIiTPEoyJpT9JEPbj799ji70cm2mZ20=
=Qyix
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
