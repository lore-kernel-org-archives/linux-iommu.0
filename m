Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF28FC433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:22:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C2D64F67
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C2D64F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4984385540;
	Wed,  3 Feb 2021 08:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n94Mn-Vf4BDx; Wed,  3 Feb 2021 08:22:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CFF3985516;
	Wed,  3 Feb 2021 08:22:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3D48C0174;
	Wed,  3 Feb 2021 08:22:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83567C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:22:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 69D3086473
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TI85TvG4jRrr for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 08:22:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 075A386460
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:22:10 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id C68A05801C8;
 Wed,  3 Feb 2021 03:22:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 03 Feb 2021 03:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=fqkHRYodlshvhyIA+UJ4UfsOf/l
 tAp7H6MffX1tyNxE=; b=slcOTGvTpKA4WljhiJv7+iCUZH8gSK7HINfjxfcyHYS
 oVWP3iCVbGh8iebkQ64Otesly/pgB6Ojkd/8+NHHcXREflHQrwFbmKhQW9Pt1mpo
 0jGaiibdct3rA5gtLBBJD+WqevLjejqfXmO25CUl/H7wZ16tsr7G4Bi7EM++QQiP
 uGt1hmCkYEs9fT3Ccb33TsiX1rUASf/lWhTrjChfxbVhV/ThkAddln2eUhyy5d1W
 AruG4cHgZ5LbUzJLSv2lNTCZRTV4iYx6F8KiPqcNKqHbAiNmegBw9hqzuZ3RcezD
 TAjxwAkZUcA0rRhpbZgJpZ2cTP+j4TNMlDxTLMpoQbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fqkHRY
 odlshvhyIA+UJ4UfsOf/ltAp7H6MffX1tyNxE=; b=u81W7hCHQNnX8ioS0QjzTI
 dXYEXN8u7Zv12w/JGQY9cb+EXhyFPhGHybUSyy58L5BYFAsTB8TIvPcJMO1yIzR2
 wXB4Q63BEG+dRtnsn+ScSOdchORgRtuhUciKHps0h8VG/5wFo00V85MKJi+839q/
 HyrbXvamWMkX0+lH9Umbi7gcrOfD+UXSmY6lb64xzZO5TS7nuWW9Swbxnz0U7WsV
 QTSrEj6zktT37l7KKq0Zzl1v/vpW/Gvjx9A5aaByY3qvZ8RNRbvfHoZELkHYwIbK
 gNATlaHd7ZYOa1pqxowGPfDGKqx62lN3MwsHhZkmGfe63hzwVwjtB3Uy80MSe28w
 ==
X-ME-Sender: <xms:LV0aYHdnCSxFxDCLC5CXYrWHBt_VwtPnVzVDdh1oD7oRXvVdQXmklg>
 <xme:LV0aYNMToA5In7Ytxt8daA1e-8wVQnQ6K7h_43MrxcNeQajOhD4r3bA09TSyCLrWb
 i6sO3Rh85G3zl0eh-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedugdduudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:LV0aYAhb3EPSlG7qHPT7wzMboPymJneBnX7mcDOV8ZX_7-2InDhEaQ>
 <xmx:LV0aYI9e3_6x364E7PvAgYd1Z-BjvqNvpdA2yELBilajlOhDzNbDug>
 <xmx:LV0aYDuBJ57wK1dK4YgxXtVXo_Mm4TBHG6QekGn_AcEfBHtQ_3jAZw>
 <xmx:MF0aYC9hdUdELtEoyj7de93BQEQX4jOyhX4iH0KZUvHvXhdclUakXQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8D50D1080063;
 Wed,  3 Feb 2021 03:22:05 -0500 (EST)
Date: Wed, 3 Feb 2021 09:22:03 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: Fix undocumented compatible strings in
 examples
Message-ID: <20210203082203.pq2xxyrjkzhbwfks@gilmour>
References: <20210202205544.24812-1-robh@kernel.org>
 <161231243653.76967.3231080427102153199@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
In-Reply-To: <161231243653.76967.3231080427102153199@swboyd.mtv.corp.google.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>,
 Tali Perry <tali.perry1@gmail.com>, Daniel Palmer <daniel@thingy.jp>,
 linux-i2c@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, linux-kernel@vger.kernel.org,
 Andrew Jeffery <andrew@aj.id.au>, iommu@lists.linux-foundation.org,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============6814044040408554862=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6814044040408554862==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4gldcp53h554eeqa"
Content-Disposition: inline


--4gldcp53h554eeqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 04:33:56PM -0800, Stephen Boyd wrote:
> Quoting Rob Herring (2021-02-02 12:55:42)
> >=20
> > diff --git a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a8=
0-usb-clocks.yaml b/Documentation/devicetree/bindings/clock/allwinner,sun9i=
-a80-usb-clocks.yaml
> > index fa0ee03a527f..53cc6df0df96 100644
> > --- a/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-c=
locks.yaml
> > +++ b/Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-c=
locks.yaml
> > @@ -18,7 +18,7 @@ properties:
> >      const: 1
> > =20
> >    compatible:
> > -    const: allwinner,sun9i-a80-usb-clocks
> > +    const: allwinner,sun9i-a80-usb-clks
>=20
> Should the file name change too?

Ideally yes, and with that change
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--4gldcp53h554eeqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBpdKwAKCRDj7w1vZxhR
xfXZAP4mNYff3e9rGt7MOkYTYcw0pPEWCEpYYXYTI2ssF+qYBwD9FyVvxvbomZwA
YVE/qhtvuINsw89s7u6/KsQoWh85RwA=
=Nhso
-----END PGP SIGNATURE-----

--4gldcp53h554eeqa--

--===============6814044040408554862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6814044040408554862==--
