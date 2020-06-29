Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33145C433DF
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:27:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D2F23D97
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mXRRbfVP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JiDM2YHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D2F23D97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2D56C87569;
	Mon, 29 Jun 2020 13:27:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GwyMWIDY7wAK; Mon, 29 Jun 2020 13:27:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 831FF869D1;
	Mon, 29 Jun 2020 13:27:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68E68C07FF;
	Mon, 29 Jun 2020 13:27:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D3E2C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6CB5487559
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YDcZb-SEui40 for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 13:27:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 373BD869D1
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:27:03 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id E3ECF5C00D3;
 Mon, 29 Jun 2020 09:27:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 29 Jun 2020 09:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=JpiETwDZ/SAflAAJFgDp4FBg1pZ
 pP5xS6lyjUSfpKCM=; b=mXRRbfVPgfG6UPXp/PSzKJMBzfyjzsl1E/7lyo5a3gM
 9Cge2GRb9lDgs1kvu9QUnD5zMEAk50D+o3Dz/RYf823HuITyl2SD6M5mqGJgvWNc
 o1DHLyzKoKgSZJTUqsMGT7GI/A6baxRB5Kh0TJgXydX2agP/hYV74Adp+0f8Bx9X
 4OWOLbSK1Dkwef0W1j8RNCam018fu8QBRaea8CUFHF60Snqn740cn2LdKaRsUVnb
 PeJU5B266/SwyxLZ8L1vrCoB165XsYMg4BGvlvXCsF6Urim6SXsBQDWghKck1U/6
 eiTtWyReAbSY+f0ZJw6Ghgc7Wkt7q+kCS6UASuCNlDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JpiETw
 DZ/SAflAAJFgDp4FBg1pZpP5xS6lyjUSfpKCM=; b=JiDM2YHPZhJvZBxwhPP024
 aKmfMURylJFOkccBcL+q9vj+SXy0Evq7N25IywsKCzIYUHcz8gpZOMl++jUWhpU6
 zp0+gQjFNV8O4i4iAn/UZAYNcJN9oUGoKduYA479RqzWzLCCCje0orJiJOtaC8NM
 k1rT+n0nuZyz5hujpZsPR04VTXwa+HyqAY01mhHSSocPRLJO25uJ4X34mdxgOUNV
 hreUs4zsGH16nEuchYNsY5ScQnkqiKUjY7fxwbzlMgNs5DtdHdnvwx1fhyHFw5QC
 WJPWI5KinuhCKrPH0eCVROihF8YBDz6fv6IU+z/zT39CiG/8Tk2KpRZTwXJhrVTg
 ==
X-ME-Sender: <xms:Juz5XuE4l6QSEmDlfJ9AvbfBgIk02Prg-ilcCIwJZhXYadez6pF8Ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudelkedgieehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Juz5XvV538Y4-dH1cRmxotMtkaQwuH05ywz1yFow3UEOXy4Vswm_fw>
 <xmx:Juz5XoJj9U8sljPLdaVdWpfy9zRwxhL1HDr_B4wECbYa_REcNOORTA>
 <xmx:Juz5XoGWnT9dNZWrIqynMyfRugD9fbrG5znCVlOdhnELAzJ-dY-LsA>
 <xmx:Juz5Xteuhv-OXifqHbVUMdKUdfk-96lZMLTejeBsEnJiZVurIx-9wg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 12707328005D;
 Mon, 29 Jun 2020 09:27:01 -0400 (EDT)
Date: Mon, 29 Jun 2020 15:27:00 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iommu: SUN50I_IOMMU should depend on HAS_DMA
Message-ID: <20200629132700.qtchohqyb4vslfhz@gilmour.lan>
References: <20200629121146.24011-1-geert@linux-m68k.org>
MIME-Version: 1.0
In-Reply-To: <20200629121146.24011-1-geert@linux-m68k.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============3148025472001605732=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3148025472001605732==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="srp6bnpiqzimzunw"
Content-Disposition: inline


--srp6bnpiqzimzunw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 02:11:46PM +0200, Geert Uytterhoeven wrote:
> If NO_DMA=3Dy (e.g. Sun-3 all{mod,yes}-config):
>=20
>     drivers/iommu/dma-iommu.o: In function `iommu_dma_mmap':
>     dma-iommu.c:(.text+0x92e): undefined reference to `dma_pgprot'
>=20
> IOMMU_DMA must not be selected, unless HAS_DMA=3Dy.
>=20
> Hence fix this by making SUN50I_IOMMU depend on HAS_DMA.
>=20
> Fixes: 4100b8c229b32835 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--srp6bnpiqzimzunw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvnsJAAKCRDj7w1vZxhR
xT08AQD0Cz/X0wU0i8MZumEsV0zYZgHgFem+MQvh7UEfUWFx6QEAwPl3iEuK5fAo
DgSiPvd7gsJK7PToEsd3T2mB9YYqzQE=
=WyeQ
-----END PGP SIGNATURE-----

--srp6bnpiqzimzunw--

--===============3148025472001605732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3148025472001605732==--
