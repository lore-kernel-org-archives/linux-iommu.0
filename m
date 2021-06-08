Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7335C4743D
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 16:50:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6924960FDB
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 16:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6924960FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F5594044C;
	Tue,  8 Jun 2021 16:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wu4RORwinJ9n; Tue,  8 Jun 2021 16:50:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFD0840476;
	Tue,  8 Jun 2021 16:50:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEC9AC000D;
	Tue,  8 Jun 2021 16:50:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 487DBC0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 16:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4058940443
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 16:50:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A3tlBFHEdS5i for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 16:50:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0FE3402C9
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 16:50:02 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id r9so5629649wrz.10
 for <iommu@lists.linux-foundation.org>; Tue, 08 Jun 2021 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=emhG+KU668RyKaTDpkYn9+UEVsu8HBt2BbT4L0AqGFM=;
 b=Arq6evDAJO9682NNCbJGOmS/Ix2R11ay0Oha8yWtOkt2njWw30QyG7hMsYpskboiwb
 n843tfuextglmK/eV6TsUipPM/LucqGBIYstF52djN51ncuXyKdxomAbueFkZ6Mwx8/r
 ly041H90n6/kAhrP/ctWBTVaiatv8oBfxwsjJPFlNWypNLddXhq79kgAneUqOPsJxBQ9
 X4GzommSQvu/DWFmceOWTCBnqiPqA0zKLFcaAMvwR7DggSTmPiR+28olcQ3CoRl93X7m
 CRhqQ3pkPv+wX9mTQvoqLTpC5+Fn9fS+KLeSfQAovNWbsYnCESjySrfA82nOYLRRUc/N
 U5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=emhG+KU668RyKaTDpkYn9+UEVsu8HBt2BbT4L0AqGFM=;
 b=RhlfBZkHg3/lga2VdUmB2KLPnNUPRDbxaQcfsWQDT2K9WJIFgT1pZ/3apmRS4IUh0Q
 xhCrTWh+ET3U8J8WRPvnHl7C5Emu9S/B2BwjoKh/Kr03Ur48jY1F/j5OCeHxqDQ2aVgn
 2iLUPaDiMMCv6L+DhGhSTDNm4jtl7rH85qnoqfI4cjjnuIjzCnLOqFuMwJjKyxryht6V
 1ApT9594tNIbChu252JyarA/HO0GWLpabJ20uK109gHb4wYt9R42gE0KCYey6a6eqqvJ
 AFnMXOVdEuBySiDxF0qgmnSAmGyXyFmM9Te3EQZn4PI2275uawhR6rRkJL2FsfpXla1k
 QWdg==
X-Gm-Message-State: AOAM530b2gnYfbGZdF8cKHCpfKPvz1+f0eYWrNIJkEAIg5n8X4nmhWOj
 FldANhgYn/pl89wg/XoLyvA=
X-Google-Smtp-Source: ABdhPJxtr+cKgjMGW7wuMWfL7IB+s8uOOwE9Y9v6rnisU/GUY6hLtVq2wMy9NKzXGakcQAUNvo7Wow==
X-Received: by 2002:adf:b648:: with SMTP id i8mr17318780wre.425.1623171000932; 
 Tue, 08 Jun 2021 09:50:00 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id j131sm3662366wma.40.2021.06.08.09.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jun 2021 09:49:58 -0700 (PDT)
Date: Tue, 8 Jun 2021 18:51:40 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: reserved-memory: Document memory
 region specifier
Message-ID: <YL+gHN4YZ4vt1vPk@orome.fritz.box>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-2-thierry.reding@gmail.com>
 <20210520220306.GA1976116@robh.at.kernel.org>
 <YLEgXyLBF8PEFNw2@orome.fritz.box>
MIME-Version: 1.0
In-Reply-To: <YLEgXyLBF8PEFNw2@orome.fritz.box>
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
Content-Type: multipart/mixed; boundary="===============4447180749180245996=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4447180749180245996==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qFncihfL+fqzgudb"
Content-Disposition: inline


--qFncihfL+fqzgudb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 28, 2021 at 06:54:55PM +0200, Thierry Reding wrote:
> On Thu, May 20, 2021 at 05:03:06PM -0500, Rob Herring wrote:
> > On Fri, Apr 23, 2021 at 06:32:30PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > Reserved memory region phandle references can be accompanied by a
> > > specifier that provides additional information about how that specific
> > > reference should be treated.
> > >=20
> > > One use-case is to mark a memory region as needing an identity mapping
> > > in the system's IOMMU for the device that references the region. This=
 is
> > > needed for example when the bootloader has set up hardware (such as a
> > > display controller) to actively access a memory region (e.g. a boot
> > > splash screen framebuffer) during boot. The operating system can use =
the
> > > identity mapping flag from the specifier to make sure an IOMMU identi=
ty
> > > mapping is set up for the framebuffer before IOMMU translations are
> > > enabled for the display controller.
> > >=20
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  .../reserved-memory/reserved-memory.txt       | 21 +++++++++++++++++=
++
> > >  include/dt-bindings/reserved-memory.h         |  8 +++++++
> > >  2 files changed, 29 insertions(+)
> > >  create mode 100644 include/dt-bindings/reserved-memory.h
> >=20
> > Sorry for being slow on this. I have 2 concerns.
> >=20
> > First, this creates an ABI issue. A DT with cells in 'memory-region'=20
> > will not be understood by an existing OS. I'm less concerned about this=
=20
> > if we address that with a stable fix. (Though I'm pretty sure we've=20
> > naively added #?-cells in the past ignoring this issue.)
>=20
> A while ago I had proposed adding memory-region*s* as an alternative
> name for memory-region to make the naming more consistent with other
> types of properties (think clocks, resets, gpios, ...). If we added
> that, we could easily differentiate between the "legacy" cases where
> no #memory-region-cells was allowed and the new cases where it was.
>=20
> > Second, it could be the bootloader setting up the reserved region. If a=
=20
> > node already has 'memory-region', then adding more regions is more=20
> > complicated compared to adding new properties. And defining what each=
=20
> > memory-region entry is or how many in schemas is impossible.
>=20
> It's true that updating the property gets a bit complicated, but it's
> not exactly rocket science. We really just need to splice the array. I
> have a working implemention for this in U-Boot.
>=20
> For what it's worth, we could run into the same issue with any new
> property that we add. Even if we renamed this to iommu-memory-region,
> it's still possible that a bootloader may have to update this property
> if it already exists (it could be hard-coded in DT, or it could have
> been added by some earlier bootloader or firmware).
>=20
> > Both could be addressed with a new property. Perhaps something like=20
> > 'iommu-memory-region =3D <&phandle>;'. I think the 'iommu' prefix is=20
> > appropriate given this is entirely because of the IOMMU being in the=20
> > mix. I might feel differently if we had other uses for cells, but I=20
> > don't really see it in this case.=20
>=20
> I'm afraid that down the road we'll end up with other cases and then we
> might proliferate a number of *-memory-region properties with varying
> prefixes.
>=20
> I am aware of one other case where we might need something like this: on
> some Tegra SoCs we have audio processors that will access memory buffers
> using a DMA engine. These processors are booted from early firmware
> using firmware from system memory. In order to avoid trashing the
> firmware, we need to reserve memory. We can do this using reserved
> memory nodes. However, the audio DMA engine also uses the SMMU, so we
> need to make sure that the firmware memory is marked as reserved within
> the SMMU. This is similar to the identity mapping case, but not exactly
> the same. Instead of creating a 1:1 mapping, we just want that IOVA
> region to be reserved (i.e. IOMMU_RESV_RESERVED instead of
> IOMMU_RESV_DIRECT{,_RELAXABLE}).
>=20
> That would also fall into the IOMMU domain, but we can't reuse the
> iommu-memory-region property for that because then we don't have enough
> information to decide which type of reservation we need.
>=20
> We could obviously make iommu-memory-region take a specifier, but we
> could just as well use memory-regions in that case since we have
> something more generic anyway.
>=20
> With the #memory-region-cells proposal, we can easily extend the cell in
> the specifier with an additional MEMORY_REGION_IOMMU_RESERVE flag to
> take that other use case into account. If we than also change to the new
> memory-regions property name, we avoid the ABI issue (and we gain a bit
> of consistency while at it).

Ping? Rob, do you want me to add this second use-case to the patch
series to make it more obvious that this isn't just a one-off thing? Or
how do we proceed?

Thierry

--qFncihfL+fqzgudb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC/oBoACgkQ3SOs138+
s6ET+w/+PTiRwPNOOI1EJ4lo0IREpJKktlixBTlvZVIqbSpSvkRiQiWuFTKu0+dC
hVF6S+J80UhmpLdqLjveObZPS+5KcjtVDdbsqQ80Z+SQUkLv/k9NkKlZ/cBhZqZf
ILKP0hhyPwOXy4KbkYQ48lcE3g+ItIUb7zhAUqpMreNHrer3mm7SJsJWgjBXn84r
y9C17Wvs6XrFG3K0mtYk/CUrW8RjDgLElxE6DCMijGRscU3P32jMvFI7Q1jPmg8a
H+4ooQ/oo4oQ9A6rkbdWShcrJezQC6tgVtQWhfVP0fTHyfIh7+tj+fBcTQc+3qZa
BEDNE5qbF7pkXsmda1a35oP0OKk5a62l8nH6c/3QefMQIcSae26Xb3Zn6fCGEmsX
Xn+NO2DdcifutTCZI/ArS9OafCkGOpunBPG3bTUv6QcgTyKvfr45dtVP6vOgDPuf
P53BN+GDvZJPmHokdlIvhf7zac71snILDJzmZWiCgURm3uEjqrt3m9IpU+adOgN8
TvUumgf+UCSsnT0UFMYcx2xVcJqhrl2BPChcqzXiYL7j4vXvVs0bbxGd16oEYg9N
A3rf2jHLDX6vCNBtBDKYCGrdJdOm46vGc4BBTmzloPz8rhq/sqC2kFc3B+acuuBf
XlKuvnaqL/6vx0+7ZdFkchXN/Zv/lA/LOfx2rI3UHe9UfoqQNHc=
=nlI3
-----END PGP SIGNATURE-----

--qFncihfL+fqzgudb--

--===============4447180749180245996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4447180749180245996==--
