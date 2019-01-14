From: Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
Date: Mon, 14 Jan 2019 17:09:03 +0100
Message-ID: <20190114160902.GB9218@ulmo>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114132240.12125-1-m.szyprowski@samsung.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Russell King <rmk+kernel@armlinux.org.uk>, Ben Skeggs <bskeggs@redhat.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
> This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
>=20
> That patch broke IOMMU support for devices, which fails to probe for the
> first time and use deferred probe approach. When non-NULL dma_ops is set
> in arm_iommu_detach_device(), the given device later ignored by
> arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
>=20
> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iommu_de=
tach_device()"
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mm/dma-mapping.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Can you point out exactly what drivers break because of this change? We
need to find a solution that works for everyone. Reverting is only
marginally useful because somebody will just end up wanting to revert
the revert because a different driver is now broken.

Thierry

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw8tBsACgkQ3SOs138+
s6GvdA//W9RbyrwK0Z1YF6WLWPz/Vrii+8f8EHn/G8ZOdAmYNIJLbATdEhoF+3zo
Fr6+hdn1ZOtXfyMMTXz63/c47xpiJVqpCj09vIt5qv7Mixu4xA90obTA227xDvVE
7ta1T3DXzMskYiUgqSQUceJh2MIHLjpF4yFtoAvsn4y9Uji7CkcVbaoCmRVy3fGJ
rNGPBRSbbIR29Ox3fpECd+zf+9Ca4YhwD08+IuZ04vBO2JOnAh/gzephofRsYf/o
uqkxLdRux2c5tvzJIkuovYrbSYKNCuB/2GMy+mDVdUVpKpuOeI+XnryipeaGLX1W
wD+hXq7uJ63s6HEH7IkIb6s7TjZEhHmtYSA8vw5KWbGPj47t1Yr3P+aD4dZ5hOaU
w9EhRJW3WKUgWH5jioTtXU9npYXwDfJG3+TKe+XNB2fQ6gOhttoch+lMggtgNEzK
a85jKxcnXV7Xpo7UHz7KJGivug20QvAsYSipVjhn6CXBdIg6PEfOgOmAULhpX/O7
gQxUdeVhvW4N8WS4nkVMJ8Kudo8370WQ7gHW7kYSLE7ncksa17cbMegb3jq5dvax
9HygtnaTqdO8VlbdXghXU8C7X3z1eWeUJO2ZcedmsVPSRzJ4lfYxfK4ep/YsqS2q
fgCBQmOzZV6JNPJNUZzeVedrIArWbr6DejaXff4LjfO/Y94Q7rA=
=cziU
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
