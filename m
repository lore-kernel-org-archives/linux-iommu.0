Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C3C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 18:03:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E9D61261
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 18:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D0E9D61261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A85760ABA;
	Thu,  7 Oct 2021 18:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V3g9JL7uWY-l; Thu,  7 Oct 2021 18:03:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 86A966080B;
	Thu,  7 Oct 2021 18:03:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A073C000F;
	Thu,  7 Oct 2021 18:03:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6F94C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 18:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A458140489
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 18:03:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tj7wzH9FKeVg for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 18:03:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CA8F040480
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 18:03:00 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id i12so9054256wrb.7
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LzYgfKlvwHIBL3wW8fhtlH1KhCgihQqD0wQewNy3gTQ=;
 b=CnrKfrCI/7b7P9niH6/3IP1Wt0eRn43RT4hn5SxwlYELYRR0SK5WKU/Vr/4eE2NQcv
 Yg66RubvO6t+h58bUDi2pYnddx5mcj/CSK0pfE7DHvrb7yGY7Qhv/ZfWriK3aJqLFTg3
 tAq/5wyD2bVUOe3NJNMdEP5hqzRwlSdreV3jtphDHyFNmrZEBU+M2Nhh+qmIEU2f8UHO
 1VrYqfFkAbntzETc89XOlZd4C8rgPMX0beOiVqcuePDLJ2kAT5ax66nkwRbYc1Mrj1bq
 wrfWIk9XqGS0KT08W9SaFguWb6nyttqseHLSsNtV3xtO8REQ8QIiT8KkOnOT6/8q6LhC
 T7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LzYgfKlvwHIBL3wW8fhtlH1KhCgihQqD0wQewNy3gTQ=;
 b=CRy6RWxkBaWcmgwopsDd5hEW/c0OBHitZ8XkEdgKswwlto9kANZ50N6JhBgk8c7ir+
 jXcPEB0+/Bh40N3mBYD7+20ZWH0eekBDKq36Xt6mZKDXrmHIn3H077iwnaAkMuxAF9wb
 +mxc/fVvGNeoUH28FmV+LMgZMtPJkw7vibxOYZdcUbEptU38Uj0GK/1d0Ro7iUQF/Go9
 NOYn3uAdTKhqhFflVdSJdtPCVwfb92ODxfxKbAcbSzFwqW0rMT350MIhte+DuQQFG6P5
 9MIN/YTCfa3lhymgK2+CExsvTPmucqHGhLRCYwRzjIUflzN70cux3L/pdycJeUJUWJUY
 z5wQ==
X-Gm-Message-State: AOAM530jn1/S4Z6nTC4ISzaxD8jcjeXg6TzCTOWqASehOP4vPFlFgaDf
 90koznxnL4tlTg9siC92ypc=
X-Google-Smtp-Source: ABdhPJzLFQShRWgexENr9TAiLhixQbONosI4QunNbNjX2FeAqLNG3BVRbZG2LBnMAFnm0kRccGzhCw==
X-Received: by 2002:a1c:f01a:: with SMTP id a26mr6084520wmb.150.1633629778982; 
 Thu, 07 Oct 2021 11:02:58 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id g2sm67566wrb.20.2021.10.07.11.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 11:02:58 -0700 (PDT)
Date: Thu, 7 Oct 2021 20:02:57 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] iommu/tegra-smmu: Use devm_bitmap_zalloc when applicable
Message-ID: <YV82USMgonpRzoWd@orome.fritz.box>
References: <2c0f4da80c3b5ef83299c651f69a563034c1c6cb.1632661557.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
In-Reply-To: <2c0f4da80c3b5ef83299c651f69a563034c1c6cb.1632661557.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, will@kernel.org
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
Content-Type: multipart/mixed; boundary="===============0003973509652963898=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0003973509652963898==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YJJooXTg9A0B1Lju"
Content-Disposition: inline


--YJJooXTg9A0B1Lju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 26, 2021 at 03:07:18PM +0200, Christophe JAILLET wrote:
> 'smmu->asids' is a bitmap. So use 'devm_kzalloc()' to simplify code,
> improve the semantic of the code and avoid some open-coded arithmetic in
> allocator arguments.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/iommu/tegra-smmu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--YJJooXTg9A0B1Lju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFfNlEACgkQ3SOs138+
s6Ex8g/9FzkP6Q72V90vFaRIUz/isfotGtkN2TgNhkMcQ1nfh8YNMPDVdFOS0tPN
eTBbg2moh1JaDxrQ6V6SWNypCZYzoN4fzCYrLOmCa2mC7Yteq5m5zXlIqt9wMmdd
i1UAVw0u57F/Nyw9dH0bQxDZYNAYJzrhq8FUIlZ3UroysSKF+ipjf07k8ANtovrj
Wq0q+xm+vn6MJS5TElVeCd0fLQWJvUwq6lZ9YUtB44uszvhciCy04xeMJ4sLAvdA
0VA3BjOHglRi4bEivpviSMMw5viABX1ZedM5lrxkAZDzcoPEu4cNuri77aaAwcge
XSDX/jViJASF73nqt5AI3mhDa8RUbtgKBDFbWi7dgpVSF9JAPdNbeWQKR/lNWdos
7vLch3cbR7Zc6AGerOld5s7XDLAN85ocp5CexAr1Wj3UgYGmjk5RuvXQH6aHJ5Zr
RJ1AV5yzu8FY6CzvKGR6ywoJbmzZTAK5R+XrhyBSDO0IuIKLPByRH12vOnzS8bEX
5aJYrih3ugVLCgOLMda/qsRiKjhHZOeZYlFMxuXKqxLXsdOXcu27VuQg2Vu9mb53
wJdioW3oDctaL6La9upYSerpBxzOxjcP+0aSBMAu1hUqOIU5m+0ktn05xl06OyY0
sZ22iw1pYgmE7WGTmq2rTHksIX2WP1PipyJNpuJF4Xh5df/QOVY=
=EYc+
-----END PGP SIGNATURE-----

--YJJooXTg9A0B1Lju--

--===============0003973509652963898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0003973509652963898==--
