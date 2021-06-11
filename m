Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81D3C48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 12:04:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73736613CF
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 12:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73736613CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BC0B404CE;
	Fri, 11 Jun 2021 12:04:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id orDuJWYQafhm; Fri, 11 Jun 2021 12:04:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A7DE404C3;
	Fri, 11 Jun 2021 12:04:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF27BC000D;
	Fri, 11 Jun 2021 12:04:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4842C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 12:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D49D4149B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 12:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qtAW6_4IpspW for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 12:04:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D4B84066E
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 12:04:26 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id c5so5790292wrq.9
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hRpdmhMpuxXRQobR0p25JN65+9rAtH99oGxwRFzt4Og=;
 b=A6qec+2aZ5Q8YBecDbnt0i3i1uWt8libaJeTykG0XqkriQI8PvvIAb0aUqmisjwMlj
 da1qSFZUutBUihSBhPXF6I/vQE6uZEL6V9tyeVumZpJVS0TAQahcDHaCvXdMIA59qdqP
 8HERLhPDeLjDbblSdUsVNB3MnOM88mWOnMlp9n1UrzvDYHEUxjxLZpkYkToylMnkRlnF
 EIHTBh+G1au/gNaKsZMqp0M42ZR1zaA0Nw13cH72Er+K5CN/hPyIdocQf4T2fB6Oek26
 dKAtIsx3HAuhyivOkH+AVOvVEVQqtwHLAFmwPhNtpXenR5WlJDZFz/1e/v3kRuj1h2qB
 gTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hRpdmhMpuxXRQobR0p25JN65+9rAtH99oGxwRFzt4Og=;
 b=uG+VTXpu49U3GgqPxCl8bqvH9/V8oHX1DYA5LS6WGIa+h6mf30uavjIs4teRoEVsX6
 LapMjyCil52XSmMQHBNsxb19NWZ+XbG4y40x/Bo2PgQWA9o6fvCxi2zAyaShwDueXZI+
 B98f1jmvlULSmezJ6FdhBxd09vO/AevoHvShj45t0mCS0pU2YNCGFVjQGnUzEoeXd9um
 EfuC0ROUZ9XjXSnCF0aDmhC562E9ABtqGgXW5dijrIfdKk/paYaCJLXN8mx8OUV/dwF/
 hBmpit4Hye3q0iU6pVRDsPHER+zAhS/l5UK0F+w12PO3/w7DzRT3QeT1L35FKOiIhK+j
 /nRg==
X-Gm-Message-State: AOAM531PfUyHaU5SMF7GLMALxx6XP1BHafN3eiBfwYT0/Gr6SkEnj4f0
 gBR9sW/ltx7y4CMlsxSFbzg=
X-Google-Smtp-Source: ABdhPJxqBjw3HrtMgc2OXg5KORiGwzysOQKEB1Ej0iptMdt1LmifSFgOy1HB3fw6Cytwcs7I8jeLZQ==
X-Received: by 2002:adf:ec43:: with SMTP id w3mr3600353wrn.270.1623413064793; 
 Fri, 11 Jun 2021 05:04:24 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id m65sm5739813wmm.19.2021.06.11.05.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 05:04:23 -0700 (PDT)
Date: Fri, 11 Jun 2021 14:05:58 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/9] arm64: tegra: Prevent early SMMU faults
Message-ID: <YMNRpo0vC8Rjn+a9@orome.fritz.box>
References: <20210603164632.1000458-1-thierry.reding@gmail.com>
 <162339404910.6729.11145661496228624827.b4-ty@canonical.com>
MIME-Version: 1.0
In-Reply-To: <162339404910.6729.11145661496228624827.b4-ty@canonical.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Cc: iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============1268463048199289839=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1268463048199289839==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0FeCZruiAMHvtV86"
Content-Disposition: inline


--0FeCZruiAMHvtV86
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 11, 2021 at 08:48:00AM +0200, Krzysztof Kozlowski wrote:
> On Thu, 3 Jun 2021 18:46:23 +0200, Thierry Reding wrote:
> > this is a set of patches that is the result of earlier discussions
> > regarding early identity mappings that are needed to avoid SMMU faults
> > during early boot.
> >=20
> > The goal here is to avoid early identity mappings altogether and instead
> > postpone the need for the identity mappings to when devices are attached
> > to the SMMU. This works by making the SMMU driver coordinate with the
> > memory controller driver on when to start enforcing SMMU translations.
> > This makes Tegra behave in a more standard way and pushes the code to
> > deal with the Tegra-specific programming into the NVIDIA SMMU
> > implementation.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/9] memory: tegra: Implement SID override programming
>       (no commit info)
> [2/9] dt-bindings: arm-smmu: Add Tegra186 compatible string
>       commit: 4287861dca9d77490ee50de42aa3ada92da86c9d
>=20
> [3/9] - skipped
>=20
> [4/9] iommu/arm-smmu: tegra: Detect number of instances at runtime
>       commit: 7ecbf253f8d64c08de28d16a66e3abbe873f6c9f
> [5/9] iommu/arm-smmu: tegra: Implement SID override programming
>       commit: 8eb68595475ac5fcaaa3718a173283df48cb4ef1
> [6/9] iommu/arm-smmu: Use Tegra implementation on Tegra186
>       commit: 2c1bc371268862a991a6498e1dddc8971b9076b8

I've applied patches 7-9 to the Tegra tree.

Thanks Krzysztof and Will for your help in getting this over the finish
line!

Thierry

--0FeCZruiAMHvtV86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDDUaMACgkQ3SOs138+
s6EoFxAAniadn+i4fcWUq2ejwdfgme+Hn6STBgBar4sptJiRZwCfzyFMounIY8gw
5kc/6teVwJPzi0nVc/xnvM6FkCBgQKFkNCwgvoZO05gQ1tRMLWxtoRiJmpKpkCsF
D7Q4DBb7k5bUwy+wy1cT0UMMTFeRrdRGZ0wOesEQwAU+fAAjC6pzfGtlEAeIeUU1
8vsHuTO8Pws8LfeUVKPSRf2wIMjKsb6g5aR5oMrISKVCZvjoW+oOm1FN6o+/mwpS
Sh+GtZwbsrN/uzE9qdEWTxXRAj+RFUlYuuMeUuxEvSKj7cZ8hQ/k2lmm3fP+O4A6
wT6P9tqAv0TBwBeQ4Pgyqzmi5dptnuR5TsGAjDcaR6v2H0v2FfMa67dEF88LC4yp
f7rAdULjuqfgFaZ0miboE/o2gXCiz4eRFXmeff9RSToOTXl0/CasUbkQfkpjMaUV
cOqD6YpahFqjI+WTrLcAD7fJ+VdVOL2/Qrgss2ILXd1xyAdivSSEhcbuH7Q68wkT
hnYUzKvMCyQvMyjAAxvgy0QOhuDcdFn3g3vsxErO88I1qcy4+4Dzhf4oH4OzNY2A
lGzWv+SF1La4261QdOJW2FvLWVGmPQf+yBtsGMwqhUJPUyIBfiAmniNvDOtT4PSP
RcK5rqO4qkbZrLgpGvqnmNQG2c3Q3CuCXoqKu/d+V4r4M6P08H8=
=ZoqM
-----END PGP SIGNATURE-----

--0FeCZruiAMHvtV86--

--===============1268463048199289839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1268463048199289839==--
