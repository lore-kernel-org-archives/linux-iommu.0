Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44875C433E0
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:22:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67FB64F60
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 08:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67FB64F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3B1C1204C0;
	Wed,  3 Feb 2021 08:22:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfuINtbDhXNy; Wed,  3 Feb 2021 08:22:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 034512037A;
	Wed,  3 Feb 2021 08:22:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE531C0174;
	Wed,  3 Feb 2021 08:22:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3259C013A
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EADDF85540
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JTZwFZJW3FX9 for <iommu@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 08:22:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C0E7485516
 for <iommu@lists.linux-foundation.org>; Wed,  3 Feb 2021 08:22:32 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id CDA5E5801CA;
 Wed,  3 Feb 2021 03:22:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 03 Feb 2021 03:22:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=UWp3cTR8UlCtxWWrylu98BqrLP6
 gokgH/+UUDAES7bc=; b=izBbaIxXq3u1WterMcXA8m478hwLEeJutIS8a7YuYeZ
 Vi42oiGsRDqrSULcHG4xVSAcpkY2A6VtaJRm+E10OqdMwfujpp4DItI6jMUiv27W
 RGmEiChWp37gV/KSCL5kJtvUmeezEQQ+B0bg4eBrX9Ahsk5I7QTaJzW9ekWX7h2y
 QFzAfml9CQjZ3FKCgWLYtFoAhzWdrQfr2rIGL5xDp+d2LLJqgwoKjSDeOGsjR2rP
 Fm2pPQHoj22jpf1RufSNs4FYfJrP0PI2Rw/X59WziKhkRKDgKDC5lZRpb39NIzZp
 vcAGde6weuPh658VEl9059ls9Uu/Vi1AvALTccKurkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UWp3cT
 R8UlCtxWWrylu98BqrLP6gokgH/+UUDAES7bc=; b=t1KBEuFc49+xMxqyXKoA8/
 3WulD3tIJgeVT7eIlcnWMsTdXmZB6jEs0TTx1IWwOhZ9dFEQ0dFcSuMicV6ydQx8
 iu8rMQyX2ej1yEI2wkUSvDpWum0PQTLN8s5pyFRQBcTsKGEzK8sSnm1BrjKbQjqP
 eSoEWze8EyVg+zYeYpnxcX3NeVQGARYhkm2Vi5AR3/oj94MHf2xCwOW4PM9dBnvu
 xmyYMwqcexvQGIBcW/BFr3KBbHQl0WIm2ab/sdLmnmaryM1x4LWmagh5WQBwNSFu
 x5qWRhy1aPzLiKnrPQRGC60avUBAVBRELf3vfo4zXU8VsUY+3YrgE/k8dPrLbxIg
 ==
X-ME-Sender: <xms:QV0aYFcXyYQ5TRYF7WGlLELFRJ1yQrOtHhDhPTipbdc2SMX1x6avng>
 <xme:QV0aYDKbQJPLw9pI2uDq_kM1o2gSVmuw6NUgK-0koA0owfmY95Lzv5Weugu-XmQH9
 93sR2yeFpxpTbVhM1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgedugdduudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QV0aYLb1Lc2GX4BVZHDPMIXgosvMbTnsa4utNq8m25HOwmKHKexoSw>
 <xmx:QV0aYGsPxsALW4VvASQluws1JKhNT-dddtY-lQD2QtZfe8BSp71ccA>
 <xmx:QV0aYAu80RUvGgUCDStecBY7uxawxEupGRT2YOBtRmQT3b7gK2f1tA>
 <xmx:R10aYMJuTiGgAhdHzPiQSUSFePWiskGLbKXQEI-JgoTQwKfIw7bxkg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id D9835240066;
 Wed,  3 Feb 2021 03:22:24 -0500 (EST)
Date: Wed, 3 Feb 2021 09:22:22 +0100
From: Maxime Ripard <maxime@cerno.tech>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: Fix errors in 'if' schemas
Message-ID: <20210203082222.z27map6smi2x7ry7@gilmour>
References: <20210202205544.24812-1-robh@kernel.org>
 <20210202205544.24812-3-robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210202205544.24812-3-robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomer Maimon <tmaimon77@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>,
 Vincent Cheng <vincent.cheng.xh@renesas.com>, dri-devel@lists.freedesktop.org,
 Tali Perry <tali.perry1@gmail.com>, Eric Anholt <eric@anholt.net>,
 Daniel Palmer <daniel@thingy.jp>, linux-i2c@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Joel Stanley <joel@jms.id.au>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 Ray Jui <rjui@broadcom.com>, linux-gpio@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Avi Fishman <avifishman70@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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
Content-Type: multipart/mixed; boundary="===============6471846709592378343=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6471846709592378343==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mkorhjmes6qelxs4"
Content-Disposition: inline


--mkorhjmes6qelxs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2021 at 02:55:44PM -0600, Rob Herring wrote:
> Properties in if/then schemas weren't getting checked by the meta-schemas.
> Enabling meta-schema checks finds several errors.
>=20
> The use of an 'items' schema (as opposed to the list form) is wrong in
> some cases as it applies to all entries. 'contains' is the correct schema
> to use in the case of multiple entries.
>=20
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-crypto@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-leds@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--mkorhjmes6qelxs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBpdPgAKCRDj7w1vZxhR
xRUtAP94Y18dPhOCV8TVxavL7kG7XsboIrsPGFEgK0eLh1EFVgD/Z52O0dog31tF
YkN66sClBd92y+lqf0Ark2e+vBrqFwU=
=Zd51
-----END PGP SIGNATURE-----

--mkorhjmes6qelxs4--

--===============6471846709592378343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6471846709592378343==--
