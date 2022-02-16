Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E3CC433FE
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 13:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F4AE40448;
	Wed, 16 Feb 2022 13:48:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T6QWzQ2E7SrG; Wed, 16 Feb 2022 13:48:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 36D2C40440;
	Wed, 16 Feb 2022 13:48:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3C5AC001A;
	Wed, 16 Feb 2022 13:48:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B82C5C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 13:48:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98EA6606EB
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 13:48:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QJDE91CzduJb for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 13:48:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F964605BA
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 13:48:32 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id b13so4107656edn.0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FlRChV2ED66U1fV2UHlPevpzTBOWajWUQYxF7iIvvyk=;
 b=qv/vc03s2YbobtXaOohRYrtMGKaiPeoul7yaXpDYp9Y8BCPMXPgdTH8hkDVyyxKKzc
 ieV6spSKvomI4/UXpEouoWG/oY9V63xQPHlTU7P8iAwoRd29MbwfCS8x/HPZ5daqjKpo
 7FdSTmIpY9smQlACRWFTIsUn6Yas6dm9VrbtgNW1T/+ZOmd2WVPBUWzcCbXeXRwIa3o4
 fABK7daW4Y09JE81WsWyCmDM2Bv/HN7mg7tAmU2psxcdCsBBqOLelrT9DmZkY4ZIyPdO
 QwG4SrNtCZ5km0oe8JP1kO67fwzSI4/gG2rx79OPI5NhQQTn+zqAfRivbZNvEsonmdYa
 NbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FlRChV2ED66U1fV2UHlPevpzTBOWajWUQYxF7iIvvyk=;
 b=xGzcO5pN/qhrvw1rv79pzm2HxnHeBwkllOuqy4MQUIT8OXrTm7XOoN0kZrD9SkLTty
 Tbh4l+ejJZmeInU0EMt/mSvuP1/PhWGWZz9kp0MVxBPxWxdRFvq6OE1mdwjdP5LC3Q5v
 QuovsEzSAaPX0yCJDSs5vfEFXZ7AjHSz/1MrS0PYOH6/gX6F+5wdvCsL11xPgzWn59HC
 DvCDceeZCgEB1ig9Gv+NmNYu51ahP3g9+cPZC4q6JvC6QyZTSVsKTuA051DodlItKOMl
 BftW5L7sd4vURmdJMuBctOAghsacE4aH7DHAxU8fblXWRhueMENFdsMXshB68s3KshqN
 xdcA==
X-Gm-Message-State: AOAM530V4ljuzEV0GCgRGVy3I9dqrKdQSF/T+eKHuwXwOXZwiOjWmz3m
 DuB1Xi4DHuBxtMxgLab2Ack=
X-Google-Smtp-Source: ABdhPJywvjh3cUfTL6Z618E7/SfBQBXo7KQhw71ZpUbdF4ZEaTN3AkTWga5vyZBBC2CiwwhHXNUqdQ==
X-Received: by 2002:a05:6402:2694:b0:411:f0b1:7f90 with SMTP id
 w20-20020a056402269400b00411f0b17f90mr2995670edd.398.1645019310575; 
 Wed, 16 Feb 2022 05:48:30 -0800 (PST)
Received: from orome ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id p25sm5245206ejn.33.2022.02.16.05.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Feb 2022 05:48:29 -0800 (PST)
Date: Wed, 16 Feb 2022 14:48:26 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] iommu/tegra-smmu: Fix missing put_device() call in
 tegra_smmu_find
Message-ID: <Yg0AqkLA7eXQOuh2@orome>
References: <20220107080915.12686-1-linmq006@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220107080915.12686-1-linmq006@gmail.com>
User-Agent: Mutt/2.2 (7160e05a) (2022-02-12)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4363719690908242286=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4363719690908242286==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="enq9AsaXPXANugPJ"
Content-Disposition: inline


--enq9AsaXPXANugPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 08:09:11AM +0000, Miaoqian Lin wrote:
> The reference taken by 'of_find_device_by_node()' must be released when
> not needed anymore.
> Add the corresponding 'put_device()' in the error handling path.
>=20
> Fixes: 765a9d1d02b2 ("iommu/tegra-smmu: Fix mc errors on tegra124-nyan")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e900e3c46903..2561ce8a2ce8 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -808,8 +808,10 @@ static struct tegra_smmu *tegra_smmu_find(struct dev=
ice_node *np)
>  		return NULL;
> =20
>  	mc =3D platform_get_drvdata(pdev);
> -	if (!mc)
> +	if (!mc) {
> +		put_device(&pdev->dev);
>  		return NULL;
> +	}
> =20
>  	return mc->smmu;
>  }

Sorry for the late reply, looks correct. We probably also need a similar
call in ->release_device(). I also wonder if we should be returning an
-EPROBE_DEFER here, which is technically the correct thing to do, though
in practice that will likely never happen because these pointers are set
during an arch_initcall, so should always be available by the time a
driver tries to attach to an IOMMU.

Acked-by: Thierry Reding <treding@nvidia.com>

--enq9AsaXPXANugPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmINAKcACgkQ3SOs138+
s6E1Dw/+JdYuxQb5lyl9zrWDXni3KEEqylRty/S9yBZqB5op/xogYj6rZ/tCOc66
CAA/cFSERk918QsbfuuajpAwiDBoivU8XAjn2pRhwfS30pE1wttCbvnYx/Pa6fhj
rFCI7P86LtlW8ppsKt2j2YE6Ro6iBe78vMu2NHsRyF/dTqdF77LBBbHc/1D7jvKJ
E516Wgps8uBmnElGaBXaWqBJm9gF+1DUcRB2iCqqKoKcZGd4cU1Z97caIfwzmxF8
+Pfy3xsZQUM/q0NEUQkYS24RhFaPIMSlVNJuBq4X8RUkobx/bSaQQybtY+CYeOfE
CdZhCt1Uvwt3REBb4crS1obr39XHDrmg9DPhwBPOxXJdoT+gHntny13RVB9PysER
SXDv62b8R/ZR4ORh9vNSlY355IauVLEJGgRqyloH0W6ylj5QVM1/PEnHUJu+E6Bp
tXAyNRwUfysUryxZgjhVjYTJnCzxhszhR8hPhwk5uxyyyzBI7oB8T9FwIuVukkqW
bw5UvHWlrKj1dQVu1Eup9qn039PjZs4cHldFi9gkjMFAupaS07mAY1FHPe2U1lD0
bq+aIHuenFUa3F+sfC4PTptGWxEcfPWEPk0QHts7FTRLEBwy4b97RLRKHwa942v6
wPzUzR62Raw96lTAPiq8UYPqB82nxDiRTIqalgVPL9DJTyk4lOA=
=FvXw
-----END PGP SIGNATURE-----

--enq9AsaXPXANugPJ--

--===============4363719690908242286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4363719690908242286==--
