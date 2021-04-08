Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEFCC433B4
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:26:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2352261107
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 13:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2352261107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB96E40578;
	Thu,  8 Apr 2021 13:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SiO3v2JsSzJh; Thu,  8 Apr 2021 13:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4608D40571;
	Thu,  8 Apr 2021 13:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EB8FC000B;
	Thu,  8 Apr 2021 13:26:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9741BC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 85E7184816
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VaIS0vC6IeoD for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 13:26:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF8FB84808
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 13:26:01 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id w3so3044839ejc.4
 for <iommu@lists.linux-foundation.org>; Thu, 08 Apr 2021 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fWNbvaLef6259fRiVwT8gP9uDYrSeaWV/GmX7+mRaYk=;
 b=chgOTL62v+0C7rWcqD5pJN1jRyYzvFOuDOAldJufUdJu7ZV25rNPTAy94OjfZmRY3N
 y5cT8c1IB9RPbBF8KPIpknvij3S10h9Eqntq1NGonmRc6hPR1TaqTqfAvj36VTTcNJ09
 +8kyKxbUKAai1Liipscx9BKsPAkH8lGreZR8aYET35oobKTVOAh/53H4qvLAKJFmMDWL
 sH17birHxXwhQkrjPk8BMAMktZW1A9U2lxyDxpjFZPzq3kVEeBJxscOV5wq+4P0E4zb/
 BDKSzkrh6my85rZNYgdFvJYwQAfPdkYf4lh26uRDGwPiQdKLGV/iXi8t2Zih5OfUOjZi
 /YXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fWNbvaLef6259fRiVwT8gP9uDYrSeaWV/GmX7+mRaYk=;
 b=nLptW/TWFsBDamTXcoJRcAdnR4c3MYx/a5P5nySkU8fe/I5lqGBAop2qd/9DUbj8vA
 tFnSRFF/G3l/V9SacEzy05sD5auTrLouTc87DTh1RCXXD9w468uEwxi1kHBXrX3L8dUK
 PM3aABuHrLHyaX1eS0616Ev//nejLCvGqscDA+YaZZGtwanXgwBTHaSbpxWkt9mXGr2n
 jvFxKD48p9/g9VbM0yXp3Fkbe9gishiJISx8uVjIpR0cAlKt7fpakqs+xXsOE79YnkJD
 IAnIb/VcVVGqPXU0FVc9Mlw6V7yPLhMHnDAOfihSgushQGLyuXCI4GVkl3zGxCNXp0JT
 1THQ==
X-Gm-Message-State: AOAM532q/3kPd/db1RoDAGL+87qYx+KVkHQFsMq1lMOl4gCVQWuGWpkz
 lIhttpOVLKbkn1H5RMp5o4w=
X-Google-Smtp-Source: ABdhPJw9BESp1aZIkxjyZ1Hj8Wn+YQnpayJdATQPKrEwEx2YlgmlgYzkBb2MlRuUVTjwIjBqcmzXnw==
X-Received: by 2002:a17:906:1d0e:: with SMTP id
 n14mr10523496ejh.97.1617888359967; 
 Thu, 08 Apr 2021 06:25:59 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id d8sm9939596edy.83.2021.04.08.06.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 06:25:58 -0700 (PDT)
Date: Thu, 8 Apr 2021 15:26:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v1 1/2] iommu/tegra-smmu: Defer attachment of display
 clients
Message-ID: <YG8EiUXkgPTZsfIY@orome.fritz.box>
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210408094241.GA31714@Asurada-Nvidia>
MIME-Version: 1.0
In-Reply-To: <20210408094241.GA31714@Asurada-Nvidia>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, Will Deacon <will@kernel.org>
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
Content-Type: multipart/mixed; boundary="===============1746043789643863352=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1746043789643863352==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rPdv4N4OEIEY1wvJ"
Content-Disposition: inline


--rPdv4N4OEIEY1wvJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 08, 2021 at 02:42:42AM -0700, Nicolin Chen wrote:
> On Mon, Mar 29, 2021 at 02:32:55AM +0300, Dmitry Osipenko wrote:
> > All consumer-grade Android and Chromebook devices show a splash screen
> > on boot and then display is left enabled when kernel is booted. This
> > behaviour is unacceptable in a case of implicit IOMMU domains to which
> > devices are attached during kernel boot since devices, like display
> > controller, may perform DMA at that time. We can work around this probl=
em
> > by deferring the enable of SMMU translation for a specific devices,
> > like a display controller, until the first IOMMU mapping is created,
> > which works good enough in practice because by that time h/w is already
> > stopped.
> >=20
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>=20
> For both patches:
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
>=20
> The WAR looks good to me. Perhaps Thierry would give some input.
>=20
> Another topic:
> I think this may help work around the mc-errors, which we have
> been facing on Tegra210 also when we enable IOMMU_DOMAIN_DMA.
> (attached a test patch rebasing on these two)

Ugh... that's exactly what I was afraid of. Now everybody is going to
think that we can just work around this issue with driver-specific SMMU
hacks...

> However, GPU would also report errors using DMA domain:
>=20
>  nouveau 57000000.gpu: acr: firmware unavailable
>  nouveau 57000000.gpu: pmu: firmware unavailable
>  nouveau 57000000.gpu: gr: firmware unavailable
>  tegra-mc 70019000.memory-controller: gpusrd: read @0x00000000fffbe200: S=
ecurity violation (TrustZone violation)
>  nouveau 57000000.gpu: DRM: failed to create kernel channel, -22
>  tegra-mc 70019000.memory-controller: gpusrd: read @0x00000000fffad000: S=
ecurity violation (TrustZone violation)
>  nouveau 57000000.gpu: fifo: SCHED_ERROR 20 []
>  nouveau 57000000.gpu: fifo: SCHED_ERROR 20 []
>=20
> Looking at the address, seems that GPU allocated memory in 32-bit
> physical address space behind SMMU, so a violation happened after
> turning on DMA domain I guess...=20

The problem with GPU is... extra complicated. You're getting these
faults because you're enabling the IOMMU-backed DMA API, which then
causes the Nouveau driver allocate buffers using the DMA API instead of
explicitly allocating pages and then mapping them using the IOMMU API.
However, there are additional patches needed to teach Nouveau about how
to deal with SMMU and those haven't been merged yet. I've got prototypes
of this, but before the whole framebuffer carveout passing work makes
progress there's little sense in moving individual pieces forward.

One more not to try and cut corners. We know what the right solution is,
even if it takes a lot of work. I'm willing to ack this patch, or some
version of it, but only as a way of working around things we have no
realistic chance of fixing properly anymore. I still think it would be
best if we could derive identity mappings from command-line arguments on
these platforms because I think most of them will actually set that, and
then the solution becomes at least uniform at the SMMU level.

For Tegra210 I've already laid out a path to a solution that's going to
be generic and extend to Tegra186 and later as well.

Thierry

--rPdv4N4OEIEY1wvJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBvBIYACgkQ3SOs138+
s6Hezg//VHpLpwMZYFB+XfNT7BMio9KNR0anBI58Ageu8ki5TpyavNg6gIHSeYtX
27YnoTVXPfpbqB28IWKNwUpy0mQFR8qPHAoG2i558GyS66EpB0sQxbESCe5Kr9sT
qYiTWuHS64u4tSBV/snQzmC4C3QWmt7R+wkEPScIYrSfzZpcK0tlcDxRC47b29Iv
tY0dVJXGkuHpRKaSzCjA0TwUdnwbBd1QVHUVkXzjl8wBBG6IKcLfvdbUAfEZZqbT
hhcZJ+vTmJMILLg6qjwoIkM2SGDwQchXhNSnA9BST8xl5husFIewNVXjX5w4qzp+
7tUzTIUVzwP2lKou2viUhKtgv1d/4vK7m5sTqrLGbEXgDb7LxUvgO/qzYWB77Keh
qI+Zv1ePd/RVXHuuOMM6vcLvXBFN5heXtW5CvFr+uwPbdVfz6/0QTxSAYF1pew+m
3I7u5VYgQSKdZ7uekRTppUh3d/0YZspTjpjfQtCYbdE8jnyp3dDPMVJqsZ88m7Op
kWdZ6CFCcoKY7K+lhtrs1i/p3FJqlRMc+3bjfRyYsTxJu3UThMDa6mrTDwojtBq4
jlSfMKJrbwBT+ARJQQNikRm6g9aAI/Y6SlaF1GmnhCDZm9IPo3f8zr3UcgPCAHCO
eASsZZUacPziyminANJTo8m8A0k4BtaL9esNfHOG+0WyYhI9e1E=
=d+bf
-----END PGP SIGNATURE-----

--rPdv4N4OEIEY1wvJ--

--===============1746043789643863352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1746043789643863352==--
