Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D9222586
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996587; cv=none; b=cvSXm5U91/5yrzjCa6MUzRWSBpOtn9Z7eaqeIowMSeaWXOUc+h1nMq5pkHPTFweSjAKtHTHuhBM4qmkEbtWBfBulTzNuYdsWDgO1vbi6TsI3w16xgbxcWf0imfQ+oFnXAj/yjKK6BeMe7ecnNoyfMt9BDIGLFyUGa/R9ccOOk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996587; c=relaxed/simple;
	bh=rhd2Vz+1e/iOi2LHto5xUh03sKP51Qg56huR5FisGJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUjoCGDwX3vy1dfl403yIe+Qt5dzmaD/DwnlVSfyfVq2/rsMEbGNSJQVYI6vMm+sJXQD3niSxcmxhMzxx5o8bd+5qRIGiHW7T3JA1OmN/uUqyVLcKfs7T6HHWOCOiECIH5g/e/TLKPBe6sDAoMPioVxyKLd6yF4FUlaRpmH7kfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJPqRnFi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJPqRnFi"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso568328f8f.3
        for <iommu@lists.linux.dev>; Thu, 09 Oct 2025 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996583; x=1760601383; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0a1fYc0MJ9EuqumxNBgOSane0jVrbsSTPrQvSq4lE4=;
        b=OJPqRnFiZWyRGRtJSKh+uwiWHeOYe/VpQny6cW86RzzJZzeh2IQ/vmEdKBcFBIX66J
         CEFyrFtnP5VFpTlqZiwwSmWiMli/K4Q/KKaiubFJ+AjOGCxCZ5zTz3aYLySC50/1KA4I
         wY44cefnUh5BwiTRKYtvn8hpKa2uWE/9K33QAt1a9IqmsokWhov+ILMmpITkr4sq4S+S
         rKaKAAHOgoBkeJSAo3HjWrlWwyqUPln/CbnDVxTeaR9NI78WI3eSG8vUkpfAXCx0Ajuv
         Lr6hAcN+4sUb8neUdt8R2jJRbeWpWtUU1Qi5FVkGcMwNqt7erbsNR7oytjkv9rR3sPvw
         TKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996583; x=1760601383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0a1fYc0MJ9EuqumxNBgOSane0jVrbsSTPrQvSq4lE4=;
        b=vFqlKwWEX6kj9QBnwfVbLvyaXeLW16q9cGvtgbCK1TgkFDch9o6gAXrCA05Mq7lJeS
         bsEggnklfdGJeHPoMW+/v4OFlcbPbTn23fv3y8PJl+kK6XV3/e14+I+g+ny9WPXbJujo
         E2oL1IyUU5YuINE6VNEHpgkbUujjDLIfQbDUfLpX2l/LL7YisL9MmbLoi2c8GxmcOsoH
         RyBfFUzapRVtFWbQPyaf1Cfg1cA3ciMrpw+Jh/yeQ2BwsfWJfrmQ2m3zqONFET75w3Fz
         GE5alKQ04W+aq6sDwXA7mJhqhL2k+e7u4CCfmRfz3b81U1XzISieyZIbropO5gC30Q7K
         QXmg==
X-Forwarded-Encrypted: i=1; AJvYcCUTUItOVmwdrl1zQsybodEBUzkOCEeGrjlRpUjKVGDC5mtW0I3QLvqd4E0lHH77p6pLApLhUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMMVHM63hwNhOgP7VzQkeo3UF8nZtYbPXhDc/slfQ1HLRZN9I9
	eyHLYXBeGvyD9Imepw97nbJPR6FDcyCc34Slchu4qZQM3hBUWn/DIooB
X-Gm-Gg: ASbGnct+iTniBPLR3a2x3xyLtHcrXpVqO6Z6wIptWgdAFmfNK5F71QrzaKNUaBl2jGT
	q0Usyhl/bR/xa0W8N+CfjUfN0gN3dm8qkIszT1fDAbhgVf3tru1714obO8ndjfhgHxr16nEFjud
	wZ+KNF5o/itm15TGys28EKdAPsQc8myJ5iTHL/PAp8jXt4fWdSEa84V90rslCYf6GOYHTXok1uj
	4zTI4JTtinBUDZwuKG0mDHNG3HBFsFnfHKRvPu4ZX/OI/Xcpuy8U1GH2FrB6am0/+pLuKwh5ZLl
	5U09FZKZLvfnwPpFf8RggCHviqQ8F5qHv1MuW9ZCYqtIeONHT3U6eqSNTmQFXpCmlmxQi+buz/9
	eH2hGIH6umFdHeXnxbT+HG+b5QD8M0bUFIdw5FeDiGpE+iJwoIAY0rUZk/jXUYf+b9TOFhax+cm
	GwK0+sXFiuHpN+fbZVzW4bkfua38Pu8tkWpoKdej97wooo
X-Google-Smtp-Source: AGHT+IHdPDeElx1hyAYh5U0ai1YogNJIHEcNDQIevaS+npNxA1G4K3X5r3iKDWJLm2QYPiZpKcmqQA==
X-Received: by 2002:a05:6000:2301:b0:425:72cd:8364 with SMTP id ffacd0b85a97d-4266e8e1afamr4240788f8f.53.1759996582753;
        Thu, 09 Oct 2025 00:56:22 -0700 (PDT)
Received: from orome (p200300e41f28f500f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:f500:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm33269369f8f.12.2025.10.09.00.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:56:20 -0700 (PDT)
Date: Thu, 9 Oct 2025 09:56:18 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wens@csie.org>, Krishna Reddy <vdumpa@nvidia.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH v2 14/14] iommu/tegra: fix device leak on probe_device()
Message-ID: <rp2yiradenf3twznebagx7tgsruwh66exiikal37c4fwo75t4t@4breto65stqt>
References: <20251007094327.11734-1-johan@kernel.org>
 <20251007094327.11734-15-johan@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgvpzj7uzsv4xh6z"
Content-Disposition: inline
In-Reply-To: <20251007094327.11734-15-johan@kernel.org>


--wgvpzj7uzsv4xh6z
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 14/14] iommu/tegra: fix device leak on probe_device()
MIME-Version: 1.0

On Tue, Oct 07, 2025 at 11:43:27AM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the iommu platform device when
> looking up its driver data during probe_device().
>=20
> Note that commit 9826e393e4a8 ("iommu/tegra-smmu: Fix missing
> put_device() call in tegra_smmu_find") fixed the leak in an error path,
> but the reference is still leaking on success.
>=20
> Fixes: 891846516317 ("memory: Add NVIDIA Tegra memory controller support")
> Cc: stable@vger.kernel.org	# 3.19: 9826e393e4a8
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Miaoqian Lin <linmq006@gmail.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/iommu/tegra-smmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 36cdd5fbab07..f6f26a072820 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -830,10 +830,9 @@ static struct tegra_smmu *tegra_smmu_find(struct dev=
ice_node *np)
>  		return NULL;
> =20
>  	mc =3D platform_get_drvdata(pdev);
> -	if (!mc) {
> -		put_device(&pdev->dev);
> +	put_device(&pdev->dev);
> +	if (!mc)
>  		return NULL;
> -	}
> =20
>  	return mc->smmu;

pdev->dev is what's backing mc, so if we use put_device() here, then the
MC could go away at any time, right?

So the goal here was to make sure that the MC stays around during the
entire lifetime of the IOMMU attachment. We don't currently release that
reference, ever, so there is a leak, but wouldn't it be more appropriate
to release it in a .release_device implementation?

Thierry

--wgvpzj7uzsv4xh6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmjnaqIACgkQ3SOs138+
s6GKbhAAsfz1wZw0MTC9RsEY4Yd9FfbGZFwUqkdbKTFeuIj2pdIDddlr1W27EUR4
k8LSmG+B/zzQVAB+e6/9evMs0tBh7sAJqdN+4KS9Xu9oCSz0NZT/DVYKPEhAH44D
/LkM2+RGcyVcF/2ebov9rCMzHJpcNbgjU6gg9NfQlCrl7diKXSUGhTcSL/Emycmg
3FuBz6DDHAD0J1slkQ7Tfy+jUKm4Z8Ewh4NBTF0Cv8k+S6WdTq8TOlVhedYyOhii
YGJeu84qQoOfIf3wFIWqIswb0NmzL/uN/kMw4eLy3FaJ+H9LjYVrfHkDO5lNfW/N
wwj7QOHLllKcSavr7TPGLglzrRBj2l0ApXL+8Xe1zLvhTx7VX4ksEAVzkJY4mHmu
5M2JLtgntGiyAY8Korl+NY0K3G42D48qa4fWIewpTEjbT5IQB3C0GQsDMaz0uaZT
xQK1Ik2W4zP6w/de2FlZj7YF2D/8tAuS7Af8uEZXMny3addBpoICCgraDg4aU1XV
Nqx/TP3mFHu4V/J6twarFQM7zTeKiKdUyp0yJ428Jed/yGVREBjAqS8Vvml/Zmpn
e7LFJGHYCLUVymAE1z61G3HPSt1w1IAnRaHrSrq/IbanY3Jhfeu95Az/fpYcW2hU
FOjysPFAigkUvlqz6M954uRgLGHixqtm3vI/VA+LtKqjR1PJo3w=
=VlYs
-----END PGP SIGNATURE-----

--wgvpzj7uzsv4xh6z--
