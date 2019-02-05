From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Date: Tue, 5 Feb 2019 23:29:12 +0100
Message-ID: <20190205222912.GC1372@mithrandir>
References: <20190205110602.27717-1-thierry.reding@gmail.com>
 <20190205161036.GA782@lst.de>
 <20190205162057.GA29974@ulmo>
 <20190205163837.GA1222@lst.de>
 <20190205175611.GA7052@ulmo>
 <20190205180218.GB2882@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205180218.GB2882@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 07:02:18PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 06:56:11PM +0100, Thierry Reding wrote:
> > Sure, here you go:
> >=20
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tr=
ee/drivers/gpu/host1x/cdma.c#n106
>=20
> Yes, I think we I can come up with a nicer helper for that.

One thing I could also try is to remove direct IOMMU API usage at least
=66rom the host1x driver. I think this might work nowadays.

For Tegra DRM we still need direct IOMMU API usage because we need to be
able to map into an IOMMU domain without knowing the struct device *
that we're mapping for (it could be needed by any of up to four display
controllers). For host1x we always only have one struct device *, so the
DMA mapping API should be good enough.

Thierry

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxaDjcACgkQ3SOs138+
s6Gcwg//WRhXjFu9BSLtgrWzoBPopvxCVRqepUzKFiRnTnkFrU/g59V6Pr1ZByZv
z/urtOpVjpYTLc/RHUuTvY1eojJRv40hE/WYNrqN6u9/WLdbSZQVktNkt0HD1het
f29Of53/q3CDCagCP/BcePZllaNrf0aMSicRVAJFLhL9x5ZtV0TII4yCTGSdmnYj
7zWkd4NEp5BqoPi76MtxlfsrPpUPCeDa5ZBiCffDebDQyVMvfNtWp1FYvYop4hLt
z2y+QYqUlyMpxeMEi5P6vTFtoDsZuATEbMF9+Y9DPVZXseKgbMcTnFIzR6rPcQM0
k/d4sMXl/GPMPQtCyQlXKaflHuL5uvrk+3WDAP3pjnG/IO8MZj0L8u3rfWa03wuF
3J2LF7khOs60EFPZYYgIlO4ocvVrAygjWiEu39oK8OuIFTuvRujrzi2lCqsgqoT5
HI1J5GxKFpCjejRSAy2CtDthx+SwKkewLiUy2ZKz7TLwAS1NMx0cwh+6t5p35Q/l
/NjU6hg1bWk/Tb3Q5aVqO5wPi+xs70BMXGTS7ZEIt+qEtwe5IEWpDWU9zHDtCjA/
XFmcPow2PZNRrXsHWdeba2JZrhcVCSZamoXubt/ZAhf97N5SKi/sj/h8PEzBGQCn
vFjAOaZurOKJsSL+Anx+XX07K/K/Drq4uqWiwTkW8FMwAei7K7w=
=igOb
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
