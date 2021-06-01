Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F742C4708F
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 18:07:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67C4613AD
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 18:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67C4613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72E61607F0;
	Tue,  1 Jun 2021 18:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1KPNoznc8U8n; Tue,  1 Jun 2021 18:07:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 316D560798;
	Tue,  1 Jun 2021 18:07:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2B55C000E;
	Tue,  1 Jun 2021 18:07:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41838C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 18:07:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22C3260798
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 18:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqExoxzFRzSb for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 18:07:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EB3060794
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 18:07:07 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id b11so11717444edy.4
 for <iommu@lists.linux-foundation.org>; Tue, 01 Jun 2021 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Esv6sX04kKkiDuWbC2+d4pQCUltl4LpO+bkOs8CbqkQ=;
 b=hgbApr657+Etn04lQeL3PNx7z27hnAxYFfysC2JIcHd96N8DCGSMtdC15JVH+B0EOm
 AAWw2SYhANXTkueFfQvhwhUrE2QfVnN2EZ90Ve5FixmcIxO5zSbgr0tDXyW/WIR2x4ak
 uBZ0clOaUIwi4fozG+tz9/pVITBkaNEZJmtDyr9hSoMCd9B81ikIfw7E2BYCB8zDj+V4
 1kL6+ZImodbC1yXUIIEI2b+h20uoZI4Vo3VqRgaJ1e3M1217xKKeg5a3AMj5yaFHGk11
 kF9W8ndt53yww8CuPBu8pPDcwum92ZxNsn+cgLwjf0Zcd5768hP9c0gHCzOvsg2nuQvh
 YPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Esv6sX04kKkiDuWbC2+d4pQCUltl4LpO+bkOs8CbqkQ=;
 b=snfZ2hKsPQswEOYqw4IDZlEf5/x/SBdVLTtzWSxbPwKberueKnZHDOYcl4fUHsLAm8
 M80MdHEGqd8H3cTprevuALXbxi9W2uQXZNvY6MO3i9HndeR5T9+RRS7JYrhUz7GoHaHw
 /CdqbTPHPsqnxkEuJImGZrlwIOe9CADtv3Pg7go4y4beuS4Gpsxum2bWPeZQL518VcoP
 wHNtcf+FKFzKql8Zq9Qq3BNTQIr9psBisgUD6WAjqBrLN4d8qQGcSsihJSXhYX5N5C16
 pPQ+gL7IcpJzBMeRWht2e2pPX3SWfNflhSwxNP5XtSRmrCYZZbzO2lj09qn3siKBEA+f
 R5ig==
X-Gm-Message-State: AOAM531V2y/TBvhTiaVwFOySxEKlmIGF8zOhXSSZjk3TSQTrr9r+lwqp
 SXx65gqzFQuyJcCXHHwoK0JLVMQMxow=
X-Google-Smtp-Source: ABdhPJzCVy7fQlPo5/PSmFNwwyl6CDprhSMUmZ6ZjTAZw7Z9VW6cdy5KZEidZf3eNxY8Kg9tm78RUw==
X-Received: by 2002:a50:a446:: with SMTP id v6mr34495436edb.254.1622570826320; 
 Tue, 01 Jun 2021 11:07:06 -0700 (PDT)
Received: from localhost (pd9e51d70.dip0.t-ipconnect.de. [217.229.29.112])
 by smtp.gmail.com with ESMTPSA id u12sm4546514ejz.1.2021.06.01.11.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 11:07:04 -0700 (PDT)
Date: Tue, 1 Jun 2021 20:08:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 00/10] arm64: tegra: Prevent early SMMU faults
Message-ID: <YLZ3qPC8ofjsGkPi@orome.fritz.box>
References: <20210420172619.3782831-1-thierry.reding@gmail.com>
 <YLEi2FonP568wYrE@orome.fritz.box>
 <20210601122646.GB27832@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20210601122646.GB27832@willie-the-truck>
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
Content-Type: multipart/mixed; boundary="===============4370867798779650091=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4370867798779650091==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MH/G2v7nzEjSLE2F"
Content-Disposition: inline


--MH/G2v7nzEjSLE2F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 01:26:46PM +0100, Will Deacon wrote:
> On Fri, May 28, 2021 at 07:05:28PM +0200, Thierry Reding wrote:
> > On Tue, Apr 20, 2021 at 07:26:09PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > Hi,
> > >=20
> > > this is a set of patches that is the result of earlier discussions
> > > regarding early identity mappings that are needed to avoid SMMU faults
> > > during early boot.
> > >=20
> > > The goal here is to avoid early identity mappings altogether and inst=
ead
> > > postpone the need for the identity mappings to when devices are attac=
hed
> > > to the SMMU. This works by making the SMMU driver coordinate with the
> > > memory controller driver on when to start enforcing SMMU translations.
> > > This makes Tegra behave in a more standard way and pushes the code to
> > > deal with the Tegra-specific programming into the NVIDIA SMMU
> > > implementation.
> > >=20
> > > Compared to the original version of these patches, I've split the
> > > preparatory work into a separate patch series because it became very
> > > large and will be mostly uninteresting for this audience.
> > >=20
> > > Patch 1 provides a mechanism to program SID overrides at runtime. Pat=
ch
> > > 2 updates the ARM SMMU device tree bindings to include the Tegra186
> > > compatible string as suggested by Robin during review.
> > >=20
> > > Patches 3 and 4 create the fundamentals in the SMMU driver to support
> > > this and also make this functionality available on Tegra186. Patch 5
> > > hooks the ARM SMMU up to the memory controller so that the memory cli=
ent
> > > stream ID overrides can be programmed at the right time.
> > >=20
> > > Patch 6 extends this mechanism to Tegra186 and patches 7-9 enable all=
 of
> > > this through device tree updates. Patch 10 is included here to show h=
ow
> > > SMMU will be enabled for display controllers. However, it cannot be
> > > applied yet because the code to create identity mappings for potentia=
lly
> > > live framebuffers hasn't been merged yet.
> > >=20
> > > The end result is that various peripherals will have SMMU enabled, wh=
ile
> > > the display controllers will keep using passthrough, as initially set=
 up
> > > by firmware. Once the device tree bindings have been accepted and the
> > > SMMU driver has been updated to create identity mappings for the disp=
lay
> > > controllers, they can be hooked up to the SMMU and the code in this
> > > series will automatically program the SID overrides to enable SMMU
> > > translations at the right time.
> > >=20
> > > Note that the series creates a compile time dependency between the
> > > memory controller and IOMMU trees. If it helps I can provide a branch
> > > for each tree, modelling the dependency, once the series has been
> > > reviewed.
> > >=20
> > > Changes in v2:
> > > - split off the preparatory work into a separate series (that needs to
> > >   be applied first)
> > > - address review comments by Robin
> > >=20
> > > Thierry
> > >=20
> > > Thierry Reding (10):
> > >   memory: tegra: Implement SID override programming
> > >   dt-bindings: arm-smmu: Add Tegra186 compatible string
> > >   iommu/arm-smmu: Implement ->probe_finalize()
> > >   iommu/arm-smmu: tegra: Detect number of instances at runtime
> > >   iommu/arm-smmu: tegra: Implement SID override programming
> > >   iommu/arm-smmu: Use Tegra implementation on Tegra186
> > >   arm64: tegra: Use correct compatible string for Tegra186 SMMU
> > >   arm64: tegra: Hook up memory controller to SMMU on Tegra186
> > >   arm64: tegra: Enable SMMU support on Tegra194
> > >   arm64: tegra: Enable SMMU support for display on Tegra194
> > >=20
> > >  .../devicetree/bindings/iommu/arm,smmu.yaml   |  11 +-
> > >  arch/arm64/boot/dts/nvidia/tegra186.dtsi      |   4 +-
> > >  arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 166 ++++++++++++++++=
++
> > >  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   3 +-
> > >  drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c  |  90 ++++++++--
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.c         |  13 ++
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.h         |   1 +
> > >  drivers/memory/tegra/mc.c                     |   9 +
> > >  drivers/memory/tegra/tegra186.c               |  72 ++++++++
> > >  include/soc/tegra/mc.h                        |   3 +
> > >  10 files changed, 349 insertions(+), 23 deletions(-)
> >=20
> > Will, Robin,
> >=20
> > do you have any more comments on the ARM SMMU bits of this series? If
> > not, can you guys provide an Acked-by so that Krzysztof can pick this
> > (modulo the DT patches) up into the memory-controller tree for v5.14?
> >=20
> > I'll send out a v3 with the bisectibilitiy fix that Krishna pointed
> > out.
>=20
> Probably best if I queue 3-6 on a separate branch once you send a v3,
> then Krzysztof can pull that in if he needs it.

Patch 5 has a build-time dependency on patch 1, so they need to go in
together. The reason why I suggested Krzysztof pick these up is because
there is a restructuring series that this depends on, which will go into
Krzysztof's tree. So in order to pull in 3-6, you'd get a bunch of other
and mostly unrelated stuff as well.

Alternatively I can set this all up on stable branches and send out pull
requests for both you and Krzysztof to merge. Or if this is all too
complicated and you'd just prefer to ack the patches I could also take
this through ARM SoC via the Tegra tree.

Thierry

--MH/G2v7nzEjSLE2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC2d6gACgkQ3SOs138+
s6HdFg//RxQga1zW8VQK5x6lzg4jAMYo+qgonVGZsS8QQSzQZLpuYufhLDfg7XFX
Gi4SlRKn6VNFps03lr299e1HCSb5+48cp54lViMaqCj1dJlK4g6KDbLLE5dGRHrE
PepcIZw1xZwMpSueqm422ZVBVD+FOqUOHZoNkAZ7rPeHYnvClP2HfmfgAj5mzdCg
1LNKKOYl/nM2B6zRjtfTSJZC+5tGBumA+F0+1b9R7iee0ya+8QUmFQIrgP25Lywt
bX/+DI62oxsu6TXfnZags0sBK5LTb6ZmRiWz+5wHDebQGqXR17919OO/i0xZxrQU
hyVqOUrzbCVG+BmTNJAN9RlP6H/06BSL81N0LQ5veM6FgCULRRYLxOqbpBkmLotc
LFAQ03ziXKxqhN3E4uL5M1qNWz9PWBS4p4gH35xExbmvSb1wdKI87gJNEnShXTyM
qRtE2J8DpbjDYrqaJza/bVVouXc3zkc4UdctHj6vtFOqH49WKd9LfB87XJS0jZ4/
QJabr5f0DRnJlHNkawBnl34DvhRIRGxRl98YbhYbGBYbPUK3niL/5+Rp48KW9UxI
Gpd/SLBKqUlBmKBtRNKhTWRhLq3yM/GJsjCfLU/nIMyJkhcYM4x9i3lL5dU+loao
mhXpt0qdbbScggGqmFD3I3Tl6uulZdr9dOXSpNEkKMPvFk2y9Is=
=UPdE
-----END PGP SIGNATURE-----

--MH/G2v7nzEjSLE2F--

--===============4370867798779650091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4370867798779650091==--
