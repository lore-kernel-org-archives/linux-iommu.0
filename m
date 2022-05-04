Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD93C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 19:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04C2841944;
	Wed,  4 May 2022 19:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y42w1l6VMLBU; Wed,  4 May 2022 19:51:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6A3D41726;
	Wed,  4 May 2022 19:51:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78869C0039;
	Wed,  4 May 2022 19:51:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86AD7C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66DFE60AFA
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=sang-engineering.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3h1Rghs9-AXv for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 19:51:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8089660ABB
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=k1; bh=roOe+AeBY7DP+Q6uo/3NlHB6bacD
 iF8cZtCOKwDNtfY=; b=AVvmqY7D3UH/BWMnn7wIorUCqnrJ/+VLUtw394q8E+Om
 FcZj38Meag68aRXJMZqBMV/ykDiAbYkJb7JobePTVSDwsJScwk5GU/y4NLU/d2X/
 TtjYV05OBt+x37dH92tXFElqcjQbmeUxdL9XANm472CsC+dHuhk7AahZPz9ANQE=
Received: (qmail 1533983 invoked from network); 4 May 2022 21:51:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 4 May 2022 21:51:39 +0200
X-UD-Smtp-Session: l3s3148p1@aBgC9DTeXJwgAwDtxwyXAP9dq+3qRUcy
Date: Wed, 4 May 2022 21:51:36 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 2/7] dt-bindings: i2c: renesas,rcar-i2c: R-Car V3U is
 R-Car Gen4
Message-ID: <YnLZSNJh7rdH77Lp@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Vinod Koul <vkoul@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1651497024.git.geert+renesas@glider.be>
 <a0402ff46027196953fe9c13f60576d40c5aea4c.1651497024.git.geert+renesas@glider.be>
MIME-Version: 1.0
In-Reply-To: <a0402ff46027196953fe9c13f60576d40c5aea4c.1651497024.git.geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, dmaengine@vger.kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-watchdog@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============2792857607090400401=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2792857607090400401==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j/bfMYaLl7xWqyb8"
Content-Disposition: inline


--j/bfMYaLl7xWqyb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 03:34:54PM +0200, Geert Uytterhoeven wrote:
> Despite the name, R-Car V3U is the first member of the R-Car Gen4
> family.  I2C on R-Car V3U also supports some extra features (e.g. Slave
> Clock Stretch Select), which are supported by other R-Car Gen4 SoCs, but
> not by any other R-Car Gen3 SoC.
>=20
> Hence move its compatible value to the R-Car Gen4 section.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to for-next, thanks!


--j/bfMYaLl7xWqyb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJy2UgACgkQFA3kzBSg
KbbbBQ//bHWIRu7MnsRqfYi9eFC5lxec3M3uiwvykedIMxXDdWQCC2qXlAn6efuH
qv9GS22D0TLykN9cUMh/mwkF8j4CpK1hxncdTz7//FyzfDcEhuABgks83Z1Z1Vib
X8oYEjRjx5kRJD+TC6OXer3OVwKfFX8V+6FpRruFVW/LWVEZa/LTKFqlSLw1sO3A
fy4Mw5pcBbKlDiXWmyTiAjk+Rv+apo2VXaO9nV7UxAJSICixTe0GmOPZzXHCem/z
GvqpFKcaXWXtQ1FHt1zwxuscEhTf8YD4XDB3S1iCvkh1BXwN7xK0BW5vLQYtwxKJ
c/F9Zwwg7dz5VHAy8Sf+AFIi3Q5Iv9gBJ7kjt6G4hpYG4itHOpCopBjmfxQu0YcD
J5bOb/F1jKOVjPHfnE2IFzyH4Alsy+z7hAMk3R90WM/AumDfVB1d1msG/1V3rnFe
IRRaP3yu9mmcPkG7rRWs3oi/HH3SWzeDCywaqJgIMwJWE0oFHuw5LA8KzKvk5rbD
lVm+yJTMx0GyyhqV/dl+fyPdLTHj+5O1grgopDg6xjKDiN+2EmbstKJdGKtocA6N
tHNzcp80bFOHV6eO3j89GhutyTdL0ma8z892LN/+Lk7dQDpyoTKLmC51fvE7BHBK
+yqozekqkqbqe/qUVYEV0UCB/VkIEgSIoJJP39lRITx/rY2F404=
=hJCI
-----END PGP SIGNATURE-----

--j/bfMYaLl7xWqyb8--

--===============2792857607090400401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2792857607090400401==--
