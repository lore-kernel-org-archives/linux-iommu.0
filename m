Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D236FC433EF
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 14:56:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7507A601FA
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 14:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7507A601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 23EB6402A9;
	Fri, 12 Nov 2021 14:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4QZ-9XGkZxPc; Fri, 12 Nov 2021 14:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D31674023C;
	Fri, 12 Nov 2021 14:56:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91E93C002E;
	Fri, 12 Nov 2021 14:56:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 891A5C0012
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 14:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6199F403E0
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 14:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wL8rs6G7dz7i for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 14:56:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C2BB4023C
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 14:56:26 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 r9-20020a7bc089000000b00332f4abf43fso7439295wmh.0
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 06:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JCqVUzOzEGA4JkXqmf2+cqP3C2tmsy0AnOVF6rZCuc4=;
 b=m4kSxAI2d8o+9qJr6+UPuYzZjtwofpmxkWdXwVzXo3doQFfYkWLbKIzzXdAoNuRN0B
 3UBxeSWsDlVB4JHJvK7oXSSuqxlhBK+UMXMTaUuES9E+8TSR6uTL5LOHALc6s7KIQRpA
 f+5822Yz4gckl0F58hz+LmttUQHHQMM9HasiW5IAmNuDnzxN+oUsqTx9JSbRWnxNFvDA
 uk8D3fBS5Zaj+124/+mCW6g31JhGKbiFs4ct0gQgN4I8glN43nOQHoyAl1y/29Dcbkez
 /NRlNakTdv+R47uhXUd8nWDBt/DQNAV5P1b71WwzlyRxc1typXvR2/pyw0hs9DPSF866
 tr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JCqVUzOzEGA4JkXqmf2+cqP3C2tmsy0AnOVF6rZCuc4=;
 b=cbhy2L2Qqg/DqVl0/RAsmptJLEQEtXa1CGzD2gn+O2vW/7IHjhD+cnQnaOnA1TzK59
 5+USQvft1xK/AweQgxzv8cPsweXP4CKWxer9L3VchScdQNlJHPYxWnOI9hHcF+CnN1Ek
 qXF7NjSA7nRubf5gKgb08UZVRxjkmnjf5ov+YZSJIQXE1FXWKX5gNGNKmdhLaFx/skEI
 12lKsDQoJUtTMr9d9fcfojc0NBG9y47Wt5ykLGdDrwDHY1lWf9yvQLLEXsgBMWHlSqNe
 j/nI/iz18lwi3XD2/mHo5AK2DWVHhkXydMba2hUsGQRonk60wYLp4rk1Nm59ifiwvTW8
 IfkQ==
X-Gm-Message-State: AOAM530j6X0KTGNtUlEY3Pxq19Yku6p5p2otBSN7V5sSnvjp366lym/J
 l1eFVh4ozqet22gdPR0jH18=
X-Google-Smtp-Source: ABdhPJxksw1qU0cW8bIxV9dRicQ97DWaZ82PYF74HlxiYdecbV5alqNSZosmQkAhil1NpGWpUXPz3w==
X-Received: by 2002:a05:600c:4308:: with SMTP id
 p8mr11848789wme.132.1636728984574; 
 Fri, 12 Nov 2021 06:56:24 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id a12sm5819733wrm.62.2021.11.12.06.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Nov 2021 06:56:23 -0800 (PST)
Date: Fri, 12 Nov 2021 15:56:20 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/4] iommu/arm-smmu: Support Tegra234 SMMU
Message-ID: <YY6AlFhZFaUoIkBM@orome.fritz.box>
References: <20211112131231.3683098-1-thierry.reding@gmail.com>
 <e19479d9-f0b4-5347-1a43-2fcf5224a090@arm.com>
MIME-Version: 1.0
In-Reply-To: <e19479d9-f0b4-5347-1a43-2fcf5224a090@arm.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Cc: devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============8371910440636681394=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8371910440636681394==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YzV9+/LPAQG+ci/z"
Content-Disposition: inline


--YzV9+/LPAQG+ci/z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 12, 2021 at 01:43:54PM +0000, Robin Murphy wrote:
> On 12/11/2021 1:12 pm, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Hi,
> >=20
> > this series of patches adds and enables support for the ARM SMMU
> > instances found on the new Tegra234 SoC. This is mostly similar to what
> > can be found on Tegra194 except that there are a few more instances to
> > meet increased bandwidth needs.
> >=20
> > In addition to adding support for the new Tegra234 compatible string,
> > this also adds a missing description for the nvidia,memory-controller
> > property to the ARM SMMU device tree binding.
>=20
> Besides a nitpick about the inconsistent enum ordering in patch #2,

Heh, yeah, I'll go fix that up so it's consistent in both the top-level
compatible property description and the conditionals.

>=20
> Acked-by: Robin Murphy <robin.murphy@arm.com>
>=20
> for patches #1-3.

Thanks!
Thierry

--YzV9+/LPAQG+ci/z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGOgJQACgkQ3SOs138+
s6FPbw//abAd6QKSSqbcGCDl8InqWLdNRjR3JNpKWAM8Dvib8JJ2NSbRGaveExqJ
7xLI556MCIJzuX9DEFW+ay1SeVnW/KZwANl1Y/DSq29n8W+makepo523s04TsIBE
VpwsgHlvoVIslWvex0n31M+EjKy+udR6/lQpTbBmuMDIG6ETH/cZ6XBkqwGRPbau
EnCi55JSXQWujbOgKrCSAajqSt5AgqXgIzFzZBqbPnWnZf8ESOicTfQwdwpwOeCS
IQqYbPfh0vdZ7C6wnTC4CFXqv4//WXjTPALh5tz0qi3eKP6nCOVO9psh9eVMbHGs
949MghRv0hrTf2V815Au2fqlf+Gf0LMizWgbi6EP9mRQkKd9nXFhHKa0ime86Ryd
V5QzTfcHQBuW7+qv8uQNHRn8cBxsmoMxIkpaoGRoW0Okt920c2SkXXGzOZ37d/lK
joea6gwnJj/rEb6xy2Vbn0oEkaX2HpzHEDB0aB6N+/mKx7ZGXesNafW4nSW+xaPD
VYmjx74Hv6vL+cw0idLkR9ifU5MLVdcJiLwevuHy/bOdH8K11nopo4uM/MigWGEd
8UhcDrbq6cPGof9zSf7T/noyNHW7+G/uaGaE3SSDvBleQGS1iWho7rp7mxO37Kf1
9jbfBjI4PQMqkKKE6y/U5UqrMCxiatKJPlhpQrR7dZNuPJvKyqQ=
=imbm
-----END PGP SIGNATURE-----

--YzV9+/LPAQG+ci/z--

--===============8371910440636681394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8371910440636681394==--
