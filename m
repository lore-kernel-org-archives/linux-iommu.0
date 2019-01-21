From: Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] ARM: dma-mapping: Clear DMA ops on teardown
Date: Mon, 21 Jan 2019 16:34:40 +0100
Message-ID: <20190121153439.GA21078@ulmo>
References: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2f5833b7639543d614095cd3f5ab0dc0274e26d6.1548081277.git.robin.murphy@arm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, hch@lst.de, rmk+kernel@armlinux.org.uk, bskeggs@redhat.com, tjakobi@math.uni-bielefeld.de, b.zolnierkie@samsung.com
List-Id: iommu@lists.linux-foundation.org

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 02:52:16PM +0000, Robin Murphy wrote:
> Installing the appropriate non-IOMMU DMA ops in arm_iommu_detch_device()
> serves the case where IOMMU-aware drivers choose to control their own
> mapping but still make DMA API calls, however it also affects the case
> when the arch code itself tears down the mapping upon driver unbinding,
> where the ops now get left in place and can inhibit arch_setup_dma_ops()
> on subsequent re-probe attempts.
>=20
> Fix the latter case by making sure that arch_teardown_dma_ops() cleans
> up whenever the ops were automatically installed by its counterpart.
>=20
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_de=
tach_device()"
> Tested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> Sorry for the delay - there was a giant email infrastructure cock-up just
> at the point I wanted to go back through my archive and double-check the
> discussion around the original commit...
>=20
> Robin.
>=20
>  arch/arm/mm/dma-mapping.c | 2 ++
>  1 file changed, 2 insertions(+)

I had also tested your draft on Tegra last week and this looks
identical, so:

Tested-by: Thierry Reding <treding@nvidia.com>

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxF5osACgkQ3SOs138+
s6Hu1w/+PREMHDE0jWgKBN3n9eINXN6aliHOhCeWQxco5/iJjCSeCofcMvFzuKx2
p8nZ8OfIMZvj4AatYeryqn7bPLSQiRfwVtC8qOfERTv7z+8m4F+o4rPSKmr0/1qI
rSqpTFY4exsTlp7Lp7DHsg2sbd0Av6UvgiNJSLpTLai0loCYfPuF+lvbdlw/x6wC
CNa6SBE+rI/u+QRNY1jRPkgEMovOnsvkKY4bf7+v3elI3X7bZhObqyNLnTLkNpYL
w01hvCpxpo4vrX12kTDzuhOxxnKF1md/QrlviZWl/K6CI5L/UqlP1ttSj3p5INna
nGQ4Zjr+ykq1enUBHlLwkfVGD7mV//BaVxvIyMtKtWewJ3YoQbPhrcWCAg1pqjJ7
C9ksb5Njf7vOyF5KPGdcyePUIVw7NaIytAQrRE3ww7iuZg78fBs7oxjdzyK4D6G5
+2DcaumIx18jwD44wP8g6z0foo1GgN6IitWoAcH/UhVX9ID/eMl5KNxHogW1N2bW
GJDagpZCD09vxmKBcYFctXGbL3RoLKS4+mVu93vjPNhRs813nXAPMC5E+NZcI6vZ
l7CYkq3/V6af54QGr7/0K87mIT6dIjkOCVYNjH4ZHPLjJolBZ8iS5636DyDoldk0
SlUgLWwfZ80fcqNh19syiJRaVIpW2CahirFJilXtoFd2cvDOLPM=
=LcGP
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
