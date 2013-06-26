From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 21/23] iommu/tegra: smmu: Get swgroup ID from DT
Date: Wed, 26 Jun 2013 13:12:21 +0200
Message-ID: <20130626111220.GQ27083@manwe>
References: <1372238906-9346-22-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SvyA5ywaG/v2A5dH"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-22-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--SvyA5ywaG/v2A5dH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:28:24PM +0300, Hiroshi Doyu wrote:
> Get swgroup ID from DT. "nvidia,swgroups" indicates which swgroup IDs
> a device belongs to.
>=20
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/tegra30.dtsi |  1 -
>  drivers/iommu/tegra-smmu.c     | 20 +++++++++++++++++++-
>  2 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.d=
tsi
> index 7c480f2..a116737 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -1,6 +1,5 @@
>  #include <dt-bindings/clock/tegra30-car.h>
>  #include <dt-bindings/gpio/tegra-gpio.h>
> -#include <dt-bindings/iommu/tegra-swgid.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> =20
>  #include "skeleton.dtsi"
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 50eb843..96dbef3 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -314,6 +314,24 @@ static inline void smmu_write(struct smmu_device *sm=
mu, u32 val, size_t offs)
> =20
>  #define smmu_client_hwgrp(c)	(c->as->smmu->swgroups)
> =20
> +static u64 tegra_smmu_of_get_swgids(struct device *dev)
> +{
> +	size_t bytes;
> +	const char *propname =3D "nvidia,memory-clients";
> +	const __be32 *prop;
> +	int i;
> +	u64 swgids =3D 0;
> +
> +	prop =3D of_get_property(dev->of_node, propname, &bytes);
> +	if (!prop || !bytes)
> +		return 0;
> +
> +	for (i =3D 0; i < bytes / sizeof(u32); i++, prop++)
> +		swgids |=3D 1ULL << be32_to_cpup(prop);
> +
> +	return swgids;
> +}
> +
>  static int __smmu_client_set_hwgrp(struct smmu_client *c,
>  				   u64 map, int on)
>  {
> @@ -725,7 +743,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain =
*domain,
>  		return -ENOMEM;
>  	client->dev =3D dev;
>  	client->as =3D as;
> -	map =3D smmu->swgroups;
> +	map =3D tegra_smmu_of_get_swgids(dev);
>  	if (!map)
>  		return -EINVAL;

Shouldn't this be part of an earlier patch ("[PATCH 17/23] iommu/tegra:
smmu: Use swgroups instead of pdata")? What's the reason for the split?

Thierry

--SvyA5ywaG/v2A5dH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRysyUAAoJEN0jrNd/PrOhuSUP/2QiGsJnjV+DJ6QFoeXeE27U
o/y9z9bnQ6aYvOVS5ENTWebD5524quqn/nBXNOCMIcwuE8wNn+EuHLaY93VfUlR/
InqUq+jDDl7QvJMabMPfmWTR4D/9IOKUf3CxFIN9IppfujMqmrnAUzbiobjisYAq
pdaAL1eFgLsBNCTy3cH+v2z921YWEbIyu2j9QgYSd6gbx6ICLPyVBs6wfkvEP7zF
PS2o68dbWQDxKSOdKYTuwnRcxotvHgfCREJjcj81d1pu/hja10T94uzQmsEun/VQ
/Vzsz5I+yCIxyastDgKcVfHXF4JPkPhlQZgYRXoLSwRm9J4ZnrhYkdn/Oy8Faoga
odQep5krTY3GlOcqRZmDU0dCmZV2cBncSs49cy78qoGr46wweBFFqxnazN2eJGPu
K5CqFuzSy9u0yS+Kn7aTqvp7x78AfykGfgwvRTpRuFEvt+KNNJ5LhXtWFqAZGfd8
of6zdxSdPJhhxx10UMjL9is1Vo2aO2jbX5tjEA0hzW7F/FthIxTpBEW0fzqXiY8Z
x11ApjTuf7k2fQCawI1/thfNjiYSqJW5f0XKTmsOCggQQR+GAr+k6iSjod2Ylzrk
+RxV+X5YBiaDgtz9y/x2way2EC+u2V2iQHJTZGaMbJC3Xgb5QrlIgYGL05wW6aKg
cQ6HEa7ym4djT0IAkaqS
=Vsv4
-----END PGP SIGNATURE-----

--SvyA5ywaG/v2A5dH--
