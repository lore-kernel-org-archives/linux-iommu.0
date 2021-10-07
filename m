Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E2C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A0D61245
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 16:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83A0D61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A4A740488;
	Thu,  7 Oct 2021 16:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3AjQ49aTgbwX; Thu,  7 Oct 2021 16:59:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E5EF2403CC;
	Thu,  7 Oct 2021 16:59:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA426C0011;
	Thu,  7 Oct 2021 16:59:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B190AC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 944536063F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:59:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id te-Wy4N7hC97 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 16:59:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB1F7605D7
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 16:59:31 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id v17so21095900wrv.9
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=O/6xeTmbcSfH4dU0QlXPd2Z2HNBLZ+XUOU25+6nXnF8=;
 b=Ujcn/9YFWw9MXCaG6NsmLaNNfvK/N1SiKzK4a4mqcfcyD/BeEse0PhnoEfbk4tOYnl
 UiaOQMTY3oguzPKZEDbwyTy9ptHAwXbYsCFtc/Jzco9Xy5YshJ+BOXaO/sk3UFojjuBv
 BsHB8PJ0sSCbWcxuH3YHGoXKLJSl079vyvhrAGpyx9RCUwEMwdkt+fSnfJvJ/GGogEtH
 nLPEmFZBqXBoWakVni5oLyNf9KWN2jTvIpmLAAUHiyfdZhVZQV1Sd/+Fm9qfRHBWjW5R
 olzwQJYxDwGjO50f+x8lmlJGW5vYtgRSNo6Fo0f8uNn65Ouoxo4GOkGIyobZC1+SQXfS
 t1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=O/6xeTmbcSfH4dU0QlXPd2Z2HNBLZ+XUOU25+6nXnF8=;
 b=ASkgJrjNl88Wh85GOiHEhmwZ7HM8dOQH+9HpjIqJbiqcoFRjbT7FS7P+VgxhW52OtG
 9sbSC9cdCxrcQo/DQ1UaLKDc7RkLfFMaLADwAbTwqELZgg9Hl6jNJKsFAXpSs3qdXU8G
 jYyxFsPikxq0dsbhJa41Ue6gdOPDEei+J0FQuo0lZtMeNklq0uoZuu6lLsvP5Tco5s0G
 +F/7JMThzSSpwzrzBFv7zJsyyl4LIKVQeSiyiePtoUBXksQW3qeEUnkMln6YlIaRdU9t
 WLjjMBWLMF8ptS70RCKhn9owSfiZ92mH8hZDVRTk+d/yeJVvCu/u1O000MAk8R8dO+/R
 oCiw==
X-Gm-Message-State: AOAM532pps3Zn/upv6wdxLDVPjVCjp20HN+NcPFDSGHcQaQuIjAfUEq+
 1NcG6d2s14oRfWV0s7iHDG8=
X-Google-Smtp-Source: ABdhPJzcN9D8+20ZyMYSCztYzvvqG61UQ2rwsGhnrzQ/5vwoEHmaKS4ZAR3Ivcfrdkct8bSk4JkhTA==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr6832345wrw.226.1633625970107; 
 Thu, 07 Oct 2021 09:59:30 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id x17sm173027wrc.51.2021.10.07.09.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 09:59:28 -0700 (PDT)
Date: Thu, 7 Oct 2021 18:59:26 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v6 4/6] iommu/tegra-smmu: Use swgrp pointer instead of
 swgroup id
Message-ID: <YV8nbgfZgkXHgsYm@orome.fritz.box>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-5-nicoleotsuka@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20210914013858.31192-5-nicoleotsuka@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6170884596106001064=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6170884596106001064==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XSdiJyX2ODUVHwjJ"
Content-Disposition: inline


--XSdiJyX2ODUVHwjJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 06:38:56PM -0700, Nicolin Chen wrote:
> This patch changes in struct tegra_smmu_group to use swgrp
> pointer instead of swgroup, as a preparational change for
> the "mappings" debugfs feature.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/iommu/tegra-smmu.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Seems fine:

Acked-by: Thierry Reding <treding@nvidia.com>

--XSdiJyX2ODUVHwjJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfJ24ACgkQ3SOs138+
s6G4fg//RJ1qv8A19ca5R0BWaTPrbKYcwVRsYCJWUNSW+TuIOpUIWAR4BaymZSV/
zYQwCVcjbXsrMWHmS/tFA8ySlceEncee13kTA5ypAHsZWOPZOyy3qlt6k6qXZYfc
32SKK7Tq6vbgI5LdWBF8JstrNG50IOeV144GxIK1owgGs7Yht06oqXoCrfBJ48qr
rH9jSZhYS11NvC17I7njqfIf4rSMxo1xVvMW2y1RJoh+rlbGWA9wSbqMDuHQR/Ek
4x5RqN3Vd5pc2LZUZ0UWQt6XnLwMYR9BK3ajLWKMmYEzNveYh9OEnQjInKNF1hjW
uloABAGbVtmf166hjoz/G+Vb7b0RZiskiz+FoljAekF1zFIh8z1J7USrEDcH9U5S
/YO7eaRSfPnL5CGVdrJcDdQuKRsvVF3/ScB8w68L+2/MdibD+oZD8YxUfYsRzFFQ
q2GbON+TSw6XVlpIGSuXlOQ8mmmPNvDv65k8/E0YvO1rkVd1Wll5sLIZqcTCc8t9
XWNSe3Dl9iQYE6OzQms6wjewzTtd5Yg0ZFM3ru081lTiftgz0SjkHGomq8h60afU
LTUaYmThVI1FmQiJZJrEoeHLTiiLF1614/EDSmgkbAfic/Hq7wYaQg4MMjvpAXDb
CCPNWuCOTQwuQxErtNjzMUeZ2dN4r56kZ2vd0eZN8Q7L8Nq8NkU=
=WxRa
-----END PGP SIGNATURE-----

--XSdiJyX2ODUVHwjJ--

--===============6170884596106001064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6170884596106001064==--
