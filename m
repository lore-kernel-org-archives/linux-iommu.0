Return-Path: <SRS0=HmBJ=3Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0302C2D0DB
	for <iommu@archiver.kernel.org>; Mon, 27 Jan 2020 14:23:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B300F20716
	for <iommu@archiver.kernel.org>; Mon, 27 Jan 2020 14:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="jSd+KVp0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D7EzLR7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B300F20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 940C884524;
	Mon, 27 Jan 2020 14:23:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xseblm_yUV7N; Mon, 27 Jan 2020 14:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 350B084187;
	Mon, 27 Jan 2020 14:23:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DDB2C0177;
	Mon, 27 Jan 2020 14:23:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14771C0171
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jan 2020 14:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F3BFE87404
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jan 2020 14:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pN9PyeSaywB1 for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jan 2020 14:23:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5E55B87364
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jan 2020 14:23:42 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 7F3D6220E4;
 Mon, 27 Jan 2020 09:23:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Mon, 27 Jan 2020 09:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=6nVE0kCyNJt9qWBWbOEKXHwSwow
 EKCywtD9brS7Cseg=; b=jSd+KVp02RKwQqPOorW+yQlhQtgIyI5GqkLKAEGj54b
 VPHJNyxapcInzFerkE3dJs2dhmszb/mrNDbHIS6y5614b+yH9VnDC8T0ksTehpjz
 Lkgjt8RVRotnnu8kQBagY3uugjb+JSY1/YRn18NbsdNI8n/b6/Un3G6feKx5pN9z
 XVuvLYxRk0/H+olW0rAHD87ANjdCgUrkDb/qDdXPPGRV8WHZVV6oUPSQURmba+8Y
 h1MOaAY7+0+ur0G4Y5TTGMrtyN3GXW8ey9bmjvDna6Gamdk93UeDMy3G5x+EVe+s
 t6J6rONmRjNahF57o1GyH4vod4rCP+HCmzFs/ZuP6VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6nVE0k
 CyNJt9qWBWbOEKXHwSwowEKCywtD9brS7Cseg=; b=D7EzLR7lxn0OcIw0cH2BLp
 7CXRBRI4NSjaUx6TlrGbgMaRbt9MnAtKKTg5hBclY8hI3j64++fNEieLivCCtzte
 3mSLvHOD6e/bBp3ZayhVRAZNgSZl9oTATcQhssdFw+b5xTgSbAWKV+/DEIgf2P89
 yTi1OA4hhsaaR+I79LeLQebUaMzLuF+IBuNiHrPOcmWtFYf+UQUL9qH3WjRrvHCS
 +/1AMx7SM7sdJYB8ODYCjFpM7tYlvW0QQnljqBRlHKwik/cT5C9wigVue3wzuiHt
 IHncMW1BS8aqxRlc3RVJmGX9NeDRvpapzSeL3wbSxA8L6TRpc7cCe8nGUbdIexBw
 ==
X-ME-Sender: <xms:bfIuXjumlbnjk2u_C1w6XJ4Se3pJzIY_US3xcycy-6jZxRRfIWrWvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgdeifecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
 ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bfIuXm3v5sNBERXLPgckY-tKb8uutWlW7awBLTWTxLP3ddnzDrKpfg>
 <xmx:bfIuXgDhfhzfoCbgX8lQt1FhbIAwnqCW72eXZ-vamuB8CasVo17M0g>
 <xmx:bfIuXlV47Bf5kEkVqvIb-RYhddj7ukYQufeEBYKGImnVsWezO-GTBw>
 <xmx:bfIuXucAErhGZsMH9hHPsXAmB1UPZzfwU75CZN9C2DRmlWahFJHGew>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 313263069F0E;
 Mon, 27 Jan 2020 09:23:41 -0500 (EST)
Date: Mon, 27 Jan 2020 15:23:39 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h6: Add IOMMU
Message-ID: <20200127142339.crxsuunzec5drfe2@gilmour.lan>
References: <cover.b2a9e1507135d81e726fcbb65137665a7f0ab74f.1579696927.git-series.maxime@cerno.tech>
 <54e22e25c2c13cb1b73cc7ecb645b5d62f325b63.1579696927.git-series.maxime@cerno.tech>
 <5320339.DvuYhMxLoT@jernej-laptop>
MIME-Version: 1.0
In-Reply-To: <5320339.DvuYhMxLoT@jernej-laptop>
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
Content-Type: multipart/mixed; boundary="===============7387913655453423465=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============7387913655453423465==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="23dys2vkg5qz4fja"
Content-Disposition: inline


--23dys2vkg5qz4fja
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Fri, Jan 24, 2020 at 09:54:23PM +0100, Jernej =C5=A0krabec wrote:
> Dne sreda, 22. januar 2020 ob 13:44:09 CET je Maxime Ripard napisal(a):
> > Now that we have a driver for the IOMMU, let's start using it.
> >
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> > 29824081b43b..8608bcf1c52c 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> > @@ -53,6 +53,7 @@
> >  	de: display-engine {
> >  		compatible =3D "allwinner,sun50i-h6-display-engine";
> >  		allwinner,pipelines =3D <&mixer0>;
> > +		iommus =3D <&iommu 0>;
> >  		status =3D "disabled";
> >  	};
>
> Isn't iommu property of the mixer node? After all, mixer is the one which
> reads one or more framebuffers. Once second mixer is defined, would you p=
ut
> another iommu phandle here?

You're right. I added it during the early dev, and forgot to remove
it. Thanks!

Maxime

--23dys2vkg5qz4fja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXi7yawAKCRDj7w1vZxhR
xeztAP9pfvFOvLl0WNETETdOGyGO/pBPPZtOCEHsIaOgcIfqCwEA61DgtSFMFRSM
4UmZO6xgB73HVB6s09UFT59ZuHSWMgg=
=/MfB
-----END PGP SIGNATURE-----

--23dys2vkg5qz4fja--

--===============7387913655453423465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7387913655453423465==--
