From: Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] Revert "ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()"
Date: Tue, 15 Jan 2019 16:29:11 +0100
Message-ID: <20190115152910.GA12652@ulmo>
References: <CGME20190114132250eucas1p2abdf2f36bad3554e37dfbf40e539f594@eucas1p2.samsung.com>
 <20190114132240.12125-1-m.szyprowski@samsung.com>
 <20190114160902.GB9218@ulmo>
 <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4f7fd8db-33e4-9c8d-2fee-1ca9c98a9276@arm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk+kernel@armlinux.org.uk>, Ben Skeggs <bskeggs@redhat.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 04:38:20PM +0000, Robin Murphy wrote:
> On 14/01/2019 16:09, Thierry Reding wrote:
> > On Mon, Jan 14, 2019 at 02:22:40PM +0100, Marek Szyprowski wrote:
> > > This reverts commit 1874619a7df4b14b23b14877e705ae15325773e3.
> > >=20
> > > That patch broke IOMMU support for devices, which fails to probe for =
the
> > > first time and use deferred probe approach. When non-NULL dma_ops is =
set
> > > in arm_iommu_detach_device(), the given device later ignored by
> > > arch_setup_dma_ops() and stays with non-IOMMU dma_ops.
> > >=20
> > > Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> > > Fixes: 1874619a7df4 "ARM: dma-mapping: Set proper DMA ops in arm_iomm=
u_detach_device()"
> > > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > ---
> > >   arch/arm/mm/dma-mapping.c | 12 ++++++------
> > >   1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
> > Can you point out exactly what drivers break because of this change? We
> > need to find a solution that works for everyone. Reverting is only
> > marginally useful because somebody will just end up wanting to revert
> > the revert because a different driver is now broken.
>=20
> At first glance, it sounds like what we really want is for
> arch_teardown_iommu_ops() to completely clear any ops that
> arch_setup_dma_ops() installed - does the below suffice?
>=20
> Robin.
>=20
> ----->8-----
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f1e2922e447c..1e3e08a1c456 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2390,4 +2390,6 @@ void arch_teardown_dma_ops(struct device *dev)
>  		return;
>=20
>  	arm_teardown_iommu_dma_ops(dev);
> +	/* Let arch_setup_dma_ops() start again from scratch upon re-probe */
> +	set_dma_ops(dev, NULL);
>  }

Seems to work fine on Tegra:

Tested-by: Thierry Reding <treding@nvidia.com>

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw9/EIACgkQ3SOs138+
s6FxyQ//ZXUg6+LaxF3qtCgUCjlJAxBQEY573IAkyXQRnqOtvp01En0lJhfI5fRy
oPY84NIYecY/Okx9GKAnsOSZ3/qDKN+XwHiwEnIF8Jwom8zDholM7xxHdQQDBxCE
QW9pHFDVVxNlm2tI1S//+Rrb/V8mSbxt/4Ufn9pOwh9ZEghQgyAVzXM8O0WYr+lu
ddkl/u50sBNO3VfJPTUP4gJFMus1RuYV35U37hqdgZNK9Scy8aB2ocpk0phA5LK1
7kX/jrFSkCw9mvGgnBH1Lqfwxl4ts6c+MWSz8A7tNFOhFystJLi7qQOkYHujU1on
yAFaC7Mq8VuUdigXsQ3pyTxBLQFAm/ifV1ut44VXnZU3OIuSCJHPHoVL9FnO3237
bqQBvA8LxO9mWsP9GFaHs38TaMkD1hoLispjSeZbRNa+EvI8xRBsqOBIW5mvXE8p
p125mj1mNIKdzOtmh2x1tFrorXMT6JgpD4AkDyj8450dpKeT73CELCntYkvdBzyh
pV8XidIaT1ilF5s2UOYzY8od4QeH1RyMIPiqCZHQQzqnx5U+u7KBeyCBi4osqtCj
pDwGeMuz6IxnPdKJRnfVIgOpq1YTelR/SknqK5mEI8vJGqHKDLsLWZRN0+kPB1dh
u9abmsyph4ctT+vL1gy8xh0moEBIBix0C7rodaP2MzxfrymikjM=
=hfU3
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
