Return-Path: <SRS0=acbz=LZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ACBC11F64
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 18:12:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00D761417
	for <iommu@archiver.kernel.org>; Thu,  1 Jul 2021 18:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00D761417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 69BFE401F4;
	Thu,  1 Jul 2021 18:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DCxytatHEHsp; Thu,  1 Jul 2021 18:12:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79F98400F0;
	Thu,  1 Jul 2021 18:12:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CBE6C0010;
	Thu,  1 Jul 2021 18:12:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F4C0C000E
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 18:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 505A2401F4
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 18:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3eoBswgIl69 for <iommu@lists.linux-foundation.org>;
 Thu,  1 Jul 2021 18:12:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACE6E400F0
 for <iommu@lists.linux-foundation.org>; Thu,  1 Jul 2021 18:12:06 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id hc16so11871829ejc.12
 for <iommu@lists.linux-foundation.org>; Thu, 01 Jul 2021 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=F36MKMagRhGCfKVfRAwtt9xJFZWHcYRQG0ajOVreECg=;
 b=sXBMX71ZsDJHpmuzo1jBlRAOpZcNUKocEYuEHW/ck2Jnkb/4Qk7+Rma8JfUKZcdxp1
 aXAN24ht8QX03jvqqW4shnVflz+OJrtLZkM/pUdQHUn5hnxtdox12AZpa5U9GfJnRU8X
 ZiJJQJkF6NxHGlj2Qu++GhT6c60dy9HcyMx79WlC4vK7CEyTj4F/gRtWLpJZ5eqKHAbr
 eaIhM2R5DFou7f6IOI4eEhjeH/+Ys42UrYDqxPRcETg2MpxJBLDzPkD74EDK+t2Zc6yt
 Nyp81qJQ0VZHi137abD9SySk+srqxQoI44zjenl2QnVG+vXVUaGDFOFoQKe74c3dq7yM
 2pcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F36MKMagRhGCfKVfRAwtt9xJFZWHcYRQG0ajOVreECg=;
 b=rHXdY8rNlHF7b00RgW5JbRgZ2lEVU7fBN2UiBXehfT4D3VaXFLeZII9yAgTcIx3jN5
 C73F0M5IbGLZ787UwcRxW5ZaYFT6QNcRh57UTt8LajmABVMoCllW/WFyUp8ifnCdVGPm
 ktpDIo/nqS2mHBVXLz43M9WMFr0lshIJxV0iKAeeckTO7MdR8ebn12X2LzrzzzTEalyi
 ktrn3BgqZvUt2qoao4GenCRIpN7bY3yijPQAhI+T/iac46TV39RwQNtfTbmujcTztGrb
 pi1KKs6vhTczysaHhH4h5lIktzLfE2ZTc48PvSuD8jC/9R56FBIsanAw+xKtdOxzhZU6
 MSCg==
X-Gm-Message-State: AOAM531hi2OQzlRxlqxzys9zEVWJwAR/bfFGVCje2EoB6qBbxiZG8MML
 H1YjswsCk1tZCb8AzucKbXo=
X-Google-Smtp-Source: ABdhPJx04srL5Kqb+Afxp55H3f+2E1NfRi73cTc19jrKbgpZQZM7MrtQy1ibUdloVutzgPzTdIq0MA==
X-Received: by 2002:a17:907:207c:: with SMTP id
 qp28mr1204891ejb.311.1625163124916; 
 Thu, 01 Jul 2021 11:12:04 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id j22sm185495eje.123.2021.07.01.11.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jul 2021 11:12:03 -0700 (PDT)
Date: Thu, 1 Jul 2021 20:14:22 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: reserved-memory: Document memory
 region specifier
Message-ID: <YN4F/nH/9tDuWDnQ@orome.fritz.box>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-2-thierry.reding@gmail.com>
 <20210520220306.GA1976116@robh.at.kernel.org>
 <YLEgXyLBF8PEFNw2@orome.fritz.box>
 <YL+gHN4YZ4vt1vPk@orome.fritz.box>
MIME-Version: 1.0
In-Reply-To: <YL+gHN4YZ4vt1vPk@orome.fritz.box>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
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
Content-Type: multipart/mixed; boundary="===============6213601486486988222=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6213601486486988222==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6YBegNniYlMh6yBT"
Content-Disposition: inline


--6YBegNniYlMh6yBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 08, 2021 at 06:51:40PM +0200, Thierry Reding wrote:
> On Fri, May 28, 2021 at 06:54:55PM +0200, Thierry Reding wrote:
> > On Thu, May 20, 2021 at 05:03:06PM -0500, Rob Herring wrote:
> > > On Fri, Apr 23, 2021 at 06:32:30PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Reserved memory region phandle references can be accompanied by a
> > > > specifier that provides additional information about how that speci=
fic
> > > > reference should be treated.
> > > >=20
> > > > One use-case is to mark a memory region as needing an identity mapp=
ing
> > > > in the system's IOMMU for the device that references the region. Th=
is is
> > > > needed for example when the bootloader has set up hardware (such as=
 a
> > > > display controller) to actively access a memory region (e.g. a boot
> > > > splash screen framebuffer) during boot. The operating system can us=
e the
> > > > identity mapping flag from the specifier to make sure an IOMMU iden=
tity
> > > > mapping is set up for the framebuffer before IOMMU translations are
> > > > enabled for the display controller.
> > > >=20
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > >  .../reserved-memory/reserved-memory.txt       | 21 +++++++++++++++=
++++
> > > >  include/dt-bindings/reserved-memory.h         |  8 +++++++
> > > >  2 files changed, 29 insertions(+)
> > > >  create mode 100644 include/dt-bindings/reserved-memory.h
> > >=20
> > > Sorry for being slow on this. I have 2 concerns.
> > >=20
> > > First, this creates an ABI issue. A DT with cells in 'memory-region'=
=20
> > > will not be understood by an existing OS. I'm less concerned about th=
is=20
> > > if we address that with a stable fix. (Though I'm pretty sure we've=
=20
> > > naively added #?-cells in the past ignoring this issue.)
> >=20
> > A while ago I had proposed adding memory-region*s* as an alternative
> > name for memory-region to make the naming more consistent with other
> > types of properties (think clocks, resets, gpios, ...). If we added
> > that, we could easily differentiate between the "legacy" cases where
> > no #memory-region-cells was allowed and the new cases where it was.
> >=20
> > > Second, it could be the bootloader setting up the reserved region. If=
 a=20
> > > node already has 'memory-region', then adding more regions is more=20
> > > complicated compared to adding new properties. And defining what each=
=20
> > > memory-region entry is or how many in schemas is impossible.
> >=20
> > It's true that updating the property gets a bit complicated, but it's
> > not exactly rocket science. We really just need to splice the array. I
> > have a working implemention for this in U-Boot.
> >=20
> > For what it's worth, we could run into the same issue with any new
> > property that we add. Even if we renamed this to iommu-memory-region,
> > it's still possible that a bootloader may have to update this property
> > if it already exists (it could be hard-coded in DT, or it could have
> > been added by some earlier bootloader or firmware).
> >=20
> > > Both could be addressed with a new property. Perhaps something like=
=20
> > > 'iommu-memory-region =3D <&phandle>;'. I think the 'iommu' prefix is=
=20
> > > appropriate given this is entirely because of the IOMMU being in the=
=20
> > > mix. I might feel differently if we had other uses for cells, but I=
=20
> > > don't really see it in this case.=20
> >=20
> > I'm afraid that down the road we'll end up with other cases and then we
> > might proliferate a number of *-memory-region properties with varying
> > prefixes.
> >=20
> > I am aware of one other case where we might need something like this: on
> > some Tegra SoCs we have audio processors that will access memory buffers
> > using a DMA engine. These processors are booted from early firmware
> > using firmware from system memory. In order to avoid trashing the
> > firmware, we need to reserve memory. We can do this using reserved
> > memory nodes. However, the audio DMA engine also uses the SMMU, so we
> > need to make sure that the firmware memory is marked as reserved within
> > the SMMU. This is similar to the identity mapping case, but not exactly
> > the same. Instead of creating a 1:1 mapping, we just want that IOVA
> > region to be reserved (i.e. IOMMU_RESV_RESERVED instead of
> > IOMMU_RESV_DIRECT{,_RELAXABLE}).
> >=20
> > That would also fall into the IOMMU domain, but we can't reuse the
> > iommu-memory-region property for that because then we don't have enough
> > information to decide which type of reservation we need.
> >=20
> > We could obviously make iommu-memory-region take a specifier, but we
> > could just as well use memory-regions in that case since we have
> > something more generic anyway.
> >=20
> > With the #memory-region-cells proposal, we can easily extend the cell in
> > the specifier with an additional MEMORY_REGION_IOMMU_RESERVE flag to
> > take that other use case into account. If we than also change to the new
> > memory-regions property name, we avoid the ABI issue (and we gain a bit
> > of consistency while at it).
>=20
> Ping? Rob, do you want me to add this second use-case to the patch
> series to make it more obvious that this isn't just a one-off thing? Or
> how do we proceed?

Rob, given that additional use-case, do you want me to run with this
proposal and send out an updated series?

Thierry

--6YBegNniYlMh6yBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDeBfsACgkQ3SOs138+
s6FEoRAArgfUJ2pN2AQEZGJFT3iV5IkbrhYdC58xmVQA7m0oyqllaDYcVzehvr3K
/srNiOAoCsVqY0NX2oHNjS5osnC8j9spEG70LqEt3EuThasMFU4D2Z3Ron1IV6v3
j0ycepZfYlxeCl/gHgvFIevQA8sWabNx+qjuSJoAjqgFALMdv0wBrdCdG0oOsqCI
Z9a0B2TQG0JX+TSrlJNbM25zH/g1orMvWRo5H1cBDxCXSeRbbdJNZ/K+DY12kAVW
dKWogA+wwereYONfIzQsCS/HqfT7dSSiA0sqBpAO78NfbD26OGMqd3Ue+mFp55mM
dDca4qoEe8n9Je6Smu3YHMNcbkjgS5WZ2yklg8uDTkiQZBt70ZIFU5sgDsx9/I5d
jEl6s20aCI7N8Bnj2zALU8VbZyBEUdGjGpgz9m+4Z2MXuPIEW0zcv63OdLPfapD3
1D5DfGQrpkHzcjmCXf5usPTtHm6oi5iRb2xn9khuShYc9td2ZpxhSP7yugtbtbdO
Vq2mf5wJO+hJeHSkRZlwQAW+lQ6eduHUAzI8f85+388XBC++pdcAA2Ku4rwzTVf1
VSCL+6LBoTA+qVsGtFUIuXH+vJnO2cXz+WQf7mZ5j0a5dqaNNjHlQsWgkAvewt3M
4UpP+4zqqb8fAupzRTIuC+8oZQ+szDDS8r0RMYqePR0w/1uYjAw=
=/Iz1
-----END PGP SIGNATURE-----

--6YBegNniYlMh6yBT--

--===============6213601486486988222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6213601486486988222==--
