From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: dma-mapping: Implement arch_iommu_detach_device()
Date: Wed, 25 Apr 2018 11:29:38 +0200
Message-ID: <20180425092938.GA21182@ulmo>
References: <20180425091815.16264-1-thierry.reding@gmail.com>
	<20180425091815.16264-3-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2336374934013037688=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180425091815.16264-3-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2336374934013037688==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 11:18:14AM +0200, Thierry Reding wrote:
[...]
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 8c398fedbbb6..1957938d8c9c 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2366,6 +2366,21 @@ static void arm_teardown_iommu_dma_ops(struct devi=
ce *dev)
>  	arm_iommu_release_mapping(mapping);
>  }
> =20
> +void arch_iommu_detach_device(struct device *dev)
> +{
> +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> +	const struct dma_map_ops *dma_ops;
> +
> +	if (!mapping)
> +		return;
> +
> +	arm_iommu_release_mapping(mapping);
> +	arm_iommu_detach_device(dev);
> +
> +	dma_ops =3D arm_get_dma_map_ops(dev->archdata.dma_coherent);
> +	set_dma_ops(dev, dma_ops);
> +}

Oh, the irony! This doesn't actually build and I failed to notice
because I forgot to enable ARM_DMA_USE_IOMMU...

Sorry about that, but I think we can use this as basis to discuss
whether the API is good and I'll make sure to properly test the next
revision before sending it out.

Thierry

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrgSn8ACgkQ3SOs138+
s6F1ww/+Io3Jb9byScviM7GR6y34CYPzZt1/CqxuuQRTH6emuGKJAX7mWuU9ijVk
U2GvdZWo5Jx20V4+22CJhlV6MqWGLOKKDrhCDD45X4v5q4U1BRQYwxzbHwjqmFdm
kmOsvWuupQ/flF4ZsX9EfVsikoQMZMyhplHpaue2DN5iiOG1abD5tYDoYYNeog0e
0QSdcdYK6phHNgbP03DILieeH+fg3UwjSaGrE/9gX2aGNfR6taHtHe8h5A1xwosr
eVjpzOYSZVpDd/inbte2mAzI6mj2gng4XTAKpN40jJV4ckKthcmvNRZOp5t6UnsA
+zkbK2yPOxvFXZToCWgcGQOXN1/6BOrYpqp7ZkoOKenbfsr6+c8d0MUYEBW0OFrl
y5xVg5Ycj/o/q52/LETGHUK2b1IYm2af1vw/poauQZOx1G9HtFnxtoJXR3U3T5X3
Py37aFcImZELUq3JkNr/dk4NCIBuXU0dMQhx14qKHJ9UPlPUpnWQKMpwarY2UXAf
opHXDgD//tpBKolmdlHHnAR+6Dqo3mFuU5RUAmYJakfMCiSyM1Zz/zTwJKAN1tEV
qlBJRrNnDHliroPYVlYq1lOxbAttvhIMMpEsH6QbxCICcTY2FPG6wCdAa9eo+fTW
mZ8LIqwLIsM+taZdbznDlL8PjpgSrCG5//SmHXXonYTvKt8VG54=
=J0eW
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--

--===============2336374934013037688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2336374934013037688==--
