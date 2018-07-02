From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] ARM: dma-mapping: Set proper DMA ops
 in arm_iommu_detach_device()
Date: Mon, 2 Jul 2018 13:53:17 +0200
Message-ID: <20180702115317.GB5280@ulmo>
References: <20180530140625.21247-1-thierry.reding@gmail.com>
 <20180530140625.21247-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2113506574=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180530140625.21247-2-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2113506574==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 04:06:24PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> Instead of setting the DMA ops pointer to NULL, set the correct,
> non-IOMMU ops depending on the device's coherency setting.
>=20
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v4:
> - new patch to fix existing arm_iommu_detach_device() to do what we need
>=20
>  arch/arm/mm/dma-mapping.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Christoph, Russell,

could either of you provide an Acked-by for this? I think it makes the
most sense for Ben to pick this up into the Nouveau tree along with
patch 2/2.

Thierry

> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index af27f1c22d93..87a0037574e4 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1151,6 +1151,11 @@ int arm_dma_supported(struct device *dev, u64 mask)
>  	return __dma_supported(dev, mask, false);
>  }
> =20
> +static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
> +{
> +	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
> +}
> +
>  #ifdef CONFIG_ARM_DMA_USE_IOMMU
> =20
>  static int __dma_info_to_prot(enum dma_data_direction dir, unsigned long=
 attrs)
> @@ -2296,7 +2301,7 @@ void arm_iommu_detach_device(struct device *dev)
>  	iommu_detach_device(mapping->domain, dev);
>  	kref_put(&mapping->kref, release_iommu_mapping);
>  	to_dma_iommu_mapping(dev) =3D NULL;
> -	set_dma_ops(dev, NULL);
> +	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
> =20
>  	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
>  }
> @@ -2357,11 +2362,6 @@ static void arm_teardown_iommu_dma_ops(struct devi=
ce *dev) { }
> =20
>  #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
> =20
> -static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
> -{
> -	return coherent ? &arm_coherent_dma_ops : &arm_dma_ops;
> -}
> -
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  			const struct iommu_ops *iommu, bool coherent)
>  {
> --=20
> 2.17.0
>=20

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAls6Ei0ACgkQ3SOs138+
s6GLKg/9EtxOidIWFfV0JMYDi5/VjIp9Wpb0c3kTEkd1vvvwRvTIDeyr004XGRxf
TxEhQKwwGVOCQkAevC+OgWmpFxBpbYvJ7Ps4kGTqjoJWFH53VCoVWbHqGcBqdW3A
gV99iJyR8YyIRMVtsRJIqD/3w9J/JfM2fGHj/gUxqbuiAhLK+heAt+sLXJGD4gDv
NQp3iCEGvaM8mfMHcgxwKulhmbRbznJ5YIvc7cDQZDVVoijyQqbA7sGWVV26oAkE
zvFeu0v/Dkl+ht2Y0rKayMgf7nqbhYM1zvMAaDZvoVrj/KuL0+4Gv8RSEsMVoNIg
akWPRj81i3+hzc+p0T/HmDbzkS+NT5eV3qy9OdZ3h3EDAR/IG0gxqxS40Cz8dlbu
ai7gDy0lwqLZ/0+qknCH0U4+ep6j+B4oyOSRm7gG2B3a+3MH0lnEAXb+LcM+0Hs/
t6yMwc4xIg6jAM01G9ov7/szUvaWyJMAmE8/dwZZOTR/iD5l8TGHVb+UM9BR7Wek
2xLDORkTNVYav8oweu0LEeuihbDRTkX8jJqSPI5Au1qodihqEwzNPf23hr1/w8Hr
9TCoKI+2OentXk0cYk+1H4nCnEQxThP1TNJIo353TbqXOJgwdaPKbdGizh7BhM19
2/PwWVPtZpm0uirIxldz0N5mKf7HouYwch9qtl9X3AOQMAn/Mis=
=wTHr
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

--===============2113506574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============2113506574==--
