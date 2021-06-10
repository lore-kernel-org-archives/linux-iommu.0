Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E93C47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 09:17:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7376861407
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 09:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7376861407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 378B0405CE;
	Thu, 10 Jun 2021 09:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDMG1YNbhmCm; Thu, 10 Jun 2021 09:17:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3C7C405D7;
	Thu, 10 Jun 2021 09:17:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABB83C000E;
	Thu, 10 Jun 2021 09:17:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D243AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 09:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFB9740395
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 09:17:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id goVD53da1cVQ for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:17:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4BA3401C9
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 09:17:25 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id q5so1429694wrm.1
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lufrtSYaRB+3cU25JjfQ213i4rIMewljTlWV6qMFCfU=;
 b=OfUdSJkaR48ZzMbKamaCpBecfRh/Ga7yYmiWthlZkjbRD2aBAsms4czdHt0TeYv14s
 gfEl53pzpd2J0B7NlM1RnZc0iENloEpbv9IXOBmMTJ3b4d4LjI+mcXJbUNGsckCtlNtz
 w7tDV32ehthcXQRyNSqbTDDwcbPO0nV3y2V57Qom5op6xzhPIOiQJVIJ54hkYns38aTL
 9epRtsCLy5qMyBpvMBv18xMcZvm/Q6COwzdr0ZxD+J8BbPGzWtp/X9bV1kUpiY+vPdbP
 ugkz7as3b1trF3cEiUxBP8Bh+PiBOTOupB/UI6IHha6W/S2giYgnZtGBPlvCFerb7+/a
 ffxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lufrtSYaRB+3cU25JjfQ213i4rIMewljTlWV6qMFCfU=;
 b=DbqxUEEeuW5SopOgcklgXsuNHfFfAiBXuLnjzyDfeqQfmmlUVXvsNHU3vJ1jBVi23p
 ybCoUurw/6ojT3XEn4j2xaG5lXWjy8qL2IsxW9wxyNvGqBXUS8ZfrmRHSn7ok5L0gP6h
 kd7jBbW3JoRAFZZ+33Ji/SkGo7sOHtcw33b0aPzzZ79OoqcpTe7NRbPZzPxp0B+SjHna
 QhiX5agkdRAuNpWdSykf3QQpg53p1knzRdttSoGqkVVt9/acjc+4hkBB0MUlhNY0Mojk
 HlNILrmVTwa7QLePX3SngqP9hB249Y8w6VupWQGXLhFed4wVvF8TDJrzCtxvjpum1MgH
 KfDg==
X-Gm-Message-State: AOAM533yGxjoRmRGpK3VN0uqEWxPW8vd/6wruOc8H6Ut3F5eIhVHzGPj
 ebInCWjCBRlvVnwua2mpFck=
X-Google-Smtp-Source: ABdhPJyW5m2MHrnAF1Ii+EvXADbLuM7bYTX9Cc1kCfjq7UI7PxLu4x3Bw7uYywoxvxiaKBPgYspf6A==
X-Received: by 2002:a5d:564a:: with SMTP id j10mr4235390wrw.171.1623316643906; 
 Thu, 10 Jun 2021 02:17:23 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id t1sm2710631wrx.28.2021.06.10.02.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 02:17:22 -0700 (PDT)
Date: Thu, 10 Jun 2021 11:19:05 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [GIT PULL] memory: Tegra memory controller for v5.14
Message-ID: <YMHZCaRiQNQCSsVr@orome.fritz.box>
References: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
 <20210608120128.GB10174@willie-the-truck>
 <YL+A+MPjjaa3nSwq@orome.fritz.box>
 <20210608164851.GB10994@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20210608164851.GB10994@willie-the-truck>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
List-Id: <soc.lore.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, soc@kernel.org,
 arm@kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
 Dmitry Osipenko <digetx@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: multipart/mixed; boundary="===============6999787303802342338=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6999787303802342338==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jVj7juWizf7nxW9D"
Content-Disposition: inline


--jVj7juWizf7nxW9D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 05:48:51PM +0100, Will Deacon wrote:
> On Tue, Jun 08, 2021 at 04:38:48PM +0200, Thierry Reding wrote:
> > On Tue, Jun 08, 2021 at 01:01:29PM +0100, Will Deacon wrote:
> > > On Mon, Jun 07, 2021 at 10:49:10AM +0200, Krzysztof Kozlowski wrote:
> > > > This is the pull for you to base further SMMU aptches (prevent earl=
y SMMU
> > > > faults).
> > >=20
> > > This is a tonne of code for me to pull into the SMMU tree given that =
I only
> > > want one patch!
> > >=20
> > > Thierry, if I just stick:
> > >=20
> > > https://lore.kernel.org/r/20210603164632.1000458-4-thierry.reding@gma=
il.com
> > >=20
> > > on its own branch, can you stitch together whatever you need?
> >=20
> > I'm not sure I understand what you're proposing. For reference, here's
> > the set of patches that I sent out:
> >=20
> >   1. memory: tegra: Implement SID override programming
> >   2. dt-bindings: arm-smmu: Add Tegra186 compatible string
> >   3. iommu/arm-smmu: Implement ->probe_finalize()
> >   4. iommu/arm-smmu: tegra: Detect number of instances at runtime
> >   5. iommu/arm-smmu: tegra: Implement SID override programming
> >   6. iommu/arm-smmu: Use Tegra implementation on Tegra186
> >   7. arm64: tegra: Use correct compatible string for Tegra186 SMMU
> >   8. arm64: tegra: Hook up memory controller to SMMU on Tegra186
> >   9. arm64: tegra: Enable SMMU support on Tegra194
> >=20
> > Krzysztof already picked up patch 1 and I was assuming that you'd pick
> > up 2-6 because they are to the ARM SMMU driver. However, if you're
> > primarily interested in just patch 3, which is more "core" ARM SMMU than
> > the rest, which are Tegra-specific, then I suppose what we could do is
> > for you to give an Acked-by on the rest (2, 4-6) and then Krzysztof or I
> > can pick them up and take them via ARM SoC, based on the stable branch
> > from your tree that only has patch 3.
>=20
> I think you previously said that patch 5 depends on patch 1, so I can't
> take 2-6 without also pulling in the memory controller queue.
>=20
> > Patch 6 touches arm-smmu-impl.c, though it's a two-line change that
> > touches only the Tegra-specific matching bit in arm_smmu_impl_init(), so
> > the likelihood of that conflicting with anything else is fairly small.
> >=20
> > Is that what you were proposing?
>=20
> I can queue as much or as little of 2-6 as you like, but I would like to
> avoid pulling in the memory controller queue into the arm smmu tree. But
> yes, whichever of those I take, I can put them on a separate branch so
> that you're not blocked for the later patches.
>=20
> You have a better handle on the dependencies, so please tell me what works
> for you. I just want to make sure that at least patch 3 lands in my tree,
> so we don't get late conflicts with other driver changes.

Yes, if you could pick up patch 3 and send out a link with the stable
branch, I think Krzysztof or I could pull in that branch and pick up the
remaining patches. It'd be good if you could also ack the remaining SMMU
patches so that ARM SoC knows that they've been sanctioned.

Krzysztof: would you be okay with picking up patches 2 and 4-6 on top of
your memory branch for v5.14?

Thierry

--jVj7juWizf7nxW9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDB2QcACgkQ3SOs138+
s6EnLA//ZgBQdPoxTa9Yc7sswfHwAYyKCWSKQcgTH84rrCOszXWcAZORrfyMA4/d
3OuzF8mlebPISC4OJoo3k9/EfITpQWbqFZSYQN03cqVDys/Kb+3woqyUvgrqmFUl
rxrITRTsCOakoo3/OGgAtC0r3P+btzdZco6pqrsTr4PwQe1oUC+179jq6R536pVO
n+liywt2NNxpGX1lI9rCpePyB777kLZZHI0oJO2HOtwLS/Z3TWLau3cRH1JSY7uy
GpCUzS87izn2OPo65VOQDIHIDA67M6UiqesYQCOic0AY4fo4hvTIQ7DIdFMQYh0t
Q2DUAr53VrV7m7DY313Xbo+ZGeq+c+ZQKn4JZ2KIOGDtucts8WpkEfmbJ2q7sUH7
JnIBMeUs1k5v52eW8/GfZT6reyEcNzYCT/C1w2cSRwB/bCTc7j1+O4Iarc45mJgP
pXFEsSZErCFLh0TBirnzJEqJ7eUyldWgSUy2jHndovEsS/hYJIuoKt6vILDlb4tn
9KrMopwWp4gKN6fZwZZIV2dOgx07jzsVXpBjVjtnafnqad4IanU1RobRKOikiNkX
xi97rLtRq5dB5oI1CTe3yHGUAz/A6gKyYtd3oQPP1hyeXglMAkThHJUBHTBlEAYy
3GeB7oBGK6Cn/ZmG4qWFvsW82bxW9mjFzwOxW4zmSuLxPCFveG0=
=Jpm0
-----END PGP SIGNATURE-----

--jVj7juWizf7nxW9D--

--===============6999787303802342338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6999787303802342338==--
