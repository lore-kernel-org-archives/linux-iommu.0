Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795725262;
	b=KfS6YF7gV/0q4YEB9Zpaj3rtIGMr6kHqUBib7VrXjCqcdVe1jIrWr2Ex9xVDKnhxw/ld
	 PPeY0Nst4azzPOCG2XYmyPN5uB3vDvATNWg/etl0TW2HS1SOcvbYpvFtIyRiHHMiRzttq
	 p4MzjmAdkgDJgmPJWVTPrBjNK3664QBr5P8HEH9K1Er7sfKvM0h9CX5sNjE6O4UnKh+GT
	 4Qq+RoJB6n51fmEQGyiPj8+P2cMQFGpBDigx4O+cPGaBYL8acj6v5Kv8JBGYCB0qgguY1
	 CXzLzz5mc67OdL+YXtwdJE4ZIyx3WuEx77PyCgZjjbTzo7C2/LgcX41Y3yANBITe7Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795725262;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=ZtyRiqIaJqFwMQaq2Qb+Lq38EH6o6V0HwgTuxki6ieU=;
	b=4Zmnfm8VVzLp6hmzw5Q6zSf0Ys6q01wMORZK3lr14w3ZXLVk6LokWjfb65VUVXYYYYbq
	 j94vqXSvldTjRiYdDKHJpNEKnnb2VkbW1EFk0Kd7t1fHCr9hWduEQp1fFMeFhtxCKb5Hy
	 XvuYOp/g/sUlUBSdqHJTwkhWqke0smOVO1dD7hzvI/pUIQRSARggYs8ztA5T4dOqV7q0w
	 Q781k1BvKA2YElCZU21Vvwvw1x+kFlZc7Ugtk3MbxdQyO/rHnEBxMlWA8bNAKXsbxz7BW
	 w0qlKMUwApDwDjllbay9b3AA45R4dCYOygKmtNN2+/2k5cd05UIw4y7MbbLwnF3JVwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=frUaz41j;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8715606A32F
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 20:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8715606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=frUaz41j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795725259;
	bh=abqDquCjMGqMJ3NkU3LM2AslGjSstfozpN5N2jtE3gM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=frUaz41jyxqWysbTEj7WnpwOkf/UkdVpsl4V+c3czHyi+dNs3eM8KpUC1JuQmitop
	 1uuld94b69SM+aY/Mg19vPINTbi21n3CVEi6rwCSRUzuYXY78rnLoVcM2YkJy3MI1E
	 h0fm6FX51SWmK/G65FoJY2xaJcYi1TiyjQrIO1vrVWDMam2DRPswx80TnYA75A5+3i
	 YPJ/r+iGOJxMOmTpteOELJIk9303GQsUw239RzduK2ZWbn03O66osJfjMXzWkTD68i
	 /qt8fg9tZP+hCsYWfdRsNqOvbJKGetDArEpLvcqI5Vuc5tkR6B2Yc5Lm2l9xzy0Xv9
	 aRASBYTmrSD7Q==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6169517E01D1;
	Thu, 26 Nov 2026 21:34:17 +0100 (CET)
Message-ID: <3d866004c558c169d3bdbee8cd737b0fb818f3d9.camel@collabora.com>
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
Date: Thu, 26 Nov 2026 15:34:15 -0500
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
	protocol="application/pgp-signature"; boundary="=-3MjT44OPCjy6caLCkHly"
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

--=-3MjT44OPCjy6caLCkHly
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

I was checking the core, even though I'm not very knowledgeable, and all th=
e
attach/detach is protected by the group mutex. This helper bypass this. In =
many
ways, its fine for the media m2m use cases, since we call this "just after"=
 we
have performed a reset of the core that exclusively use the IOMMU.

If it was shared, here the condition above isn't guaranteed without holding=
 that
mutex. Maybe its the documentation that should make that super clear?

Nicolas

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

--=-3MjT44OPCjy6caLCkHly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawiXxwAKCRDZQZRRKWBy
9Cr2AQCsTl6XPrjbaY0SjcDbbzXlND83mZ41UCypu76rA3F1DQEAy7HVkCPVts6P
z7OrYiyBAVAHXip+a45hCdo/piTAIwU=
=KzIp
-----END PGP SIGNATURE-----

--=-3MjT44OPCjy6caLCkHly--
