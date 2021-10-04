Return-Path: <SRS0=nHvM=OY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E89C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 19:23:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746CC61354
	for <iommu@archiver.kernel.org>; Mon,  4 Oct 2021 19:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 746CC61354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4234B607C8;
	Mon,  4 Oct 2021 19:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BUWFtc7Ub6I9; Mon,  4 Oct 2021 19:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F0BB6082D;
	Mon,  4 Oct 2021 19:23:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEC2CC0011;
	Mon,  4 Oct 2021 19:23:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6079C000D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 19:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A23196082D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 19:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TElhv9Ck8bNQ for <iommu@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 19:23:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC30F607C8
 for <iommu@lists.linux-foundation.org>; Mon,  4 Oct 2021 19:23:29 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 t16-20020a1c7710000000b003049690d882so300703wmi.5
 for <iommu@lists.linux-foundation.org>; Mon, 04 Oct 2021 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uMjCccuv8K3FthyMvW3umSTS3TXEzXjJZC770iFNXMw=;
 b=T2U/nE7hnQSuiIVNXx59ef/KVGvClvaES83NC0R+C/3AWB+l1vO8a+jvJe+dsF+Au2
 iBDZVJ8ZpaBDFHU/BtxgDphiSZpuFUjU64E6txDvtN4d24igRZNmXkoLz1PuhIP2IHEK
 CAQWThnaBlUeIrnqxTjYF8wt6lPkNXgIuPY1XTHb/D9T+E5NNROAhJW0cbUHtpHmChYR
 gX+hXU6gsU1dNpnzDOpqnAsOBV0I4es4WLQHD6JO/6OwpezrLJcrN2XquUZ0oDAJEXQr
 kY7NkOW7FblGAPzGsbIFeWsTDK++aRYDd3dYpGjOhSmyecNOtDbJJ0MidhsSkXa6hFNO
 ZgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uMjCccuv8K3FthyMvW3umSTS3TXEzXjJZC770iFNXMw=;
 b=MINmFjYF/VK+wPHBR7EzqM8/ssMInvdrTj7dwDswwQSQH4DNuvi/+NqUwSoXjOhObF
 pRmVc6zMkhKYLMgQIHUZBKbnJwW/gdLk9HbMVUw77LRWvJnX8p+JCm43QFNilSpaJ9Ef
 ZIvOjvX8gZBl7ztsZNpXoZWLYBmjzRp1YipTvm8IRJ7fjYxLjHFfesfs7Xkd1EPuVU80
 BVpvBaPPg9WIPNgjD5VJKuu8Nt29XBg8UsP7bhj2HcTr4Mz+HH5mzwqTdWO7VwdFdnyf
 lqXrBLhD+cJwz5XPwze2hxnXnXH5zWCE3K9Fo6StV1o4HRBx66IrQCAynpgmC58uHyCf
 3oXw==
X-Gm-Message-State: AOAM530uegvRfeuHyPA95qwELKNUxwNhiw9qMjNM7kyw3XjeyguadvWY
 Oa+WSe8RRmqcqLLE7afndnk=
X-Google-Smtp-Source: ABdhPJyjwD/LH2q95MXnuxOh2nx+sB81p6fg9bLtYYJr1TQ6uyeixQlpw5qjfZ9c4yBIQ6sqSZlgoA==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr19823190wmq.159.1633375407907; 
 Mon, 04 Oct 2021 12:23:27 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id h18sm18108229wmq.23.2021.10.04.12.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 12:23:26 -0700 (PDT)
Date: Mon, 4 Oct 2021 21:23:25 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 0/5] iommu: Support identity mappings of
 reserved-memory regions
Message-ID: <YVtUrTdI9kUSScui@orome.fritz.box>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <95e4c23e-4700-ef7e-d8ae-17693b65e121@gmail.com>
MIME-Version: 1.0
In-Reply-To: <95e4c23e-4700-ef7e-d8ae-17693b65e121@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============1367849713201181035=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1367849713201181035==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="348p5nA0ximYPP+C"
Content-Disposition: inline


--348p5nA0ximYPP+C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 03, 2021 at 04:09:56AM +0300, Dmitry Osipenko wrote:
> 23.04.2021 19:32, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > I've made corresponding changes in the proprietary bootloader, added a
> > compatibility shim in U-Boot (which forwards information created by the
> > proprietary bootloader to the kernel) and the attached patches to test
> > this on Jetson TX1, Jetson TX2 and Jetson AGX Xavier.
>=20
> Could you please tell what downstream kernel does for coping with the
> identity mappings in conjunction with the original proprietary bootloader?
>=20
> If there is some other method of passing mappings to kernel, could it be
> supported by upstream? Putting burden on users to upgrade bootloader
> feels a bit inconvenient.

It depends on the chip generation. As far as I know there have been
several iterations. The earliest was to pass this information via a
command-line option, but more recent versions use device tree to pass
this information in a similar way as described here. However, these
use non-standard DT bindings, so I don't think we can just implement
them as-is.

Thierry

--348p5nA0ximYPP+C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmFbVKsACgkQ3SOs138+
s6GKyQ//V2saEEzeX3U0wiG5Q2qsyu91r79CCduNGpAEgJwyoZfObKu07BhPXBUw
lCxgiRVS84aoOcEl7llqB01B8UzRAaB4c3jXW5SvRyYF+J0MUjcwXENJpWE1Ojho
PuIcOZPRJt0jCcAv2O0hK8azDyFdaf+xpCeLEOMwA3oDp1MadfGzhP9K3Nj/la6f
KKldVqTYxbSaErW/jZ/S1Rdhe7M0iWW/90f+NdBU2hdFvChd0WkQW7WSbTRDitu9
GorqdupEe9fwsm5xh43kk3jrST3tJccjJkeAuK+JqVnfaesNChgiiyAvXtva1bBh
fqwp+Ey5YjcgoRUO5PBwCOg86+LrCifhpoVkGSSV3+GO9VPg1A6r90A665fFR6ti
H9QWJCt0NgdEQeCmkeKZ4JIQ1ICm9OYSRe8JjJpTV/ppGAcyP3nyXfye7cru0hc3
lh5BgGcksPz6kgawyxeIZNrEWOg9T6qb9uV29myqNHGt2yXgTAIC1IxoqYD/SBD6
ghGS/qDBo2jGiUC97GmEOoY2/2JK7EgRpjmPKWdRjy8xmqSgIr87+Lxg5ZmpFvmw
Z6JWzqUjbD2E3La+r10q6B19BQd/9vK7j4k19Umz5WTnbHMAZwi91b8Rbs8C0D0p
oDdx7kjHeSKdqsh68zNTx0RDwEsl5jgIb5hxtdTJOWKOOgVNGfU=
=Unww
-----END PGP SIGNATURE-----

--348p5nA0ximYPP+C--

--===============1367849713201181035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1367849713201181035==--
