From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Date: Tue, 5 Feb 2019 17:20:57 +0100
Message-ID: <20190205162057.GA29974@ulmo>
References: <20190205110602.27717-1-thierry.reding@gmail.com>
 <20190205161036.GA782@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205161036.GA782@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 05:10:36PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 12:06:02PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Drivers that are built as modules may want to use these functions, so
> > make them available like the rest of the functions.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> How do they want to use these functions?  The proper way is to
> call dma_alloc_coherent / dma_alloc_free and let the DMA API
> handle the rest.

This is again for the host1x driver and Tegra DRM where we had a similar
situation a little while ago where we needed to explicitly detach from a
DMA/IOMMU mapping.

I ran into a similar situation on Tegra186 (which has an ARM SMMU). The
host1x driver needs to allocate memory for a push buffer that commands
are written to. This push buffer is mapped translated through the SMMU
using direct IOMMU API usage. We use the same domain to also map command
buffers that userspace can pass in.

The problem is that if I use dma_alloc_coherent(), then the memory will
already be mapped via the SMMU at that point and then the driver, not
knowing that memory has already been mapped, will attempt to map an IOVA
which will cause an SMMU fault when the host1x tries to access the
memory.

I didn't find an equivalent to arm_iommu_detach_device() for non-ARM,
but then stumbled across this and thought it was rather convenient for
these cases. If there's a better way to deal with this situation, I'd be
happy to do so.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxZt+YACgkQ3SOs138+
s6FSlxAAlC10Qh1f+7ePw23JTUxc7z8UWOPkt36ZuuJ0PMKin0QFFGx/x5atfSH9
N1c0nzH6bTi5RcdQ7qjkFkJrYnXfHnZaBmQqp2agsNI2F0X431Be3byeAxD+Pr9M
v8vVImN5LV2NUXtrgJaDhOdFg/yBOV7HoNWoiFA7GBxaKjVquQrZ1AxbWfvgEw/G
piPrkNh2oWl0dwK2PIvXD7BUTR9i4u+a2lOqozdfo8rOoIGfsOsSnkI9biDFi7zH
J5F8x1Q1KbK/VqT73dzPPOLa9w5WR9NddPaqc/BtFQGNevpNbnF0UM6oIsYWAysn
RU1Dj8XLApzINvFGP+lYY7HOW+fai6ckvkIXwPDUYxsgcnFts9cjrnqYEqZJceo7
N0cuiExgaqgRREJrvQ3kv2u9+dCKgQulqpNa7G9++T+6w0dhP76Eur5akH8UMYxd
BQSJEl5G/T0E3KZ2Hq/Jn47/A4iTb/QaP7mM8ewM60NT493Md4gMR27hvbezbeIl
neaH+eTcbvyjxe4lbf+0TBqWK0FzkZh4tUwurZ/NPOMVD0z+KgJo2ZFsxh84pr2f
mbmrC3zSNSA4Ls7EFaX4oOwUfsS/WVRaTz9w4eNo4V7i7hXKYhWbPJvrVIaCmK8c
o//eHmWRyMN2XTpJx/rzJ918TEr6eeZo9XZGymFj04Al+R8LvV8=
=72tt
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
