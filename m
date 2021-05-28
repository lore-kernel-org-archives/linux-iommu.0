Return-Path: <SRS0=hOEw=KX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3205BC2B9F7
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 16:53:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B2A613E5
	for <iommu@archiver.kernel.org>; Fri, 28 May 2021 16:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B2A613E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8259A4045F;
	Fri, 28 May 2021 16:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bXpR2ACgqGIl; Fri, 28 May 2021 16:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13A4340ED5;
	Fri, 28 May 2021 16:53:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4CD7C000E;
	Fri, 28 May 2021 16:53:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D556C0001
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 16:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 19349400AE
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 16:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NzDwcqCeI6ba for <iommu@lists.linux-foundation.org>;
 Fri, 28 May 2021 16:53:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF98B40579
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 16:53:26 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id s22so6291584ejv.12
 for <iommu@lists.linux-foundation.org>; Fri, 28 May 2021 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8/Q1T7/H3Ga42CpeeXwBtnXyWFCr/Nsv9NyGJyZCOVw=;
 b=EMVcyf6Vgozn5JaYJzcv45C5rVttjwZhqro7BUHd7I3jakgKq8Pbk7u9QzQGlo5MAD
 Dk2qFwXmHzAWKZpmpX8mTMlTgCUh5e8M0Nk7GJL8ar5Ok2CraN8y81cNbPrE2vGRTbrH
 KGHuKPgYre/zEvkyFVKxIXf5edK1SPiaq04y/2nS3EQKznllAGzpPmcaJaxJJTYueipU
 s7oNVNfnGFb2EZQOoWBsiAbTLe+413OVfW/uCjolzRCxjaXXncFbnhT6agwrdh/HKtWJ
 qicDai95PQu5/TK8Fx3dccPsg+kEPUX4nY2Ipb+N8VYr0SkT92c0IlyFSA0E9A8g6kRB
 fcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8/Q1T7/H3Ga42CpeeXwBtnXyWFCr/Nsv9NyGJyZCOVw=;
 b=ErHeIv+PQkJ7audnwCIZNRCzDTvuaGvR8B1H5hCK/hmk3NGUuKJ3eQc9gDGxKBLLOz
 9WudxTZvBY0TH9K/qCKsYq7VfnWETtT0nJIf1zj6HCBKWR7gtVpjaUCakPi0Dqa/0QDd
 U63sFtMexaSdCXW5UkjehruD1t1Rhbvxl+OZfAVsfi5XBzqNjmfDDXjYpNLcf2nszORU
 YUnZheD55u2wi89xh05u8PODgdkP1znRu9Wq7L5hzpVs1e3uVI0C0GdT3UVD0PzvaDpr
 TFfY5WcD/+pNoSAbnBqIVhQ9ALHy+inkooVDflRHFaBmer9sRt82zmbsx53tDvMcmIhW
 uoXw==
X-Gm-Message-State: AOAM533KFIREkXgzhfrieRGobDIC8uKkNiipM7RNX6H1nPkqsUvJNU5y
 vZx5tJJrX5+kF3fj5vSG2jk=
X-Google-Smtp-Source: ABdhPJw+KFj6oh+Lnn+VyF4bZ3YYAp39NuBtIqWCrkvnE4kOjTZxgBquKlUXFUfzQ3Ajk/jPxTuIHQ==
X-Received: by 2002:a17:906:6dd0:: with SMTP id
 j16mr10062452ejt.208.1622220804798; 
 Fri, 28 May 2021 09:53:24 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id l11sm2600520ejd.103.2021.05.28.09.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 May 2021 09:53:23 -0700 (PDT)
Date: Fri, 28 May 2021 18:54:55 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: reserved-memory: Document memory
 region specifier
Message-ID: <YLEgXyLBF8PEFNw2@orome.fritz.box>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-2-thierry.reding@gmail.com>
 <20210520220306.GA1976116@robh.at.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210520220306.GA1976116@robh.at.kernel.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============9185352624474858027=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============9185352624474858027==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q8VGTr6iP6guEeJM"
Content-Disposition: inline


--Q8VGTr6iP6guEeJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 05:03:06PM -0500, Rob Herring wrote:
> On Fri, Apr 23, 2021 at 06:32:30PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Reserved memory region phandle references can be accompanied by a
> > specifier that provides additional information about how that specific
> > reference should be treated.
> >=20
> > One use-case is to mark a memory region as needing an identity mapping
> > in the system's IOMMU for the device that references the region. This is
> > needed for example when the bootloader has set up hardware (such as a
> > display controller) to actively access a memory region (e.g. a boot
> > splash screen framebuffer) during boot. The operating system can use the
> > identity mapping flag from the specifier to make sure an IOMMU identity
> > mapping is set up for the framebuffer before IOMMU translations are
> > enabled for the display controller.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../reserved-memory/reserved-memory.txt       | 21 +++++++++++++++++++
> >  include/dt-bindings/reserved-memory.h         |  8 +++++++
> >  2 files changed, 29 insertions(+)
> >  create mode 100644 include/dt-bindings/reserved-memory.h
>=20
> Sorry for being slow on this. I have 2 concerns.
>=20
> First, this creates an ABI issue. A DT with cells in 'memory-region'=20
> will not be understood by an existing OS. I'm less concerned about this=
=20
> if we address that with a stable fix. (Though I'm pretty sure we've=20
> naively added #?-cells in the past ignoring this issue.)

A while ago I had proposed adding memory-region*s* as an alternative
name for memory-region to make the naming more consistent with other
types of properties (think clocks, resets, gpios, ...). If we added
that, we could easily differentiate between the "legacy" cases where
no #memory-region-cells was allowed and the new cases where it was.

> Second, it could be the bootloader setting up the reserved region. If a=
=20
> node already has 'memory-region', then adding more regions is more=20
> complicated compared to adding new properties. And defining what each=20
> memory-region entry is or how many in schemas is impossible.

It's true that updating the property gets a bit complicated, but it's
not exactly rocket science. We really just need to splice the array. I
have a working implemention for this in U-Boot.

For what it's worth, we could run into the same issue with any new
property that we add. Even if we renamed this to iommu-memory-region,
it's still possible that a bootloader may have to update this property
if it already exists (it could be hard-coded in DT, or it could have
been added by some earlier bootloader or firmware).

> Both could be addressed with a new property. Perhaps something like=20
> 'iommu-memory-region =3D <&phandle>;'. I think the 'iommu' prefix is=20
> appropriate given this is entirely because of the IOMMU being in the=20
> mix. I might feel differently if we had other uses for cells, but I=20
> don't really see it in this case.=20

I'm afraid that down the road we'll end up with other cases and then we
might proliferate a number of *-memory-region properties with varying
prefixes.

I am aware of one other case where we might need something like this: on
some Tegra SoCs we have audio processors that will access memory buffers
using a DMA engine. These processors are booted from early firmware
using firmware from system memory. In order to avoid trashing the
firmware, we need to reserve memory. We can do this using reserved
memory nodes. However, the audio DMA engine also uses the SMMU, so we
need to make sure that the firmware memory is marked as reserved within
the SMMU. This is similar to the identity mapping case, but not exactly
the same. Instead of creating a 1:1 mapping, we just want that IOVA
region to be reserved (i.e. IOMMU_RESV_RESERVED instead of
IOMMU_RESV_DIRECT{,_RELAXABLE}).

That would also fall into the IOMMU domain, but we can't reuse the
iommu-memory-region property for that because then we don't have enough
information to decide which type of reservation we need.

We could obviously make iommu-memory-region take a specifier, but we
could just as well use memory-regions in that case since we have
something more generic anyway.

With the #memory-region-cells proposal, we can easily extend the cell in
the specifier with an additional MEMORY_REGION_IOMMU_RESERVE flag to
take that other use case into account. If we than also change to the new
memory-regions property name, we avoid the ABI issue (and we gain a bit
of consistency while at it).

Thierry

--Q8VGTr6iP6guEeJM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmCxIF0ACgkQ3SOs138+
s6GgVBAAvM4rKjwwQlq4GSoJz946gpHZ/v8WPH/wvUQcsnFUrNIGJsLNItv+oeNC
WSP4nCxc4cEhpi0Jl9MUM24e0I9BM1eL5x9t86XdssjF8ElmHeO6uUPL3zKUmhrv
C94rix/U5H4oDUANv22Fi2GCVAMLjnCRAgz0jOzAmpRnR8CfpGhC8HD9+vsIOuyl
jr0zb5JdJQntp9KfagD2sxrrMp3bkb3AURhgxvMzu+jMgsjAsg65LxZkrmwfLUOg
Dt8LDNcbx42zE3ioF+F+fT7mHRfMPsxyAM9dYtFbjeGr4/+vdwEIuySRXW4lY9+U
j1Lc/M5Fperag6as/U7dGSNutUBzWRJTKe9AmCgJ4+O0Z3GZJCl1ziuUjI7WmMxv
6E2s5Mg0CImYe4rMFVy065os+saYdiLy4xJy2sjnt71qsa0GMzJ0k8H07E9RYQ9g
l4RRkfj21qt/PuMAh9TuFewQIJxgVHUmOWFQ/qATYqTGKAmXriVBolY7wO/KuwTe
zgo8dShCCO92KASb9NFZEqCg9Igi5c+5hzU5oi3tXKG54uCfWnhNn/HVN1viCbzi
jr1cm5Bn/kj1id1xeHdPKPCIONcDEQYv/slUpRsMo3hTQzgpkxKP5OH7CbAxLo3Y
/RPDyN8wSreHg3SM97nqYGade6GOZVug0oFC5RoL4oQaU02immw=
=1rTq
-----END PGP SIGNATURE-----

--Q8VGTr6iP6guEeJM--

--===============9185352624474858027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9185352624474858027==--
