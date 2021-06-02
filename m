Return-Path: <SRS0=kThj=K4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D407C47083
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 14:57:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF3F613BF
	for <iommu@archiver.kernel.org>; Wed,  2 Jun 2021 14:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF3F613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9BBFA404B0;
	Wed,  2 Jun 2021 14:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTaMn8beOx_t; Wed,  2 Jun 2021 14:57:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49ED3404B5;
	Wed,  2 Jun 2021 14:57:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 233D5C000E;
	Wed,  2 Jun 2021 14:57:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5FD8C0001
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5200401F1
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z2EPslGuM0WY for <iommu@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 14:56:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A295F40188
 for <iommu@lists.linux-foundation.org>; Wed,  2 Jun 2021 14:56:56 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id qq22so4273594ejb.9
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9RLU/826fL0tWIk2PrvJDBE7HJXooGGXs9jpMJCjFmk=;
 b=QAnEBPM0bz46mcSUJMsqPwBeBOS6PzdZ3pO2u+CwmZ5N8gyzfkZoGFTknvwVHDvBRn
 fm5DhLt+LvRJmnPK5wyy+BRzxTWm2rVKPg6YBzKd9QWjPbLXroSCUe6zwIx7NU8Q2O3S
 Z5AJH/z1h2RWrvub9IblT3h7/oyqwxXjdJfwEgHA9D6KbzYsk/pJfFYwsxcPZ+T+DJl5
 sQ7PFLl9g0moUcxFEBOo5aMS7n+iJMVTklvREVzLi4zSRAVye/RV8nq1F8RkXMgBb5Jm
 ZOu6m5yMM2Oabson/PLKtvOwyLaKIqzMif6UlBpcA9swXxF1VJHHJb8tLqY6NNdZCTcc
 85MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9RLU/826fL0tWIk2PrvJDBE7HJXooGGXs9jpMJCjFmk=;
 b=S9MT35zD0bnzJZAPVHxkR1kTO0eLBB5CydQ8QjrqFOya/VkYUE98+2P2x4ioEXmhZ+
 BNugXGclXC2FHpmbjABqTLdOUI2LupaO2wtdqzWqgeh1AlWeH/E7bv64blxHu23GdkDv
 QVYjuOmu4cs8D8hQYCaP8iHXDkd//AUrybtmons5M9/a2toEQiQQRLQcxbUO0X6SRrwl
 9pCnPFocuUvzzcvnYL8E+pRUUQ/qOcvrxy2ClWNbCBZxU+C1stu/q9Y9X4CrlMkdr0UV
 rkJYvZ1D2Jc0aFZGPOKruMkwnxXhYWx/KsvfQAHLggpFKlPKIwH9X/OHfjORiJWujl7D
 kWtw==
X-Gm-Message-State: AOAM533cCCz++31KZg4Cru6QWuPfNphOJuAaSmLGIgaZj42dmlmyTL+0
 Cq/aYicBIN2TvVa28r8dOMM=
X-Google-Smtp-Source: ABdhPJxcl5AxBDibOdNUu+8zMhKTO7KIau9/v+b2PNTkAe8Cqa/TRnHv5OrqQdQzkXZ12hw5MhrRfA==
X-Received: by 2002:a17:906:5299:: with SMTP id
 c25mr19095821ejm.85.1622645814812; 
 Wed, 02 Jun 2021 07:56:54 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id dk12sm131166ejb.84.2021.06.02.07.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 07:56:53 -0700 (PDT)
Date: Wed, 2 Jun 2021 16:58:29 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
Message-ID: <YLeclZlP8l3dMX4o@orome.fritz.box>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box>
 <20210601122646.GB27832@willie-the-truck>
 <YLZ3qPC8ofjsGkPi@orome.fritz.box>
 <6826d892-d1ac-e3b1-ebee-68392d11d7c5@canonical.com>
 <8c70f82f-0db9-2312-7fc4-c079899c25a0@canonical.com>
 <YLdGwD0dxfER4USn@orome.fritz.box>
 <e2341ca1-7b6d-cc19-8c43-1ada0b1f5601@canonical.com>
 <20210602114049.GF30593@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20210602114049.GF30593@willie-the-truck>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>,
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
Content-Type: multipart/mixed; boundary="===============7919919312694035266=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7919919312694035266==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NklhWG4Eau+rgwxG"
Content-Disposition: inline


--NklhWG4Eau+rgwxG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 12:40:49PM +0100, Will Deacon wrote:
> On Wed, Jun 02, 2021 at 12:44:58PM +0200, Krzysztof Kozlowski wrote:
> > On 02/06/2021 10:52, Thierry Reding wrote:
> > > On Wed, Jun 02, 2021 at 09:35:13AM +0200, Krzysztof Kozlowski wrote:
> > >> On 02/06/2021 09:33, Krzysztof Kozlowski wrote:
> > >>> On 01/06/2021 20:08, Thierry Reding wrote:
> > >>>> On Tue, Jun 01, 2021 at 01:26:46PM +0100, Will Deacon wrote:
> > >>>>> On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
> > >>>>>> On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
> > >>>>>>> From: Thierry Reding <treding@nvidia.com>
> > >>>>>>>
> > >>>>> Probably best if I queue 3-6 on a separate branch once you send a=
 v3,
> > >>>>> then Krzysztof can pull that in if he needs it.
> > >>>>
> > >>>> Patch 5 has a build-time dependency on patch 1, so they need to go=
 in
> > >>>> together. The reason why I suggested Krzysztof pick these up is be=
cause
> > >>>> there is a restructuring series that this depends on, which will g=
o into
> > >>>> Krzysztof's tree. So in order to pull in 3-6, you'd get a bunch of=
 other
> > >>>> and mostly unrelated stuff as well.
> > >>>
> > >>> I missed that part... what other series are needed for this one? Ex=
cept
> > >>> Dmitry's power management set I do not have anything in my sight for
> > >>> Tegras memory controllers.
> > >>>
> > >>> Anyway, I can take the memory bits and provide a stable tag with th=
ese.
> > >>> Recently there was quite a lot work around Tegra memory controllers=
, so
> > >>> this makes especially sense if new patches appear.
> > >>
> > >> OK, I think I have now the patchset you talked about - "memory: tegr=
a:
> > >> Driver unification" v2, right?
> > >=20
> > > Yes, that's the one. That series is fairly self-contained, but Dmitry=
's
> > > power management set has dependencies that pull in the regulator, clo=
ck
> > > and ARM SoC trees.
> > >=20
> > > I did a test merge of the driver unification series with a branch that
> > > has Dmitry's patches and all the dependencies and there are no confli=
cts
> > > so that, fortunately, doesn't further complicates things.
> > >=20
> > > Do you want me to send you a pull request with Dmitry's memory
> > > controller changes? You could then apply the unification series on to=
p,
> > > which should allow this SMMU series to apply cleanly on top of that.
> >=20
> > Makes sense and it looks quite bulletproof for future changes. Let's do
> > like this. I will apply your patch 1/10 from this v2 on top of it and
> > driver unification later.
>=20
> Okey doke. Thierry -- please let me know which patches I can queue. Having
> the SMMU driver changes in the IOMMU tree really helps in case of conflic=
ts
> with other SMMU changes. As I say, I can put stuff on a separate branch f=
or
> you if it helps.

Given that the SMMU patches have a build-time dependency on the first
patch in the series, and the series depends on the unification series, I
think Krzysztof would have to pull the memory controller branch that I
have with Dmitry's work, apply the unification series on top and then
take patch 1 of this series on top of that. That's the state that you'd
have to pull into the SMMU tree to get the right dependencies.

The SMMU pieces are the leaf of the dependency tree, so technically no
separate branch is needed, because I don't think anybody would have to
pull from it. However, a separate branch might make it easier to back
any of this work out if we have to.

Krzysztof, I do plan on sending out a v3 of the unification series to
address the two cleanups that Dmitry and you have pointed out. After
that I can send out v3 of this series to fix the ordering issue that
Krishna had mentioned. After all of those are applied, would you be able
to provide a stable branch for Will's SMMU tree?

Thierry

--NklhWG4Eau+rgwxG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC3nJUACgkQ3SOs138+
s6G5qRAAi9IkZoO8OpHp1SldqyZjWSfQI0mnh9AhIX/kBkbvi378AFhSPNoAH3rG
pZINISZZIP7WlB/dkV/YQKTiveEHfBgHPxF/i2/ES9SIah6o2BJMKUh7AdpgB+Nk
oEv3BTH4z12idTkydBdAdzX21I1O41noQnFdNYxhfiO0q5zCSjP+SNaW5CL0H9tW
VqO3O2nGETEHymcw/2u1oLNHld0ALPUwSiVzB6x32TlTNnusFrgU2SH/ymLeDLgA
AJ4atRdjjQZPabBymAfzbL6tGSshV7d6Vb7qI6pcEzqEXmgPtcB+CKo8uoSpue6n
zg3WwdBMtjc4AKSnEQ82kHafaUdW0Cjz0Xp6jeIFJmSYYPNQCF0W3j9sQcQIOQ6e
/RHB8OGhardOiwZ1QbEz+eQDc1umCPExfm8WCtFi7DxA6mIOkrb2at/fSVVCWbG8
a9MxLd68bpPuhCWxzgMdjyW3rmCl8S7xLRc0FwjDoxZ2n0XURAwqwWwsIwrUMeUA
OsvMv+Tq4vmFMV6MEc0kxEnzNsUTXoVL1uPTkwDsxfitb1CqgOxQbnZwOESPhO80
0rIIAfqoI5QWjiNrNePwlBnwrmZNhTF57wMWm4ELR5bG5CeIYXKCUF2Qf+hjHYEP
B7GMc1oAkKi978C8VU2hhyIjypSEhqBJRejaIitADr3UdxctPF4=
=R26M
-----END PGP SIGNATURE-----

--NklhWG4Eau+rgwxG--

--===============7919919312694035266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7919919312694035266==--
