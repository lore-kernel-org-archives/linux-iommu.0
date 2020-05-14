Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112E2C433DF
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 16:22:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B3520671
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 16:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Yl/aIKqo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WOtOzTtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B3520671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9216888A4E;
	Thu, 14 May 2020 16:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9aXmrdJGBA4L; Thu, 14 May 2020 16:22:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E7F1688ACE;
	Thu, 14 May 2020 16:22:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1DEAC0863;
	Thu, 14 May 2020 16:22:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2DF8C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 16:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E22338814C
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 16:22:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n9LkfPLZA3W9 for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 16:22:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F191A8862D
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 16:22:43 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 963665C0212;
 Thu, 14 May 2020 12:22:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 14 May 2020 12:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=BBAPlSEHy7qfk456tIvoxyLmZFq
 Ly4UcCnDWEG14lto=; b=Yl/aIKqo4MPIc7QpZmLqew2xx3UMNUzD9BV+J+dmaOQ
 y2UQEJLuUAMouu92M3NUxkyMUMrAkcZxbu6eGRFmQsyEKTyTrudQ8j1QWzTg6ley
 uwky1kRZW7lyxLHTpEls3IwIn/l0Iif3xhcrkhyhl4JcClGUfM4ZQyJo8ktRBY2a
 TiQ7zDyRRrYDdstZPLhTO42CngCXE1WSrAkjS91b+HpAc3M4MYNK4fVtcEW2MTkC
 rcv/7kSZD7FjwP9fNsZ/yBVwP4q2b7A9J6UnIKAoJtc20ZXnEjONDJvu5MDo5GWq
 Z8kyYIxQKc5B9A5cYYeytdN8ZtfgN/MrY6fKPXXXtzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BBAPlS
 EHy7qfk456tIvoxyLmZFqLy4UcCnDWEG14lto=; b=WOtOzTtkbEXrlLfpeXbIY4
 4sB3pcXdz+ovlZEpBIeYHiarKEKF9SzbbLqpztSi0ZrSqrv4vjMrp+Z8u92sU4En
 C8o3muOawFpn4+5vjPdC4NkgfstnrhYDl59wNrTerIgFY568s59hkHIMWfmrKQcb
 b/mKZN82qsibYCn/E/FlBx4xiHKlFDX5MwX+ExvAnSLeVkb3f2NOZda+/mGnpVOw
 uNclSAh1q5wC4yjHm3PKQI2+0k1CItr86CsuLl+PuGnmtt5XpzvjYPYA84IHRtXN
 5lJAxs1YUYNlRGRuIcDGtChpR86NCAw45pUjZ9LnnzhseS0ULx5Y8Mycnh2yQfxg
 ==
X-ME-Sender: <xms:TXC9XpNDVcPyn68f-ks293yeNgPlPtzPyxTObRAoI-egFr8qGIep2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeigdelvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TXC9Xr_zfdP2leqWlSrUsY3yr_xIyeKY4qRFd6UK5n_0lueJrD8ioQ>
 <xmx:TXC9XoS6EoMGVFTa-s3BvO_emvkjxtlMuKwKEmfImqsXxWpTZ_UHYQ>
 <xmx:TXC9XltuH1G-4lKs5iO5viP83uvaV7km3tzxKbpNBs0cVwYsrJBtfw>
 <xmx:UnC9Xo5iA9Nm8bC-KW7sn6PAEqC6Vm78k-mxEydZzCz8egtAj7uMNw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2D873328005A;
 Thu, 14 May 2020 12:22:37 -0400 (EDT)
Date: Thu, 14 May 2020 18:22:35 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 0/5] iommu: Add Allwinner H6 IOMMU driver
Message-ID: <20200514162235.he2q7vx3dra5ck2l@gilmour.lan>
References: <cover.b27dedd61e008ffcf55a028ccddda3bb4d21dfc8.1589378833.git-series.maxime@cerno.tech>
 <20200514123855.GI18353@8bytes.org>
 <20200514130900.k4gvr3zcajg3rouc@gilmour.lan>
 <20200514131647.GK18353@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200514131647.GK18353@8bytes.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
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
Content-Type: multipart/mixed; boundary="===============3385901627336910822=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3385901627336910822==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phtkiivizeocuqcp"
Content-Disposition: inline


--phtkiivizeocuqcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2020 at 03:16:47PM +0200, Joerg Roedel wrote:
> On Thu, May 14, 2020 at 03:09:00PM +0200, Maxime Ripard wrote:
> > On Thu, May 14, 2020 at 02:38:55PM +0200, Joerg Roedel wrote:
> > > On Wed, May 13, 2020 at 04:07:19PM +0200, Maxime Ripard wrote:
> > > > Maxime Ripard (5):
> > > >   dt-bindings: iommu: Add Allwinner H6 IOMMU bindings
> > > >   dt-bindings: display: sun8i-mixer: Allow for an iommu property
> > > >   iommu: Add Allwinner H6 IOMMU driver
> > > >   arm64: dts: allwinner: h6: Add IOMMU
> > > >   drm/sun4i: mixer: Call of_dma_configure if there's an IOMMU
> > >=20
> > > Applied all to the IOMMU tree, thanks. The code lives in the
> > > arm/allwinner branch.
> >=20
> > Did you also merge the DTS and DRM patches?
> >=20
> > Ideally, they should be merged through other trees to avoid the conflic=
ts as
> > much as possible (arm-soc and drm-misc respectively).
> >=20
> > If it's an option, could you drop all of them but "dt-bindings: iommu: =
Add
> > Allwinner H6 IOMMU bindings" and "iommu: Add Allwinner H6 IOMMU driver"?
>=20
> Okay, just to be on the safe side, I am going to drop:
>=20
> 	dt-bindings: display: sun8i-mixer: Allow for an iommu property
> 	arm64: dts: allwinner: h6: Add IOMMU
> 	drm/sun4i: mixer: Call of_dma_configure if there's an IOMMU
>=20
> from the iommu-tree?

Yep, please :)

> I took them because you are also maintaining the DRM driver, which
> counted as an implicit ACK for me :)

I also maintain the DTS patches for that matter, but we have a good number =
of
patches queued up for those files in those trees usually, so it's easier for
everyone to avoid the conflicts and just merge them into separate trees whe=
n we
can.

Thanks!
Maxime

--phtkiivizeocuqcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXr1wSgAKCRDj7w1vZxhR
xQ1UAP9NNM9p3Y+kfFB3QB7uFNTQoj45RAJZ4+7liXO1OnMMYQD9FQkWyw3VFTeT
i82PNurLgs71brOZ1Qfwy2UAvsBU8QE=
=thRW
-----END PGP SIGNATURE-----

--phtkiivizeocuqcp--

--===============3385901627336910822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3385901627336910822==--
