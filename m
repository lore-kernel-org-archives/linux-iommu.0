Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B40C433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Dec 2021 08:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCFE3832AA;
	Thu, 16 Dec 2021 08:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HPd2XcLO69dy; Thu, 16 Dec 2021 08:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9E78A83299;
	Thu, 16 Dec 2021 08:55:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74B6BC001E;
	Thu, 16 Dec 2021 08:55:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAF38C0012
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE8AB416BD
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SvwzhTV-dLQU for <iommu@lists.linux-foundation.org>;
 Thu, 16 Dec 2021 08:55:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7EB341651
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 08:55:45 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id v11so42776276wrw.10
 for <iommu@lists.linux-foundation.org>; Thu, 16 Dec 2021 00:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SOuxRFXySPzshUyGC5iL0C2CvH+JBhvny1eTkHaCuAk=;
 b=C3+lWk3b0y78VVa5eWSCceWoMVKh8OoLiXVo7+b6aykRMYMZS84tnO1iY3ilDuL+9S
 kNFtEfRVtO639culhM0FpOo4Y5s9vMHKmSsjGZuezi40pU5i8mpnOQ3RS+oeaRMH3hl9
 pPN24fNaNFy0a9PsTywZjzg/vJ29iwzznOpSkfNmKYcxwRecN9Ii8967W2bG+MsJYOzd
 zipVfIzveylYNsmoBr6s3JwYXRZnmQ2MZdQL4HlJjlJcy9Yugxhwqe9D+SjsSbm+OJ0B
 hqYQy30NATx1d4buHLlzpvm/LnePURXPW/Ml0FrbTWnDlmXYjVLLhwVt0JIVC5anZtg1
 swTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SOuxRFXySPzshUyGC5iL0C2CvH+JBhvny1eTkHaCuAk=;
 b=B6AzegVqhXWzGnIxXijHSI8MoOo1JDWJyanZZfvp0uR4Sj8TEllUPsL7UJAcOtd7oz
 IzK/W7jvBLs6xI0sSfxNF2c/hu4EyDiQ34F6l3KgE43zyzVAlO5DmtKUlOPdYhXaoAgd
 Rw/szTrwefs6WSTvLblFHEHD3bd5QPwJlHMu6fTvnyMnMnDmwQ6wDqmI4tmO9KNox7Sy
 LR5KOjIPwYspcdTkbuZZ3X9p5nSEkAiawbFgvYgSnPtuKIBqENIYWkFWCw9jpWx0D7yx
 qCPFE3u8qpiACRhzG24QTLQ2gh8ZpN/1tA+ZwYXk+qqlHvZhdMccLJ+r9d7uo1txPggE
 cVkA==
X-Gm-Message-State: AOAM533clV1Ss60Tidkw/TGMtRdYt2GU/EUiXDnyqfCEsWk/lzHq/DnZ
 u1Cka0wxA3qqtMSsYJMxEV4=
X-Google-Smtp-Source: ABdhPJwbtAMNBx3u2dBIsPqwFJsMFEOrlFqylkByzKob5f0kf3vZdqodg/kqdagKi6U3S/JWjAH3Vg==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr7678332wru.397.1639644943821; 
 Thu, 16 Dec 2021 00:55:43 -0800 (PST)
Received: from orome ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id w15sm4090586wrk.77.2021.12.16.00.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 00:55:42 -0800 (PST)
Date: Thu, 16 Dec 2021 09:55:39 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 03/11] drm/tegra: vic: Fix DMA API misuse
Message-ID: <Ybr/C+GNFPDPgLnF@orome>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
In-Reply-To: <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Cc: linux-kernel@vger.kernel.org, willy@infradead.org,
 Mikko Perttunen <mperttunen@nvidia.com>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
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
Content-Type: multipart/mixed; boundary="===============2367854679484978703=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2367854679484978703==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xaI96K7vWbm32g6g"
Content-Disposition: inline


--xaI96K7vWbm32g6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 05:54:44PM +0000, Robin Murphy wrote:
> Upon failure, dma_alloc_coherent() returns NULL. If that does happen,
> passing some uninitialised stack contents to dma_mapping_error() - which
> belongs to a different API in the first place - has precious little
> chance of detecting it.
>=20
> Also include the correct header, because the fragile transitive
> inclusion currently providing it is going to break soon.
>=20
> Fixes: 20e7dce255e9 ("drm/tegra: Remove memory allocation from Falcon lib=
rary")
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Mikko Perttunen <mperttunen@nvidia.com>
> CC: dri-devel@lists.freedesktop.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>=20
> ---
>=20
> It also doesn't appear to handle failure of the tegra_drm_alloc() path
> either, but that's a loose thread I have no desire to pull on... ;)
>=20
> v2: Resend as part of the series, originally posted separately here:
>=20
> https://lore.kernel.org/dri-devel/2703882439344010e33bf21ecd63cf9e5e6dc00=
d.1637781007.git.robin.murphy@arm.com/
>=20
>  drivers/gpu/drm/tegra/vic.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied, thanks. I've also fixed up the missing failure handling for
tegra_drm_alloc(), which was actually quite trivial to do.

Thierry

--xaI96K7vWbm32g6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6/wsACgkQ3SOs138+
s6G5Ng//YzfjTiVGwWVICqHpvgQHCcZ8oVaca2ULy6V9X+H0OOwBsrnOOsQRNQPN
bhUymR2MvtF7CGkWXSLcLBInR683ccLJefYom3K7kd/Lf1bptAbYsIIR6mEU/iHF
dgk52WgEANXqXpjIkny9hIQdmgjL4ilBS9vwZnBniFIfNTAER2fEy3CsfvoQnkC6
0ZoB9zaj+a+PBUy2oGB0K51wzoYWglCG5sbD94eeztUwdZtnWcFz8FpYWLVZQgvb
OH7mgLECdjDiu6ZJ+/h57xcO2gR0NhEPOlq5fhyWd6M2OMcqmwE4xEmH14zyq1RS
maeLK89xm8X7BCEneOai8B70OH2nzW7dHYMFT33WWJOVzvfX9jBzTn5aMxif8T1x
NYoJew1GJDCvc0hE1SQyWLqfomvVE9Ctod8pgR18us9XMn0jhQZ9+9frVE661g7C
0ATJ+ekU7msdPeQGG+gIgOoBI1nxVlhMyaeiEA5ZUI7jaa118EAS5o7RFHGW55yu
YTmw+ZiJ1Oqtm+sJIco6G4z30Su+rsAo99K0lALgJ0op2uBibF49yGyoDvfM/k62
7fgmTjnj2tA/V4isGVdH8/JjF8gvferm8YCBh2PZlArczHEUTOh1hIoNwxGOGIG7
y02bpMz2KLrRaOdf+ut96A/t1b+aUMiwgnH1cOyt1cy7SuBVvjU=
=+ED4
-----END PGP SIGNATURE-----

--xaI96K7vWbm32g6g--

--===============2367854679484978703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2367854679484978703==--
