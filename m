From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dma-direct: Export dma_direct_alloc() and
 dma_direct_free()
Date: Tue, 5 Feb 2019 18:56:11 +0100
Message-ID: <20190205175611.GA7052@ulmo>
References: <20190205110602.27717-1-thierry.reding@gmail.com>
 <20190205161036.GA782@lst.de>
 <20190205162057.GA29974@ulmo>
 <20190205163837.GA1222@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205163837.GA1222@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 05:38:37PM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 05:20:57PM +0100, Thierry Reding wrote:
> > The problem is that if I use dma_alloc_coherent(), then the memory will
> > already be mapped via the SMMU at that point and then the driver, not
> > knowing that memory has already been mapped, will attempt to map an IOVA
> > which will cause an SMMU fault when the host1x tries to access the
> > memory.
> >=20
> > I didn't find an equivalent to arm_iommu_detach_device() for non-ARM,
> > but then stumbled across this and thought it was rather convenient for
> > these cases. If there's a better way to deal with this situation, I'd be
> > happy to do so.
>=20
> So you basically do a dma_direct_alloc + iommu_map?  Can you send me
> a pointer to your code?  Maybe we need to add a proper IOMMU-layer
> API for that.

Sure, here you go:

	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/gpu/host1x/cdma.c#n106

Thierry

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxZzjgACgkQ3SOs138+
s6FcGg/9HDPe6r1j5PFKvrj6Ft7aPgTrOaDE/rYoMyc2mPL3KOzkUQJh9yg7Wa9K
p5VL1XUtuSgIXUAXnFeAAocWUa5Tmq1GPCXbbWeRi87XWVFjuKq+xCGz1AZBhgaS
EwrWRLyGqE9fZXM3iBCFyRGzNSxGiAA80TuxJCq8VmfOe6+fa0TrN3c06olPdBc3
zdARlmjL2rr0vOXG9SFz/zuK4xJ86aup3Q1H8oBFtTXM4zbmejVzxelZRkJ+Ck3U
NNCwArBojOT7DfA03QPElZZwXmwegBERMXD2Zjeb5c/c2Mhy0/tNtW9Qvd6jBDpZ
sIP9KLgL3s1PoP+fapM3V4FVf4+KSxbLe1h1GiXbkQQiD35n6b9Q+Ka5CicEBTYv
aGqQoZSHr9uNFXzDzv2cZ8KBj0lk3MvEXIB+ZQUXSyL1lLmLSMuWbpoG/9B7krfj
71CSEZO1qiP1Ya8tMbjgjOW0HjlOF/Z15mkkSizAH3YIyYnqNCWTluUADyZf/xxm
YSoOMJ2yHwUzuxO1J0pWu4kv98F+KiV8VlUwk736Ykq2oBoFzVTCQt+rBPDG8+ak
vYchQ+dOGZ+JuEiXht8ejZsTXPZEHDvo4ycudPSE3NTeEtBF0qa/1qROUQAaI8bN
Kn41hiTmlbzeyQ5tbrMO+t4ar9dlCn1NGue45ZS2pjXJh96c82o=
=eUMp
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
