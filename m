From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] dma-mapping: fix lack of DMA address assignment in
 generic remap allocator
Date: Wed, 5 Dec 2018 13:35:57 +0100
Message-ID: <20181205123557.GA28929@ulmo>
References: <20181204142304.GC2618@lst.de>
 <CGME20181205101414eucas1p2fdde1c06ad6352293980b94b86b022f9@eucas1p2.samsung.com>
 <20181205101401.3561-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181205101401.3561-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 11:14:01AM +0100, Marek Szyprowski wrote:
> Commit bfd56cd60521 ("dma-mapping: support highmem in the generic remap
> allocator") replaced dma_direct_alloc_pages() with __dma_direct_alloc_pag=
es(),
> which doesn't set dma_handle and zero allocated memory. Fix it by doing t=
his
> directly in the caller function.
>=20
> Fixes: bfd56cd60521 ("dma-mapping: support highmem in the generic remap a=
llocator")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  kernel/dma/remap.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Tested-by: Thierry Reding <treding@nvidia.com>

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwHxioACgkQ3SOs138+
s6FrEQ/+JDxH1WopBJG6bpMeKByiWYJdObpk1wWcMYzSme2BnvWsUJW1OM7ctUOT
AZKVxbWFbaDJdLs9xlkIkVAOMe9i9eGkwFJB0IugR7NlhH3HV1VPbd99K4VvmV1q
hAtBq8UEod1YXBD7X836sJLRsYwzEb6TP6E2en5EPMDgrOS5N1rhcCyslorrXoqs
h+n3wZllTQxBr3liY3FFwawKDYuSj8PRqsn8AKXh5KXJS6F718lpPxL4PmnhWPUB
76YA6uqe5mYPvdxAS7lEhM+BjuNBRSO7rGSOJpBVkcXbDxb3BJCGMnhUbmnjRDCH
0zyIyaKQa926YoZIhSOcWCIgQdPpXUWf67BOaX7phmL0fIUwfjJKsMQY80Wcqxxu
YzqE36DCHj46h29PbhXbBcy+/bCBZ7YgDCQsHBk6+gYGJbYLj77ouN2L8OrmcDBt
+yXpoyQoRDiGhDQ4UBEvK4bAKvBPG77G5Z/he3XvKIwty/ErnKC7aVWpa+a2sn+x
mnOz+E7M6eVM/nSkdXRn/wWfAxXYZbwJ5+oLMyKERHEyvl6/acKAoTmH7vNNVmjt
TKdXUoEQr1rTzGD05Zlm0wC5sB8+PnCIJQV/g779HpYLNtFJq/YyAF2d2NoVXkcg
EDMdZsy7f/vWd0+4oKpR18RvDdKzBuzHUJdiVC/P9rt7FDvI5YQ=
=TbI5
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
