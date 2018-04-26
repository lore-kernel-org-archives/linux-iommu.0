From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/5] ARM: dma-mapping: Implement
	arch_iommu_detach_device()
Date: Thu, 26 Apr 2018 14:14:09 +0200
Message-ID: <20180426121409.GE11985@ulmo>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
	<20180425101051.15349-3-thierry.reding@gmail.com>
	<20180425152049.GD16075@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4079600245322452102=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180425152049.GD16075-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4079600245322452102==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 08:20:49AM -0700, Christoph Hellwig wrote:
> > +void arch_iommu_detach_device(struct device *dev)
> > +{
> > +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> > +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> > +	const struct dma_map_ops *dma_ops;
> > +
> > +	if (!mapping)
> > +		return;
> > +
> > +	arm_iommu_release_mapping(mapping);
> > +	arm_iommu_detach_device(dev);
> > +
> > +	dma_ops =3D arm_get_dma_map_ops(dev->archdata.dma_coherent);
> > +	set_dma_ops(dev, dma_ops);
>=20
> Why not simply:
>=20
> 	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));

I had that initially, but it looked cluttered to me, so I split it up.
I don't care much either way, so I can revert to that if you prefer.

Thierry

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrhwpEACgkQ3SOs138+
s6FV9Q/+KVsKhrVJ7Zh8jvSb6d/IAN1aQMyNjF/2Z39Y4CoJvSf7b1UfWFrxCqPa
Mn3QVSjsW0xCIf8TNvhyxu7T4utumxzQ5Hh1Xl0ql8Astkj1rnGnenN6RpHb5abR
ePpXDYfeltIWHTCUON2NCHnz494SUKbB9Y6/t4u2vWVjapr+dc1WY3P0fRpOxgSN
Ei5IUqn97vHB4zvLQoE7V8x2xohh1D5ZWgS1tkl9CRstgAnCebUZVIvP+j2gULdc
mVODPlj5iw1JLlYlovw9jf8L6eobAMtMzJsg1xeBfgUKsTm6SBES/GHjiUKQwbqq
tXufglIka3tJmNde3D9ESOhCkJPbkwCEzKY90JVGDulB/D9XI+24AMXG+6Ip0D8k
BP8+xHBRjsiWmQs6QGMQfAevV9+xYCA/cg1LletwoV1nf4QhfS5qUTVNd75jKU4e
q2FKimpJHDgATjwk/pBfru7myN3+7c6qA2UMd3NFJzaKIczisRHJvpChdDhwZsSS
70d4XAsVPlnagL3l9V3m2cvqqEobJnQrhaf0ncHhzs7Lu5WF8ZaEODzwYrqu8lHM
H/yktoBOuA7eyQ360VugWkzZkzmk6G1gfQmwzDvGIfU0d7j5YOYui5p0wsWbXstJ
u2VdllCbsrfFOLgFCLwiyQPy4gQ22Tja58D7WRRx6vopRk36zAg=
=2jKW
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

--===============4079600245322452102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4079600245322452102==--
