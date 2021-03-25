Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18465C433C1
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 15:52:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A227F61A1F
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 15:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A227F61A1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5DE09401D3;
	Thu, 25 Mar 2021 15:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZRQz6q7OKEAu; Thu, 25 Mar 2021 15:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26C88401B5;
	Thu, 25 Mar 2021 15:52:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD8C2C000D;
	Thu, 25 Mar 2021 15:52:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B114EC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9721A60757
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DC57BqMxvwJL for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 15:52:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B4E23606E2
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:52:03 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 r10-20020a05600c35cab029010c946c95easo1447518wmq.4
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HtoKdQXjuNRr5RVF7BAAsqXcllsDQnD0BM3AUVSmNYI=;
 b=OjMXjNBk7/2AVcS/w5jmMrtwkuY26EkeNO1UxFvzkucjJZprdOilTedbyOOjrDpKti
 Hn5U866NKLvKZrJDqRzuucfj33lsBc6VrgWlbujLL4Bm0++h4HEA+bvXOgqhMy7O4D9V
 W0HpwXUu6e0mQWVccrOkxFkNwu47QfuIplt05o7fK+QG6+fBoMAmP7uAOJTlhqtFyJOE
 G4+E5cucvaftrId5FqDq7e2G3Wu+eWPOVBoI4ZvwO22LMuezYRifJzYRY1spaoL7ia73
 ImFuwgSVeW8wAEwbMMAxlZTpfykGColacXKFaHdCHwvR+FTEDPI4OJ5OfDW6DdU8kZmm
 64Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HtoKdQXjuNRr5RVF7BAAsqXcllsDQnD0BM3AUVSmNYI=;
 b=qDXhdqXTmXFV3Vj2MAHf0PzNmX6V1b5BSzO7RnXq//S51doOv6M3BgKPaWYGvKySEZ
 Cu114rKnbVr9FL/DeeH9Hac5o5Il7DPCvQQ2GbtVq7jY/fwG4MRp54ZidUjZhvnwnQTl
 ulzFx3HnJnndcQUTVtsHHvyX3tehwjblZ35/KXWIIK30WDNM4BrvUYUlScE7qARxWKjL
 p6aI9F8JVSq7PkIpGZb3dY0O5wtbebxS9XcDZdFr1MpQ5FeD7iEaWdHE1dHNPnfjyz7i
 qSqOQp+7LYOjmqXLvf1ZPmMPQwzD1EvEl+mcLYbf8Ep64t5g2n2x9wTMwqcx2ieWRPQr
 sVnA==
X-Gm-Message-State: AOAM533ODxkcxhPzvHbv0v5sa2HmoDXidHpljJdxTm7uAF7G+F+KFZbZ
 VCSQYx69hr9fNid477pZdwo=
X-Google-Smtp-Source: ABdhPJxLVYcJ9/0x+rt83xfSIG1ko3R60i1XKxD3ztgT9Tn2IYeL/mo64eQoF4Q5wVEef4WoT+smaQ==
X-Received: by 2002:a05:600c:19cf:: with SMTP id
 u15mr8434268wmq.7.1616687521899; 
 Thu, 25 Mar 2021 08:52:01 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id l15sm8058477wru.38.2021.03.25.08.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 08:52:00 -0700 (PDT)
Date: Thu, 25 Mar 2021 16:52:22 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 1/9] memory: tegra: Move internal data structures into
 separate header
Message-ID: <YFyxtq6cwIJNr/Y5@orome.fritz.box>
References: <20210325130332.778208-1-thierry.reding@gmail.com>
 <20210325130332.778208-2-thierry.reding@gmail.com>
 <ca70b07a-608a-51b3-3c30-ff04bdf8bcc0@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ca70b07a-608a-51b3-3c30-ff04bdf8bcc0@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: multipart/mixed; boundary="===============1071945312005733619=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1071945312005733619==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3koIXHrG9oTo3ihE"
Content-Disposition: inline


--3koIXHrG9oTo3ihE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2021 at 06:12:51PM +0300, Dmitry Osipenko wrote:
> 25.03.2021 16:03, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > From Tegra20 through Tegra210, either the GART or SMMU drivers need
> > access to the internals of the memory controller driver because they are
> > tightly coupled (in fact, the GART and SMMU are part of the memory
> > controller). On later chips, a separate hardware block implements the
> > SMMU functionality, so this is no longer needed. However, we still want
> > to reuse some of the existing infrastructure on later chips, so split
> > the memory controller internals into a separate header file to avoid
> > conflicts with the implementation on newer chips.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/iommu/tegra-gart.c      |  2 +-
> >  drivers/iommu/tegra-smmu.c      |  2 +-
> >  drivers/memory/tegra/mc.h       |  2 +-
> >  drivers/memory/tegra/tegra186.c | 12 ++++---
> >  include/soc/tegra/mc-internal.h | 62 +++++++++++++++++++++++++++++++++
> >  include/soc/tegra/mc.h          | 50 --------------------------
> >  6 files changed, 72 insertions(+), 58 deletions(-)
> >  create mode 100644 include/soc/tegra/mc-internal.h
>=20
> What about to make T186 to re-use the existing tegra_mc struct? Seems
> there is nothing special in that struct which doesn't fit for the newer
> SoCs. Please notice that both SMMU and GART are already optional and all
> the SoC differences are specified within the tegra_mc_soc. It looks to
> me that this could be a much nicer and cleaner variant.

The problem is that much of the interesting bits in tegra_mc_soc are
basically incompatible between the two. For instance the tegra_mc_client
and tegra186_mc_client structures, while they have the same purpose,
have completely different content. I didn't see a way to unify that
without overly complicating things by making half of the fields
basically optional on one or the other SoC generation.

Maybe one option would be to split tegra_mc into a tegra_mc_common and
then derive tegra_mc and tegra186_mc from that. That way we could share
the common bits while still letting the chip-specific differences be
handled separately.

Thierry

--3koIXHrG9oTo3ihE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBcsbMACgkQ3SOs138+
s6HQIg//We9S3OSADP9jVLY5xm506ojbPSA2QxJNei0ivAFx1Esq65AjrCjQHenz
l6cf9L64Ffe+qZuCdGY0JUx2zWFdL2AyygpYn5QNKQB6whHvQ5utJCf/EyOQ5x2U
JRBQ8kJsFLTNI/svznbjkHuqrT6cqpf0A2yElVtKcrZB/tqaJ8HPoqfbJnYK/tLV
A/+e1oRPT0p24ifaui1V4I47Mxp5BYi8YkygqN00Ag8gpiUSfGIV2n/kuXTIvS5l
N4Vl4Y6aCz2IQnUAy7D1x1WzjQI3fRN1MeosWZp0og0QK6AalUl1FHy07Qs0O9g6
DJvTz01U4YTgnAWk6I5KlK97vEajg6ZV8o/P1CTMgkTs22yMge4RfSjkgZU4xzeT
d9mGJxZrNvNyVeb/ppFXNxVRcV8BG6/HuTOiVMxlyOUG62sXjiuh6wvCBJ57uNwA
voi5uqnf/rUy9E9L9Kv9IVzEscymBK3+xkkbu4oAoWLX7RkxGx5pk2FB5LFVJkIh
TmmQFBut+lKRE/CjohwY6kUKFhJHv0wGUfxRcDkdEe8aNt1XmBDEySozoq2z4/4m
JuhjLEOh2y+34fPhXaoClB8t0U0U6ULn0j9M9sQTG6Yk2G4/ui9KHFbZBTrx2hnz
7DRonhuWR/amM3jN9XS6HVBB//ebz2yP5WvQCrV1a5Zssq+dA5k=
=PluH
-----END PGP SIGNATURE-----

--3koIXHrG9oTo3ihE--

--===============1071945312005733619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1071945312005733619==--
