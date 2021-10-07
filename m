Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BA1C433FE
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 16:43:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1A161354
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 16:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A1A161354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E983402AB;
	Thu,  7 Oct 2021 16:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1TpeOGpnqT50; Thu,  7 Oct 2021 16:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DA39D400AF;
	Thu,  7 Oct 2021 16:43:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2F3FC0011;
	Thu,  7 Oct 2021 16:43:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B5BEC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30B38605EA
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hmXNzitwiXkN for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:43:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 76F48605DC
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:43:50 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id t8so21127437wri.1
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/o6DiwQZhh19GLhVRavM/M0aMT3RcLEjTJ9jadw7cGo=;
 b=RvjWatib7mLhQDYv2+BXxiKtKUXGJLp0dXyjkWYHoki61KjPqd0PsYAiAApiYK8lsf
 cmpFclGzBy2jCMrijwFTXsC20VfARzplHYSfrfWVpxLATljzz7SJdQPSAYnsVZbo6zLm
 lOHqcuRDkUEpJ6vGAh78qSM4wIl4S4DVclBgy2FcNbKebvpn5KB5bKV6VJZl1SBFn1Vl
 LNv2cXrWBkzUOz8PEJ5S3h1Vi5sFIV8Qz9sokvPWTg2yCU6LLX2EZciaxjis5Nihw4+x
 +cjjJFs5bZg9eCV97VZefXU+aV2og3VVfwJvMJ3OJ1in/CtplG7WX63LKAWaM0RpSepE
 cSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/o6DiwQZhh19GLhVRavM/M0aMT3RcLEjTJ9jadw7cGo=;
 b=ZV3h+dHPm+ZAk1IkbaIybmjaM+I0vyoy91gbrIhlpYmSZGLR1M/Is//WT5o2yIMak5
 ULDFJEC0huxiWJ09XB2ZGV11CndnXSgkwcRigd90Vc1G8kOpV/vdNXHgmQRXPbPBlO9+
 UU1SSI/bHqfq1emnxwMvCfmEWku9/9GVmCAxlISmfTJbvJvJyvMr+mSFCeZRmrEEcptC
 Pmwle9vYEbDnjSe+mg/mt63HQQd+BOoOr0t1hqrKVX0Yw2tC4CCv0VCHmBXbnu+F/Ejr
 3pc6j/fciFvHjvS61hxUVa+3hm6lWJ7ngkfm1n/wASTK8sgJ/UabAuQv20Jw4LDfnFQh
 AKcQ==
X-Gm-Message-State: AOAM531+wtsz3gDNPrj7TYP2Js3HMKyMDYOT5SaNQsQdqqUeKxVQoLEF
 /sex+qx1RlXjml/r0JJw8Oo=
X-Google-Smtp-Source: ABdhPJxMOHI4XL+MVCsGksAzLKfzL84amFFZ6UA/Vds//W9SvT/L9kO0OFGtcWT5eAjLP4w2Cq8vfw==
X-Received: by 2002:a05:600c:1548:: with SMTP id
 f8mr5901641wmg.70.1633625028637; 
 Thu, 07 Oct 2021 09:43:48 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id z6sm186037wmp.1.2021.10.07.09.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 09:43:47 -0700 (PDT)
Date: Thu, 7 Oct 2021 18:43:46 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v6 1/6] iommu/tegra-smmu: Rename struct iommu_group
 *group to *grp
Message-ID: <YV8jwuXnwx2tqBlR@orome.fritz.box>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210914013858.31192-2-nicoleotsuka@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============5118659637000988696=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5118659637000988696==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uYhwg0fUPRcWSEUC"
Content-Disposition: inline


--uYhwg0fUPRcWSEUC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 06:38:53PM -0700, Nicolin Chen wrote:
> There are a few structs using "group" for their pointer instances.
> This gets confusing sometimes. The instance of struct iommu_group
> is used in local function with an alias "grp", which can separate
> it from others.
>=20
> So this patch simply renames "group" to "grp" as a cleanup.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--uYhwg0fUPRcWSEUC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfI8AACgkQ3SOs138+
s6Eq7w//SVWsjVe9UOjkMKkpAbWc4qfqqLNq7qF34QQ9ro3WdZpuOAu19A6CAFlp
GhMiQp/HKvnnWD9RWjftqKHnK1fuEoBvyPoRJGV8M4SQ8jdKAZfA57evk8a8DH/U
e32E9akHOXqFxMK8YJAcz3JECGJ0IWTheeUREBcfB8Gk8ldW1rl1zRTP2hwLD89e
WftOVkxpIeqrpJthaQ0MGIjEdVk3E0My9KSD2TCkCqVUVh8cprUhMaWl6ImuauGt
BYxaXHCxkLKkM0QLEcOJReizLpqBTBMOAvuvWU+Fdzrgse0Fq6XrFx9DbNyvYG8a
2PXa7b+BbO32/3eIOtzvddqEV7u0f0PgNY2rTfXlpE572OTWZ74/MYKyIbMxt4im
rtwF8goKHEANM1wyCngM3mcoQfHlZNhluWAM6zrfpj0EQeovkj2vskrjnC67Kdnv
uze7Rqc9IZqVDS43xC54zLwqh7F89yt8GzXQySZLBtxctvRgKwYs5VzNxd7CYGTP
ZRdEvOTXHCR5cXoCmc59B6V8mty6v59Fk4ZMOlPIWOVSzCEIZbxZGTvHCB/JGxff
5XqwY2w1pRC78MusL3NctBY4tbnSEU2uDyGJIkBnIuc381yqB0E1v88EYrnsszha
p0J0h08Sqc1Vz2YSaAZYoZtoaKNKQy/j1mXeCHC6dMWwH5jkNLQ=
=ZGNg
-----END PGP SIGNATURE-----

--uYhwg0fUPRcWSEUC--

--===============5118659637000988696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5118659637000988696==--
