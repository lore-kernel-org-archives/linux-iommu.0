Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A997C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 16:57:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DFB61248
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 16:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3DFB61248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B334D40A3A;
	Thu,  7 Oct 2021 16:57:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSevbCiDR-JA; Thu,  7 Oct 2021 16:57:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8086A40A36;
	Thu,  7 Oct 2021 16:57:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B8E6C0011;
	Thu,  7 Oct 2021 16:57:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6260C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B4CAD60FEA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oIi2CMRCNAf9 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:57:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E414F60FE8
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:57:34 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id r18so21136586wrg.6
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=El2GgWjzGT3viL2Ka9TGbi2wzgQQNq0vXUAM3RTl7rM=;
 b=NgX7hfYeaa3E/yEBbPOQByUrqiYE/qI824xs4ToqrJj1fTGpxW9OXRkBDDGIuBzxpp
 01OTm5/FyD37etzeiJWIz9o90MT0ztqEHYa4Bok3tTouLKs3c7WBapKz5439tMFYLA6w
 NAqT+9pmb2tNEdpf12np7W4TIijC2wFgLon/tnsF82lJ4uH146LP5dqU0YuPVeyKS53+
 Ys33ILup66XiUjWAI5hnZlqLh9K8Pajia0xShDz0LqW1Ha6ilBAQvSWMPVlVa4eroDjw
 cVbke7jP/DglmKoFE3YE1KbPtmrqWPzkMDPP3A4Smbi7pVAXWolyCizb+8OXX508OoLm
 WNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=El2GgWjzGT3viL2Ka9TGbi2wzgQQNq0vXUAM3RTl7rM=;
 b=ySmk1DOj1RgSAAmjSe1/sB6I20TqsYRZXdvv7so6tmcwLsyStNRbCweWim0VofvXaX
 nAYMDVd79jJKal4pwz9AK76xz7yFNipYTwV8OXh5GON80fmhsqr22W8j8v9zDIOkI5D+
 y1RXbfQzw/ne8Lp6YsIsqzh4VX44GzhtCWX78RKzn7MMMcaN1sij0C5QDrxiFAgoRR2N
 3joHAUUARqSpHxDDOuqi656zDRE02cjIkGGOrLIAGEPxMBMliNz621BL/Z8m7MNbOQp1
 PKoQWi9HnwzctzqNcSsspDUulHGLGp5xrzjPdwPfswe4IVfeXlZPCMiV7d6wddIaq4P5
 WtxQ==
X-Gm-Message-State: AOAM531zyZuMXI3T3aATGoKsYEnRPSuNuoSTLS0K5+65kSwI17QZBhNy
 up1Ae6Gg9jrOlAc+XjlQ5R4=
X-Google-Smtp-Source: ABdhPJx4XwYRlso76dDdIc3k2apWPUAjSpgjJfpK+bS23C8zb7IRv85ldfWBS1S3aUXBTU4EGI+i0g==
X-Received: by 2002:a1c:9d97:: with SMTP id g145mr5894307wme.78.1633625853047; 
 Thu, 07 Oct 2021 09:57:33 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id n1sm2800731wmi.30.2021.10.07.09.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 09:57:32 -0700 (PDT)
Date: Thu, 7 Oct 2021 18:57:31 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v6 3/6] iommu/tegra-smmu: Rename struct
 tegra_smmu_swgroup *group to *swgrp
Message-ID: <YV8m+0qP2ibQBvNs@orome.fritz.box>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-4-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210914013858.31192-4-nicoleotsuka@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 will@kernel.org
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
Content-Type: multipart/mixed; boundary="===============2293980739027694625=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2293980739027694625==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z5TfhxvQFdT1ZzDp"
Content-Disposition: inline


--z5TfhxvQFdT1ZzDp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 06:38:55PM -0700, Nicolin Chen wrote:
> There are both tegra_smmu_swgroup and tegra_smmu_group structs
> using "group" for their pointer instances. This gets confusing
> to read the driver sometimes.
>=20
> So this patch renames "group" of struct tegra_smmu_swgroup to
> "swgrp" as a cleanup. Also renames its "find" function.
>=20
> Note that we already have "swgroup" being used for an unsigned
> int type variable that is inside struct tegra_smmu_swgroup, so
> it's not able to use "swgroup" but only something like "swgrp".
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index a32ed347e25d..0f3883045ffa 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -334,35 +334,35 @@ static void tegra_smmu_domain_free(struct iommu_dom=
ain *domain)
>  }
> =20
>  static const struct tegra_smmu_swgroup *
> -tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
> +tegra_smmu_find_swgrp(struct tegra_smmu *smmu, unsigned int swgroup)

This makes things inconsistent now. The tegra_smmu_find_swgroup() name
indicates that we're looking for some "swgroup" entity within an "smmu"
object. The entity that we're looking for is a struct tegra_smmu_swgroup
so I think it makes sense to use that full name in the function name.

>  {
> -	const struct tegra_smmu_swgroup *group =3D NULL;
> +	const struct tegra_smmu_swgroup *swgrp =3D NULL;

I don't think the existing naming is confusing. The variable name
"group" is consistently used for tegra_smmu_swgroup structures and there
are no cases where we would confuse them with struct tegra_smmu_group
instances.

However, I don't feel strongly about it, so I'm fine with changing the
variable names to "swgrp" if you think that makes things less confusing.

Thierry

--z5TfhxvQFdT1ZzDp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfJvsACgkQ3SOs138+
s6FH1g//bwitjmhtyJUDK/UWfxLfuFwOjEu/eNLJf0O23uMNI90/z2dGywyDoXgu
QYpUdBr3dSr6mO1uQjFSnftlgad6AK7CReY0ZeHKu3SiGmpIbXI84vSJRKVHpoWu
Hc4daNzWEAQS2SnBvzpwa8rnLPoxsbpA4x2EqI5nN+Zh1bmaeIcEMF/BQHoGJWj9
o55XUIwRXKa500tP3JG7qNa0LhwYHnaDI+R8mYVTee88wD2nCwTGuxghWiJk7aKI
NvLTq7Y1/lHHzAEpP1a+fEXsjDUKTOTU6FuZyd8Fx16N/O0FigyQXl4SU3WPmMfg
tvRZtn/Y/gdB7uodJRhLmLCAhTc1NZSxZWU5TXupPAIVohIWHtecEKTD5aKBXNhv
btbQxyPz0WLT34CqPCdl5+8+2U3v3OyhjdP3Z+v37mPYav85ejuySiBfTuyDcvb7
4T6QgAIEOaOIGPQGBmchEoe5MUlPDN3U2ZN9wmiw/kZdH0k13MhVRHPe5wK6kMJ7
bYLAH+Am3+sTgdnPJsKQ/ILyXbaI1jj11CZko/FmKKK0Tr72ue7npLSHf41m74TU
B7tOnybngivbPWz4R8hANp0/fIP0PLuIS6mYd5+8Gs/qb1J7gx82RIbLrZcP/N8t
e5XgdrCf+8sezq8ADDn4o+JrGb8vE0c/rrNQImyTOsAOwXfDHeE=
=z04X
-----END PGP SIGNATURE-----

--z5TfhxvQFdT1ZzDp--

--===============2293980739027694625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2293980739027694625==--
