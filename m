Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724431;
	b=n6mOaUB9wNdBdWtFCsW++7jQ3v2/6Anho/dER32Hn6HEKTpzFSBi+/kJlXrG+mlOSxjz
	 pmz80sIDRYZMvOrfRiQtNBQrJ23lzM7RTfrmPXYbDftXHPkAUjVb9VECxVED/m9bRxgro
	 PaCzDkonaVi98SCfvdeNW1vSxBXcyHNzn4c7Zwvh68Xz9u8BWpeAc2rx07CuO19PwMPvR
	 LpCeZjzVkenvdCw1nrCDsL/TIV04JlCheXaOgonNZF/KvhaTbu3IfOD0sZiedeA5Bwohu
	 lFGWIoo4abocFr8S7wiMWGj/5nCBuSHehC/PBksdVhAsqYso00ih3sjecbK+l5tV7sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724431;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=7CCrVyrTBdPbSe+1if8Pi4d/84Yf1ZbiqX0NUSqRqbc=;
	b=nqEBMvaGq1qh2hAi7APLpP1JvxD+pwTF4AVQcBtcOOIea2+6eLbUsxXaOFofRDCyRqnm
	 9TyU75Vj7ORBOf36bAYIkzOFti7sPrup+EsCwgLEl2jiaMyShW2BgKb0GihqreucCaSBw
	 DsKS5PiEhBTHeg8zSvu5mbizTBYGcl7/2bMe2MIlhsLIvPRaoE+M0xmkUdF3x73TuQMsF
	 6vl2/ngMW+7RtEqeKRhI7cYZnew4qfiNxm3SF7tM5jog3BXe4+Tk0CSwt1l29x0FU1OZA
	 Xf4NHlNaqb6ejYEwl2fv0Je48AIyzBxjJXByWHM7ej309KfUPRfeHrQj582hMPZpH3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qSOzqmLQ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BA606A31E
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 20:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4BA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qSOzqmLQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795724428;
	bh=pUN2TxTtZtOVhddUkx6PB3N78CQVfEnriFZuNg5Tvgk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qSOzqmLQEkX+WmrOPd53ng4Ub+f3WGThnGgKuLjCGaW25geqXy7wFsN4FAoD2V6V+
	 G5135TPN/vMUQg07ob8ICMRGsXkKtPnhoNQqZwD5Fs2yZnXUwxWyLXoAmQQ/deolyN
	 dgAvUV1LAQ899xivuB4Txz9UumTJQECIAusvR9raaAe8hLxfOnFk9OM5wUn0umBuFd
	 Bl0TGgC4t23igBCkDDEN7lWTyb05AfGEvQH0MQuEtNqlLipxq+V/Ph8Yer1a0QcCSA
	 IVLSFNwOuVnFv0mwHxw11o9Fnr28wW6V+ywmW9VqMgerhDB/njmIcc6XDjfuqMomyl
	 B7OIaLOGRW9Tw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A5A817E00E8;
	Thu, 26 Nov 2026 21:20:26 +0100 (CET)
Message-ID: <23748f44fb9f43f88af97c65200cc75ed5d1ee6e.camel@collabora.com>
Subject: Re: [PATCH v5 2/4] iommu/rockchip: Add rockchip_iommu_restore()
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: aiyengar1990@gmail.com, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, "Joerg
 Roedel (AMD)"	 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy	 <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, Hans Verkuil
	 <hverkuil@kernel.org>, Alex Bee <knaerzche@gmail.com>
Date: Thu, 26 Nov 2026 15:20:24 -0500
In-Reply-To: <20261126-iep2-v5-2-3deac0976f10@gmail.com>
References: <20261126-iep2-v5-0-3deac0976f10@gmail.com>
	 <20261126-iep2-v5-2-3deac0976f10@gmail.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-dQAySM4Jzz+X++kJrWM9"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

--=-dQAySM4Jzz+X++kJrWM9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 26 novembre 2026 =C3=A0 19:51 +0000, Arun Iyengar via B4 Relay a =
=C3=A9crit=C2=A0:
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> Some masters reset their IOMMU along with themselves. The RK3588 IEP2
> does: after its soft reset, paging is off and its DMA is untranslated.
>=20
> Add a helper to reprogram the IOMMU of such a master, so that its
> driver need not attach and detach an empty domain to do it. rkvdec
> does the same with rkvdec_iommu_restore().
>=20
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

We are trying to get rid of hacks in many Rockchip m2m media drivers. rkvde=
c
have that hack upstream, and now I have rga2 and iep2 driver submission wan=
ting
to use the same hack. So I asked Arun to give it a try and find a solution.=
 So
see this as a v1.

Nicolas

> ---
>  drivers/iommu/rockchip-iommu.c        | 36 +++++++++++++++++++++++++++++=
++++++
>  include/soc/rockchip/rockchip_iommu.h | 17 +++++++++++++++++
>  2 files changed, 53 insertions(+)
>=20
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 21af2f621c76..81cad102929e 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -27,6 +27,8 @@
>  #include <linux/spinlock.h>
>  #include <linux/string_choices.h>
> =20
> +#include <soc/rockchip/rockchip_iommu.h>
> +
>  #include "iommu-pages.h"
> =20
>  /** MMU register offsets */
> @@ -1349,6 +1351,40 @@ static int __maybe_unused rk_iommu_resume(struct d=
evice *dev)
>  =09return rk_iommu_enable(iommu);
>  }
> =20
> +/**
> + * rockchip_iommu_restore() - Reprogram the IOMMU of a master after its =
reset
> + * @dev: master device, runtime active, with no DMA in flight
> + *
> + * Some masters reset their IOMMU with themselves, which turns paging of=
f.
> + *
> + * Context: may sleep.
> + *
> + * Return: 0 on success or a negative error code.
> + */
> +int rockchip_iommu_restore(struct device *dev)
> +{
> +=09struct rk_iommu *iommu;
> +=09int ret;
> +
> +=09if (!device_iommu_mapped(dev) ||
> +=09    dev->iommu->iommu_dev->ops !=3D &rk_iommu_ops)
> +=09=09return 0;
> +
> +=09iommu =3D rk_iommu_from_dev(dev);
> +=09if (!iommu || iommu->domain =3D=3D &rk_identity_domain)
> +=09=09return 0;
> +
> +=09ret =3D pm_runtime_get_if_in_use(iommu->dev);
> +=09if (ret <=3D 0)
> +=09=09return ret;
> +
> +=09ret =3D rk_iommu_enable(iommu);
> +=09pm_runtime_put(iommu->dev);
> +
> +=09return ret;
> +}
> +EXPORT_SYMBOL_GPL(rockchip_iommu_restore);
> +
>  static const struct dev_pm_ops rk_iommu_pm_ops =3D {
>  =09SET_RUNTIME_PM_OPS(rk_iommu_suspend, rk_iommu_resume, NULL)
>  =09SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> diff --git a/include/soc/rockchip/rockchip_iommu.h b/include/soc/rockchip=
/rockchip_iommu.h
> new file mode 100644
> index 000000000000..79fdd898a0fc
> --- /dev/null
> +++ b/include/soc/rockchip/rockchip_iommu.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SOC_ROCKCHIP_IOMMU_H__
> +#define __SOC_ROCKCHIP_IOMMU_H__
> +
> +struct device;
> +
> +#ifdef CONFIG_ROCKCHIP_IOMMU
> +int rockchip_iommu_restore(struct device *dev);
> +#else
> +static inline int rockchip_iommu_restore(struct device *dev)
> +{
> +=09return 0;
> +}
> +#endif
> +
> +#endif /* __SOC_ROCKCHIP_IOMMU_H__ */

--=-dQAySM4Jzz+X++kJrWM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawiUiAAKCRDZQZRRKWBy
9BjUAQDSNPqdSlLUl/O9azaIblOpLLPu+oK5Nw5EuSLHW+r7zAEAxnuyZq9XVKSw
gxVnBpP/poBKRTNumlOhqdw1p4TEoAQ=
=p9Z6
-----END PGP SIGNATURE-----

--=-dQAySM4Jzz+X++kJrWM9--
